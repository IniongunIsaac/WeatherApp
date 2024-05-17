//
//  MockCurrentWeatherRemoteDatasourceProtocol.swift
//  WeatherAppTests
//
//  Created by Isaac Iniongun on 17/05/2024.
//

import Foundation
@testable import WeatherApp

final class MockCurrentWeatherRemoteDatasourceProtocol: CurrentWeatherRemoteDatasourceProtocol {
    var getCityWeatherDataCalled = false
    var getCityWeatherDataParams: NetworkRequestParameters?
    var getCityWeatherDataCompletion: NetworkResultAction<WeatherResponse>?

    func getCityWeatherData(params: NetworkRequestParameters, completion: @escaping NetworkResultAction<WeatherResponse>) {
        getCityWeatherDataCalled = true
        getCityWeatherDataParams = params
        getCityWeatherDataCompletion = completion
    }
}
