//
//  Profile+UserLogtime.swift
//  Intra42
//
//  Created by Marc Mosca on 06/01/2024.
//

import Algorithms
import Charts
import SwiftUI

extension ProfileView
{
    
    struct UserLogtime: View
    {
        
        // MARK: - Private properties
        
        @Environment(\.store) private var store
        @AppStorage("userIsConnected") private var userIsConnected: Bool?
        
        @State private var loadingState = AppRequestState.loading
        @State private var logtimes = [Api.Types.Logtime]()
        
        private var currentMonthLogtime: Api.Types.Logtime?
        {
            guard !logtimes.contains(where: { $0.fullmonth == Date.currentMonthDate }) else { return nil }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM yyyy"
            
            guard let date = dateFormatter.date(from: Date.currentMonthDate) else { return nil }
            
            dateFormatter.dateFormat = "yyyy-MM"
            let month = dateFormatter.string(from: date)
            
            return Api.Types.Logtime(
                month: month,
                total: Date.currentMonthLogtime(logtimes),
                details: Api.Types.LogtimeResult(),
                numberOfDaysToWork: Date.getNumberOfDaysToWorkPerMonth(month)
            )
        }
        
        private var formattedLogtimes: [Api.Types.Logtime]
        {
            var formattedLogtimes = logtimes
            
            if let currentMonthLogtime = currentMonthLogtime
            {
                formattedLogtimes.insert(currentMonthLogtime, at: 0)
            }
            
            return formattedLogtimes
        }
        
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
                    ScrollView(.horizontal, showsIndicators: false)
                    {
                        HStack
                        {
                            ForEach(formattedLogtimes, content: logtimeDetails)
                        }
                        .scrollTargetLayout()
                    }
                    .contentMargins(16, for: .scrollContent)
                    .scrollTargetBehavior(.paging)
                }
            }
            .navigationTitle("Logtime")
            .task
            {
                await fetchUserLogtime()
            }
            .toolbar
            {
                ToolbarItem
                {
                    RefreshButton(state: loadingState)
                    {
                        Task
                        {
                            await fetchUserLogtime()
                        }
                    }
                }
            }
        }
        
        // MARK: - Private components
        
        private func logtimeDetails(logtime: Api.Types.Logtime) -> some View
        {
            VStack
            {
                LogtimeChart(month: logtime.fullmonth, currentLogtime: logtime.total, numberOfDaysToWork: logtime.numberOfDaysToWork)
                LogtimeResume(logtime: logtime.details)
            }
            .containerRelativeFrame(.horizontal, count: 1, spacing: 0)
        }
        
        // MARK: - Private methods
        
        private func fetchUserLogtime() async
        {
            loadingState = .loading
            
            guard let user = store.user else { return }
            
            do
            {
                let logtime = try await Api.Client.shared.request(for: .fetchLogtime(login: user.login, entryDate: user.entryDate)) as Api.Types.LogtimeResult
                logtimes = convertLogtimeResultToLogtimeData(logtimeResult: logtime)
                loadingState = .succeded
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
            }
        }
        
        private func convertLogtimeResultToLogtimeData(logtimeResult: Api.Types.LogtimeResult) -> [Api.Types.Logtime]
        {
            var monthData = [Api.Types.Logtime]()
            var monthlyData = [String: Double]()
            
            for (date, time) in logtimeResult
            {
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
        
    }
    
    // MARK: - Private components
    
    private struct LogtimeChart: View
    {
        
        // MARK: - Exposed properties
        
        let month: String
        let currentLogtime: Double
        let numberOfDaysToWork: Double
        
        // MARK: - Private properties
        
        @AppStorage("userDefaultLogtime") private var userDefaultLogtime: Int?
        
        private var timeToWork: Double
        {
            if let userDefaultLogtime = userDefaultLogtime, userDefaultLogtime != 0
            {
                return numberOfDaysToWork * Double(userDefaultLogtime)
            }
            
            return numberOfDaysToWork * 7
        }
        
        private var currentLogtimeInPercentage: Double
        {
            currentLogtime * 100 / timeToWork
        }
        
        private var logtimeChartData: [(type: String, time: Double)]
        {
            [
                (type: month, time: currentLogtime),
                (type: "default", time: timeToWork - currentLogtime < 0 ? 0 : timeToWork - currentLogtime)
            ]
        }
        
        // MARK: - Body
        
        var body: some View
        {
            Chart(logtimeChartData, id: \.type)
            {
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
                    
                    VStack
                    {
                        Text("Logtime")
                        
                        Text(month)
                            .font(.title2.bold())
                            .foregroundColor(.primary)
                        
                        Text("\(String(format: "%.2f", currentLogtimeInPercentage)) %")
                    }
                    .position(x: frame.midX, y: frame.midY)
                    .font(.callout)
                    .foregroundStyle(.secondary)
                }
            }
        }
        
    }
    
    private struct LogtimeResume: View
    {
        
        // MARK: - Exposed properties
        
        let logtime: Api.Types.LogtimeResult
        
        // MARK: - Private properties
        
        private var logtimeSorted: [Dictionary<String, String>.Element]
        {
            logtime.sorted(by: { $0.key < $1.key })
        }
        
        // MARK: - Body
        
        var body: some View
        {
            VStack
            {
                if !logtimeSorted.isEmpty
                {
                    List
                    {
                        ForEach(logtimeSorted, id: \.key)
                        {
                            HRow(title: "\(formattedDate($0))", value: formattedTime($1))
                                .padding(.vertical, 4)
                        }
                    }
                    .listStyle(.plain)
                }
                else
                {
                    ContentUnavailableView(
                        "No hours this month",
                        systemImage: "clock",
                        description: Text("Connect to a workstation on your campus to see how long you've been online this month.")
                    )
                }
            }
        }
        
        // MARK: - Private methods
        
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
