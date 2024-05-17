//
//  NetworkServiceProtocol.swift
//  WeatherApp
//
//  Created by Isaac Iniongun on 17/05/2024.
//

import Foundation

protocol NetworkServiceProtocol {
    func makeRequest<T: Codable>(
        responseType: T.Type,
        requestMethod: NetworkAPIMethod,
        remotePath: NetworkAPIPath,
        parameters: NetworkRequestParameters,
        completion: @escaping NetworkResultAction<T>
    )
}
