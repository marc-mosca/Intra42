//
//  URLQueryItem+Api.swift
//  Intra42
//
//  Created by Marc Mosca on 12/01/2024.
//

import Foundation

extension URLQueryItem {
    
    enum ApiSortedOptions: String {
        case beginAt = "begin_at"
        case beginAtReversed = "-begin_at"
        case createdAtReversed = "-created_at"
    }
    
    enum ApiGrantTypesOptions: String {
        case clientCredentials = "client_credentials"
        case authorizationCode = "authorization_code"
        case refreshToken = "refresh_token"
    }
    
    static let clientId = Self.init(name: "client_id", value: Api.Keys.clientID.value)
    static let secretId = Self.init(name: "client_secret", value: Api.Keys.secretID.value)
    static let redirectUri = Self.init(name: "redirect_uri", value: Api.Keys.redirectURI.value)
    static let scope = Self.init(name: "scope", value: "public+projects+profile")
    static let pageSize = Self.init(name: "page[size]", value: "100")
    static let filterFuture = Self.init(name: "filter[future]", value: "true")
    
    static func sort(by: ApiSortedOptions) -> Self {
        .init(name: "sort", value: by.rawValue)
    }
    
    static func grantType(_ value: ApiGrantTypesOptions) -> Self {
        .init(name: "grant_type", value: value.rawValue)
    }
    
    static func custom(name: String, value: String) -> Self {
        .init(name: name, value: value)
    }
    
}
