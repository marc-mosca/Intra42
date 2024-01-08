//
//  Url.swift
//  Intra42
//
//  Created by Marc Mosca on 01/01/2024.
//

import Foundation

extension Api.Endpoint
{
    
    var url: URL
    {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.intra.42.fr"
        components.path = self.path
        
        if !self.queryItems.isEmpty
        {
            components.queryItems = self.queryItems
        }
        
        return components.url!
    }
    
    private var path: String
    {
        switch self
        {
        case .authorize:
            return "/oauth/authorize"
        case .fetchApplicationAccessToken, .fetchUserAccessToken, .updateUserAccessToken:
            return "/oauth/token"
        case .fetchCorrectionPointHistorics(let userId):
            return "/v2/users/\(userId)/correction_point_historics"
        case .fetchCampusEvents(let campusId, let cursusId):
            return "/v2/campus/\(campusId)/cursus/\(cursusId)/events"
        case .fetchUserEvents(let userId):
            return "/v2/users/\(userId)/events"
        case .fetchEventUser(let userId, _):
            return "/v2/users/\(userId)/events_users"
        case .updateUserEvents:
            return "/v2/events_users"
        case .deleteEvent(let eventUserId):
            return "/v2/events_users/\(eventUserId)"
        case .fetchCampusExams(let campusId):
            return "/v2/campus/\(campusId)/exams"
        case .fetchUserExams(let userId):
            return "/v2/users/\(userId)/exams"
        case .fetchLogtime(let login, _):
            return "/v2/users/\(login)/locations_stats"
        case .fetchUserScales:
            return "/v2/me/scale_teams"
        case .fetchUserSlots:
            return "/v2/me/slots"
        case .createUserSlot:
            return "/v2/slots"
        case .deleteUserSlot(let slotId):
            return "/v2/slots/\(slotId)"
        case .fetchConnectedUser:
            return "/v2/me"
        case .fetchUserById(let id):
            return "/v2/users/\(id)"
        case .fetchUserByLogin(let login):
            return "/v2/users/\(login)"
        case .fetchProject(let id):
            return "/v2/projects/\(id)"
        }
    }
    
    private var queryItems: [URLQueryItem]
    {
        switch self
        {
        case .authorize:
            return [
                URLQueryItem(name: "client_id", value: Api.Keys.clientID.value),
                URLQueryItem(name: "redirect_uri", value: Api.Keys.redirectURI.value),
                URLQueryItem(name: "response_type", value: "code"),
                URLQueryItem(name: "scope", value: "public+projects+profile+elearning+tig+forum")
            ]
        case .fetchApplicationAccessToken:
            return [
                URLQueryItem(name: "grant_type", value: "client_credentials"),
                URLQueryItem(name: "client_id", value: Api.Keys.clientID.value),
                URLQueryItem(name: "client_secret", value: Api.Keys.secretID.value),
                URLQueryItem(name: "scope", value: "public+projects+profile+elearning+tig+forum")
            ]
        case .fetchUserAccessToken(let code):
            return [
                URLQueryItem(name: "grant_type", value: "authorization_code"),
                URLQueryItem(name: "client_id", value: Api.Keys.clientID.value),
                URLQueryItem(name: "client_secret", value: Api.Keys.secretID.value),
                URLQueryItem(name: "code", value: code),
                URLQueryItem(name: "redirect_uri", value: Api.Keys.redirectURI.value)
            ]
        case .updateUserAccessToken(let refreshToken):
            return [
                URLQueryItem(name: "grant_type", value: "refresh_token"),
                URLQueryItem(name: "client_id", value: Api.Keys.clientID.value),
                URLQueryItem(name: "client_secret", value: Api.Keys.secretID.value),
                URLQueryItem(name: "refresh_token", value: refreshToken),
                URLQueryItem(name: "redirect_uri", value: Api.Keys.redirectURI.value)
            ]
        case .fetchCorrectionPointHistorics:
            return [
                URLQueryItem(name: "sort", value: "-created_at")
            ]
        case .fetchCampusEvents:
            return [
                URLQueryItem(name: "filter[future]", value: "true"),
                URLQueryItem(name: "sort", value: "begin_at"),
                URLQueryItem(name: "page[size]", value: "100")
            ]
        case .fetchUserEvents:
            return [
                URLQueryItem(name: "sort", value: "-begin_at"),
                URLQueryItem(name: "page[size]", value: "100")
            ]
        case .fetchEventUser(_, let eventId):
            return [
                URLQueryItem(name: "filter[event_id]", value: "\(eventId)")
            ]
        case .updateUserEvents(let userId, let eventId):
            return [
                URLQueryItem(name: "events_user[event_id]", value: "\(eventId)"),
                URLQueryItem(name: "events_user[user_id]", value: "\(userId)")
            ]
        case .fetchCampusExams, .fetchUserExams:
            return [
                URLQueryItem(name: "filter[future]", value: "true"),
                URLQueryItem(name: "sort", value: "-begin_at")
            ]
        case .fetchLogtime(_, let entryDate):
            return [
                URLQueryItem(name: "begin_at", value: entryDate)
            ]
        case .fetchUserScales:
            return [
                URLQueryItem(name: "sort", value: "-begin_at"),
                URLQueryItem(name: "page[size]", value: "100")
            ]
        case .fetchUserSlots:
            return [
                URLQueryItem(name: "filter[future]", value: "true"),
                URLQueryItem(name: "sort", value: "-begin_at"),
                URLQueryItem(name: "page[size]", value: "100")
            ]
        case .createUserSlot(let userId, let beginAt, let endAt):
            return [
                URLQueryItem(name: "slot[user_id]", value: "\(userId)"),
                URLQueryItem(name: "slot[begin_at]", value: "\(beginAt)"),
                URLQueryItem(name: "slot[end_at]", value: "\(endAt)")
            ]
        default:
            return []
        }
    }
    
}
