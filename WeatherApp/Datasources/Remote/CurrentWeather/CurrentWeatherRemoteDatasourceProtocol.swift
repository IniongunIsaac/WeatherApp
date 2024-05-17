//
//  CurrentWeatherRemoteDatasourceProtocol.swift
//  WeatherApp
//
//  Created by Isaac Iniongun on 17/05/2024.
//

import Foundation

public protocol CurrentWeatherRemoteDatasourceProtocol {
    func getCityWeatherData(
        params: NetworkRequestParameters,
        completion: @escaping NetworkResultAction<WeatherResponse>
    )
}
