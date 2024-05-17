//
//  CurrentWeatherViewModel.swift
//  WeatherApp
//
//  Created by Isaac Iniongun on 17/05/2024.
//

import Foundation

final class CurrentWeatherViewModel {
    weak var viewProtocol: CurrentWeatherViewProtocol?
    private let remoteDatasource: CurrentWeatherRemoteDatasourceProtocol
    private var preference: PreferenceProtocol
    private(set) var cityName = ""
    private(set) var details = [WeatherDetail]()
    private var saveCityName = false
    
    init(
        remoteDatasource: CurrentWeatherRemoteDatasourceProtocol,
        preference: PreferenceProtocol
    ) {
        self.remoteDatasource = remoteDatasource
        self.preference = preference
        getSavedCityName()
    }
    
    private func getSavedCityName() {
        cityName = preference.cityName
    }
    
    func saveCityNameSetting(_ save: Bool) {
        saveCityName = true
    }
    
    func updateCityName(_ name: String) {
        cityName = name
        viewProtocol?.showInlineErrorMessage(name.isEmpty)
    }
    
    func getCityWeatherData() {
        guard !cityName.isEmpty else {
            viewProtocol?.showInlineErrorMessage(true)
            return
        }
        
        if saveCityName {
            preference.cityName = cityName
        }
        
        viewProtocol?.showInlineErrorMessage(false)
        viewProtocol?.showLoading(true)
        viewProtocol?.enableUIElements(false)
        remoteDatasource.getCityWeatherData(
            params: ["q": cityName]
        ) { [weak self] result in
            self?.viewProtocol?.showLoading(false)
            self?.viewProtocol?.enableUIElements(true)
            switch result {
            case let .success(weatherResponse):
                self?.didGetWeatherResponse(weatherResponse)
            case let .failure(error):
                self?.viewProtocol?.showMessage(error.description ?? "An error occured, please try again", type: .error)
            }
        }
    }
    
    private func didGetWeatherResponse(_ response: WeatherResponse) {
        let defaultText = "--"
        details = [
            .init(title: "Weather.", value: response.weather?.first?.description ?? defaultText),
            .init(title: "Lat.", value: response.coord?.lat?.string ?? defaultText),
            .init(title: "Long.", value: response.coord?.lon?.string ?? defaultText),
            .init(title: "Temp.", value: response.main?.temp?.string ?? defaultText),
            .init(title: "Min Temp.", value: response.main?.tempMin?.string ?? defaultText),
            .init(title: "Max Temp.", value: response.main?.tempMax?.string ?? defaultText),
            .init(title: "Feels Like.", value: response.main?.feelsLike?.string ?? defaultText),
            .init(title: "Pressure.", value: response.main?.pressure?.string ?? defaultText),
            .init(title: "Humidity.", value: response.main?.humidity?.string ?? defaultText),
            .init(title: "Sea Level.", value: response.main?.seaLevel?.string ?? defaultText),
            .init(title: "Grnd. Level.", value: response.main?.grndLevel?.string ?? defaultText),
            .init(title: "Visibility.", value: response.visibility?.string ?? defaultText),
            .init(title: "Wind Speed.", value: response.wind?.speed?.string ?? defaultText),
            .init(title: "Wind Deg.", value: response.wind?.deg?.string ?? defaultText),
            .init(title: "Wind Gust.", value: response.wind?.gust?.string ?? defaultText),
            .init(title: "Clouds.", value: response.clouds?.all?.string ?? defaultText),
            .init(title: "Sys. Type.", value: response.sys?.type?.string ?? defaultText),
            .init(title: "Sys. Country.", value: response.sys?.country ?? defaultText),
            .init(title: "Sys. Sunrise.", value: response.sys?.sunrise?.string ?? defaultText),
            .init(title: "Sys. Sunset.", value: response.sys?.sunset?.string ?? defaultText),
            .init(title: "Timezone.", value: response.timezone?.string ?? defaultText),
            .init(title: "ID.", value: response.id?.string ?? defaultText)
        ]
        viewProtocol?.showWeatherDetails()
    }
}
