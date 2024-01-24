//
//  CampusView.swift
//  Intra42
//
//  Created by Marc Mosca on 24/01/2024.
//

import SwiftUI

struct CampusView: View {
    
    // MARK: - Properties
    
    @Environment(\.store) private var store
    
    @State private var viewModel = ViewModel()
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            VStack {
                CategoryPicker(selection: $viewModel.selection)
                
                if viewModel.loadingState != .succeded {
                    ProgressView()
                        .frame(maxHeight: .infinity)
                }
                else {
                    switch viewModel.selection {
                    case .events:           Events(viewModel.futureEvents(store.campusEvents))
                    case .exams:            Exams(viewModel.futureExams(store.campusExams))
                    }
                }
            }
            .navigationTitle("My campus")
            .padding()
            .searchable(text: $viewModel.searched)
            .onChange(of: viewModel.selection, viewModel.resetSelectedFilter)
            .toolbar {
                ToolbarItemGroup {
                    FilterButton(selection: $viewModel.selectedFilter, filters: viewModel.filters(for: store.campusEvents))
                    RefreshButton(state: viewModel.loadingState) {
                        viewModel.updateCampusActivities(store: store)
                    }
                }
            }
        }
    }
    
}

// MARK: - Previews

#Preview {
    CampusView()
}

// MARK: - Components extension

extension CampusView {
    
    func CategoryPicker(selection: Binding<CampusPickerCategory>) -> some View {
        Picker("Select an activity category", selection: selection) {
            ForEach(CampusPickerCategory.allCases) {
                Text($0.title)
            }
        }
        .pickerStyle(.segmented)
    }
    
    @ViewBuilder
    func Events(_ events: [Api.Types.Event]) -> some View {
        if !events.isEmpty {
            List(events, rowContent: EventRow.init)
                .listStyle(.plain)
        }
        else {
            ContentUnavailableView(
                "No events planned",
                systemImage: "calendar",
                description: Text("Register for an event offered by your campus to see it appear here.")
            )
        }
    }
    
    @ViewBuilder
    func Exams(_ exams: [Api.Types.Exam]) -> some View {
        if !exams.isEmpty {
            List(exams, rowContent: ExamRow.init)
                .listStyle(.plain)
        }
        else {
            ContentUnavailableView(
                "No examinations planned",
                systemImage: "scroll.fill",
                description: Text("Register for an exam offered by your campus to see it appear here.")
            )
        }
    }
    
}
