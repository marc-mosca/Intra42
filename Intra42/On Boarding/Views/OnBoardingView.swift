//
//  OnBoardingView.swift
//  Intra42
//
//  Created by Marc Mosca on 01/01/2024.
//

import AuthenticationServices
import SwiftUI

struct OnBoardingView: View
{
    
    // MARK: - Private properties
    
    @Environment(\.webAuthenticationSession) private var webAuthenticationSession
    @Environment(\.store) private var store
    @AppStorage("userIsConnected") private var userIsConnected: Bool?
    @State private var viewModel = ViewModel()
    
    // MARK: - Body
    
    var body: some View
    {
        VStack
        {
            VStack(spacing: 50)
            {
                WelcomeTitle()
                Paragraph()
            }
            .frame(maxHeight: .infinity, alignment: .top)
            
            VStack(spacing: 10)
            {
                SignInButton(placeholder: "Sign In", action: signIn)
                Author()
            }
        }
        .padding()
    }
    
    // MARK: - Private methods
    
    private func signIn()
    {
        Task
        {
            if await viewModel.signIn(webAuthenticationSession: webAuthenticationSession)
            {
                userIsConnected = true
            }
            else
            {
                store.error = .apiAuthorization
            }
        }
    }
    
}

// MARK: - Previews

#Preview
{
    OnBoardingView()
}
