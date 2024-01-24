//
//  Profile+UserAchievements.swift
//  Intra42
//
//  Created by Marc Mosca on 24/01/2024.
//

import SwiftUI

extension ProfileView {
    
    struct UserAchievements: View {
        
        // MARK: - Properties
        
        @Binding var viewModel: ViewModel
        
        let achievements: [Api.Types.User.Achievements]
        
        private var achievementsFiltered: [Api.Types.User.Achievements] {
            viewModel.filteredAchievements(achievements: achievements)
        }
        
        // MARK: - Body
        
        var body: some View {
            VStack {
                if !achievements.isEmpty {
                    List(achievementsFiltered) {
                        VRow(title: "\($0.name)", value: $0.description)
                    }
                    .searchable(text: $viewModel.searchedAchievement)
                    .overlay {
                        if achievementsFiltered.isEmpty {
                            ContentUnavailableView.search(text: viewModel.searchedAchievement)
                        }
                    }
                }
                else {
                    ContentUnavailableView(
                        "No achievements found",
                        systemImage: "graduationcap",
                        description: Text("Achieved objectives to obtain achievements.")
                    )
                }
            }
            .navigationTitle("Achievements")
            .toolbar {
                ToolbarItem {
                    FilterButton(selection: $viewModel.selectedAchievementFilter, filters: viewModel.achievementsFilters(for: achievements))
                }
            }
        }
        
    }
    
}
