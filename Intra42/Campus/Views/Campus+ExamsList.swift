//
//  Campus+ExamsList.swift
//  Intra42
//
//  Created by Marc Mosca on 03/01/2024.
//

import SwiftUI

extension CampusView
{
    
    struct ExamsList: View
    {
        
        // MARK: - Exposed properties
        
        let exams: [Api.Types.Exam]
        
        // MARK: - Body
        
        var body: some View
        {
            if !exams.isEmpty
            {
                List(exams, rowContent: ExamRow.init)
                    .listStyle(.plain)
            }
            else
            {
                ContentUnavailableView(
                    "No examinations planned",
                    systemImage: "calendar",
                    description: Text("No exams are scheduled on your campus.")
                )
            }
        }
        
    }
    
}
