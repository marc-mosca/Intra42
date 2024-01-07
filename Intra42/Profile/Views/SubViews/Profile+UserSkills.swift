//
//  Profile+UserSkills.swift
//  Intra42
//
//  Created by Marc Mosca on 07/01/2024.
//

import SwiftUI

extension ProfileView
{
    
    struct UserSkills: View
    {
        
        // MARK: - Exposed properties
        
        let skills: [Api.Types.User.Cursus.Skills]
        
        // MARK: - Body
        
        var body: some View
        {
            VStack
            {
                if !skills.isEmpty
                {
                    List(skills)
                    {
                        HRow(title: "\($0.name)", value: $0.level.formatted())
                    }
                }
                else
                {
                    ContentUnavailableView(
                        "No skills found",
                        systemImage: "list.bullet.clipboard",
                        description: Text("Validate projects to earn skills points.")
                    )
                }
            }
            .navigationTitle("Skills")
        }
        
    }
    
}
