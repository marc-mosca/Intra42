//
//  User.swift
//  Intra42
//
//  Created by Marc Mosca on 01/01/2024.
//

import Foundation

extension Api.Types
{
    
    /// A structure representing a user.
    struct User: Decodable, Identifiable
    {
        
        // MARK: - Exposed properties
        
        let id: Int
        let email: String
        let login: String
        let phone: String
        let displayname: String
        let image: Avatar
        let correctionPoint: Int
        let poolMonth: String
        let poolYear: String
        let location: String?
        let wallet: Int
        let cursusUsers: [Cursus]
        let projectsUsers: [Projects]
        let achievements: [Achievements]
        let patroned: [Patronages]
        let patroning: [Patronages]
        let campusUsers: [Campus]
        
        var mainCursus: Cursus?
        {
            let studentCursus = cursusUsers.first { cursus in
                cursus.cursus.slug == "42cursus"
            }
            
            let piscineCursus = cursusUsers.first { cursus in
                cursus.cursus.slug == "c-piscine"
            }
            
            return studentCursus != nil ? studentCursus : piscineCursus
        }
        
        var mainCampus: Campus?
        {
            campusUsers.first(where: \.isPrimary)
        }
        
        var postCC: Bool
        {
            let lastProject = projectsUsers.first { project in
                project.project.slug == "ft_transcendence"
            }
            
            let lastExam = projectsUsers.first { project in
                project.project.slug == "exam-rank-06"
            }
            
            return lastProject?.validated == true && lastExam?.validated == true
        }
        
        var entryDate: String
        {
            let defaultEntryDate = "\(poolYear)-01-01"
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM"
            
            guard let monthDate = dateFormatter.date(from: poolMonth) else { return defaultEntryDate }
            
            let calendar = Calendar.current
            let year = Int(poolYear) ?? 1
            
            guard let date = calendar.date(bySetting: .year, value: year, of: monthDate) else { return defaultEntryDate }
            
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            return dateFormatter.string(from: date)
        }
        
        // MARK: - Sub-structures
        
        /// A structure representing a user's achievements.
        struct Achievements: Decodable, Identifiable
        {
            let id: Int
            let name: String
            let description: String
            let kind: String
        }
        
        /// A structure representing a user's profile image.
        struct Avatar: Decodable
        {
            let link: String
        }
        
        /// A structure representing the user's campus information.
        struct Campus: Decodable, Identifiable
        {
            let id: Int
            let campusId: Int
            let isPrimary: Bool
        }
        
        /// A structure representing the user's cursus.
        struct Cursus: Decodable, Identifiable
        {
            let id: Int
            let grade: String?
            let level: Double
            let skills: [Skills]
            let cursusId: Int
            let hasCoalition: Bool
            let cursus: Details
            
            /// A structure representing the skills in the user's cursus.
            struct Skills: Decodable, Identifiable
            {
                let id: Int
                let name: String
                let level: Double
            }
            
            /// A structure representing the details of the user's cursus.
            struct Details: Decodable, Identifiable
            {
                let id: Int
                let name: String
                let slug: String
            }
        }
        
        /// A structure representing a user's patronages.
        struct Patronages: Decodable, Identifiable
        {
            let id: Int
            let userId: Int
            let godfatherId: Int
            let ongoing: Bool
        }
        
        /// A structure representing the user's projects.
        struct Projects: Decodable, Identifiable
        {
            let id: Int
            let finalMark: Int?
            let status: String
            let validated: Bool?
            let currentTeamId: Int?
            let project: Details
            let cursusIds: [Int]
            let markedAt: Date?
            let marked: Bool
            let retriableAt: Date?
            
            var markedAtFormatted: String
            {
                guard let markedAt = markedAt else { return "N/A" }
                
                let formatStyle = Date.FormatStyle.dateTime.year().month(.wide)
                
                return markedAt.formatted(formatStyle)
            }
            
            /// A structure representing the details of the user's projects.
            struct Details: Decodable, Identifiable
            {
                let id: Int
                let name: String
                let slug: String
                let parentId: Int?
            }
            
            private enum CodingKeys: String, CodingKey
            {
                case id
                case finalMark
                case status
                case validated = "validated?"
                case currentTeamId
                case project
                case cursusIds
                case markedAt
                case marked
                case retriableAt
            }
        }
        
    }
    
}
