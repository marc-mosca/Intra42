//
//  Profile+UserCorrections.swift
//  Intra42
//
//  Created by Marc Mosca on 08/01/2024.
//

import Charts
import SwiftUI

extension ProfileView
{
    
    struct UserCorrections: View
    {
        
        // MARK: - Private properties
        
        @Environment(\.store) private var store
        @AppStorage("userIsConnected") private var userIsConnected: Bool?
        
        @State private var correctionPointHistorics = [Api.Types.CorrectionPointHistorics]()
        @State private var slots = [Api.Types.Slot]()
        @State private var showSheet = false
        @State private var loadingState = AppRequestState.loading
        
        // MARK: - Body
        
        var body: some View
        {
            VStack
            {
                if loadingState == .loading
                {
                    ProgressView()
                }
                else
                {
                    CorrectionPointHistoricsChart(correctionPoints: store.user?.correctionPoint ?? 0, historics: correctionPointHistorics)
                    CorrectionPointHistoricsList(slots: $slots, loadingState: $loadingState, showSheet: $showSheet)
                }
            }
            .navigationTitle("Corrections")
            .task
            {
                await fetchUserCorrections()
            }
            .toolbar
            {
                ToolbarItemGroup
                {
                    RefreshButton(state: loadingState)
                    {
                        Task
                        {
                            await fetchUserCorrections()
                        }
                    }
                    
                    Button
                    {
                        showSheet = true
                    }
                    label:
                    {
                        Label("Add a correction slot", systemImage: "plus")
                            .labelStyle(.iconOnly)
                            .imageScale(.small)
                    }
                    .disabled(loadingState != .succeded)
                }
            }
            .sheet(isPresented: $showSheet)
            {
                CorrectionSlotSheet(slots: $slots, showSheet: $showSheet)
            }
        }
        
        // MARK: - Private methods
        
        private func fetchUserCorrections() async
        {
            loadingState = .loading
            
            guard let user = store.user else { return }
            
            do
            {
                correctionPointHistorics = try await Api.Client.shared.request(for: .fetchCorrectionPointHistorics(userId: user.id))
                slots = try await Api.Client.shared.request(for: .fetchUserSlots)
                loadingState = .succeded
            }
            catch AppError.apiAuthorization
            {
                store.error = .apiAuthorization
            }
            catch
            {
                store.error = .network
            }
        }
        
    }
    
    // MARK: - Private components
    
    private struct CorrectionPointHistoricsChart: View
    {
        
        // MARK: - Exposed properties
        
        let correctionPoints: Int
        let historics: [Api.Types.CorrectionPointHistorics]
        
        // MARK: - Body
        
