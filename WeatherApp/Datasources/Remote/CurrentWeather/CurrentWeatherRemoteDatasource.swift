//
//  CurrentWeatherRemoteDatasource.swift
//  WeatherApp
//
//  Created by Isaac Iniongun on 17/05/2024.
//

import Foundation

final class CurrentWeatherRemoteDatasource: CurrentWeatherRemoteDatasourceProtocol {
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func getCityWeatherData(
        params: NetworkRequestParameters,
        completion: @escaping NetworkResultAction<WeatherResponse>
    ) {
        networkService.makeRequest(
            responseType: WeatherResponse.self,
            requestMethod: .get,
            remotePath: .currentWeather,
            parameters: params,
            completion: completion
        )
    }
}
