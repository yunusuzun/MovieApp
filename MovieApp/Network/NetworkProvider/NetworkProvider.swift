//
//  NetworkProvider.swift
//  MovieApp
//
//  Created by Yunus Uzun on 7.09.2023.
//

import Foundation

typealias DataTaskResult = @Sendable (Data?, URLResponse?, Error?) -> Void

protocol URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol { }

final class NetworkProvider<T: Endpoint> {
    let session: URLSessionProtocol
    let decoder: ResponseDecoder
    
    init(session: URLSession = URLSession.shared, decoder: ResponseDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
    }
    
    func request<U: Decodable>(_ endpoint: T, completion: @escaping (Result<U, Error>) -> Void) {
        guard let request = try? buildRequest(from: endpoint) else {
            completion(.failure(NSError(domain: .empty, code: -1, userInfo: nil)))
            return
        }
        
        session.dataTask(with: request) { (data, _, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: .empty, code: -2, userInfo: nil)))
                return
            }
            
            do {
                let response = try self.decoder.decode(U.self, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

private extension NetworkProvider {
    func buildRequest(from endpoint: T) throws -> URLRequest {
        var url = endpoint.baseURL.appendingPathComponent(endpoint.path)
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.headers
        
        switch endpoint.task {
        case .requestPlain:
            break
        case .requestParameters(let bodyParameters, let queryParameters):
            if let body = bodyParameters {
                request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
            }
            if let query = queryParameters {
                url = url.appending(queryParameters: query)
                request.url = url
            }
        }
        
        return request
    }
}
