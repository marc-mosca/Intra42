//
//  ProfileView.swift
//  Intra42
//
//  Created by Marc Mosca on 04/01/2024.
//

import SwiftUI

struct ProfileView: View
{
    
    // MARK: - Exposed properties
    
    let user: Api.Types.User
    let isSearchedProfile: Bool
    
    init(user: Api.Types.User, isSearchedProfile: Bool = false)
    {
        self.user = user
        self.isSearchedProfile = isSearchedProfile
    }
    
    // MARK: - Body
    
    var body: some View
    {
        NavigationStack
        {
            VStack(spacing: 40)
            {
                HStack(spacing: 20)
                {
                    Avatar(url: user.image.link, isConnected: user.location != nil)
                    Informations(name: user.displayname, email: user.email, isPostCC: user.postCC, cursus: user.mainCursus)
                }
                
                GridInformations(location: user.location, grade: user.mainCursus?.grade, poolYear: user.poolYear)
            }
            .navigationTitle(isSearchedProfile ? "\(user.login.capitalized)'s profile" : "My profile")
            .padding()
        }
    }
    
}

// MARK: - Previews

#Preview
{
    ProfileView(user: .sample)
}
