//
//  MockCurrentWeatherViewProtocol.swift
//  WeatherAppTests
//
//  Created by Isaac Iniongun on 17/05/2024.
//

import Foundation
@testable import WeatherApp

final class MockCurrentWeatherViewProtocol: CurrentWeatherViewProtocol {
    var enableUIElementsCalled = false
    var enableUIElementsEnabled: Bool?

    var showLoadingCalled = false
    var showLoadingLoading: Bool?

    var showMessageCalled = false
    var showMessageMessage: String?
    var showMessageType: ToastType?

    var hideMessageCalled = false

    var showWeatherDetailsCalled = false

    var showInlineErrorMessageCalled = false
    var showInlineErrorMessageShow: Bool?

    func enableUIElements(_ enable: Bool) {
        enableUIElementsCalled = true
        enableUIElementsEnabled = enable
    }

    func showLoading(_ loading: Bool) {
        showLoadingCalled = true
        showLoadingLoading = loading
    }

    func showMessage(_ message: String, type: ToastType) {
        showMessageCalled = true
        showMessageMessage = message
        showMessageType = type
    }

    func hideMessage() {
        hideMessageCalled = true
    }

    func showWeatherDetails() {
        showWeatherDetailsCalled = true
    }

    func showInlineErrorMessage(_ show: Bool) {
        showInlineErrorMessageCalled = true
        showInlineErrorMessageShow = show
    }
}
