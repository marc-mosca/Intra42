//
//  Profile+UserCorrections.swift
//  Intra42
//
//  Created by Marc Mosca on 24/01/2024.
//

import Charts
import SwiftUI

extension ProfileView {
    
    struct UserCorrections: View {
        
        // MARK: - Properties
        
        @Environment(\.store) private var store
        
        @Binding var viewModel: ViewModel
        
        // MARK: - Body
        
        var body: some View {
            VStack {
                if viewModel.loadingState != .succeded {
                    ProgressView()
                        .frame(maxHeight: .infinity)
                }
                else {
                    CorrectionPointHistoricsChart(correctionPoints: store.user?.correctionPoint ?? 0, historics: viewModel.correctionPointHistorics)
                    CorrectionPointHistoricsList(viewModel: $viewModel)
                }
            }
            .navigationTitle("Corrections")
            .task { await viewModel.fetchUserCorrections(store: store) }
            .toolbar {
                ToolbarItemGroup {
                    RefreshButton(state: viewModel.loadingState) {
                        Task {
                            await viewModel.fetchUserCorrections(store: store)
                        }
                    }
                    
                    Button {
                        viewModel.toggleCorrectionSlotSheet()
                    }
                    label: {
                        Label("Add a correction slot", systemImage: "plus")
                            .labelStyle(.iconOnly)
                            .imageScale(.small)
                    }
                    .disabled(viewModel.loadingState != .succeded)
                }
            }
            .sheet(isPresented: $viewModel.showCorrectionSheet) {
                CorrectionSlotSheet(viewModel: $viewModel)
            }
        }
        
        // MARK: - Extensions
        
        private struct CorrectionPointHistoricsChart: View {
            
            // MARK: - Properties
            
            let correctionPoints: Int
            let historics: [Api.Types.CorrectionPointHistorics]
            
            // MARK: - Body
            
            var body: some View {
                VStack(alignment: .leading, spacing: 40) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Correction Point Historics")
                            .foregroundStyle(.primary)
                            .font(.headline)
                        
                        Text("Total: \(correctionPoints.formatted())")
                            .foregroundStyle(.secondary)
                            .font(.system(.footnote, weight: .semibold))
                            .padding(.bottom, 12)
                    }
                    
                    Chart(historics.prefix(20)) {
                        AreaMark(x: .value("Date", $0.updatedAt), y: .value("Total", $0.total))
                            .foregroundStyle(
                                LinearGradient(colors: [.night, .night.opacity(0.3)], startPoint: .top, endPoint: .bottom)
                            )
                    }
                    .frame(height: 150)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            
        }
        
        private struct CorrectionPointHistoricsList: View {
            
            // MARK: - Properties
            
            @Environment(\.store) private var store
            
            @Binding var viewModel: ViewModel
            
            // MARK: - Body
            
            var body: some View {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Correction slots")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    if viewModel.slotsAvailable.isEmpty && viewModel.slotsTaken.isEmpty {
                        ContentUnavailableView {
                            Label("No correction slots found", systemImage: "scroll")
                        }
                        description: {
                            Text("Create a correction slot to see it appear in the list.")
                        }
                        actions: {
                            Button("Create a correction slot", action: viewModel.toggleCorrectionSlotSheet)
                        }
                    }
                    else {
                        List {
                            if !viewModel.slotsTaken.isEmpty {
                                Section("Slots taken") {
                                    ForEach(viewModel.slotsTaken, content: SlotRow.init)
                                }
                            }
                            
                            if !viewModel.slotsAvailable.isEmpty {
                                Section("Slots available") {
                                    ForEach(viewModel.slotsAvailable, content: SlotRow.init)
                                        .onDelete {
                                            viewModel.onDeleteCorrectionSlot(indexSet: $0, store: store)
                                        }
                                }
                            }
                        }
                        .listStyle(.plain)
                    }
                }
            }
            
        }
        
        private struct CorrectionSlotSheet: View {
            
            // MARK: - Properties
            
            @Environment(\.store) private var store
            @Binding var viewModel: ViewModel
            
            // MARK: - Body
            
            var body: some View {
                NavigationStack {
                    VStack {
                        Text("A slot is an interval of time during which you declare yourself available to assess other users. A slot can be defined each day between 45 minutes and 2 weeks in advance and must last at least one hour.")
                            .foregroundStyle(.secondary)
                            .font(.subheadline)
                            .padding(.horizontal, 14)
                        
                        Form {
                            DatePicker("Begin", selection: $viewModel.beginAt, in: viewModel.defaultBeginAt...viewModel.defaultEndBeginAt)
                            DatePicker("End", selection: $viewModel.endAt, in: Date(timeInterval: 3_600, since: viewModel.beginAt)...viewModel.defaultEndAt)
                        }
                        .onChange(of: viewModel.beginAt, viewModel.onBeginAtChange)
                    }
                    .navigationTitle("New correction slot")
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel", role: .cancel) { viewModel.showCorrectionSheet = false }
                        }
                        
                        ToolbarItem {
                            Button("Add") {
                                viewModel.createCorrectionSlot(store: store)
                            }
                        }
                    }
                }
                .onAppear { UIDatePicker.appearance().minuteInterval = 15 }
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
            }
            
        }
        
    }
    
}
