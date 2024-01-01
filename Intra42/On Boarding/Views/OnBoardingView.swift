//
//  OnBoardingView.swift
//  Intra42
//
//  Created by Marc Mosca on 01/01/2024.
//

import SwiftUI

struct OnBoardingView: View
{
    
    // MARK: - Private properties
    
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    // MARK: - Body
    
    var body: some View
    {
        VStack(alignment: .leading, spacing: 50)
        {
            WelcomeTitle()
        }
    }
}

// MARK: - Previews

#Preview
{
    OnBoardingView()
}
