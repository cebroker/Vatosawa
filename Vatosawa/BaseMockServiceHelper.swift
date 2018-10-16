//
//  BaseMockServiceHelper.swift
//  Vatosawa
//
//  Created by Genesis on 10/16/18.
//  Copyright © 2018 CE Broker. All rights reserved.
//

import Alamofire
import RxSwift
import PactConsumerSwift

public class Mock {
    public let uponReceiving: String
    public let method: PactHTTPMethod
    public let path: String
    public let requestQuery: Any?
    public let requestHeaders: [String: Any]?
    public let requestBody: Any?
    public let statusCode: Int
    public let responseHeaders: [String: Any]?
    public let expectedResult: Any?
    
    public init(uponReceiving: String, method: PactHTTPMethod, path: String, requestQuery: Any? = nil, requestHeaders: [String: Any]? = nil, requestBody: Any? = nil, statusCode: Int, responseHeaders: [String: Any]? = nil, expectedResult: Any? = nil) {
        self.uponReceiving = uponReceiving
        self.method = method
        self.path = path
        self.requestQuery = requestQuery
        self.requestHeaders = requestHeaders
        self.requestBody = requestBody
        self.statusCode = statusCode
        self.responseHeaders = responseHeaders
        self.expectedResult = expectedResult
    }
}

public protocol MockServiceProtocol {
    func mock(_ mockData: Mock) -> MockService
}

public class BaseMockServiceClient: MockServiceProtocol {
    
    public let mockService: MockService
    
    public init(mockService: MockService) {
        self.mockService = mockService
    }
    
    open func mock(_ mockData: Mock) -> MockService {
        mockService
            .uponReceiving(mockData.uponReceiving)
            .withRequest(method: mockData.method,
                         path: mockData.path,
                         query: mockData.requestQuery,
                         headers: mockData.requestHeaders,
                         body: mockData.requestBody)
            .willRespondWith(status: mockData.statusCode,
                             headers: mockData.responseHeaders,
                             body: mockData.expectedResult)
        
        return mockService
    }
}
