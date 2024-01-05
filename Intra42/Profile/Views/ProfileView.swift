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
            VStack
            {
                Avatar(url: user.image.link, isConnected: user.location != nil)
            }
            .navigationTitle("My profile")
        }
    }
    
}

// MARK: - Previews

#Preview
{
    ProfileView(user: .sample)
}
