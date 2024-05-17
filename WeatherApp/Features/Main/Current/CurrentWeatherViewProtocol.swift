//
//  CurrentWeatherViewProtocol.swift
//  WeatherApp
//
//  Created by Isaac Iniongun on 17/05/2024.
//

import Foundation

public protocol CurrentWeatherViewProtocol: AnyObject {
    func enableUIElements(_ enable: Bool)
    func showLoading(_ loading: Bool)
    func showMessage(_ message: String, type: ToastType)
    func hideMessage()
    func showWeatherDetails()
    func showInlineErrorMessage(_ show: Bool)
}
