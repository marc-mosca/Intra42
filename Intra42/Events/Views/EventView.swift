//
//  EventView.swift
//  Intra42
//
//  Created by Marc Mosca on 03/01/2024.
//

import SwiftUI

struct EventView: View
{
    
    // MARK: - Private properties
    
    @Environment(\.store) private var store
    @AppStorage("userIsConnected") private var userIsConnected: Bool?
    @State private var viewModel = ViewModel()
    
    private var filters: [String]
    {
        viewModel.fetchFilters(events: store.campusEvents)
    }
    
    // MARK: - Body
    
    var body: some View
    {
        NavigationStack
        {
            VStack
            {
                EventPicker(selection: $viewModel.selection)
            }
            .navigationTitle("Events")
            .padding()
            .searchable(text: $viewModel.searched)
            .onChange(of: viewModel.selection, viewModel.resetFilterOnCategoryChange)
            .toolbar
            {
                ToolbarItem
                {
                    FilterButton(selection: $viewModel.selectedFilter, filters: filters)
                }
            }
        }
    }
}

// MARK: - Previews

#Preview
{
    EventView()
}
