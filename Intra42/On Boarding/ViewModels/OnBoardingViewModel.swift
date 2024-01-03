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
                
                try await Api.Client.shared.request(for: .fetchUserAccessToken(code: code))
                try await Api.Client.shared.request(for: .fetchApplicationAccessToken)
                
                return true
            }
            catch
            {
                return false
            }
        }
        
    }
    
}
