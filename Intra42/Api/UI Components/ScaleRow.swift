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
    let projects: [Int: String]
    
    private var scaleTime: (Int, Int, Int, Int, Int)? {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: .now, to: scale.beginAt)
        
        guard let year = components.year, let month = components.month, let days = components.day, let hours = components.hour, let minutes = components.minute else { return nil }
        
        return (year, month, days, hours, minutes)
    }
    
    private var title: String {
        guard let user = store.user else { return "UNDEFINED ERROR" }
        let projectName = projects.first(where: { $0.key == scale.teams?.projectId })?.value
        
        var time = "N/A"
        
        if let (year, month, days, hours, minutes) = scaleTime {
            time = year > 0 ? "\(year) years" : month > 0 ? "\(month) months" : days > 0 ? "\(days) days" : hours > 0 ? "\(hours) hours" : "\(minutes) minutes"
        }
        
        if let value = scale.corrector?.value as? String, value == "invisible" {
            return String(localized: "You will be evaluated by \(scale.teamName) \(projectName == nil ? "" : "on \(projectName!) ")in \(time).")
        }
        else if let value = scale.corrector?.value as? Api.Types.Scale.User {
            if value.id == user.id {
                return String(localized: "You will evaluate \(scale.teamName)\(projectName == nil ? "" : "on \(projectName!) ") in \(time).")
            }
            else {
                return String(localized: "You will be evaluated by \(scale.teamName) \(projectName == nil ? "" : "on \(projectName!) ")in \(time).")
            }
        }
        else {
            return "UNDEFINED ERROR"
        }
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
    ScaleRow(scale: .sample, projects: [:])
}
