//
//  UIViewController+.swift
//  WeatherApp
//
//  Created by Isaac Iniongun on 17/05/2024.
//

import Foundation
import UIKit
import Toast

extension UIViewController {
    func showToastMessage(
        message: String,
        type: ToastType,
        duration: TimeInterval = 3.0,
        dismissCompletion: VoidAction? = nil
    ) {
        runOnMain { [weak self] in
            self?.view.hideAllToasts()
        }
        
        var toastStyle = ToastStyle()
        toastStyle.messageColor = .white
        toastStyle.messageFont = .systemFont(ofSize: 14)
        toastStyle.backgroundColor = type.bgColor
        
        ToastManager.shared.isTapToDismissEnabled = true
        
        runOnMain { [weak self] in
            self?.view.makeToast(
                message,
                duration: duration,
                position: .top,
                style: toastStyle
            )
        }
    }
    
    func hideToastMessage() {
        runOnMain { [weak self] in
            self?.view.hideAllToasts()
        }
    }
}

