//
//  NetworkService.swift
//  WeatherApp
//
//  Created by Isaac Iniongun on 17/05/2024.
//

import Foundation

final public class NetworkService: NetworkServiceProtocol {
    
    private let urlSession: URLSession
    
    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }
    
    func makeRequest<T: Codable>(
        responseType: T.Type,
        requestMethod: NetworkAPIMethod,
        remotePath: NetworkAPIPath,
        parameters: NetworkRequestParameters,
        completion: @escaping NetworkResultAction<T>
    ) {
        guard remotePath != .emptyPath else {
            completion(.failure(.invalidURL))
            return
        }
        
        guard var urlComponents = URLComponents(string: remotePath.absoluteURL) else {
            completion(.failure(.invalidURL))
            return
        }
        
        if !parameters.isEmpty, requestMethod == .get {
            urlComponents.queryItems = parameters.map { key, value in
                .init(name: key, value: String(describing: value))
            }
        }
        
        urlComponents.queryItems?.append(.init(name: "appid", value: Bundle.main.openWeatherAPIAppID))
        
        guard let requestURL = urlComponents.url else {
            completion(.failure(.invalidURL))
            return
        }
        
        log("Request URL: \(requestURL.absoluteURL)")
        
        var urlRequest = URLRequest(url: requestURL)
        urlRequest.httpMethod = requestMethod.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        
        if requestMethod == .post {
            do {
                let requestBody = try JSONSerialization.data(withJSONObject: parameters)
                urlRequest.httpBody = requestBody
            } catch {
                completion(.failure(.encodingFailure(reason: error.localizedDescription)))
            }
        }
        
        urlSession.dataTask(with: urlRequest) { data, urlResponse, error in
            if let httpURLResponse = urlResponse as? HTTPURLResponse {
                let statusCode = httpURLResponse.statusCode
                
                if (400...499).contains(statusCode) {
                    completion(.failure(.resourceNotFound))
                    return
                }
                
                if statusCode >= 500 {
                    completion(.failure(.serverFailure))
                    return
                }
            }
            
            if let error {
                completion(.failure(.requestFailure(reason: error.localizedDescription)))
                return
            }
            
            if let data {
                do {
                    let response = try JSONDecoder().decode(T.self, from: data)
                    log("\(remotePath.absoluteURL) Request Response")
                    log(response.prettyJson)
                    completion(.success(response))
                } catch {
                    completion(.failure(.decodingFailure(reason: error.localizedDescription)))
                }
            } else {
                log("No Response Data:")
                completion(.failure(.noResponseData))
            }
            
        }.resume()
    }
}
