//
//  Profile-ViewModel.swift
//  Intra42
//
//  Created by Marc Mosca on 24/01/2024.
//

import Algorithms
import Foundation

extension ProfileView {
    
    @Observable
    final class ViewModel {
        
        // MARK: - Properties
        
        private(set) var user: Api.Types.User?
        private(set) var loadingState = AppLoadingState.succeded
        
        // - Projects
        
        var selectedProjectFilter = String(localized: "All")
        var searchedProject = ""
        
        // - Events
        
        var selectedEventFilter = String(localized: "All")
        var searchedEvent = ""
        
        // - Logtime
        
        private(set) var logtimes = [Api.Types.Logtime]()
        
        var formattedLogtimes: [Api.Types.Logtime]
        {
            guard !logtimes.contains(where: { $0.fullmonth == Date.currentMonthDate }) else { return logtimes }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM yyyy"
            
            guard let date = dateFormatter.date(from: Date.currentMonthDate) else { return logtimes }
            
            dateFormatter.dateFormat = "yyyy-MM"
            let month = dateFormatter.string(from: date)
            
            let currentMonthLogtime =  Api.Types.Logtime(
                month: month,
                total: Date.currentMonthLogtime(logtimes),
                details: Api.Types.LogtimeResult(),
                numberOfDaysToWork: Date.getNumberOfDaysToWorkPerMonth(month)
            )
            logtimes.insert(currentMonthLogtime, at: 0)
            
            return logtimes
        }
        
        // - Corrections
        
        private(set) var correctionPointHistorics = [Api.Types.CorrectionPointHistorics]()
        var slots = [Api.Types.Slot]()
        var showCorrectionSheet = false
        
        var defaultBeginAt = Date(timeIntervalSinceNow: 2_700)
        var defaultEndBeginAt = Date(timeIntervalSinceNow: 1_204_200)
        var defaultEndAt = Date(timeIntervalSinceNow: 1_207_800)
        var beginAt = Date(timeIntervalSinceNow: 2_700)
        var endAt = Date(timeIntervalSinceNow: 6_300)
        
        var slotsAvailable: [Api.Types.GroupedSlots] {
            let slotsAvailable = slots.filter { $0.scaleTeam == nil }
            
            return Api.Types.GroupedSlots.create(for: slotsAvailable)
        }
        
        var slotsTaken: [Api.Types.GroupedSlots] {
            let slotsTaken = slots.filter { $0.scaleTeam != nil }
            
            return Api.Types.GroupedSlots.create(for: slotsTaken)
        }
        
        // - Achievements
        
        var selectedAchievementFilter = String(localized: "All")
        var searchedAchievement = ""
        
        // - Patronages
        
        var patronedList = [Api.Types.User]()
        var patroningList = [Api.Types.User]()
        var firstLoad = true
        
        // MARK: - Methods
        
