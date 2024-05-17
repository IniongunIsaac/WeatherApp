//
//  Stubs+.swift
//  WeatherAppTests
//
//  Created by Isaac Iniongun on 17/05/2024.
//

import Foundation
@testable import WeatherApp

let weatherJson = """
{
    "coord": {
        "lon": 3.75,
        "lat": 6.5833
    },
    "weather": [
        {
            "id": 500,
            "main": "Rain",
            "description": "light rain",
            "icon": "10d"
        }
    ],
    "base": "stations",
    "main": {
        "temp": 303.68,
        "feels_like": 309.51,
        "temp_min": 303.68,
        "temp_max": 303.68,
        "pressure": 1010,
        "humidity": 70,
        "sea_level": 1010,
        "grnd_level": 1010
    },
    "visibility": 10000,
    "wind": {
        "speed": 2.87,
        "deg": 221,
        "gust": 3.06
    },
    "rain": {
        "1h": 0.56
    },
    "clouds": {
        "all": 100
    },
    "dt": 1715962286,
    "sys": {
        "country": "NG",
        "sunrise": 1715923718,
        "sunset": 1715968464
    },
    "timezone": 3600,
    "id": 2332453,
    "name": "Lagos",
    "cod": 200
}
"""
let weatherResponse = try? WeatherResponse.mapFrom(jsonString: weatherJson)
