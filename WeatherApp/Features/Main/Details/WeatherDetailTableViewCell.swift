//
//  WeatherDetailTableViewCell.swift
//  WeatherApp
//
//  Created by Isaac Iniongun on 17/05/2024.
//

import UIKit

class WeatherDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var detailValueLabel: UILabel!
    @IBOutlet weak var detailTitleLabel: UILabel!
    
    func configure(detail: WeatherDetail) {
        with(detail) {
            detailTitleLabel.text = $0.title
            detailValueLabel.text = $0.value
        }
    }

}
