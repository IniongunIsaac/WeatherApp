//
//  NetworkAPIPath.swift
//  WeatherApp
//
//  Created by Isaac Iniongun on 17/05/2024.
//

import Foundation

public enum NetworkAPIPath {
    case currentWeather
    case emptyPath
    
    private var path: String {
        switch self {
        case .currentWeather:
            return "weather"
        case .emptyPath:
            return ""
        }
    }
    
    var absoluteURL: String {
        if self == .emptyPath {
            return ""
        } else {
            return "\(Bundle.main.baseURL)\(path)"
        }
    }
}
