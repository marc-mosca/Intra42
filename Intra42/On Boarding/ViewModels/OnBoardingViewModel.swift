//
//  OnBoardingViewModel.swift
//  Intra42
//
//  Created by Marc Mosca on 01/01/2024.
//

import AuthenticationServices
import Observation
import SwiftUI

extension OnBoardingView
{
    
    @Observable
    final class ViewModel
    {
        
        // MARK: - Exposed methods
        
        func signIn(webAuthenticationSession: WebAuthenticationSession) async -> Bool
        {
            let authorizeURL = Api.Endpoint.authorize.url
            let callbackURLScheme = Api.Keys.redirectURI.value.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
            
            guard let callbackURLScheme = callbackURLScheme else { return false }
            
            do
            {
                let urlWithCode = try await webAuthenticationSession.authenticate(using: authorizeURL, callbackURLScheme: callbackURLScheme)
                let queryItems = URLComponents(string: urlWithCode.absoluteString)?.queryItems
                
                guard let code = queryItems?.first(where: { $0.name == "code" })?.value else { return false }
                
                let userToken = try await Api.Client.shared.request(for: .fetchUserAccessToken(code: code)) as Api.Types.OAuth.UserToken
                let applicationToken = try await Api.Client.shared.request(for: .fetchApplicationAccessToken) as Api.Types.OAuth.AppToken
                
                try Api.Keychain.shared.save(account: .applicationAccessToken, data: applicationToken.accessToken)
                try Api.Keychain.shared.save(account: .userAccessToken, data: userToken.accessToken)
                try Api.Keychain.shared.save(account: .userRefreshToken, data: userToken.refreshToken)
                
                return true
            }
            catch
            {
                return false
            }
        }
        
    }
    
}
