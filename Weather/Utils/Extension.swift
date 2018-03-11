//
//  Extension.swift
//  Weather
//
//  Created by George on 2018/03/09.
//  Copyright © 2018 george kapoya. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

extension UIActivityIndicatorView {
    convenience init(activityIndicatorStyle: UIActivityIndicatorViewStyle, color: UIColor, placeInTheCenterOf parentView: UIView) {
        self.init(activityIndicatorStyle: activityIndicatorStyle)
        center = parentView.center
        self.color = UIColor.black
        parentView.addSubview(self)
    }
}


extension CLLocation {
    func generateURL(url: String) -> URL? {
        guard var components = URLComponents(string: url) else {
            return nil
        }
        let lat = String(self.coordinate.latitude)
        let lon = String(self.coordinate.longitude)
        components.queryItems = [URLQueryItem(name:"lat", value:lat),
                                 URLQueryItem(name:"lon", value:lon),
                                 URLQueryItem(name:"units", value:"metric"),
                                 URLQueryItem(name:"appid", value:API_KEY)]
        
        return components.url
    }
    
}

extension   String {
    func toDayName() -> String{
        let date = Date(timeIntervalSince1970: Double(self)!)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "CAT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "EEEE"
        let strDate = dateFormatter.string(from: date)
        return String(strDate)
    }
    
    func toFullDayName() -> String{
        let date = Date(timeIntervalSince1970: Double(self)!)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "CAT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "MMM d yyyy"
        let strDate = dateFormatter.string(from: date)
        return String(strDate)
    }
    
    func convertTocelsius() -> String {
        return String(format: "%.0f",5.0 / 9.0 * (Double(self)! - 32.0))
        
    }
    
    func toZeroDecimal() -> String {
        return  String(format: "%.0f",(Double(self))!)
    }
    
    func generateIconURL() -> String {
        return WEATHER_ICON_URL + self + ".png"
    }
}


