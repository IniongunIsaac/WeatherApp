//
//  CurrentWeatherViewController.swift
//  WeatherApp
//
//  Created by Isaac Iniongun on 17/05/2024.
//

import UIKit
import MHLoadingButton

final class CurrentWeatherViewController: UIViewController {
    @IBOutlet weak var saveCityNameSwitch: UISwitch!
    @IBOutlet weak var getWeatherButton: LoadingButton!
    @IBOutlet weak var cityNameTextfield: UITextField!
    @IBOutlet weak var textfieldContainerView: UIView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var inputStackView: UIStackView!
    
    var viewModel: CurrentWeatherViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Current Weather"
        navigationController?.navigationBar.prefersLargeTitles = true
        setupUI()
    }
    
    private func setupUI() {
        viewModel.viewProtocol = self
        configureButton()
        errorLabel.isHidden = true
        inputStackView.setCustomSpacing(15, after: errorLabel)
        cityNameTextfield.text = viewModel.cityName
    }
    
    private func configureButton() {
        with(getWeatherButton) {
            $0.bgColor = .systemBlue
            $0.cornerRadius = 10
            $0.indicator = MaterialLoadingIndicator(color: .white)
        }
    }
    
    @IBAction func cityNameDidChange(_ sender: UITextField) {
        viewModel.updateCityName(cityNameTextfield.text ?? "")
    }
    
    @IBAction func didTapGetWeatherButton(_ sender: Any) {
        viewModel.getCityWeatherData()
    }
    
    @IBAction func saveSwitchValueDidChange(_ sender: Any) {
        viewModel.saveCityNameSetting(saveCityNameSwitch.isOn)
    }
}

extension CurrentWeatherViewController: CurrentWeatherViewProtocol {
    func showInlineErrorMessage(_ show: Bool) {
        errorLabel.isHidden = !show
    }
    func enableUIElements(_ enable: Bool) {
        runOnMain { [weak self] in
            self?.saveCityNameSwitch.isEnabled = enable
        }
    }
    
    func showLoading(_ loading: Bool) {
        runOnMain { [weak self] in
            if loading {
                self?.getWeatherButton.showLoader(userInteraction: false)
            } else {
                self?.getWeatherButton.hideLoader()
            }
        }
    }
    
    func showMessage(_ message: String, type: ToastType) {
        showToastMessage(message: message, type: type)
    }
    
    func hideMessage() {
        hideToastMessage()
    }
    
    func showWeatherDetails() {
        runOnMain { [weak self] in
            guard let self, let controller = R.storyboard.main.weatherDetailsViewController() else { return }
            controller.viewModel = self.viewModel
            controller.modalPresentationStyle = .overCurrentContext
            self.present(controller, animated: true)
        }
    }
}
