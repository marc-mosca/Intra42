//
//  Profile+UserProjects.swift
//  Intra42
//
//  Created by Marc Mosca on 06/01/2024.
//

import Algorithms
import SwiftUI

extension ProfileView
{
    
    struct UserProjects: View
    {
        
        // MARK: - Exposed properties
        
        let projects: [Api.Types.User.Projects]
        let cursus: [Api.Types.User.Cursus]
        
        // MARK: - Private properties
        
        @State private var selectedFilter = String(localized: "All")
        @State private var searched = ""
        
        private var filters: [String]
        {
            var filtersSet = Set(cursus.map(\.cursus.name.capitalized))
            filtersSet.insert(String(localized: "All"))
            return Array(filtersSet).sorted()
        }
        
        private var projectsFiltered: [Api.Types.User.Projects]
        {
            let cursusId = cursus.first(where: { $0.cursus.name.capitalized == selectedFilter })?.cursus.id
            let filteredProjects = selectedFilter != String(localized: "All") ? projects.filter { $0.cursusIds.first == cursusId } : projects
            
            guard !searched.isEmpty else { return filteredProjects }
            
            return filteredProjects.filter { $0.project.name.lowercased().contains(searched.lowercased()) }
        }
        
        private var projectsChucked: [[Api.Types.User.Projects]]
        {
            let projects = projectsFiltered.sorted(by: { $0.markedAt ?? .now > $1.markedAt ?? .now })
            
            let projectsChucked = projects.chunked { lhs, rhs in
                guard let lhsMarkedAt = lhs.markedAt, let rhsMarkedAt = rhs.markedAt else { return false }
                
                return Calendar.current.isDate(lhsMarkedAt, equalTo: rhsMarkedAt, toGranularity: .month)
            }
            
            return projectsChucked.map { Array($0) }
        }
        
        // MARK: - Body
        
        var body: some View
        {
            List(projectsChucked, id: \.self)
            {
                projectsSection(projects: $0)
            }
            .navigationTitle("Projects")
            .searchable(text: $searched)
            .toolbar
            {
                FilterButton(selection: $selectedFilter, filters: filters)
            }
            .overlay
            {
                if !searched.isEmpty && projectsChucked.isEmpty
                {
                    ContentUnavailableView.search(text: searched)
                }
                else if projectsChucked.isEmpty
                {
                    ContentUnavailableView(
                        "No projects found",
                        systemImage: "briefcase",
                        description: Text("You must register or have submitted a project to perceive it appears in this list.")
                    )
                }
            }
        }
        
        // MARK: - Private components
        
        private func projectsSection(projects: [Api.Types.User.Projects]) -> some View
        {
            Section(projects.first?.markedAtFormatted ?? "In progress")
            {
                ForEach(projects)
                {
                    ProjectRow(project: $0, cursus: cursus)
                }
            }
        }
        
    }
    
}
