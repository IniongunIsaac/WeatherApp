//
//  ToastType.swift
//  WeatherApp
//
//  Created by Isaac Iniongun on 17/05/2024.
//

import Foundation
import UIKit

public enum ToastType {
    case success
    case error
    
    var bgColor: UIColor {
        switch self {
        case .success:
            return .systemGreen
        case .error:
            return .systemRed
        }
    }
}
