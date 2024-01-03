//
//  AppScreen.swift
//  Intra42
//
//  Created by Marc Mosca on 03/01/2024.
//

import SwiftUI

enum AppScreen: Identifiable, CaseIterable
{
    
    case activities
    case search
    case events
    case profile
    
    var id: Self { self }
    
}

// MARK: - Extensions

extension AppScreen
{
    
    @ViewBuilder
    var label: some View
    {
        switch self
        {
        case .activities:
            Label("Activities", systemImage: "list.bullet.clipboard.fill")
        case .search:
            Label("Search", systemImage: "magnifyingglass")
        case .events:
            Label("Events", systemImage: "calendar")
        case .profile:
            Label("Profile", systemImage: "person.fill")
        }
    }
    
    @ViewBuilder
    var destination: some View
    {
        switch self
        {
        case .activities:
            ActivitiesView()
        case .search:
            Text("Search")
        case .events:
            EventView()
        case .profile:
            Text("Profile")
        }
    }
    
}
