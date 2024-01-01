//
//  ExamRow.swift
//  Intra42
//
//  Created by Marc Mosca on 01/01/2024.
//

import SwiftUI

struct ExamRow: View
{
    
    // MARK: - Exposed properties
    
    let exam: Api.Types.Exam
    
    // MARK: - Private properties
    
    private var formatStyle: Date.FormatStyle
    {
        .dateTime.day().month().year().hour().minute()
    }
    
    // MARK: - Body
    
    var body: some View
    {
        HStack(spacing: 16)
        {
            Image(systemName: "hourglass")
                .foregroundStyle(.night)
                .font(.headline)
                .imageScale(.large)
            
            VStack(alignment: .leading, spacing: 2)
            {
                Text(exam.name)
                    .foregroundStyle(.primary)
                    .font(.system(.subheadline, weight: .semibold))
                
                Text(exam.beginAt, format: formatStyle)
                    .foregroundStyle(.secondary)
                    .font(.footnote)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.vertical, 8)
    }
}

// MARK: - Previews

#Preview
{
    ExamRow(exam: .sample)
}
