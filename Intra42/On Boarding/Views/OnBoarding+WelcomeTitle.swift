//
//  OnBoarding+WelcomeTitle.swift
//  Intra42
//
//  Created by Marc Mosca on 01/01/2024.
//

import SwiftUI

extension OnBoardingView
{
    
    struct WelcomeTitle: View
    {
        
        // MARK: - Private properties
        
        @Environment(\.horizontalSizeClass) private var horizontalSizeClass
        
        private var fontSize: CGFloat
        {
            horizontalSizeClass == .regular ? 80 : 44
        }
        
        // MARK: - Body
        
        var body: some View
        {
            VStack(alignment: .leading)
            {
                Text("Welcome to")
                    .foregroundStyle(.primary)
                    .accessibilityLabel("Welcome to")
                
                Text("Intra42")
                    .foregroundStyle(.night)
                    .accessibilityLabel("Intra42")
            }
            .font(.system(size: fontSize, weight: .heavy))
            .lineSpacing(1.0)
            .multilineTextAlignment(.center)
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            .accessibilityHint("Headline")
            .accessibilityAddTraits(.isStaticText)
            .allowsTightening(true)
            .minimumScaleFactor(0.5)
        }
    }
    
}
