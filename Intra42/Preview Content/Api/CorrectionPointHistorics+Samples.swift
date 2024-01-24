//
//  CorrectionPointHistorics+Samples.swift
//  Intra42
//
//  Created by Marc Mosca on 23/01/2024.
//

import Foundation

extension Api.Types.CorrectionPointHistorics {
    
    static let sample = Self.init(id: 8768604, scaleTeamId: 5279884, total: 18, createdAt: .now, updatedAt: .now)
    
}

extension [Api.Types.CorrectionPointHistorics] {
    
    static let sample: Self = [
        .init(id: 8768604, scaleTeamId: 5279884, total: 18, createdAt: .now, updatedAt: .now),
        .init(id: 8752117, scaleTeamId: 5272634, total: 19, createdAt: .now, updatedAt: .now),
        .init(id: 8752109, scaleTeamId: 5272631, total: 20, createdAt: .now, updatedAt: .now),
        .init(id: 8635646, scaleTeamId: 5218189, total: 16, createdAt: .now, updatedAt: .now)
    ]
    
}
