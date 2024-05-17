//
//  WeatherResponse.swift
//  WeatherApp
//
//  Created by Isaac Iniongun on 17/05/2024.
//

import Foundation

public struct WeatherResponse: Codable {
    let coord: Coord?
    let weather: [Weather]?
    let base: String?
    let main: Main?
    let visibility: Double?
    let wind: Wind?
    let clouds: Clouds?
    let dt: Double?
    let sys: Sys?
    let timezone, id: Double?
    let name: String?
    let cod: Double?
}

public struct Clouds: Codable {
    let all: Double?
}

public struct Coord: Codable {
    let lon, lat: Double?
}

public struct Main: Codable {
    let temp, feelsLike, tempMin, tempMax: Double?
    let pressure, humidity, seaLevel, grndLevel: Double?

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
    }
}

public struct Sys: Codable {
    let country: String?
    let type, sunrise, sunset: Double?
}

public struct Weather: Codable {
    let id: Double?
    let main, description, icon: String?
}

public struct Wind: Codable {
    let speed: Double?
    let deg: Double?
    let gust: Double?
}
