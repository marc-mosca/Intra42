//
//  Profile+UserLogtime.swift
//  Intra42
//
//  Created by Marc Mosca on 24/01/2024.
//

import Charts
import SwiftUI

extension ProfileView {
    
    struct UserLogtime: View {
        
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
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(viewModel.formattedLogtimes) { logtime in
                                VStack {
                                    LogtimeChart(month: logtime.fullmonth, currentLogtime: logtime.total, numberOfDaysToWork: logtime.numberOfDaysToWork)
                                    LogtimeResume(logtime: logtime.details)
                                }
                                .containerRelativeFrame(.horizontal, count: 1, spacing: 0)
                            }
                        }
                        .scrollTargetLayout()
                    }
                    .contentMargins(16, for: .scrollContent)
                    .scrollTargetBehavior(.paging)
                }
            }
            .navigationTitle("Logtime")
            .task { await viewModel.fetchUserLogtime(store: store) }
            .toolbar {
                ToolbarItemGroup {
                    RefreshButton(state: viewModel.loadingState) {
                        Task {
                            await viewModel.fetchUserLogtime(store: store)
                        }
                    }
                    
                    Button(action: viewModel.toggleShowInformationsAlert) {
                        Label("Informations", systemImage: "info.circle")
                            .labelStyle(.iconOnly)
                    }
                    .foregroundStyle(.night)
                }
            }
            .alert("Logtime Informations", isPresented: $viewModel.showLogtimeInformations) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("The logtime shown on the application corresponds to the time you have spent connected to a workstation on your campus. The percentage is calculated according to the number of working days in the month (civic holidays are counted as working days).")
            }
        }
        
        // MARK: - Extensions
        
        private struct LogtimeChart: View {
            
            // MARK: - Properties
            
            @AppStorage(AppStorageKeys.userLogtime.rawValue) private var userLogtime: Int?
            
            let month: String
            let currentLogtime: Double
            let numberOfDaysToWork: Double
            
            private var timeToWork: Double {
                if let userLogtime = userLogtime, userLogtime != 0 {
                    return numberOfDaysToWork * Double(userLogtime)
                }
                
                return numberOfDaysToWork * 7
            }
            
            private var logtimeChartData: [(type: String, time: Double)] {
                [(type: month, time: currentLogtime), (type: "default", time: timeToWork - currentLogtime < 0 ? 0 : timeToWork - currentLogtime)]
            }
            
            // MARK: - Body
            
            var body: some View {
                Chart(logtimeChartData, id: \.type) {
                    SectorMark(
                        angle: .value("Value", $1),
                        innerRadius: .ratio(0.618),
                        outerRadius: .inset(10),
                        angularInset: 1
                    )
                    .cornerRadius(8)
                    .foregroundStyle(.night)
                    .opacity($0 == "default" ? 0.5 : 1)
                }
                .chartBackground { chartProxy in
                    GeometryReader { geometry in
                        let frame = geometry[chartProxy.plotFrame!]
                        
                        VStack {
                            Text("Logtime")
                            
                            Text(month)
                                .font(.title2.bold())
                                .foregroundColor(.primary)
                            
                            Text("\(String(format: "%.2f", currentLogtime * 100 / timeToWork)) %")
                        }
                        .position(x: frame.midX, y: frame.midY)
                        .font(.callout)
                        .foregroundStyle(.secondary)
                    }
                }
            }
            
        }
        
        private struct LogtimeResume: View {
            
            // MARK: - Properties
            
            let logtime: Api.Types.LogtimeResult
            
            private var logtimeSorted: [Dictionary<String, String>.Element] {
                logtime.sorted(by: { $0.key < $1.key })
            }
            
            // MARK: - Body
            
            var body: some View {
                VStack {
                    if !logtimeSorted.isEmpty {
                        List {
                            ForEach(logtimeSorted, id: \.key) {
                                HRow(title: "\(formattedDate($0))", value: formattedTime($1))
                                    .padding(.vertical, 4)
                            }
                        }
                        .listStyle(.plain)
                    }
                    else {
                        ContentUnavailableView(
                            "No hours this month",
                            systemImage: "clock",
                            description: Text("Connect to a workstation on your campus to see how long you've been online this month.")
                        )
                    }
                }
            }
            
            // MARK: - Methods
            
            private func formattedDate(_ dateStr: String) -> String {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                
                guard let date = dateFormatter.date(from: dateStr) else { return dateStr }
                
                let newDateFormatter = DateFormatter()
                newDateFormatter.dateFormat = "EE dd MMM yyyy"
                newDateFormatter.locale = Locale.current
                
                return newDateFormatter.string(from: date).capitalized
            }
            
            private func formattedTime(_ time: String) -> String {
                let split = time.split(separator: ":")
                guard split.count > 2 else { return time }
                return "\(split[0])h \(split[1])min"
            }
            
        }
        
    }
    
}
