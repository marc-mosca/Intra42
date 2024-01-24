//
//  Exam+Samples.swift
//  Intra42
//
//  Created by Marc Mosca on 23/01/2024.
//

import Foundation

extension Api.Types.Exam {
    
    static let sample = Self.init(
        id: 15631,
        beginAt: .now,
        endAt: .init(timeIntervalSinceNow: 10800),
        location: "Z2",
        maxPeople: 60,
        nbrSubscribers: 5,
        name: "Exam",
        projects: .sample
    )
    
}

extension [Api.Types.Exam] {
    
    static let sample: Self = [
        .init(id: 15631, beginAt: .now, endAt: .init(timeIntervalSinceNow: 10800), location: "Z2", maxPeople: 60, nbrSubscribers: 5, name: "Exam", projects: .sample)
    ]
    
}

extension Api.Types.Exam.Projects {
    
    static let sample = Self.init(id: 1320, name: "Exam rank 02", slug: "exam-rank-02")
    
}

extension [Api.Types.Exam.Projects] {
    
    static let sample: Self = [
        .init(id: 1320, name: "Exam rank 02", slug: "exam-rank-02"),
        .init(id: 1321, name: "Exam rank 03", slug: "exam-rank-03"),
        .init(id: 1322, name: "Exam rank 04", slug: "exam-rank-04"),
        .init(id: 1323, name: "Exam rank 05", slug: "exam-rank-05"),
        .init(id: 1324, name: "Exam rank 06", slug: "exam-rank-06")
    ]
    
}
