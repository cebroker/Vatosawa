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

protocol ClientProtocol {
    func request<Response>(_ endpoint: Endpoint<Response>) -> Observable<Response>
}

enum APIAuthorizationType: String {
    case truevault
    case wallet
    case none
}

enum APIContentType: String {
    case json = "application/json"
    case formURLencoded = "application/x-www-form-urlencoded"
}

open class BaseAPIClient: ClientProtocol {
    
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
            //            guard let url = self.url(path: endpoint.relativePath) else {
            //                emitter.onError(CustomErrors.ApiRequest.malformedURL)
            //                return Disposables.create()
            //            }
            //
            //            var token: String?
            //            var authorizationType: String?
            //            switch endpoint.authorizationType {
            //            case .truevault:
            //                token = UserDefaults.standard.string(forKey: GeneralConstants.UserDefaults.tokenTrueVault)
            //                authorizationType = GeneralConstants.AuthorizationType.Basic
            //            case .wallet:
            //                token = UserDefaults.standard.string(forKey: GeneralConstants.UserDefaults.tokenWallet)
            //                authorizationType = UserDefaults.standard.string(forKey: GeneralConstants.UserDefaults.authorizationType)
            //            default:
            //                token = GeneralConstants.Values.empty
            //            }
            //
            //
            //            guard let authenticationToken = token else {
            //                emitter.onError(CustomErrors.ApiRequest.missingToken)
            //                return Disposables.create()
            //            }
            //
            //            var headers = SessionManager.defaultHTTPHeaders
            //
            //            if let safeAuthorizationType = authorizationType {
            //                headers["Authorization"] = safeAuthorizationType + " " + authenticationToken
            //            }
            //
            //            headers["Content-Type"] = endpoint.contentType.rawValue
            //
            //            let request = self.manager.request(
            //                url,
            //                method: endpoint.method,
            //                parameters: endpoint.parameters,
            //                encoding: endpoint.parameterEncoding,
            //                headers: headers)
            //
            //            request.validate()
            //                .responseData(completionHandler: { response in
            //                    let result = response.result.flatMap(endpoint.decode)
            //                    switch result {
            //                    case let .success(val):
            //                        emitter.onNext(val)
            //                        emitter.onCompleted()
            //                    case let .failure(err):
            //                        print(err.localizedDescription)
            //                        emitter.onError(err)
            //                    }
            //                })
            //
            return Disposables.create() {
                //                request.cancel()
            }
        })
    }
    
    private func url(path: String) -> URL? {
        return baseURL?.appendingPathComponent(path)
    }
}
