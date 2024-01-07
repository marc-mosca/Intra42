//
//  Profile+Dashboard.swift
//  Intra42
//
//  Created by Marc Mosca on 06/01/2024.
//

import SwiftUI

extension ProfileView
{
    
    struct Dashboard: View
    {
        
        // MARK: - Exposed properties
        
        let user: Api.Types.User
        let isSearchedProfile: Bool
        
        // MARK: - Private properties
        
        private var listSize: CGFloat
        {
            70 * CGFloat(integerLiteral: isSearchedProfile ? 5 : 8)
        }
        
        // MARK: - Body
        
        var body: some View
        {
            VStack(alignment: .leading, spacing: 20)
            {
                Text("Dashboard")
                    .foregroundStyle(.primary)
                    .font(.headline)
                
                List
                {
                    DashboardLink(image: "info.circle", title: "Informations")
                    {
                        UserInformations(user: user)
                    }
                    
                    DashboardLink(image: "briefcase", title: "Projects")
                    {
                        UserProjects(projects: user.projectsUsers, cursus: user.cursusUsers)
                    }
                    
                    if !isSearchedProfile
                    {
                        DashboardLink(image: "calendar", title: "Events", destination: UserEvents.init)
                        DashboardLink(image: "clock", title: "Logtime", destination: UserLogtime.init)
                        DashboardLink(image: "scroll", title: "Corrections", destination: EmptyView.init)
                    }
                    
                    DashboardLink(image: "list.bullet.clipboard", title: "Skills")
                    {
                        UserSkills(skills: user.mainCursus?.skills ?? [])
                    }
                    
                    DashboardLink(image: "graduationcap", title: "Achievements")
                    {
                        UserAchievements(achievements: user.achievements)
                    }
                    
                    DashboardLink(image: "person.2", title: "Patronages", destination: EmptyView.init)
                }
                .listStyle(.plain)
                .frame(minHeight: listSize)
            }
        }
        
        // MARK: - Private components
        
        private struct DashboardLink<T: View>: View
        {
            
            // MARK: - Exposed properties
            
            let image: String
            let title: String.LocalizationValue
            let destination: () -> T
            
            // MARK: - Body
            
            var body: some View
            {
                NavigationLink
                {
                    destination()
                }
                label:
                {
                    HStack(spacing: 16)
                    {
                        Image(systemName: image)
                            .foregroundStyle(.night)
                            .imageScale(.medium)
                            .font(.headline)
                            .frame(width: 48, height: 48)
                            .background(.thickMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        
                        Text(String(localized: title))
                            .foregroundStyle(.primary)
                            .font(.system(.subheadline, weight: .semibold))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .frame(maxWidth: .infinity, maxHeight: 50)
                }
            }
            
        }
        
    }
    
}
