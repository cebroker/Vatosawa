//
//  CustomErrors.swift
//  EvercheckWallet
//
//  Created by Genesis Sanguino on 16/10/18.
//  Copyright © 2018 CE Broker. All rights reserved.
//

import UIKit

public struct StatusCodes {
    static let successStatusCode = 200
    static let redirectionStatusCode = 300
    static let badRequestStatusCode = 400
    static let notAuthenticatedStatusCode = 401
    static let unauthorizedStatusCode = 403
    static let pageNotFound = 404
    static let internalServerErrorStatusCode = 500
}

public enum CustomErrors: Error {
    
    public enum ApiRequest: Error {
        case serviceError(description: String)
        case unauthorized
        case parseIssue
        case serverUnresponsive
        case emptyJson
        case malformedURL
        case missingToken
        case missingTruevaultDocumentIdOrProviderId
        case missingAuthorizationType
        case authorizationTypeNotSupportedByClient(description: String)
        case trueVaultProviderEmpty(documentId: String, providerId: String)
        case badRequest
        case missingField
        case badUrlFormat
        case pageNotFound
        case serverError
    }
    
    public enum EditCell: Error {
        case cannotApplyCurrencyFormat
        case cannotApplyPhoneFormat
        case cannotRemoveCurrencyFormat
        case cellWithoutFormat
        case cannotApplyDateFormat
    }
    
    public enum FileBrowser: Error {
        case fileDoesNotExists
    }
    
    public enum TouchId: Error {
        case firstTimeLogin
        case invalidCredentials
    }
    
    public enum LicenseSubmition: Error {
        case invalidSubmition
    }
    
    public enum SignUp: Error {
        case accountNotExists
    }
    
    public enum Programming: Error {
        case pickerFileNotFound
        case canNotCreateURLFromString
        case unabletoGetDataFromLocalStorage
        case canNotParseAsJSON
        case canNotParseAsObject
        case unknownCodableType
        case parsingIssue
        case invalidInstalledVersion
        case truevaultAuthNotFound
        case unableToCreateSummaryFromSource
        case statesNotFound
        case specialtyNotFound
        case canNotCreateImageFromString
        case canNotConvertImageToString
        case missingId
        case missingField
        case notSummarizable
        case missingSectionFromSummary
        case missingItemFromSummarySection
        case canNotExtractValueFromSummaryItem(value: String, item: String)
        case appDelegateNotFound
    }
    
    public enum Realm: Error {
        case unableToDelete
    }
    
    public enum Images: Error {
        case unableToLoad
    }
    
    public enum DeviceAuthorizations: Error {
        case pushNotificationsNotAllowed
        case photosAccessNotAllowed
    }
    
    public enum System: Error {
        case unableToRefresh
    }
    
    public enum LocalStorage: Error {
        case valueNotFound
    }
    
    public enum TrueVaultStorage: Error {
        case unableToSaveData
    }
    
    public enum TextDetection: Error {
        case textNotFound
    }
}
