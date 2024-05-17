//
//  Preference.swift
//  WeatherApp
//
//  Created by Isaac Iniongun on 17/05/2024.
//

import Foundation

struct Preference: PreferenceProtocol {
    @UserDefaultPrimitive(key: .cityName, default: "")
    var cityName: String
}
