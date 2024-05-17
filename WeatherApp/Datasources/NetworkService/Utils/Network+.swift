//
//  Network+.swift
//  WeatherApp
//
//  Created by Isaac Iniongun on 17/05/2024.
//

import Foundation

public typealias NetworkResultAction<T: Codable> = (Result<T, NetworkError>) -> Void
public typealias NetworkRequestParameters = [String: Any]
