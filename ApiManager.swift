//
//  ApiManager.swift
//  A simple API call procedure
//  2019, Francesco Sorrentino
//  https://it.linkedin.com/in/franksorro

import Foundation

class ApiManager: NSObject {
    
    private override init() {}
    
    public static let shared = ApiManager()
    
    enum ApiError: Error {
        case networkError(Error)
        case dataNotFound
        case jsonParsingError(Error)
        case invalidStatusCode(Error)
        case invalidParameters(Error)
        case badUrl
    }
    
    enum Result<T> {
        case success(T)
        case failure(ApiError)
    }
    
    enum httpMethods {
        case get
        case post
        case put
        case delete
    }
    
    enum Encoding {
        case json
        case data
        case string
    }
    
    private let cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy
    private let timeoutInterval: TimeInterval = 20.0
    
    func Request<T: Decodable>(with url: String,
                               type: T.Type,
                               _ method: httpMethods = .get,
                               _ headers: [String: String] = [:],
                               _ parameters: Any? = nil,
                               _ encoding: Encoding = .json,
                               completion: @escaping (Result<T>) -> Void) {
        guard
            let url = URL(string: url)
            else {
                completion(.failure(.badUrl))
                return
        }
        
        var request = URLRequest(url: url,
                                 cachePolicy: cachePolicy,
                                 timeoutInterval: timeoutInterval)
        request.httpMethod = String(describing: method)
        
        if let parameters = parameters {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters,
                                                              options: [])
                
            } catch let error {
                completion(.failure(.invalidParameters(error)))
                return
            }
        }
        
        headers.forEach({ (key, value) in
            request.addValue(value, forHTTPHeaderField: key)
        })
        
        URLSession.shared.dataTask(with: request,
                                   completionHandler: { data, response, error in
            guard
                error == nil
                else {
                    completion(.failure(.networkError(error!)))
                    return
            }
            
            guard
                let data = data
                else {
                    completion(.failure(.dataNotFound))
                    return
            }
            
            do {
                let decodedObject = try JSONDecoder().decode(type.self, from: data)
                completion(.success(decodedObject))
                
            } catch let error {
                completion(.failure(.jsonParsingError(error as! DecodingError)))
            }
                
        }).resume()
    }
}
