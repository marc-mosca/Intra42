//
//  OnBoarding+Paragraph.swift
//  Intra42
//
//  Created by Marc Mosca on 01/01/2024.
//

import SwiftUI

extension OnBoardingView
{
    
    struct Paragraph: View
    {
        
        // MARK: - Body
        
        var body: some View
        {
            VStack(spacing: 50)
            {
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
        
        // MARK: - Private components
        
        private func paragraph(icon: String, title: String.LocalizationValue, description: String.LocalizationValue) -> some View
        {
            let paragraphTitle = String(localized: title)
            let paragraphDescription = String(localized: description)
            
            return HStack(alignment: .top, spacing: 20)
            {
                Image(systemName: icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                
                VStack(alignment: .leading)
                {
                    Text(paragraphTitle)
                        .foregroundStyle(.primary)
                        .font(.system(.title3, weight: .bold))
                        .lineLimit(1)
                    
                    Text(paragraphDescription)
                        .foregroundStyle(.secondary)
                        .font(.subheadline)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        
    }
    
}
