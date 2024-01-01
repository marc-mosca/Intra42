//
//  Client.swift
//  Intra42
//
//  Created by Marc Mosca on 01/01/2024.
//

import Foundation
import OSLog

extension Api
{
    
    public final class Client
    {
        
        // MARK: - Exposed properties
        
        /// The shared singleton api client object.
        public static let shared = Client()
        
        // MARK: - Private properties
        
        /// The number of times the server returns a 401 error.
        private var numberOfRetry = 0
        
        /// The object used to decode the data received from the API.
        private let decoder = JSONDecoder()
        
        /// The object used to display the final status of the request in the console.
        private let logger = Logger(subsystem: "Intra42", category: "API")
        
        private init()
        {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            formatter.timeZone = TimeZone.current
            formatter.locale = Locale.current
            
            self.decoder.keyDecodingStrategy = .convertFromSnakeCase
            self.decoder.dateDecodingStrategy = .formatted(formatter)
        }
        
        // MARK: - Exposed methods
        
        public func request(for endpoint: Endpoint) async throws -> Void
        {
            let req = try handleRequest(for: endpoint)
            
            do
            {
                let (_, response) = try await URLSession.shared.data(for: req)
                try handleResponse(for: req, response: response)
            }
            catch Api.Errors.invalidAccessToken
            {
                try await handleInvalidAccessToken(authorization: endpoint.authorization)
                try await request(for: endpoint)
            }
            catch Api.Errors.tooManyRequests
            {
                try await Task.sleep(for: .seconds(1.5))
                try await request(for: endpoint)
            }
            catch AppError.apiAuthorization
            {
                numberOfRetry = 0
                throw AppError.apiAuthorization
            }
            catch
            {
                throw error
            }
        }
        
        public func request<T: Decodable>(for endpoint: Endpoint) async throws -> T
        {
            let req = try handleRequest(for: endpoint)
            
            do
            {
                let (data, response) = try await URLSession.shared.data(for: req)
                try handleResponse(for: req, response: response)
                return try decoder.decode(T.self, from: data)
            }
            catch Api.Errors.invalidAccessToken
            {
                try await handleInvalidAccessToken(authorization: endpoint.authorization)
                return try await request(for: endpoint)
            }
            catch Api.Errors.tooManyRequests
            {
                try await Task.sleep(for: .seconds(1.5))
                return try await request(for: endpoint)
            }
            catch AppError.apiAuthorization
            {
                numberOfRetry = 0
                throw AppError.apiAuthorization
            }
            catch
            {
                throw error
            }
        }
        
        // MARK: - Private methods
        
        private func handleRequest(for endpoint: Endpoint) throws -> URLRequest
        {
            var request = URLRequest(url: endpoint.url)
            request.httpMethod = endpoint.method
            
            if let token = endpoint.authorization == .user ? Api.Tokens.userAccessToken.value : Api.Tokens.applicationAccessToken.value
            {
                request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            }
            
            return request
        }
        
        private func handleResponse(for request: URLRequest, response: URLResponse) throws
        {
            guard let response = response as? HTTPURLResponse else { throw Api.Errors.invalidServerResponse }
            guard numberOfRetry <= 10 else { throw AppError.apiAuthorization }
            
            switch response.statusCode
            {
            case 200..<300:
                logger.info("✅ [\(response.statusCode)] [\(request.httpMethod ?? "")] \(request, privacy: .private) - Request successful.")
            case 401:
                logger.error("🛑 [\(response.statusCode)] [\(request.httpMethod ?? "")] \(request, privacy: .private) - Access token expired.")
                numberOfRetry += 1
                throw Api.Errors.invalidAccessToken
            case 429:
                logger.error("🛑 [\(response.statusCode)] [\(request.httpMethod ?? "")] \(request, privacy: .private) - Too many requests.")
                throw Api.Errors.tooManyRequests
            default:
                logger.error("🛑 [\(response.statusCode)] [\(request.httpMethod ?? "")] \(request, privacy: .private) - Invalid server response.")
                throw Api.Errors.invalidServerResponse
            }
        }
        
        private func handleInvalidAccessToken(authorization: Api.Endpoint.Authorization) async throws
        {
            switch authorization
            {
            case .application:
                try await request(for: .fetchApplicationAccessToken)
            case .user:
                guard let refreshToken = Api.Tokens.userRefreshToken.value else { throw Api.Errors.invalidAccessToken }
                try await request(for: .updateUserAccessToken(refreshToken: refreshToken))
            }
        }
        
    }
    
}
