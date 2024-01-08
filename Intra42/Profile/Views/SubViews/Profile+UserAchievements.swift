//
//  Profile+UserAchievements.swift
//  Intra42
//
//  Created by Marc Mosca on 07/01/2024.
//

import SwiftUI

extension ProfileView
{
    
    struct UserAchievements: View
    {
        
        // MARK: - Exposed properties
        
        let achievements: [Api.Types.User.Achievements]
        
        // MARK: - Private properties
        
        @State private var searched = ""
        @State private var selectedFilter = String(localized: "All")
        
        private var filters: [String]
        {
            var filtersSet = Set(achievements.map(\.kind.capitalized))
            filtersSet.insert(String(localized: "All"))
            return Array(filtersSet).sorted()
        }
        
        private var achievementsFiltered: [Api.Types.User.Achievements]
        {
            let filteredAchievements = selectedFilter != String(localized: "All") ? achievements.filter { $0.kind.capitalized == selectedFilter } : achievements
            
            guard !searched.isEmpty else { return filteredAchievements }
            
            return filteredAchievements.filter { $0.name.lowercased().contains(searched.lowercased()) }
        }
        
        // MARK: - Body
        
        var body: some View
        {
            VStack
            {
                if !achievements.isEmpty
                {
                    List(achievementsFiltered)
                    {
                        VRow(title: "\($0.name)", value: $0.description)
                    }
                    .searchable(text: $searched)
                    .overlay
                    {
                        if achievementsFiltered.isEmpty
                        {
                            ContentUnavailableView.search(text: searched)
                        }
                    }
                }
                else
                {
                    ContentUnavailableView(
                        "No achievements found",
                        systemImage: "graduationcap",
                        description: Text("Achieved objectives to obtain achievements.")
                    )
                }
            }
            .navigationTitle("Achievements")
            .toolbar
            {
                ToolbarItem
                {
                    FilterButton(selection: $selectedFilter, filters: filters)
                }
            }
        }
        
    }
    
}
