//
//  Profile+Informations.swift
//  Intra42
//
//  Created by Marc Mosca on 05/01/2024.
//

import SwiftUI

extension ProfileView
{
    
    struct Informations: View
    {
        
        // MARK: - Exposed properties
        
        let name: String
        let email: String
        let isPostCC: Bool
        let cursus: Api.Types.User.Cursus?
        
        // MARK: - Private properties
        
        private var level: Double
        {
            guard let cursusLevel = cursus?.level else { return 0.0 }
            
            return cursusLevel > 21 ? 21 : cursusLevel
        }
        
        // MARK: - Body
        
        var body: some View
        {
            VStack(alignment: .leading, spacing: 20)
            {
                
                // User informations
                
                VStack(alignment: .leading)
                {
                    HStack(alignment: .top)
                    {
                        Text(name)
                            .foregroundStyle(.primary)
                            .font(.system(.title2, weight: .bold))
                        
                        Spacer()
                        
                        if isPostCC
                        {
                            Image(systemName: "checkmark.seal.fill")
                                .imageScale(.small)
                                .padding(.vertical, 4)
                                .foregroundStyle(.night)
                        }
                    }
                    
                    Text(email)
                        .foregroundStyle(.secondary)
                        .font(.footnote)
                }
                
                // Cursus progress bar
                
                ProgressView(value: level, total: 21)
                {
                    HStack
                    {
                        Image(systemName: "trophy")
                            .imageScale(.small)
                            .font(.subheadline)
                            .fontWeight(.medium)
                        
                        Text("Level - \(cursus?.level.formatted() ?? "0")")
                            .font(.footnote)
                            .fontWeight(.medium)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text(cursus?.cursus.name ?? "N/A")
                            .foregroundStyle(.secondary)
                            .font(.caption)
                    }
                }
                .tint(.night)
                
            }
        }
        
    }
    
}
