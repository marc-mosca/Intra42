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
        VStack(alignment: .leading, spacing: 50)
        {
            WelcomeTitle()
            Paragraph()
        }
        .padding()
    }
}

// MARK: - Previews

#Preview
{
    OnBoardingView()
}
