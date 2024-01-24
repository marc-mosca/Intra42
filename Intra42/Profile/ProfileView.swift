//
//  ProfileView.swift
//  Intra42
//
//  Created by Marc Mosca on 24/01/2024.
//

import SwiftUI

struct ProfileView: View {
    
    // MARK: - Properties
    
    @Environment(\.store) private var store
    
    @State private var viewModel = ViewModel()
    
    let user: Api.Types.User
    let isSearchedProfile: Bool
    
    init(user: Api.Types.User, isSearchedProfile: Bool = false) {
        self.user = user
        self.isSearchedProfile = isSearchedProfile
    }
    
    private var userRefresh: Api.Types.User {
        viewModel.user ?? user
    }
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.loadingState != .succeded {
                    ProgressView()
                        .frame(maxHeight: .infinity)
                }
                else {
                    ScrollView {
                        VStack(spacing: 40) {
                            HStack(spacing: 20) {
                                Avatar(url: userRefresh.image.link, isConnected: userRefresh.location != nil)
                                Informations(name: userRefresh.displayname, email: userRefresh.email, isPostCC: userRefresh.postCC, cursus: userRefresh.mainCursus)
                            }
                            
                            GridInformations(location: userRefresh.location, grade: userRefresh.mainCursus?.grade, poolYear: userRefresh.poolYear)
                            Dashboard(user: userRefresh, isSearchedProfile: isSearchedProfile)
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle(isSearchedProfile ? "\(userRefresh.login.capitalized)'s profile" : "My profile")
            .toolbar {
                ToolbarItem {
                    RefreshButton(state: viewModel.loadingState) {
                        viewModel.updateUserInformations(store: store, for: userRefresh)
                    }
                }
            }
        }
    }
    
}

// MARK: - Previews

#Preview {
    ProfileView(user: .sample)
}

// MARK: - Components extension

extension ProfileView {
    
    // - Components
    
    func Avatar(url: String, isConnected: Bool) -> some View {
        AsyncImage(url: URL(string: url)) {
            $0
                .resizable()
                .scaledToFill()
        }
        placeholder: { Color.gray }
        .frame(width: 128, height: 128)
        .clipShape(.circle)
        .padding(3)
        .overlay {
            Circle()
                .fill(.clear)
                .stroke(isConnected ? .green.opacity(0.7) : .gray.opacity(0.5), lineWidth: 2)
        }
        .frame(width: 128, height: 128)
    }
    
    func Informations(name: String, email: String, isPostCC: Bool, cursus: Api.Types.User.Cursus?) -> some View {
        VStack(alignment: .leading, spacing: 20) {
            
            // User informations
            
            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    Text(name)
                        .foregroundStyle(.primary)
                        .font(.system(.title2, weight: .bold))
                    
                    Spacer()
                    
                    if isPostCC {
                        Image(systemName: "checkmark.seal.fill")
                            .imageScale(.small)
                            .padding(.vertical, 4)
                            .foregroundStyle(.night)
                    }
                }
                
                Text(email)
                    .foregroundStyle(.secondary)
                    .font(.footnote)
            }
            
            // Cursus progress bar
            
            ProgressView(value: cursus?.level != nil ? (cursus!.level > 21 ? 21 : cursus!.level) : 0.0, total: 21) {
                HStack {
                    Image(systemName: "trophy")
                        .imageScale(.small)
                        .font(.subheadline)
                        .fontWeight(.medium)
                    
                    Text("Level - \(cursus?.level.formatted() ?? "0")")
                        .font(.footnote)
                        .fontWeight(.medium)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(cursus?.cursus.name ?? "N/A")
                        .foregroundStyle(.secondary)
                        .font(.caption)
                }
            }
            .tint(.night)
        }
    }
    
    func GridInformations(location: String?, grade: String?, poolYear: String) -> some View {
        HStack {
            gridItem(title: String(localized: "Location"), value: location ?? "N/A")
            gridItem(title: String(localized: "Grade"), value: grade ?? "N/A")
            gridItem(title: String(localized: "Promotion"), value: poolYear)
        }
    }
    
    func Dashboard(user: Api.Types.User, isSearchedProfile: Bool) -> some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Dashboard")
                .foregroundStyle(.primary)
                .font(.headline)
            
            List {
                dashboardLink(image: "info.circle", title: "Informations") {
                    UserInformations(user: userRefresh)
                }
                
                dashboardLink(image: "briefcase", title: "Projects") {
                    UserProjects(viewModel: $viewModel, projects: userRefresh.projectsUsers, cursus: userRefresh.cursusUsers)
                }
                
                if !isSearchedProfile {
                    dashboardLink(image: "calendar", title: "Events") {
                        UserEvents(viewModel: $viewModel, events: store.userEvents)
                    }
                    
                    dashboardLink(image: "clock", title: "Logtime") {
                        UserLogtime(viewModel: $viewModel)
                    }
                    
                    dashboardLink(image: "scroll", title: "Corrections") {
                        UserCorrections(viewModel: $viewModel)
                    }
                }
                
                dashboardLink(image: "list.bullet.clipboard", title: "Skills") {
                    UserSkills(skills: user.mainCursus?.skills ?? [])
                }
                
                dashboardLink(image: "graduationcap", title: "Achievements") {
                    UserAchievements(viewModel: $viewModel, achievements: user.achievements)
                }
                
                dashboardLink(image: "person.2", title: "Patronages") {
                    UserPatronages(viewModel: $viewModel, patroned: user.patroned, patroning: user.patroning)
                }
            }
            .listStyle(.plain)
            .frame(minHeight: 70 * CGFloat(integerLiteral: isSearchedProfile ? 5 : 8))
        }
    }
    
    // - Utilities
    
    private func gridItem(title: String, value: String) -> some View {
        VStack(spacing: 8) {
            Text(title)
                .foregroundStyle(.secondary)
                .font(.footnote)
            
            Text(value)
                .foregroundStyle(.primary)
                .font(.system(.body, weight: .semibold))
        }
        .frame(maxWidth: .infinity)
    }
    
    private func dashboardLink(image: String, title: String.LocalizationValue, destination: @escaping () -> some View) -> some View {
        NavigationLink {
            destination()
        }
        label: {
            HStack(spacing: 16) {
                Image(systemName: image)
                    .foregroundStyle(.night)
                    .imageScale(.medium)
                    .font(.headline)
                    .frame(width: 48, height: 48)
                    .background(.thickMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                
                Text(String(localized: title))
                    .foregroundStyle(.primary)
                    .font(.system(.subheadline, weight: .semibold))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxWidth: .infinity, maxHeight: 50)
        }
    }
    
}
