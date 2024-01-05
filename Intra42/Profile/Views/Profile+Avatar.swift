//
//  Profile+Avatar.swift
//  Intra42
//
//  Created by Marc Mosca on 05/01/2024.
//

import SwiftUI

extension ProfileView
{
    
    struct Avatar: View
    {
        
        // MARK: - Exposed properties
        
        let url: String
        let isConnected: Bool
        
        // MARK: - Body
        
        var body: some View
        {
            AsyncImage(url: URL(string: url))
            {
                $0
                    .resizable()
                    .scaledToFill()
            }
            placeholder:
            {
                Color.gray
            }
            .frame(width: 128, height: 128)
            .clipShape(.circle)
            .padding(3)
            .overlay
            {
                Circle()
                    .fill(.clear)
                    .stroke(isConnected ? .green : .gray, lineWidth: 2)
            }
            .frame(width: 128, height: 128)
        }
        
    }
    
}
