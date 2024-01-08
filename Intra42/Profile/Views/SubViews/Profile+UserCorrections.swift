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
                }
            }
            .navigationTitle("Corrections")
            .task
            {
                await fetchUserCorrections()
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
    
}
