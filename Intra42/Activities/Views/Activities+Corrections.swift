//
//  Activities+Corrections.swift
//  Intra42
//
//  Created by Marc Mosca on 03/01/2024.
//

import SwiftUI

extension ActivitiesView
{
    
    struct Correction: View
    {
        
        // MARK: - Private properties
        
        @Environment(\.store) private var store
        
        // MARK: - Body
        
        var body: some View
        {
            if !store.userScales.isEmpty
            {
                List
                {
                    Text("Liste")
                }
                .listStyle(.plain)
            }
            else
            {
                ContentUnavailableView(
                    "No corrections planned",
                    systemImage: "person.badge.clock.fill",
                    description: Text("When a student takes one of your correction slots to be corrected, you'll see it appear here.")
                )
            }
        }
        
    }
    
}
