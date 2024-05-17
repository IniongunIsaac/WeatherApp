//
//  WeatherDetailsViewController.swift
//  WeatherApp
//
//  Created by Isaac Iniongun on 17/05/2024.
//

import UIKit

final class WeatherDetailsViewController: UIViewController {
    
    @IBOutlet weak var detailsTableView: UITableView!
    @IBOutlet weak var dismissImageView: UIImageView!
    @IBOutlet weak var cityNameLabel: UILabel!
    
    var viewModel: CurrentWeatherViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        showData()
    }
    
    private func showData() {
        cityNameLabel.numberOfLines = 0
        cityNameLabel.text = "\(viewModel.cityName.capitalized) Weather Details"
    }
    
    private func configure() {
        dismissImageView.addAnimatedTapGesture { [weak self] in
            self?.dismiss(animated: true)
        }
        
        with(detailsTableView) {
            $0.dataSource = self
            $0.delegate = self
        }
    }

}

extension WeatherDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.details.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: R.reuseIdentifier.weatherDetailTableViewCell.identifier,
            for: indexPath
        ) as? WeatherDetailTableViewCell else { return UITableViewCell() }
        let detail = viewModel.details[indexPath.row]
        cell.configure(detail: detail)
        return cell
    }
}
