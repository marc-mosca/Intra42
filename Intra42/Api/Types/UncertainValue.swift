//
//  UncertainValue.swift
//  Intra42
//
//  Created by Marc Mosca on 01/01/2024.
//

import Foundation

/// A structure representing an uncertain value of type T or U.
public struct UncertainValue<T: Decodable, U: Decodable>: Decodable
{
    
    // MARK: - Exposed properties
    
    public var tValue: T?
    public var uValue: U?
    
    public var value: Any?
    {
        return tValue ?? uValue
    }
    
    // MARK: - Exposed constructors
    
    public init(from decoder: Decoder) throws
    {
        let container = try decoder.singleValueContainer()
        
        tValue = try? container.decode(T.self)
        uValue = try? container.decode(U.self)
    }
    
}
