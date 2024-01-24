//
//  Logtime+Samples.swift
//  Intra42
//
//  Created by Marc Mosca on 23/01/2024.
//

import Foundation

extension Api.Types.LogtimeResult {
    
    static let sample = [
        "2021-03-17": "02:56:21.097917",
        "2021-03-13": "02:20:35.738681",
        "2021-03-10": "03:23:36.453802",
        "2021-03-09": "04:40:36.89249",
        "2021-03-06": "04:51:22.499393",
        "2021-03-05": "06:05:59.372873",
        "2021-03-03": "00:21:53.590291",
        "2021-02-27": "03:05:36.994655",
        "2021-02-26": "05:16:55.007148",
        "2021-02-25": "04:36:29.373432",
        "2021-02-24": "04:49:50.382865",
        "2021-02-23": "05:58:58.220621",
        "2021-02-20": "04:12:54.190362",
        "2021-02-19": "06:44:53.740148",
        "2021-02-18": "03:20:40.099337",
        "2021-02-17": "04:28:59.221241",
        "2021-02-11": "02:58:40.99942",
        "2021-01-20": "01:49:22.04"
    ]
    
}

extension Api.Types.Logtime {
    
    static let sample = Self.init(month: "2021-02", total: 70, details: .sample, numberOfDaysToWork: 147)
    
}

extension [Api.Types.Logtime] {
    
    static let sample: Self = [
        .init(month: "2021-02", total: 70, details: .sample, numberOfDaysToWork: 147),
        .init(month: "2021-03", total: 13, details: .sample, numberOfDaysToWork: 154)
    ]
    
}
