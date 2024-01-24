//
//  ScaleRow.swift
//  Intra42
//
//  Created by Marc Mosca on 23/01/2024.
//

import SwiftUI

struct ScaleRow: View {
    
    // MARK: - Properties
    
    @Environment(\.store) private var store
    
    let scale: Api.Types.Scale
    
    private var scaleTime: (Int, Int, Int)? {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day, .hour, .minute], from: .now, to: scale.beginAt)
        
        guard let days = components.day, let hours = components.hour, let minutes = components.minute else { return nil }
        
        return (days, hours, minutes)
    }
    
    private var scaleProjectName: String {
        guard let user = store.user else { return String(localized: "N/A") }
        guard let scaleProjectId = scale.teams?.projectId else { return String(localized: "N/A") }
        
        if user.projectsUsers.contains(where: { $0.project.id == scaleProjectId }) {
            return user.projectsUsers.first(where: { $0.project.id == scaleProjectId })!.project.name
        }
        
        Task {
            let scaleProject = try? await Api.Client.shared.request(for: .fetchProject(id: scaleProjectId)) as Api.Types.User.Projects.Details
            
            return scaleProject?.name ?? String(localized: "N/A")
        }
        
        return String(localized: "N/A")
    }
    
    private var title: String {
        guard let user = store.user, let corrector = scale.corrector?.uValue else { return "Undefined error." }
        
        var time = "N/A"
        
        if let (days, hours, minutes) = scaleTime {
            time = days > 0 ? "\(days) days" : hours > 0 ? "\(hours) hours" : "\(minutes) minutes"
        }
        
        if corrector.id == user.id {
            return String(localized: "You will evaluate \(scale.teamName) on \(scaleProjectName) in \(time).")
        }
        
        return String(localized: "You will be evaluated by \(scale.teamName) on \(scaleProjectName) in \(time).")
    }
    
    // MARK: - Body
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: "person.badge.clock")
                .foregroundStyle(.night)
                .font(.headline)
                .imageScale(.large)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .foregroundStyle(.primary)
                    .font(.subheadline)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.vertical, 8)
    }
}

// MARK: - Previews

#Preview {
    ScaleRow(scale: .sample)
}
