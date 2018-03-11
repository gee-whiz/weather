//
//  HeaderCell.swift
//  Weather
//
//  Created by George on 2018/03/10.
//  Copyright © 2018 george kapoya. All rights reserved.
//

import UIKit

class HeaderCell: UITableViewCell {

    
    @IBOutlet weak var lblLocationName: UILabel!
    @IBOutlet weak var lblCurrentDay: UILabel!
    @IBOutlet weak var lblMaxTemp: UILabel!
    @IBOutlet weak var lblMinTemp: UILabel!
    @IBOutlet weak var imgWeatherIcon: UIImageView!
    @IBOutlet weak var lblTempreture: UILabel!
  
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
    }

  
}
