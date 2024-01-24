//
//  Slot+Samples.swift
//  Intra42
//
//  Created by Marc Mosca on 23/01/2024.
//

import Foundation

extension Api.Types.Slot {
    
    static let sample = Self.init(id: 1, beginAt: .now, endAt: .now, scaleTeam: nil, user: .sample)
    
}

extension [Api.Types.Slot] {
    
    static let sample: Self = [
        .init(id: 1, beginAt: .now, endAt: .now, scaleTeam: nil, user: .sample),
        .init(id: 2, beginAt: .now, endAt: .now, scaleTeam: nil, user: .sample)
    ]
    
}

extension Api.Types.Slot.User {
    
    static let sample = Self.init(id: 92127, login: "mmosca")
    
}

extension [Api.Types.Slot.User] {
    
    static let sample: Self = [
        .init(id: 92127, login: "mmosca"),
        .init(id: 94131, login: "abucia")
    ]
    
}

extension Api.Types.Slot.ScaleTeam {
    
    static let sample = Self.init(
        id: 1,
        scaleId: 1000,
        beginAt: .now,
        correcteds: .sample,
        corrector: .sample
    )
    
}

extension [Api.Types.Slot.ScaleTeam] {
    
    static let sample: Self = [
        .init(id: 1, scaleId: 1000, beginAt: .now, correcteds: .sample, corrector: .sample),
        .init(id: 2, scaleId: 1001, beginAt: .now, correcteds: .sample, corrector: .sample)
    ]
    
}
