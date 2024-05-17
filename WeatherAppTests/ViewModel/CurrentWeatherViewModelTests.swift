//
//  CurrentWeatherViewModelTests.swift
//  WeatherAppTests
//
//  Created by Isaac Iniongun on 17/05/2024.
//

import XCTest
@testable import WeatherApp

final class CurrentWeatherViewModelTests: XCTestCase {
    
    private var viewModel: CurrentWeatherViewModel!
    private var viewProtocol: MockCurrentWeatherViewProtocol!
    private var preference: MockPreferenceProtocol!
    private var remoteDatasource: MockCurrentWeatherRemoteDatasourceProtocol!

    override func setUpWithError() throws {
        try super.setUpWithError()
        viewProtocol = MockCurrentWeatherViewProtocol()
        preference = MockPreferenceProtocol()
        remoteDatasource = MockCurrentWeatherRemoteDatasourceProtocol()
        viewModel = CurrentWeatherViewModel(
            remoteDatasource: remoteDatasource,
            preference: preference
        )
        viewModel.viewProtocol = viewProtocol
    }

    override func tearDownWithError() throws {
        remoteDatasource = nil
        preference = nil
        viewProtocol = nil
        viewModel = nil
        try super.tearDownWithError()
    }
    
    func testInitialCityName() {
        XCTAssertEqual(viewModel.cityName, preference.cityName)
    }
    
    func testSaveCityNameSetting() {
        viewModel.saveCityNameSetting(true)
        viewModel.updateCityName("TestCity")
        viewModel.getCityWeatherData()
        XCTAssertEqual(preference.cityName, "TestCity")
    }
    
    func testUpdateCityNameWithEmptyName() {
        viewModel.updateCityName("")
        XCTAssertTrue(viewProtocol.showInlineErrorMessageCalled)
        XCTAssertEqual(viewProtocol.showInlineErrorMessageShow, true)
    }
    
    func testUpdateCityNameWithNonEmptyName() {
        viewModel.updateCityName("Lagos")
        XCTAssertTrue(viewProtocol.showInlineErrorMessageCalled)
        XCTAssertEqual(viewProtocol.showInlineErrorMessageShow, false)
    }
    
    func testGetCityWeatherDataWithEmptyCityName() {
        viewModel.updateCityName("")
        viewModel.getCityWeatherData()
        XCTAssertTrue(viewProtocol.showInlineErrorMessageCalled)
        XCTAssertEqual(viewProtocol.showInlineErrorMessageShow, true)
    }
    
    func testGetCityWeatherDataWithNonEmptyCityName() {
        viewModel.updateCityName("Lagos")
        viewModel.getCityWeatherData()
        
        XCTAssertTrue(viewProtocol.showLoadingCalled)
        XCTAssertEqual(viewProtocol.showLoadingLoading, true)
        XCTAssertTrue(viewProtocol.enableUIElementsCalled)
        XCTAssertEqual(viewProtocol.enableUIElementsEnabled, false)
        XCTAssertTrue(remoteDatasource.getCityWeatherDataCalled)
        XCTAssertEqual(remoteDatasource.getCityWeatherDataParams?["q"] as? String, "Lagos")
    }
    
    func testGetCityWeatherDataSuccess() {
        viewModel.updateCityName("Lagos")
        viewModel.getCityWeatherData()
        
        guard let weatherResponse = weatherResponse else { return }
        
        remoteDatasource.getCityWeatherDataCompletion?(.success(weatherResponse))
        
        XCTAssertTrue(viewProtocol.showLoadingCalled)
        XCTAssertEqual(viewProtocol.showLoadingLoading, false)
        XCTAssertTrue(viewProtocol.enableUIElementsCalled)
        XCTAssertEqual(viewProtocol.enableUIElementsEnabled, true)
        XCTAssertTrue(viewProtocol.showWeatherDetailsCalled)
        XCTAssertEqual(viewModel.details.count, 22)
    }
    
    func testGetCityWeatherDataFailure() {
        viewModel.updateCityName("Lagos")
        viewModel.getCityWeatherData()
        
        let error = NetworkError.serverFailure
        remoteDatasource.getCityWeatherDataCompletion?(.failure(error))
        
        XCTAssertTrue(viewProtocol.showLoadingCalled)
        XCTAssertEqual(viewProtocol.showLoadingLoading, false)
        XCTAssertTrue(viewProtocol.enableUIElementsCalled)
        XCTAssertEqual(viewProtocol.enableUIElementsEnabled, true)
        XCTAssertTrue(viewProtocol.showMessageCalled)
        XCTAssertEqual(viewProtocol.showMessageMessage, "Unable to contact the server, please try again.")
        XCTAssertEqual(viewProtocol.showMessageType, .error)
    }

}
