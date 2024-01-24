//
//  Profile+UserProjects.swift
//  Intra42
//
//  Created by Marc Mosca on 24/01/2024.
//

import SwiftUI

extension ProfileView {
    
    struct UserProjects: View {
        
        // MARK: - Properties
        
        @Binding var viewModel: ViewModel
        
        let projects: [Api.Types.User.Projects]
        let cursus: [Api.Types.User.Cursus]
        
        private var projectsChuncked: [[Api.Types.User.Projects]] {
            viewModel.filteredProjects(projects: projects, cursus: cursus)
        }
        
        // MARK: - Body
        
        var body: some View {
            List(projectsChuncked, id: \.self) { projectChuncked in
                Section(projectChuncked.first?.markedAtFormatted ?? "In progress") {
                    ForEach(projectChuncked) {
                        ProjectRow(project: $0, cursus: cursus)
                    }
                }
            }
            .navigationTitle("Projects")
            .searchable(text: $viewModel.searchedProject)
            .toolbar {
                ToolbarItem {
                    FilterButton(selection: $viewModel.selectedProjectFilter, filters: viewModel.projectsFilters(for: cursus))
                }
            }
            .overlay {
                if !viewModel.searchedProject.isEmpty && projectsChuncked.isEmpty {
                    ContentUnavailableView.search(text: viewModel.searchedProject)
                }
                else if projectsChuncked.isEmpty {
                    ContentUnavailableView(
                        "No projects found",
                        systemImage: "briefcase",
                        description: Text("You must register or have submitted a project to perceive it appears in this list.")
                    )
                }
            }
        }
        
    }
    
}
