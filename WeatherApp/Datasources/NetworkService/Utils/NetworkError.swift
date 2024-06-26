//
//  RemoteDatasourceError.swift
//  WeatherApp
//
//  Created by Isaac Iniongun on 17/05/2024.
//

import Foundation

public enum NetworkError: Error, Equatable {
    case invalidURL
    case requestFailure(reason: String)
    case decodingFailure(reason: String)
    case encodingFailure(reason: String)
    case resourceNotFound
    case serverFailure
    case noResponseData
    
    var description: String? {
        switch self {
        case .invalidURL:
            return "Bad Request URL"
        case .requestFailure(reason: let reason):
            return "Unable to perform request, please try again.\nReason: \(reason)"
        case .decodingFailure(reason: let reason):
            return "Unable to read data from server, please try again.\nReason: \(reason)"
        case .encodingFailure(reason: let reason):
            return "Unable to send request data, please try again.\nReason: \(reason)"
        case .resourceNotFound:
            return "Unable to locate resource on the server, please try again or contact customer support."
        case .serverFailure:
            return "Unable to contact the server, please try again."
        case .noResponseData:
            return "An error occurred, try again"
        }
    }
}
