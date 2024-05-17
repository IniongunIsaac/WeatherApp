//
//  DIGraph.swift
//  WeatherApp
//
//  Created by Isaac Iniongun on 17/05/2024.
//

import Foundation
import Swinject
import SwinjectStoryboard

extension SwinjectStoryboard {
    public static func setup() {
        defaultContainer.register(NetworkServiceProtocol.self) { _ in
            NetworkService(urlSession: .shared)
        }
        
        defaultContainer.register(PreferenceProtocol.self) { _ in
            Preference()
        }
        
        defaultContainer.register(CurrentWeatherRemoteDatasourceProtocol.self) { res in
            CurrentWeatherRemoteDatasource(networkService: res.resolve(NetworkServiceProtocol.self)!)
        }
        
        defaultContainer.register(CurrentWeatherViewModel.self) { res in
                .init(
                    remoteDatasource: res.resolve(CurrentWeatherRemoteDatasourceProtocol.self)!,
                    preference: res.resolve(PreferenceProtocol.self)!
                )
        }
        
        defaultContainer.storyboardInitCompleted(CurrentWeatherViewController.self) { res, cntrl in
            cntrl.viewModel = res.resolve(CurrentWeatherViewModel.self)
        }
    }
}
