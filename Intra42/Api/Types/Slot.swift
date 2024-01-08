//
//  Slot.swift
//  Intra42
//
//  Created by Marc Mosca on 01/01/2024.
//

import Foundation

extension Api.Types
{
    
    /// A structure representing a correction slot.
    struct Slot: Decodable, Identifiable
    {
        
        // MARK: - Exposed properties
        
        let id: Int
        let beginAt: Date
        let endAt: Date
        let scaleTeam: UncertainValue<String, ScaleTeam>?
        let user: User
        
        // MARK: - Exposed sub-structures
        
        /// A structure representing a user of a correction slot.
        struct User: Codable, Identifiable
        {
            let id: Int
            let login: String
        }
        
        /// A structure representing a team in a correction slot.
        struct ScaleTeam: Codable, Identifiable
        {
            let id: Int
            let scaleId: Int
            let beginAt: Date
            let correcteds: [Slot.User]
            let corrector: Slot.User
        }
        
    }
    
    /// An object representing correction slots grouped.
    struct GroupedSlots: Decodable, Identifiable
    {
        
        // MARK: - Exposed properties
        
        var id = UUID()
        
        var beginAt: Date
        var endAt: Date
        var slots: [Api.Types.Slot]
        var slotsIds: [Int]
        
        // MARK: - Exposed methods
        
        /// Transforms a correction slot array into a grouped correction slot structure array.
        /// - Parameter slots: The correction slot array used to create the new correction slot structure array.
        /// - Returns: The new grouped correction slot structure array.
        static func create(for slots: [Api.Types.Slot]) -> [Api.Types.GroupedSlots]
        {
            let sortedSlots = slots.sorted(by: { $0.beginAt < $1.beginAt })
            var groupedSlots = [Api.Types.GroupedSlots]()
            
            for slot in sortedSlots
            {
                if groupedSlots.isEmpty || groupedSlots.last!.endAt != slot.beginAt
                {
                    let newGroupedSlot = Api.Types.GroupedSlots(beginAt: slot.beginAt, endAt: slot.endAt, slots: [slot], slotsIds: [slot.id])
                    
                    groupedSlots.append(newGroupedSlot)
                }
                else
                {
                    let count = groupedSlots.count - 1
                    
                    groupedSlots[count].slots.append(slot)
                    groupedSlots[count].slotsIds.append(slot.id)
                    groupedSlots[count].endAt = slot.endAt
                }
            }
            
            return groupedSlots
        }
        
    }
    
}
