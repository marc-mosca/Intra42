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
    case campus
    case search
    case profile
    case settings
    
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
        case .campus:
            Label("Campus", systemImage: "graduationcap.fill")
        case .search:
            Label("Search", systemImage: "magnifyingglass")
        case .profile:
            Label("Profile", systemImage: "person.fill")
        case .settings:
            Label("Settings", systemImage: "gear")
        }
    }
    
    @ViewBuilder
    var destination: some View
    {
        switch self
        {
        case .activities:
            ActivitiesView()
        case .campus:
            CampusView()
        case .search:
            Text("Search")
        case .profile:
            Text("Profile")
        case .settings:
            Text("Settings")
        }
    }
    
}
