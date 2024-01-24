//
//  AppScreen.swift
//  Intra42
//
//  Created by Marc Mosca on 23/01/2024.
//

import SwiftUI

enum AppScreen: Identifiable, CaseIterable {
    
    // MARK: - Properties
    
    case activities, campus, search, profile, settings
    
    var id: Self { self }
    
    // MARK: - Components
    
    @ViewBuilder
    var label: some View {
        switch self {
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
    func destination(user: Api.Types.User) -> some View {
        switch self {
        case .activities:
            ActivitiesView()
        case .campus:
            CampusView()
        case .search:
            SearchView()
        case .profile:
            ProfileView(user: user)
        case .settings:
            SettingsView()
        }
    }
    
}
