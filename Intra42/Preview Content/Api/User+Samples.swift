//
//  User+Samples.swift
//  Intra42
//
//  Created by Marc Mosca on 01/01/2024.
//

import Foundation

extension Api.Types.User
{
    
    static let sample = Self.init(
        id: 92127,
        email: "mmosca@student.42lyon.fr",
        login: "mmosca",
        phone: "hidden",
        displayname: "Marc Mosca",
        image: .sample,
        correctionPoint: 17,
        poolMonth: "july",
        poolYear: "2021",
        location: nil,
        wallet: 432,
        cursusUsers: .sample,
        projectsUsers: .sample,
        achievements: .sample,
        patroned: .sample,
        patroning: [],
        campusUsers: [.sample]
    )
    
}

extension Api.Types.User.Achievements
{
    
    static let sample = Self.init(
        id: 41,
        name: "All work and no play makes Jack a dull boy",
        description: "Logged for a total of 90 hours over a week.",
        kind: "scolarity"
    )
    
}

extension [Api.Types.User.Achievements]
{
    
    static let sample: Self = [
        .init(id: 41, name: "All work and no play makes Jack a dull boy", description: "Logged for a total of 90 hours over a week.", kind: "scolarity"),
        .init(id: 54, name: "Attendee", description: "Attended 1 event.", kind: "scolarity"),
        .init(id: 55, name: "Attendee", description: "Attended 3 events.", kind: "scolarity"),
        .init(id: 437, name: "Bartender", description: "Être membre du Foyer de 42 Lyon", kind: "social"),
        .init(id: 169, name: "Bill Gates", description: "Donated 1 evaluation point to the pool.", kind: "scolarity"),
        .init(id: 170, name: "Bill Gates", description: "Donated 10 evaluation points to the pool.", kind: "scolarity"),
        .init(id: 171, name: "Bill Gates", description: "Donated 21 evaluation points to the pool.", kind: "scolarity"),
        .init(id: 172, name: "Bill Gates", description: "Donated 42 evaluation points to the pool.", kind: "scolarity"),
        .init(id: 17, name: "Bonus Hunter", description: "Validated 1 project with the maximum score.", kind: "project"),
        .init(id: 18, name: "Bonus Hunter", description: "Validated 3 projects with the maximum score.", kind: "project"),
        .init(id: 19, name: "Bonus Hunter", description: "Validated 10 projects with the maximum score.", kind: "project"),
        .init(id: 20, name: "Bonus Hunter", description: "Validated 21 projects with the maximum score.", kind: "project"),
        .init(id: 4, name: "Code Explorer", description: "Valided your first project.", kind: "project"),
        .init(id: 5, name: "Code Explorer", description: "Validated 3 projects", kind: "project"),
        .init(id: 6, name: "Code Explorer", description: "Validated 10 projects.", kind: "project"),
        .init(id: 7, name: "Code Explorer", description: "Validated 21 projects.", kind: "project"),
        .init(id: 46, name: "Film buff", description: "Watched 1 video from the e-learning.", kind: "pedagogy"),
        .init(id: 47, name: "Film buff", description: "Watched 3 videos from the e-learning.", kind: "pedagogy"),
        .init(id: 48, name: "Film buff", description: "Watched 10 videos from the e-learning.", kind: "pedagogy"),
        .init(id: 49, name: "Film buff", description: "Watched 21 videos from the e-learning.", kind: "pedagogy"),
        .init(id: 50, name: "Film buff", description: "Watched 42 videos from the e-learning.", kind: "pedagogy"),
        .init(id: 45, name: "Home is where the code is", description: "Logged into the same cluster for a month in a row", kind: "scolarity"),
        .init(id: 82, name: "I have no idea what I\'m doing", description: "Made a defense without having validated the project.", kind: "pedagogy"),
        .init(id: 84, name: "I\'m reliable !", description: "Participated in 21 defenses in a row without missing any.", kind: "pedagogy"),
        .init(id: 36, name: "It\'s a rich man\'s world", description: "Collected 100 wallet points.", kind: "social"),
        .init(id: 37, name: "It\'s a rich man\'s world", description: "Collected 200 wallet points.", kind: "social"),
        .init(id: 38, name: "It\'s a rich man\'s world", description: "Collected 500 wallet points.", kind: "social"),
        .init(id: 89, name: "It\'s a rich man\'s world", description: "Collected 1.000 wallet points.", kind: "social"),
        .init(id: 25, name: "Rigorous Basterd", description: "Validated 3 projects in a row (Piscine days included).", kind: "project"),
        .init(id: 26, name: "Rigorous Basterd", description: "Validated 10 projects in a row (Piscine days included).", kind: "project"),
        .init(id: 27, name: "Rigorous Basterd", description: "Validated 21 projects in a row (Piscine days included).", kind: "project"),
        .init(id: 218, name: "Welcome, Learner !", description: "You passed the C Piscine. Welcome at 42!", kind: "project")
    ]
    
}

