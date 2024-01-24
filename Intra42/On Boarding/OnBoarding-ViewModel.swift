//
//  OnBoarding-ViewModel.swift
//  Intra42
//
//  Created by Marc Mosca on 22/01/2024.
//

import AuthenticationServices
import SwiftUI

extension OnBoardingView {
    
    @Observable
    final class ViewModel {
        
        // MARK: - Properties
        
        private(set) var userIsConnected = false {
            didSet {
                UserDefaults.standard.set(userIsConnected, forKey: AppStorageKeys.userIsConnected.rawValue)
            }
        }
        
        init() {
            self.userIsConnected = UserDefaults.standard.bool(forKey: AppStorageKeys.userIsConnected.rawValue)
        }
        
        // MARK: - Methods
        
        func signIn(store: Store, webAuthenticationSession: WebAuthenticationSession) {
            Task {
                let authorizeURL = Api.Endpoints.authorize.url
                let callbackURLScheme = Api.Keys.redirectURI.value.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
                
                do {
                    guard let callbackURLScheme = callbackURLScheme else { throw AppError.apiAuthorization }
                    
                    let urlWithCode = try await webAuthenticationSession.authenticate(using: authorizeURL, callbackURLScheme: callbackURLScheme)
                    let queryItems = URLComponents(string: urlWithCode.absoluteString)?.queryItems
                    
                    guard let code = queryItems?.first(where: { $0.name == "code" })?.value else { throw AppError.apiAuthorization }
                    
                    let userToken = try await Api.Client.shared.request(for: .fetchUserAccessToken(code: code)) as Api.Types.OAuth.UserToken
                    let applicationToken = try await Api.Client.shared.request(for: .fetchApplicationAccessToken) as Api.Types.OAuth.AppToken
                    
                    try Api.Keychain.shared.save(account: .applicationAccessToken, data: applicationToken.accessToken)
                    try Api.Keychain.shared.save(account: .userAccessToken, data: userToken.accessToken)
                    try Api.Keychain.shared.save(account: .userRefreshToken, data: userToken.refreshToken)
                    
                    userIsConnected = true
                }
                catch {
                    store.error = .apiAuthorization
                    userIsConnected = false
                }
            }
        }
        
    }
    
}
