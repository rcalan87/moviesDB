//
//  ServiceLayer.swift
//  moviesDB
//
//  Created by Alan Rodriguez on 25/11/24.
//

import Foundation

class ServiceLayer {
    static let shared = ServiceLayer()
    private lazy var tasks = Set([URLSessionDataTask]())
    
    private func addTask(_ task: URLSessionDataTask) {
        tasks.insert(task)
    }
    
    private func removeTask(forRequest request: URLRequest) {
        guard let task = tasks.filter({$0.currentRequest == request}).first else { return }
        tasks.remove(task)
    }
    
    // MARK: - Request
    func getRequest<T: Decodable>(url: String,
                                  page: Int? = nil,
                                  auth: String? = nil,
                                  contentType: String? = nil) async -> Result<T?, ServiceError> {
        guard let url = URL(string: url) else {
            return .failure(.invalidURL)
        }
        
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            print("::: ERROR ON REQUEST:" + ServiceError.invalidURL.localizedDescription + " :::")
            return .failure(.invalidURL)
        }
        
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "page", value: String(page ?? 1)),
        ]
        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems
        
        guard let composedUrl = components.url else {
            print("::: ERROR ON REQUEST:" + ServiceError.invalidURL.localizedDescription + " :::")
            return .failure(.invalidURL)
        }
        
        var request = URLRequest(url: composedUrl)
        
        if let contentType = contentType {
            request.addValue(contentType, forHTTPHeaderField: "Content-Type")
        } else {
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        if let auth = auth {
            request.addValue("Bearer \(auth)", forHTTPHeaderField: "Authorization")
        }
        
        return await withCheckedContinuation { (continuation: CheckedContinuation<Result<T?, ServiceError>, Never>) in
            execute(request) { result in
                continuation.resume(returning: result)
            }
        }
    }
    
    // MARK: - Request trigger
    private func execute<T: Decodable>(_ request: URLRequest,
                                       completion: @escaping (Result<T?, ServiceError>) -> Void) {
        print("::: REQUEST URL: \(request.url?.absoluteString ?? "NOT DEFINED") :::")
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = request.timeoutInterval
        let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: nil)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            ServiceLayer.shared.removeTask(forRequest: request)
            if let error = error {
                print("::: ERROR ON REQUEST:" + error.localizedDescription + " :::")
                completion(.failure(.genericError))
            }
            
            if let data = data,
               let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 200...299:
                    if data.isEmpty {
                        return completion(.success(nil))
                    }
                    do {
                        let jsonDecoder = JSONDecoder()
                         jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                        let response = try jsonDecoder.decode(T.self, from: data)
                        return completion(.success(response))
                    } catch {
                        return completion(.failure(ServiceError.genericError))
                    }
                default:
                    print("::: ERROR ON REQUEST: UKNOWN ERROR :::")
                    return completion(.failure(ServiceError.genericError))
                }
            }
        }
        
        ServiceLayer.shared.addTask(task)
        
        task.resume()
    }
}

// MARK: - Errors
enum ServiceError: Error {
    case invalidURL
    case genericError
    case mockupMissingError
}

extension ServiceError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("The URL on the request is invalid", comment: "Invalid URL")
        case .genericError:
            return NSLocalizedString("There was an error on the response", comment: "Generic Error")
        case .mockupMissingError:
            return NSLocalizedString("There is no JSON file for that request", comment: "JSON FILE MISSING")
        }
    }
}
