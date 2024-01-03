//
//  OnBoarding+Author.swift
//  Intra42
//
//  Created by Marc Mosca on 01/01/2024.
//

import SwiftUI

extension OnBoardingView
{
    
    struct Author: View
    {
        
        // MARK: - Body
        
        var body: some View
        {
            Text("Developed by Marc MOSCA while eating 🍿")
                .foregroundStyle(.secondary)
                .font(.caption2)
                .frame(maxWidth: .infinity)
                .slideIn(rowHeight: 50, duration: 1, delay: 0.9)
        }
        
    }
    
}
