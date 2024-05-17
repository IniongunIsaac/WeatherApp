//
//  Bundle+.swift
//  WeatherApp
//
//  Created by Isaac Iniongun on 17/05/2024.
//

import Foundation
import UIKit

extension Bundle {
    func value<T>(for key: String) -> T? {
        object(forInfoDictionaryKey: key) as? T
    }
    
    var baseURL: String { value(for: "BASE_URL")! }
    
    var openWeatherAPIAppID: String { value(for: "OPEN_WEATHER_API_APP_ID")! }
    
}
