//
//  Preference+.swift
//  WeatherApp
//
//  Created by Isaac Iniongun on 17/05/2024.
//

import Foundation

@propertyWrapper
struct UserDefaultPrimitive<T> {
    private let key: String
    private let defaultValue: T
    private let userDefaults = UserDefaults.standard
    
    init(key: PreferenceKey, default: T) {
        self.key = key.rawValue
        self.defaultValue = `default`
    }
    
    var wrappedValue: T {
        get { (userDefaults.object(forKey: key) as? T) ?? defaultValue }
        set { userDefaults.set(newValue, forKey: key) }
    }
}
