//
//  ActivitiesView.swift
//  Intra42
//
//  Created by Marc Mosca on 23/01/2024.
//

import SwiftUI

struct ActivitiesView: View {
    
    // MARK: - Properties
    
    @Environment(\.store) private var store
    @State private var viewModel = ViewModel()
    
    private var futuresEvents: [Api.Types.Event] {
        store.userEvents.filter(\.isInFuture)
    }
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            VStack {
                CategoryPicker(selection: $viewModel.selection)
                
                switch viewModel.selection {
                case .corrections:      Corrections
                case .events:           Events
                case .exams:            Exams
                }
            }
            .navigationTitle("My Activities")
            .toolbar {
                ToolbarItem {
                    RefreshButton(state: viewModel.loadingState) {
                        viewModel.updateUserActivitiesInformations(store: store)
                    }
                }
            }
            .task {
                await viewModel.fetchProjectsName(store: store, for: store.userScales)
            }
        }
    }
}

// MARK: - Previews

#Preview {
    ActivitiesView()
}

// MARK: - Components extension

extension ActivitiesView {
    
    func CategoryPicker(selection: Binding<ActivitiesPickerCategory>) -> some View {
        Picker("Select an activity category", selection: selection) {
            ForEach(ActivitiesPickerCategory.allCases) {
                Text($0.title)
            }
        }
        .pickerStyle(.segmented)
        .padding()
    }
    
    @ViewBuilder
    var Corrections: some View {
        if !store.userScales.isEmpty {
            List(store.userScales) { scale in
                ScaleRow(scale: scale, projects: viewModel.projects)
            }
            .listStyle(.plain)
        }
        else
        {
            ContentUnavailableView(
                "No corrections planned",
                systemImage: "person.badge.clock.fill",
                description: Text("When a student takes one of your correction slots to be corrected, you'll see it appear here.")
            )
        }
    }
    
    @ViewBuilder
    var Events: some View {
        if !futuresEvents.isEmpty {
            List(futuresEvents, rowContent: EventRow.init)
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
    var Exams: some View {
        if !store.userExams.isEmpty {
            List(store.userExams, rowContent: ExamRow.init)
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