extension Api.Types.User.Avatar
{
    
    static let sample = Self.init(
        link: "https://cdn.intra.42.fr/users/ed6e7d90a93ee28b04bcbadabc439024/mmosca.jpg"
    )
    
}

extension Api.Types.User.Campus
{
    
    static let sample = Self.init(id: 83671, campusId: 9, isPrimary: true)
    
}

extension Api.Types.User.Cursus
{
    
    static let sample = Self.init(
        id: 127431,
        grade: nil,
        level: 8.71,
        skills: .sample,
        cursusId: 9,
        hasCoalition: true,
        cursus: .sample
    )
    
}

extension [Api.Types.User.Cursus]
{
    
    static let sample: Self = [
        .init(id: 127431, grade: nil, level: 8.71, skills: .sample, cursusId: 9, hasCoalition: true, cursus: .sample),
        .init(id: 133072, grade: "Member", level: 11.13, skills: [], cursusId: 21, hasCoalition: true, cursus: .sample)
    ]
    
}

extension Api.Types.User.Cursus.Skills
{
    
    static let sample = Self.init(id: 4, name: "Unix", level: 10.36)
    
}

extension [Api.Types.User.Cursus.Skills]
{
    
    static let sample: Self = [
        .init(id: 4, name: "Unix", level: 10.36),
        .init(id: 1, name: "Algorithms & AI", level: 6.97),
        .init(id: 3, name: "Rigor", level: 6.07),
        .init(id: 14, name: "Adaptation & creativity", level: 4.42)
    ]
    
}

extension Api.Types.User.Cursus.Details
{
    
    static let sample = Self.init(id: 9, name: "C Piscine", slug: "c-piscine")
    
}

extension [Api.Types.User.Cursus.Details]
{
    
    static let sample: Self = [
        .init(id: 9, name: "C Piscine", slug: "c-piscine"),
        .init(id: 21, name: "42cursus", slug: "42cursus")
    ]
    
}

extension Api.Types.User.Patronages
{
    
    static let sample = Self.init(id: 2775, userId: 92127, godfatherId: 78432, ongoing: true)
    
}

extension [Api.Types.User.Patronages]
{
    
    static let sample: Self = [
        .init(id: 2775, userId: 92127, godfatherId: 78432, ongoing: true),
        .init(id: 2776, userId: 92127, godfatherId: 78432, ongoing: true)
    ]
    
}

extension Api.Types.User.Projects
{
    
    static let sample = Self.init(
        id: 3119659,
        finalMark: nil,
        status: "in_progress",
        validated: nil,
        currentTeamId: 4880392,
        project: .sample,
        cursusIds: [21],
        markedAt: nil,
        marked: false,
        retriableAt: nil
    )
    
}

extension [Api.Types.User.Projects]
{
    
    static let sample: Self = [
        .init(id: 3119659, finalMark: nil, status: "in_progress", validated: nil, currentTeamId: 4880392, project: .sample, cursusIds: [21], markedAt: nil, marked: false, retriableAt: nil),
        .init(id: 2862531, finalMark: 100, status: "finished", validated: true, currentTeamId: 4775869, project: .sample, cursusIds: [21], markedAt: .now, marked: true, retriableAt: .now)
    ]
    
}

extension Api.Types.User.Projects.Details
{
    
    static let sample = Self.init(id: 1638, name: "Internship I", slug: "internship-i", parentId: nil)
    
}

extension [Api.Types.User.Projects.Details]
{
    
    static let sample: Self = [
        .init(id: 1638, name: "Internship I", slug: "internship-i", parentId: nil),
        .init(id: 1337, name: "ft_transcendence", slug: "ft_transcendence", parentId: nil)
    ]
    
}
