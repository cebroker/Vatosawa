//
//  BaseAPIClient.swift
//  EvercheckWalletAPI
//
//  Created by Genesis Sanguino on 6/10/18.
//  Copyright © 2018 CE Broker. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import KeychainAccess

public protocol ClientProtocol {
    func request<Response>(_ endpoint: Endpoint<Response>) -> Observable<Response>
    func upload<Response>(_ endpoint: Endpoint<Response>) -> Observable<Response>
}

public enum APIAuthorizationType: String {
    case truevault
    case wallet
    case none
}

public enum APIContentType: String {
    case json = "application/json"
    case formURLencoded = "application/x-www-form-urlencoded"
}

public class BaseAPIClient: ClientProtocol {

    public let baseURL: URL?
    public let manager: SessionManager

    public init(baseURL: String) {
        self.baseURL = URL(string: baseURL)
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        self.manager = SessionManager(configuration: configuration)
    }

    open func request<Response>(_ endpoint: Endpoint<Response>) -> Observable<Response> {
        return Observable<Response>.create({ emitter in

            guard let url = self.url(path: endpoint.relativePath) else {
                emitter.onError(CustomErrors.ApiRequest.malformedURL)
                return Disposables.create()
            }

            var headers: HTTPHeaders?

            do {
                headers = try self.getHeaders(endpoint)
            } catch let error {
                emitter.onError(error)
            }

            guard let headers_ = headers else {
                emitter.onError(CustomErrors.ApiRequest.parseIssue)
                return Disposables.create()
            }

            let request = self.manager.request(
                url,
                method: endpoint.method,
                parameters: endpoint.parameters,
                encoding: endpoint.parameterEncoding,
                headers: headers_)

            request.validate()
                .responseData(completionHandler: { response in
                    let result = response.result.flatMap(endpoint.decode)
                    switch result {
                    case let .success(val):
                        emitter.onNext(val)
                        emitter.onCompleted()
                    case let .failure(err):
                        print(err.localizedDescription)
                        emitter.onError(err)
                    }
                })

            return Disposables.create() {
                request.cancel()
            }
        })
    }

    open func upload<Response>(_ endpoint: Endpoint<Response>) -> Observable<Response> {
        return Observable<Response>.create({ emitter in

            var headers: HTTPHeaders?

            do {
                headers = try self.getHeaders(endpoint)
            } catch let error {
                emitter.onError(error)
            }

            guard let url = self.url(path: endpoint.relativePath) else {
                emitter.onError(CustomErrors.ApiRequest.malformedURL)
                return Disposables.create()
            }

            guard let headers_ = headers else {
                emitter.onError(CustomErrors.ApiRequest.parseIssue)
                return Disposables.create()
            }

            guard let urlRequest = try? URLRequest(url: url, method: endpoint.method, headers: headers_) else {
                emitter.onError(CustomErrors.ApiRequest.malformedURL)
                return Disposables.create()
            }

            self.manager.upload(multipartFormData: { (multipartFormData) in
                guard let parameters = endpoint.parameters else {
                    return
                }
                for (key, value) in parameters {
                    if !(value is Data) {
                        multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
                    } else {
                        guard let data = value as? Data else {
                            continue
                        }
                        multipartFormData.append(data, withName: key, fileName: key, mimeType: Constants.MIMEType.image)
                    }
                }
            }, usingThreshold: UInt64.init(), to: url, method: endpoint.method, headers: headers) { (uploadResult) in
                switch uploadResult {
                case .success(let upload, _, _):
                    upload.responseData(completionHandler: { response in
                        let result = response.result.flatMap(endpoint.decode)

                        guard let val = result.value else {
                            emitter.onError(CustomErrors.ApiRequest.parseIssue)
                            return
                        }

                        emitter.onNext(val)
                        emitter.onCompleted()
                    })
                case .failure(let err):
                    print(err.localizedDescription)
                    emitter.onError(err)
                }
            }

        return Disposables.create()
        })
}

private func getHeaders<Response>(_ endpoint: Endpoint<Response>) throws -> HTTPHeaders {

    let keyChain = Keychain(service: Constants.Keychain.id)

    var token: String?
    var authorizationType: String?
    switch endpoint.authorizationType {
    case .truevault:
        do {
            token = try keyChain.get(Constants.Keychain.accessToken)
        } catch let error {
            throw error
        }
        authorizationType = Constants.AuthorizationType.Basic
    case .wallet:
        do {
            token = try keyChain.get(Constants.Keychain.accessToken)
            authorizationType = try keyChain.get(Constants.Keychain.tokenType)
        } catch let error {
            throw error
        }
    default:
        token = Constants.Values.empty
    }

    guard let authenticationToken = token else {
        throw CustomErrors.ApiRequest.missingToken
    }

    var headers = SessionManager.defaultHTTPHeaders

    if let safeAuthorizationType = authorizationType {
        headers["Authorization"] = safeAuthorizationType + " " + authenticationToken
    }

    headers["Content-Type"] = endpoint.contentType.rawValue
    headers["Accept"] = APIContentType.json.rawValue

    return headers
}

private func url(path: String) -> URL? {
    return baseURL?.appendingPathComponent(path)
}
}
