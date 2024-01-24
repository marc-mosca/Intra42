//
//  ProjectRow.swift
//  Intra42
//
//  Created by Marc Mosca on 23/01/2024.
//

import SwiftUI

struct ProjectRow: View {
    
    // MARK: - Properties
    
    let project: Api.Types.User.Projects
    let cursus: [Api.Types.User.Cursus]
    
    private var image: String {
        guard let validated = project.validated else { return "timer" }
        
        return validated ? "checkmark.circle" : "xmark.circle"
    }
    
    private var color: Color {
        guard let validated = project.validated else { return .orange }
        
        return validated ? .green : .red
    }
    
    private var status: String {
        
        if project.validated == nil {
            return String(localized: "In progress")
        }
        
        return String(localized: "Finished")
    }
    
    private var cursusName: String {
        let projectCursus = cursus.first(where: { $0.cursus.id == project.cursusIds.first })
        
        return projectCursus?.cursus.name ?? "N/A"
    }
    
    // MARK: - Body
    
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: image)
                .foregroundStyle(color)
                .font(.headline)
                .imageScale(.large)
            
            VStack(alignment: .leading) {
                Text(project.project.name)
                    .foregroundStyle(.primary)
                    .font(.system(.subheadline, weight: .bold))
                
                Text("\(cursusName) - \(status)")
                    .foregroundStyle(.secondary)
                    .font(.footnote)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            if let finalMark = project.finalMark {
                Text("\(finalMark.formatted()) %")
                    .foregroundStyle(color)
                    .font(.system(.subheadline, weight: .bold))
            }
        }
        .padding(.vertical, 8)
    }
}

// MARK: - Previews

#Preview {
    ProjectRow(project: .sample, cursus: .sample)
}
