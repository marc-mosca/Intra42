//
//  ProfileViewModel.swift
//  Intra42
//
//  Created by Marc Mosca on 06/01/2024.
//

import Observation
import Foundation

extension ProfileView
{
    
    @Observable
    final class ViewModel
    {
        
        // MARK: - Exposed properties
        
        var loadingState = AppRequestState.succeded
        var user: Api.Types.User?
        
        // MARK: - Exposed methods
        
        func updateUserInformations(oldUser: Api.Types.User) async throws
        {
            user = try await Api.Client.shared.request(for: .fetchUserById(id: oldUser.id))
        }
        
    }
    
}
