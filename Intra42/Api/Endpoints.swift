//
//  Endpoints.swift
//  Intra42
//
//  Created by Marc Mosca on 13/01/2024.
//

import Foundation

extension Api {
    
    // MARK: - Endpoints
    
    /// An enumeration of all the endpoints used to communicate with the API.
    enum Endpoints {
        
        // MARK: - Cases
        
        case fetchCorrectionPointHistorics(userId: Int)
        case fetchCampusEvents(campusId: Int, cursusId: Int)
        case fetchUserEvents(userId: Int)
        case fetchEventUser(userId: Int, eventId: Int)
        case updateUserEvents(userId: Int, eventId: Int)
        case deleteEvent(eventUserId: Int)
        case fetchCampusExams(campusId: Int)
        case fetchUserExams(userId: Int)
        case fetchLogtime(login: String, entryDate: String)
        case authorize
        case fetchApplicationAccessToken
        case fetchUserAccessToken(code: String)
        case updateUserAccessToken(refreshToken: String)
        case fetchProject(id: Int)
        case fetchUserScales
        case fetchUserSlots
        case createUserSlot(userId: Int, beginAt: Date, endAt: Date)
        case deleteUserSlot(slotId: Int)
        case fetchConnectedUser
        case fetchUserById(id: Int)
        case fetchUserByLogin(login: String)
        
        // MARK: - Authorizations
        
        /// The type of authorisation required to execute the request to the API.
        var authorization: Authorizations {
            switch self {
            case .fetchCampusExams:     return .application
            case .fetchUserExams:       return .application
            case .fetchLogtime:         return .application
            default:                    return .user
            }
        }
        
        // MARK: - Methods
        
        /// The method used to execute the request to the API.
        var method: String {
            switch self {
            case .fetchApplicationAccessToken:      return Methods.post.rawValue
            case .fetchUserAccessToken:             return Methods.post.rawValue
            case .createUserSlot:                   return Methods.post.rawValue
            case .updateUserEvents:                 return Methods.post.rawValue
            case .updateUserAccessToken:            return Methods.post.rawValue
            case .deleteUserSlot:                   return Methods.delete.rawValue
            case .deleteEvent:                      return Methods.delete.rawValue
            default:                                return Methods.get.rawValue
            }
        }
        
        // MARK: - URLs
        
        /// The URL generated corresponds to the access point to the API.
        var url: URL {
            var components = URLComponents()
            components.scheme = "https"
            components.host = "api.intra.42.fr"
            components.path = self.path
            
            if !self.queryItems.isEmpty {
                components.queryItems = self.queryItems
            }
            
            return components.url!
        }
        
        // MARK: - Paths
        
        private var path: String {
            switch self {
            case .authorize:                                        return "/oauth/authorize"
            case .fetchApplicationAccessToken:                      return "/oauth/token"
            case .fetchUserAccessToken:                             return "/oauth/token"
            case .updateUserAccessToken:                            return "/oauth/token"
            case .fetchCorrectionPointHistorics(let userId):        return "/v2/users/\(userId)/correction_point_historics"
            case .fetchCampusEvents(let campusId, let cursusId):    return "/v2/campus/\(campusId)/cursus/\(cursusId)/events"
            case .fetchUserEvents(let userId):                      return "/v2/users/\(userId)/events"
            case .fetchEventUser(let userId, _):                    return "/v2/users/\(userId)/events_users"
            case .updateUserEvents:                                 return "/v2/events_users"
            case .deleteEvent(let eventUserId):                     return "/v2/events_users/\(eventUserId)"
            case .fetchCampusExams(let campusId):                   return "/v2/campus/\(campusId)/exams"
            case .fetchUserExams(let userId):                       return "/v2/users/\(userId)/exams"
            case .fetchLogtime(let login, _):                       return "/v2/users/\(login)/locations_stats"
            case .fetchUserScales:                                  return "/v2/me/scale_teams"
            case .fetchUserSlots:                                   return "/v2/me/slots"
            case .createUserSlot:                                   return "/v2/slots"
            case .deleteUserSlot(let slotId):                       return "/v2/slots/\(slotId)"
            case .fetchConnectedUser:                               return "/v2/me"
            case .fetchUserById(let id):                            return "/v2/users/\(id)"
            case .fetchUserByLogin(let login):                      return "/v2/users/\(login)"
            case .fetchProject(let id):                             return "/v2/projects/\(id)"
            }
        }
        
        // MARK: - Query Items
        
        private var queryItems: [URLQueryItem] {
            switch self {
            case .authorize:                                            return [.clientId, .redirectUri, .custom(name: "response_type", value: "code"), .scope]
            case .fetchApplicationAccessToken:                          return [.grantType(.clientCredentials), .clientId, .secretId, .scope]
            case .fetchUserAccessToken(let code):                       return [.grantType(.authorizationCode), .clientId, .secretId, .custom(name: "code", value: code), .redirectUri]
            case .updateUserAccessToken(let refreshToken):              return [.grantType(.refreshToken), .clientId, .secretId, .custom(name: "refresh_token", value: refreshToken), .redirectUri]
            case .fetchCorrectionPointHistorics:                        return [.sort(by: .createdAtReversed)]
            case .fetchCampusEvents:                                    return [.filterFuture, .sort(by: .beginAt), .pageSize]
            case .fetchUserEvents:                                      return [.sort(by: .beginAtReversed), .pageSize]
            case .fetchEventUser(_, let eventId):                       return [.custom(name: "filter[event_id]", value: "\(eventId)")]
            case .updateUserEvents(let userId, let eventId):            return [.custom(name: "events_user[event_id]", value: "\(eventId)"), .custom(name: "events_user[user_id]", value: "\(userId)")]
            case .fetchCampusExams:                                     return [.filterFuture, .sort(by: .beginAtReversed)]
            case .fetchUserExams:                                       return [.filterFuture, .sort(by: .beginAtReversed)]
            case .fetchLogtime(_, let entryDate):                       return [.custom(name: "begin_at", value: entryDate)]
            case .fetchUserScales:                                      return [.sort(by: .beginAtReversed), .pageSize]
            case .fetchUserSlots:                                       return [.filterFuture, .sort(by: .beginAtReversed), .pageSize]
            case .createUserSlot(let userId, let beginAt, let endAt):   return [.custom(name: "slot[user_id]", value: "\(userId)"), .custom(name: "slot[begin_at]", value: "\(beginAt)"), .custom(name: "slot[end_at]", value: "\(endAt)")]
            default:                                                    return []
            }
        }
        
        // MARK: - Enums
        
        /// An enumeration of all the types of authorisation required communicating with the API.
        enum Authorizations {
            case application, user
        }
        
        /// An enumeration of all the request methods for communicating with the API.
        enum Methods: String {
            case get, post, delete
        }
        
    }
    
}
