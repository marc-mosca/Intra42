//
//  OnBoardingView.swift
//  Intra42
//
//  Created by Marc Mosca on 01/01/2024.
//

import SwiftUI

struct OnBoardingView: View
{
    
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
                SignInButton(placeholder: "Sign In")
                {
                }
                Author()
            }
        }
        .padding()
    }
}

// MARK: - Previews

#Preview
{
    OnBoardingView()
}
