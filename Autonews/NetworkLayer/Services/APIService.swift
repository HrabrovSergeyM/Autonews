//
//  APIService.swift
//  Autonews
//
//  Created by Sergey Hrabrov on 08.07.2024.
//

import Combine
import Foundation

protocol APIServiceProtocol {
    func fetch<T: Decodable>(path: Endpoint, parameters: [QueryParameter]) -> AnyPublisher<T, Error>
    func create<T: Encodable, U: Decodable>(path: Endpoint, object: T) -> AnyPublisher<U, Error>
    func createWithoutResponse<T: Encodable>(path: Endpoint, object: T) -> AnyPublisher<Void, Error>
    func update<T: Encodable, U: Decodable>(path: Endpoint, object: T) -> AnyPublisher<U, Error>
    func delete(path: Endpoint) -> AnyPublisher<Void, Error>
}

class APIService: APIServiceProtocol {
    private let networkingService: NetworkingServiceProtocol
    
    init(networkingService: NetworkingServiceProtocol = NetworkingService()) {
        self.networkingService = networkingService
    }
    
    private func fullURL(path: Endpoint, parameters: [QueryParameter] = []) -> URL? {
        return path.withParameters(parameters)
    }
    
    func fetch<T: Decodable>(path: Endpoint, parameters: [QueryParameter] = []) -> AnyPublisher<T, Error> {
        guard let url = fullURL(path: path, parameters: parameters) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        print(url)
        return networkingService.get(url: url)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func create<T: Encodable, U: Decodable>(path: Endpoint, object: T) -> AnyPublisher<U, Error> {
        do {
            let data = try JSONEncoder().encode(object)
            guard let url = fullURL(path: path) else {
                return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
                
            }
            return networkingService.post(url: url, data: data)
                .decode(type: U.self, decoder: JSONDecoder())
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
    
    func createWithoutResponse<T: Encodable>(path: Endpoint, object: T) -> AnyPublisher<Void, Error> {
        do {
            let data = try JSONEncoder().encode(object)
            guard let url = fullURL(path: path) else {
                return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
            }
            return networkingService.post(url: url, data: data)
                .map { _ in () }
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
    
    func update<T: Encodable, U: Decodable>(path: Endpoint, object: T) -> AnyPublisher<U, Error> {
        do {
            let data = try JSONEncoder().encode(object)
            guard let url = fullURL(path: path) else {
                return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
            }
            return networkingService.put(url: url, data: data)
                .decode(type: U.self, decoder: JSONDecoder())
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
    
    func delete(path: Endpoint) -> AnyPublisher<Void, Error> {
        guard let url = fullURL(path: path) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        return networkingService.delete(url: url)
            .map { _ in () }
            .eraseToAnyPublisher()
    }
}

extension APIServiceProtocol {
    func create<T: Encodable, U: Decodable>(path: Endpoint, object: T, responseType: U.Type) -> AnyPublisher<U, Error> {
        return create(path: path, object: object)
    }
}
