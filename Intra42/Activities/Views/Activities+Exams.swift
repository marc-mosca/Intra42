//
//  Activities+Exams.swift
//  Intra42
//
//  Created by Marc Mosca on 03/01/2024.
//

import SwiftUI

extension ActivitiesView
{
    
    struct Exams: View
    {
        
        // MARK: - Private properties
        
        @Environment(\.store) private var store
        
        // MARK: - Body
        
        var body: some View
        {
            if !store.userExams.isEmpty
            {
                List(store.userExams, rowContent: ExamRow.init)
                    .listStyle(.plain)
            }
            else
            {
                ContentUnavailableView(
                    "No examinations planned",
                    systemImage: "scroll.fill",
                    description: Text("Register for an exam offered by your campus to see it appear here.")
                )
            }
        }
        
    }
    
}
