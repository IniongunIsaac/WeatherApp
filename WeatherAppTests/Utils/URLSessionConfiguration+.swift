//
//  URLSessionConfiguration+.swift
//  WeatherAppTests
//
//  Created by Isaac Iniongun on 17/05/2024.
//

import Foundation

extension URLSessionConfiguration {
    static var mockDefault: URLSessionConfiguration {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self] + (config.protocolClasses ?? [])
        return config
    }
}

extension URL {
    static var google1 = URL(string: "https://www.google1.com")!
}
