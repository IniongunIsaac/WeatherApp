//
//  UIView+.swift
//  WeatherApp
//
//  Created by Isaac Iniongun on 17/05/2024.
//

import UIKit

class UIViewTapGestureRecognizer: UITapGestureRecognizer {
    var action : VoidAction? = nil
}

extension UIView {
    @IBInspectable var viewCornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    func addTapGesture(action: @escaping () -> Void ){
        let tap = UIViewTapGestureRecognizer(target: self , action: #selector(self.handleTap(_:)))
        tap.action = action
        tap.numberOfTapsRequired = 1
        
        self.addGestureRecognizer(tap)
        self.isUserInteractionEnabled = true
        
    }
    
    @objc func handleTap(_ sender: UIViewTapGestureRecognizer) {
        sender.action!()
    }
    
    func breathe(
        scaleX: CGFloat = 1.2,
        scaleY: CGFloat = 1.2,
        duration: Double = 0.7,
        options: UIView.AnimationOptions = [.autoreverse, .repeat, .allowUserInteraction],
        completion: (() -> Void)?
    ) {
        UIView.animate(withDuration: duration, delay: 0, options: options) {
            self.transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
        } completion: { _ in
            completion?()
        }
    }
    
    func stopBreathing() {
        UIView.animate(withDuration: 0.5 ) {
            self.transform = CGAffineTransform.identity
        }
    }
    
    func performBreathAndStopAnimation(
        scaleX: CGFloat = 0.94,
        scaleY: CGFloat = 1,
        duration: Double = 0.1
    ) {
        breathe(
            scaleX: scaleX,
            scaleY: scaleY,
            duration: duration,
            options: []
        ) { [weak self] in
            guard let self = self else {
                return
            }
            self.stopBreathing()
        }
    }
    
    func addAnimatedTapGesture(duration: TimeInterval = 0.15, completion: VoidAction? = nil) {
        addTapGesture {
            self.performBreathAndStopAnimation()
            runAfter(duration) {
                completion?()
            }
        }
    }
}