        var body: some View
        {
            VStack(alignment: .leading, spacing: 40)
            {
                VStack(alignment: .leading, spacing: 4)
                {
                    Text("Correction Point Historics")
                        .foregroundStyle(.primary)
                        .font(.headline)
                    
                    Text("Total: \(correctionPoints.formatted())")
                        .foregroundStyle(.secondary)
                        .font(.system(.footnote, weight: .semibold))
                        .padding(.bottom, 12)
                }
                
                Chart(historics.prefix(20))
                {
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
    
    private struct CorrectionPointHistoricsList: View
    {
        
        // MARK: - Exposed properties
        
        @Binding var slots: [Api.Types.Slot]
        @Binding var loadingState: AppRequestState
        @Binding var showSheet: Bool
        
        // MARK: - Private properties
        
        @Environment(\.store) private var store
        @AppStorage("userIsConnected") private var userIsConnected: Bool?
        
        private var slotsAvailable: [Api.Types.GroupedSlots]
        {
            let slotsAvailable = slots.filter { $0.scaleTeam == nil }
            
            return Api.Types.GroupedSlots.create(for: slotsAvailable)
        }
        
        private var slotsTaken: [Api.Types.GroupedSlots]
        {
            let slotsTaken = slots.filter { $0.scaleTeam != nil }
            
            return Api.Types.GroupedSlots.create(for: slotsTaken)
        }
        
        // MARK: - Body
        
        var body: some View
        {
            VStack(alignment: .leading, spacing: 20)
            {
                Text("Correction slots")
                    .font(.headline)
                    .padding(.horizontal)
                
                if slotsAvailable.isEmpty && slotsTaken.isEmpty
                {
                    ContentUnavailableView
                    {
                        Label("No correction slots found", systemImage: "scroll")
                    }
                    description:
                    {
                        Text("Create a correction slot to see it appear in the list.")
                    }
                    actions:
                    {
                        Button("Create a correction slot")
                        {
                            showSheet = true
                        }
                    }
                }
                else
                {
                    List
                    {
                        if !slotsTaken.isEmpty
                        {
                            Section("Slots taken")
                            {
                                ForEach(slotsTaken, content: SlotRow.init)
                            }
                        }
                        
                        if !slotsAvailable.isEmpty
                        {
                            Section("Slots available")
                            {
                                ForEach(slotsAvailable, content: SlotRow.init)
                                    .onDelete(perform: onDelete)
                            }
                        }
                    }
                    .listStyle(.plain)
                }
            }
        }
        
        // MARK: - Private properties
        
        private func onDelete(indexSet: IndexSet)
        {
            Task
            {
                loadingState = .loading
                
                for index in indexSet
                {
                    guard slotsAvailable.count > index else { return }
                    
                    for slot in slotsAvailable[index].slots
                    {
                        guard slot.scaleTeam == nil else { return }
                    }
                    
                    for slotId in slotsAvailable[index].slotsIds
                    {
                        do
                        {
                            try await Api.Client.shared.request(for: .deleteUserSlot(slotId: slotId))
                        }
                        catch AppError.apiAuthorization
                        {
                            store.error = .apiAuthorization
                        }
                        catch
                        {
                            store.error = .network
                        }
                    }
                }
                
                do
                {
                    slots = try await Api.Client.shared.request(for: .fetchUserSlots)
                }
                catch AppError.apiAuthorization
                {
                    store.error = .apiAuthorization
                }
                catch
                {
                    store.error = .network
                }
                
                loadingState = .succeded
            }
        }
        
    }
    
    private struct CorrectionSlotSheet: View
    {
        
        // MARK: - Exposed properties
        
        @Binding var slots: [Api.Types.Slot]
        @Binding var showSheet: Bool
        
        // MARK: - Private properties
        
        @Environment(\.store) private var store
        
        @State private var defaultBeginAt = Date(timeIntervalSinceNow: 2_700)
        @State private var defaultEndBeginAt = Date(timeIntervalSinceNow: 1_204_200)
        @State private var defaultEndAt = Date(timeIntervalSinceNow: 1_207_800)
        @State private var beginAt = Date(timeIntervalSinceNow: 2_700)
        @State private var endAt = Date(timeIntervalSinceNow: 6_300)
        
        private let calendar = Calendar.current
        
        // MARK: - Body
        
        var body: some View
        {
            NavigationStack
            {
                VStack
                {
                    Form
                    {
                        DatePicker("Begin", selection: $beginAt, in: defaultBeginAt...defaultEndBeginAt)
                        DatePicker("End", selection: $endAt, in: Date(timeInterval: 3_600, since: beginAt)...defaultEndAt)
                    }
                    .onChange(of: beginAt, onChange)
                }
                .navigationTitle("New correction slot")
                .toolbar
                {
                    ToolbarItem(placement: .cancellationAction)
                    {
                        Button("Cancel", role: .cancel) { showSheet = false }
                    }
                    
                    ToolbarItem
                    {
                        Button("Add", action: createCorrectionSlot)
                    }
                }
            }
            .onAppear { UIDatePicker.appearance().minuteInterval = 15 }
            .presentationDetents([.medium])
            .presentationDragIndicator(.visible)
        }
        
        // MARK: - Private methods
        
        private func onChange()
        {
            let date = Date(timeInterval: 3_600, since: beginAt)
            
            guard let difference = calendar.dateComponents([.hour], from: beginAt, to: endAt).hour, difference <= 1 else { return }
            
            if date < defaultEndAt
            {
                endAt = date
            }
        }
        
        private func createCorrectionSlot()
        {
            guard beginAt < endAt else { return }
            guard let user = store.user else { return }
            guard let difference = calendar.dateComponents([.hour], from: beginAt, to: endAt).hour, difference >= 1 else { return }
            
            Task {
                do
                {
                    try await Api.Client.shared.request(for: .createUserSlot(userId: user.id, beginAt: beginAt, endAt: endAt))
                    slots = try await Api.Client.shared.request(for: .fetchUserSlots)
                }
                catch AppError.apiAuthorization
                {
                    store.error = .apiAuthorization
                }
                catch
                {
                    store.error = .network
                }
            }
            showSheet = false
        }
        
    }
    
}
