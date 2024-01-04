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
    
    @Environment(\.store) private var store
    
    private var userIsSubscribe: String
    {
        store.userExams.contains(where: { $0.id == exam.id }) ? String(localized: "Yes") : String(localized: "No")
    }
    
    // MARK: - Body
    
    var body: some View
    {
        NavigationLink
        {
            List
            {
                Section("Informations")
                {
                    HRow(title: "Date", value: exam.beginAt)
                    HRow(title: "Duration", value: Date.duration(beginAt: exam.beginAt, endAt: exam.endAt))
                    HRow(title: "Registered", value: userIsSubscribe)
                    HRow(title: "Subscribers", value: exam.numberOfSubscribers)
                    HRow(title: "Location", value: exam.location)
                }
                
                Section("Projects related")
                {
                    ForEach(exam.projects)
                    {
                        Text($0.name)
                    }
                }
            }
            .navigationTitle(exam.name)
            .navigationBarTitleDisplayMode(.inline)
        }
        label:
        {
            RowLabel(exam: exam)
        }

    }
}

// MARK: - Extensions

extension ExamRow
{
    
    struct RowLabel: View
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
    
}

// MARK: - Previews

#Preview
{
    ExamRow(exam: .sample)
}
