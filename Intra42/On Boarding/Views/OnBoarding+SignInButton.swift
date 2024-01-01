//
//  OnBoarding+SignInButton.swift
//  Intra42
//
//  Created by Marc Mosca on 01/01/2024.
//

import SwiftUI

extension OnBoardingView
{
    
    struct SignInButton: View
    {
        
        // MARK: - Exposed properties
        
        let placeholder: String.LocalizationValue
        let action: () -> Void
        
        // MARK: - Private properties
        
        private var buttonPlaceholder: String
        {
            String(localized: placeholder)
        }
        
        // MARK: - Body
        
        var body: some View
        {
            Button(buttonPlaceholder, action: action)
                .font(.body.bold())
                .foregroundStyle(.white)
                .frame(height: 50)
                .frame(maxWidth: .infinity)
                .background(.night)
                .clipShape(.buttonBorder)
        }
        
    }
    
}
