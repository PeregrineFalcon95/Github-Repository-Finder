//
//  GitHubApiClient.swift
//  RepoFinder
//
//  Created by Amit Sarker on 15/6/23.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case invalidResponse
    case httpResponse(Int)
    case decodingError(Error)
    case networkingError(Error)
}

class GitHubAPI {
    static let shared = GitHubAPI()

    private let baseURL = "https://api.github.com"

    private init() {}

    private func makeRequest(endpoint: String, queryParams: [String: String]?, completion: @escaping (Result<Data, APIError>) -> Void) {
        var components = URLComponents(string: baseURL + endpoint)!
        components.queryItems = queryParams?.map { URLQueryItem(name: $0.key, value: $0.value) }

        guard let url = components.url else {
            completion(.failure(.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(.networkingError(error)))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.invalidResponse))
                return
            }

            guard (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.httpResponse(httpResponse.statusCode)))
                return
            }

            guard let data = data else {
                completion(.failure(.invalidResponse))
                return
            }
            completion(.success(data))
        }

        task.resume()
    }

    func performGetRequest(endpoint: String, queryParams: [String: String]?, completion: @escaping (Result<Data, APIError>) -> Void) {
        makeRequest(endpoint: endpoint, queryParams: queryParams, completion: completion)
    }

    func performGetRequest<T: Decodable>(endpoint: String, queryParams: [String: String]?, completion: @escaping (Result<T, APIError>) -> Void) {
        makeRequest(endpoint: endpoint, queryParams: queryParams) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let decodedData = try decoder.decode(T.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
