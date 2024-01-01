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
    public struct User: Decodable, Identifiable
    {
        
        // MARK: - Exposed properties
        
        public let id: Int
        public let email: String
        public let login: String
        public let phone: String
        public let displayname: String
        public let image: Avatar
        public let correctionPoint: Int
        public let poolMonth: String
        public let poolYear: String
        public let location: String?
        public let wallet: Int
        public let cursusUsers: [Cursus]
        public let projectsUsers: [Projects]
        public let achievements: [Achievements]
        public let patroned: [Patronages]
        public let patroning: [Patronages]
        public let campusUsers: [Campus]
        
        public var mainCursus: Cursus?
        {
            let studentCursus = cursusUsers.first { cursus in
                cursus.cursus.slug == "42cursus"
            }
            
            let piscineCursus = cursusUsers.first { cursus in
                cursus.cursus.slug == "c-piscine"
            }
            
            return studentCursus != nil ? studentCursus : piscineCursus
        }
        
        public var mainCampus: Campus?
        {
            campusUsers.first(where: \.isPrimary)
        }
        
        public var postCC: Bool
        {
            let lastProject = projectsUsers.first { project in
                project.project.slug == "ft_transcendence"
            }
            
            let lastExam = projectsUsers.first { project in
                project.project.slug == "exam-rank-06"
            }
            
            return lastProject?.validated == true && lastExam?.validated == true
        }
        
        public var entryDate: String
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
        public struct Achievements: Decodable, Identifiable
        {
            public let id: Int
            public let name: String
            public let description: String
            public let kind: String
        }
        
        /// A structure representing a user's profile image.
        public struct Avatar: Decodable
        {
            public let link: String
        }
        
        /// A structure representing the user's campus information.
        public struct Campus: Decodable, Identifiable
        {
            public let id: Int
            public let campusId: Int
            public let isPrimary: Bool
        }
        
        /// A structure representing the user's cursus.
        public struct Cursus: Decodable, Identifiable
        {
            public let id: Int
            public let grade: String?
            public let level: Double
            public let skills: [Skills]
            public let cursusId: Int
            public let hasCoalition: Bool
            public let cursus: Details
            
            /// A structure representing the skills in the user's cursus.
            public struct Skills: Decodable, Identifiable
            {
                public let id: Int
                public let name: String
                public let level: Double
            }
            
            /// A structure representing the details of the user's cursus.
            public struct Details: Decodable, Identifiable
            {
                public let id: Int
                public let name: String
                public let slug: String
            }
        }
        
        /// A structure representing a user's patronages.
        public struct Patronages: Decodable, Identifiable
        {
            public let id: Int
            public let userId: Int
            public let godfatherId: Int
            public let ongoing: Bool
        }
        
        /// A structure representing the user's projects.
        public struct Projects: Decodable, Identifiable
        {
            public let id: Int
            public let finalMark: Int?
            public let status: String
            public let validated: Bool?
            public let currentTeamId: Int?
            public let project: Details
            public let cursusIds: [Int]
            public let markedAt: Date?
            public let marked: Bool
            public let retriableAt: Date?
            
            public var markedAtFormatted: String
            {
                guard let markedAt = markedAt else { return "N/A" }
                
                let formatStyle = Date.FormatStyle.dateTime.year().month(.wide)
                
                return markedAt.formatted(formatStyle)
            }
            
            /// A structure representing the details of the user's projects.
            public struct Details: Decodable, Identifiable
            {
                public let id: Int
                public let name: String
                public let slug: String
                public let parentId: Int?
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