        func updateUserInformations(store: Store, for oldUser: Api.Types.User) {
            Task {
                loadingState = .loading
                
                do {
                    user = try await Api.Client.shared.request(for: .fetchUserById(id: oldUser.id))
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
        
        // - Projects
        
        func projectsFilters(for cursus: [Api.Types.User.Cursus]) -> [String] {
            var filtersSet = Set(cursus.map(\.cursus.name.capitalized))
            filtersSet.insert(String(localized: "All"))
            return Array(filtersSet).sorted()
        }
        
        func filteredProjects(projects: [Api.Types.User.Projects], cursus: [Api.Types.User.Cursus]) -> [[Api.Types.User.Projects]] {
            let cursusId = cursus.first(where: { $0.cursus.name.capitalized == selectedProjectFilter })?.cursus.id
            let filteredProjects = selectedProjectFilter != String(localized: "All") ? projects.filter { $0.cursusIds.first == cursusId } : projects
            let projectsFiltered = !searchedProject.isEmpty ? filteredProjects.filter { $0.project.name.lowercased().contains(searchedProject.lowercased()) } : filteredProjects
            let projects = projectsFiltered.sorted(by: { $0.markedAt ?? .now > $1.markedAt ?? .now })
            let projectsChucked = projects.chunked { lhs, rhs in
                guard let lhsMarkedAt = lhs.markedAt, let rhsMarkedAt = rhs.markedAt else { return false }
                
                return Calendar.current.isDate(lhsMarkedAt, equalTo: rhsMarkedAt, toGranularity: .month)
            }
            
            return projectsChucked.map { Array($0) }
        }
        
        // - Events
        
        func eventsFilters(for events: [Api.Types.Event]) -> [String] {
            var filtersSet = Set(events.map(\.kind.capitalized))
            filtersSet.insert(String(localized: "All"))
            return Array(filtersSet).sorted()
        }
        
        func filteredEvents(events: [Api.Types.Event]) -> [[Api.Types.Event]] {
            let filteredEvents = selectedEventFilter != String(localized: "All") ? events.filter { $0.kind.capitalized == selectedEventFilter } : events
            let eventsFiltered = !searchedEvent.isEmpty ? filteredEvents.filter { $0.name.lowercased().contains(searchedEvent.lowercased()) } : filteredEvents
            let events = eventsFiltered.sorted(by: { $0.beginAt > $1.beginAt })
            let eventsChuncked = events.chunked(by: { Calendar.current.isDate($0.beginAt, equalTo: $1.beginAt, toGranularity: .month) })
            
            return eventsChuncked.map { Array($0) }
        }
        
        // - Logtime
        
        func fetchUserLogtime(store: Store) async {
            guard let user = store.user else { return }
            
            loadingState = .loading
            
            do {
                let logtime = try await Api.Client.shared.request(for: .fetchLogtime(login: user.login, entryDate: user.entryDate)) as Api.Types.LogtimeResult
                logtimes = convertLogtimeResultToLogtimeData(logtimeResult: logtime)
            }
            catch AppError.apiAuthorization {
                store.error = .apiAuthorization
            }
            catch {
                store.error = .network
            }
            
            loadingState = .succeded
        }
        
        private func convertLogtimeResultToLogtimeData(logtimeResult: Api.Types.LogtimeResult) -> [Api.Types.Logtime] {
            var monthData = [Api.Types.Logtime]()
            var monthlyData = [String: Double]()
            
            for (date, time) in logtimeResult {
                let components = date.split(separator: "-")
                let yearMonth = "\(components[0])-\(components[1])"
                
                let timeComponents = time.components(separatedBy: ":")
                let hours = Double(timeComponents[0]) ?? 0.0
                let minutes = Double(timeComponents[1]) ?? 0.0
                let seconds = Double(timeComponents[2].components(separatedBy: ".").first ?? "0.0") ?? 0.0
                
                let totalHours = hours + minutes / 60.0 + seconds / 3600.0
                monthlyData[yearMonth, default: 0.0] += totalHours
            }
            
            monthData = monthlyData.map { month, totalHours in
                let logtime = logtimeResult.filter { $0.key.contains(month) }
                let numberOfDaysToWork = Date.getNumberOfDaysToWorkPerMonth(month)
                
                return Api.Types.Logtime(month: month, total: totalHours, details: logtime, numberOfDaysToWork: numberOfDaysToWork)
            }
            
            monthData.sort(by: { $0.month > $1.month })
            
            return monthData
        }
        
        // - Corrections
        
        func fetchUserCorrections(store: Store) async {
            guard let user = store.user else { return }
            
            loadingState = .loading
            
            do {
                correctionPointHistorics = try await Api.Client.shared.request(for: .fetchCorrectionPointHistorics(userId: user.id))
                slots = try await Api.Client.shared.request(for: .fetchUserSlots)
            }
            catch AppError.apiAuthorization {
                store.error = .apiAuthorization
            }
            catch {
                store.error = .network
            }
            
            loadingState = .succeded
        }
        
        func toggleCorrectionSlotSheet() {
            showCorrectionSheet = true
        }
        
        func onDeleteCorrectionSlot(indexSet: IndexSet, store: Store) {
            Task {
                loadingState = .loading
                
                for index in indexSet {
                    guard slotsAvailable.count > index else { return }
                    
                    for slot in slotsAvailable[index].slots {
                        guard slot.scaleTeam == nil else { return }
                    }
                    
                    for slotId in slotsAvailable[index].slotsIds {
                        do {
                            try await Api.Client.shared.request(for: .deleteUserSlot(slotId: slotId))
                        }
                        catch AppError.apiAuthorization {
                            store.error = .apiAuthorization
                        }
                        catch {
                            store.error = .network
                        }
                    }
                }
                
                do {
                    slots = try await Api.Client.shared.request(for: .fetchUserSlots)
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
        
        func onBeginAtChange() {
            let date = Date(timeInterval: 3_600, since: beginAt)
            
            guard let difference = Calendar.current.dateComponents([.hour], from: beginAt, to: endAt).hour, difference <= 1 else { return }
            
            if date < defaultEndAt {
                endAt = date
            }
        }
        
        func createCorrectionSlot(store: Store) {
            guard beginAt < endAt else { return }
            guard let user = store.user else { return }
            guard let difference = Calendar.current.dateComponents([.hour], from: beginAt, to: endAt).hour, difference >= 1 else { return }
            
            Task {
                do {
                    try await Api.Client.shared.request(for: .createUserSlot(userId: user.id, beginAt: beginAt, endAt: endAt))
                    slots = try await Api.Client.shared.request(for: .fetchUserSlots)
                }
                catch AppError.apiAuthorization {
                    store.error = .apiAuthorization
                }
                catch {
                    store.error = .network
                }
            }
            showCorrectionSheet = false
        }
        
        // - Achievements
        
        func achievementsFilters(for achievements: [Api.Types.User.Achievements]) -> [String] {
            var filtersSet = Set(achievements.map(\.kind.capitalized))
            filtersSet.insert(String(localized: "All"))
            return Array(filtersSet).sorted()
        }
        
        func filteredAchievements(achievements: [Api.Types.User.Achievements]) -> [Api.Types.User.Achievements] {
            let filteredAchievements = selectedAchievementFilter != String(localized: "All") ? achievements.filter { $0.kind.capitalized == selectedAchievementFilter } : achievements
            
            guard !searchedAchievement.isEmpty else { return filteredAchievements }
            
            return filteredAchievements.filter { $0.name.lowercased().contains(searchedAchievement.lowercased()) }
        }
        
        // - Patronages
        
        func fetchUserPatronages(store: Store, patroned: [Api.Types.User.Patronages], patroning: [Api.Types.User.Patronages]) async {
            loadingState = .loading
            
            do {
                for patronages in patroned {
                    let user = try await Api.Client.shared.request(for: .fetchUserById(id: patronages.godfatherId)) as Api.Types.User
                    patronedList.append(user)
                }
                
                for patronages in patroning {
                    let user = try await Api.Client.shared.request(for: .fetchUserById(id: patronages.userId)) as Api.Types.User
                    patroningList.append(user)
                }
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
    
}
