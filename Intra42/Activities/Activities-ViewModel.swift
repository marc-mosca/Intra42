//
//  Activities-ViewModel.swift
//  Intra42
//
//  Created by Marc Mosca on 23/01/2024.
//

import Foundation

extension ActivitiesView {
    
    enum ActivitiesPickerCategory: Identifiable, CaseIterable {
        
        // MARK: - Properties
        
        case corrections, events, exams
        
        var id: Self { self }
        
        var title: String {
            switch self {
            case .corrections:      return String(localized: "Corrections")
            case .events:           return String(localized: "Events")
            case .exams:            return String(localized: "Exams")
            }
        }
        
    }
    
    @Observable
    final class ViewModel {
        
        // MARK: - Properties
        
        private(set) var loadingState = AppLoadingState.succeded
        var selection = ActivitiesPickerCategory.corrections
        var projects = [Int: String]()
        
        // MARK: - Methods
        
        func updateUserActivitiesInformations(store: Store) {
            guard let user = store.user else { return }
            
            Task {
                loadingState = .loading
                
                do {
                    store.userEvents.removeAll()
                    store.userExams.removeAll()
                    store.userScales.removeAll()
                    
                    store.userEvents = try await Api.Client.shared.request(for: .fetchUserEvents(userId: user.id))
                    store.userExams = try await Api.Client.shared.request(for: .fetchUserExams(userId: user.id))
                    store.userScales = try await Api.Client.shared.request(for: .fetchUserScales)
                }
                catch AppError.apiAuthorization {
                    store.error = .apiAuthorization
                }
                catch {
                    store.error = .network
                }
                
                loadingState = .succeded
            }
        }
        
        func fetchProjectsName(store: Store, for scales: [Api.Types.Scale]) async {
            guard let user = store.user else { return }
            
            loadingState = .loading
            
            for scale in scales {
                guard let scaleProjectId = scale.teams?.projectId else { return }
                
                if let project = user.projectsUsers.first(where: { $0.project.id == scaleProjectId }) {
                    projects[scaleProjectId] = project.project.name
                }
                else {
                    let project = try? await Api.Client.shared.request(for: .fetchProject(id: scaleProjectId)) as Api.Types.User.Projects.Details
                    
                    if let project = project {
                        projects[scaleProjectId] = project.name
                    }
                }
            }
            
            loadingState = .succeded
        }
        
    }
    
}
