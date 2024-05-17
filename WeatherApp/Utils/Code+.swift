//
//  Code+.swift
//  WeatherApp
//
//  Created by Isaac Iniongun on 17/05/2024.
//

import Foundation

typealias VoidAction = () -> Void

func runOnMain(action: @escaping () -> Void) {
    DispatchQueue.main.async {
        action()
    }
}

func runAfter(_ delay: Double = 0.5, action: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay) {
        action()
    }
}

@discardableResult func with<T>(_ it: T, f:(T) -> ()) -> T {
    f(it)
    return it
}

extension Double {
    var string: String {
        String(self)
    }
}
