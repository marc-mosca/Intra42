//
//  Store.swift
//  Intra42
//
//  Created by Marc Mosca on 03/01/2024.
//

import Observation
import Foundation

@Observable
final class Store
{
    
    // MARK: - Exposed properties
    
    var selection = AppScreen.activities
    
    var error: AppError?
    var errorAction: (() -> Void)?
    
    var user: Api.Types.User?
    var userEvents = [Api.Types.Event]()
    var userExams = [Api.Types.Exam]()
    var userScales = [Api.Types.Scale]()
    
    var campusEvents = [Api.Types.Event]()
    var campusExams = [Api.Types.Exam]()
    
}
