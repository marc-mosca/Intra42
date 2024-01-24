//
//  Scale+Samples.swift
//  Intra42
//
//  Created by Marc Mosca on 23/01/2024.
//

import Foundation

extension Api.Types.Scale {
    
    static let sample = Self.init(
        id: 6085486,
        scaleId: 29531,
        beginAt: .now,
        correcteds: nil,
        corrector: nil,
        scale: .sample,
        teams: .sample
    )
    
}

extension Api.Types.Scale.User {
    
    static let sample = Self.init(id: 92127, login: "mmosca")
    
}

extension [Api.Types.Scale.User] {
    
    static let smaple: Self = [
        .init(id: 92127, login: "mmosca"),
        .init(id: 94131, login: "abucia")
    ]
    
}

extension Api.Types.Scale.Details {
    
    static let sample = Self.init(id: 28445, correctionNumber: 3, duration: 900)
    
}

extension Api.Types.Scale.Team {
    
    static let sample = Self.init(
        id: 4839596,
        name: "mmosca's group",
        projectId: 2007,
        status: "waiting_for_correction",
        users: .sample,
        locked: true,
        validated: nil,
        closed: true,
        lockedAt: .now,
        closedAt: .now
    )
    
}

extension Api.Types.Scale.Team.User {
    
    static let sample = Self.init(id: 92127, login: "mmosca", leader: true)
    
}

extension [Api.Types.Scale.Team.User] {
    
    static let sample: Self = [
        .init(id: 92127, login: "mmosca", leader: true),
        .init(id: 94131, login: "abucia", leader: false)
    ]
    
}
