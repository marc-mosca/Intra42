//
//  CampusView.swift
//  Intra42
//
//  Created by Marc Mosca on 03/01/2024.
//

import SwiftUI

struct CampusView: View
{
    
    // MARK: - Private properties
    
    @Environment(\.store) private var store
    @AppStorage("userIsConnected") private var userIsConnected: Bool?
    @State private var viewModel = ViewModel()
    
    private var filters: [String]
    {
        viewModel.fetchFilters(events: store.campusEvents)
    }
    
    private var filteredEvents: [Api.Types.Event]
    {
        viewModel.filter(for: store.campusEvents)
    }
    
    private var filteredExams: [Api.Types.Exam]
    {
        viewModel.filter(for: store.campusExams)
    }
    
    // MARK: - Body
    
    var body: some View
    {
        NavigationStack
        {
            VStack
            {
                CampusPicker(selection: $viewModel.selection)
                
                switch viewModel.selection
                {
                case .events:
                    EventsList(events: filteredEvents)
                case .exams:
                    ExamsList(exams: filteredExams)
                }
            }
            .navigationTitle("My campus")
            .padding()
            .searchable(text: $viewModel.searched)
            .onChange(of: viewModel.selection, viewModel.resetFilterOnCategoryChange)
            .toolbar
            {
                ToolbarItemGroup
                {
                    FilterButton(selection: $viewModel.selectedFilter, filters: filters)
                    RefreshButton(state: viewModel.loadingState, action: refreshButtonAction)
                }
            }
        }
    }
    
    // MARK: - Private methods
    
    private func refreshButtonAction()
    {
        Task
        {
            do
            {
                try await viewModel.updateCampusActivities(store: store)
            }
            catch AppError.apiAuthorization
            {
                store.error = .apiAuthorization
                store.errorAction = {
                    Api.Keychain.shared.clear()
                    userIsConnected = false
                }
            }
            catch
            {
                store.error = .network
                store.errorAction = refreshButtonAction
            }
        }
    }
    
}

// MARK: - Previews

#Preview
{
    CampusView()
}
