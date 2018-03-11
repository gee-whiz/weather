//
//  WeatherCell.swift
//  Weather
//
//  Created by George on 2018/03/09.
//  Copyright © 2018 george kapoya. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak var lblMaxTempreture: UILabel!
    @IBOutlet weak var lblMinTempreture: UILabel!
    @IBOutlet weak var imgForecastIcon: UIImageView!
    @IBOutlet weak var lblDay: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }


}
