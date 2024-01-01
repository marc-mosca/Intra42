//
//  Endpoint.swift
//  Intra42
//
//  Created by Marc Mosca on 01/01/2024.
//

import Foundation

extension Api
{
    
    /// A structure representing the API's endpoints.
    public enum Endpoint
    {
        
        // Correction Point Historics
        
        case fetchCorrectionPointHistorics(userId: Int)
        
        // Events
        
        case fetchCampusEvents(campusId: Int, cursusId: Int)
        case fetchUserEvents(userId: Int)
        case fetchEventUser(userId: Int, eventId: Int)
        case updateUserEvents(userId: Int, eventId: Int)
        case deleteEvent(eventUserId: Int)
        
        // Exams
        
        case fetchCampusExams(campusId: Int)
        case fetchUserExams(userId: Int)
        
        // Logtime
        
        case fetchLogtime(login: String, entryDate: String)
        
        // OAuth
        
        case authorize
        case fetchApplicationAccessToken
        case fetchUserAccessToken(code: String)
        case updateUserAccessToken(refreshToken: String)
        
        // Scales
        
        case fetchUserScales
        
        // Slots
        
        case fetchUserSlots
        case createUserSlot(userId: Int, beginAt: Date, endAt: Date)
        case deleteUserSlot(slotId: Int)
        
        // User
        
        case fetchConnectedUser
        case fetchUserById(id: Int)
        case fetchUserByLogin(login: String)
        
    }
    
}
