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
