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
        
        // MARK: - Exposed properties
        
        enum SignInStatus
        {
            case loading
            case failed
            case success
        }
        
        var signInStatus = SignInStatus.loading
        
        // MARK: - Exposed methods
        
        func signIn(webAuthenticationSession: WebAuthenticationSession) async
        {
            let authorizeURL = Api.Endpoint.authorize.url
            let callbackURLScheme = Api.Keys.redirectURI.value.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
            
            guard let callbackURLScheme = callbackURLScheme
            else
            {
                signInStatus = .failed
                return
            }
            
            do
            {
                let urlWithCode = try await webAuthenticationSession.authenticate(using: authorizeURL, callbackURLScheme: callbackURLScheme)
                let queryItems = URLComponents(string: urlWithCode.absoluteString)?.queryItems
                
                guard let code = queryItems?.first(where: { $0.name == "code" })?.value
                else
                {
                    signInStatus = .failed
                    return
                }
                
                try await Api.Client.shared.request(for: .fetchUserAccessToken(code: code))
                try await Api.Client.shared.request(for: .fetchApplicationAccessToken)
                
                signInStatus = .success
            }
            catch
            {
                signInStatus = .failed
            }
        }
        
    }
    
}
