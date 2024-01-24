//
//  OnBoardingView.swift
//  Intra42
//
//  Created by Marc Mosca on 22/01/2024.
//

import AuthenticationServices
import SwiftUI

struct OnBoardingView: View {
    
    // MARK: - Properties
    
    @Environment(\.store) private var store
    @Environment(\.webAuthenticationSession) private var webAuthenticationSession
    
    @AppStorage(AppStorageKeys.userIsConnected.rawValue) private var userIsConnected: Bool?
    
    @State private var viewModel = ViewModel()
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            VStack(spacing: 50) {
                WelcomeTitle
                Paragraph
            }
            .frame(maxHeight: .infinity, alignment: .top)
            
            VStack(spacing: 10) {
                SignInButton(placeholder: "Sign in") {
                    viewModel.signIn(store: store, webAuthenticationSession: webAuthenticationSession)
                }
                .onChange(of: viewModel.userIsConnected) { userIsConnected = viewModel.userIsConnected }
                
                Text("Developed by Marc MOSCA while eating 🍿")
                    .foregroundStyle(.secondary)
                    .font(.caption2)
                    .frame(maxWidth: .infinity)
                    .slideIn(rowHeight: 50, duration: 1, delay: 0.9)
            }
        }
        .padding()
    }
    
}

// MARK: - Previews

#Preview {
    OnBoardingView()
}

// MARK: - Components extension

extension OnBoardingView {
    
    // - Components
    
    private var WelcomeTitle: some View {
        VStack(alignment: .leading) {
            Text("Welcome to")
                .foregroundStyle(.primary)
            
            Text("Intra42")
                .foregroundStyle(.night)
        }
        .font(.system(size: 44, weight: .heavy))
        .lineSpacing(1.0)
        .multilineTextAlignment(.center)
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
        .slideIn(rowHeight: 50, duration: 1, delay: 0.2)
    }
    
    private var Paragraph: some View {
        VStack(spacing: 50) {
            paragraph(
                icon: "list.bullet.clipboard",
                title: "Your activities",
                description: "View and manage your upcoming events, examinations and corrections."
            )
            .slideIn(rowHeight: 50, duration: 1, delay: 0.4)
            
            paragraph(
                icon: "magnifyingglass",
                title: "Connectivity",
                description: "Search and view the profile of any other student on the worldwide 42 network."
            )
            .slideIn(rowHeight: 50, duration: 1, delay: 0.5)
            
            paragraph(
                icon: "person",
                title: "Your profile",
                description: "View your projects, your logtime, your events and much more information about your course."
            )
            .slideIn(rowHeight: 50, duration: 1, delay: 0.6)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private func SignInButton(placeholder: String.LocalizationValue, action: @escaping () -> Void) -> some View {
        Button(String(localized: placeholder), action: action)
            .font(.system(.body, weight: .bold))
            .foregroundStyle(.white)
            .frame(height: 50)
            .frame(maxWidth: .infinity)
            .background(.night)
            .clipShape(.buttonBorder)
            .slideIn(rowHeight: 50, duration: 1, delay: 0.8)
    }
    
    // - Utilities
    
    private func paragraph(icon: String, title: String.LocalizationValue, description: String.LocalizationValue) -> some View {
        HStack(alignment: .top, spacing: 20) {
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
            
            VStack(alignment: .leading) {
                Text(String(localized: title))
                    .foregroundStyle(.primary)
                    .font(.system(.title3, weight: .bold))
                    .lineLimit(1)
                
                Text(String(localized: description))
                    .foregroundStyle(.secondary)
                    .font(.subheadline)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
}
