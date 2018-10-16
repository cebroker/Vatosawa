//
//  Constants.swift
//  Vatosawa
//
//  Created by Genesis on 10/16/18.
//  Copyright © 2018 CE Broker. All rights reserved.
//

struct Constants  {
    
    struct AuthorizationType {
        static let Basic = "Basic"
        static let Bearer = "Bearer"
    }
    
    struct MIMEType {
        static let image = "image/*"
    }
    
    struct Values {
        static let empty = ""
    }
    
    struct Keychain {
        static let id = "evercheckwallet"
        static let accessToken = "accessToken"
        static let tokenType = "tokenType"
    }
    
}

extension DateFormatter {
    static let walletApiDateFormat : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        return formatter
    }()
}
