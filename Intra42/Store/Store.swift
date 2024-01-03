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
    
    var error: AppError?
    var errorAction: (() -> Void)?
    
}
