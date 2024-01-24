//
//  EnvironmentValues+Store.swift
//  Intra42
//
//  Created by Marc Mosca on 23/01/2024.
//

import SwiftUI

private struct StoreKey: EnvironmentKey {
    
    static var defaultValue = Store()
    
}

extension EnvironmentValues {
    
    var store: Store {
        get { self[StoreKey.self] }
        set { self[StoreKey.self] = newValue }
    }
    
}
