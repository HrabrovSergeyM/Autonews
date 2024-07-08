//
//  NetworkingService.swift
//  Autonews
//
//  Created by Sergey Hrabrov on 08.07.2024.
//

import Foundation
import Combine

protocol NetworkingServiceProtocol {
    func get(url: URL) -> AnyPublisher<Data, Error>
    func post(url: URL, data: Data) -> AnyPublisher<Data, Error>
    func put(url: URL, data: Data) -> AnyPublisher<Data, Error>
    func delete(url: URL) -> AnyPublisher<Data, Error>
    func patch(url: URL, data: Data) -> AnyPublisher<Data, Error>
}

class NetworkingService: NetworkingServiceProtocol {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func get(url: URL) -> AnyPublisher<Data, Error> {
        executeRequest(url: url, method: .get, body: nil)
    }
    
    func post(url: URL, data: Data) -> AnyPublisher<Data, Error> {
        executeRequest(url: url, method: .post, body: data)
    }
    
    func put(url: URL, data: Data) -> AnyPublisher<Data, Error> {
        executeRequest(url: url, method: .put, body: data)
    }
    
    func delete(url: URL) -> AnyPublisher<Data, Error> {
        executeRequest(url: url, method: .delete, body: nil)
    }
    
    func patch(url: URL, data: Data) -> AnyPublisher<Data, Error> {
        executeRequest(url: url, method: .patch, body: data)
    }
    
    private func executeRequest(url: URL, method: HTTPMethod, body: Data?) -> AnyPublisher<Data, Error> {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = body
        if let body = body {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        return session.dataTaskPublisher(for: request)
            .tryMap { try self.handleURLResponse(output: $0, url: url) }
            .retry(3)
            .eraseToAnyPublisher()
    }
    
    private func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse else {
            throw NetworkingError.unknown
        }
        
        if response.statusCode < 200 || response.statusCode >= 300 {
            let responseString = String(data: output.data, encoding: .utf8) ?? "No response body"
            throw NetworkingError.badURLResponse(url: url, statusCode: response.statusCode, response: responseString)
        }
        
        return output.data
    }
}

extension NetworkingService {
    enum NetworkingError: LocalizedError {
        case badURLResponse(url: URL, statusCode: Int, response: String)
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .badURLResponse(url: let url, statusCode: let statusCode, response: let response):
                return "Bad response from URL: \(url) with status code: \(statusCode). Response: \(response)"
            case .unknown:
                return "Unknown error occurred"
            }
        }
    }
}
