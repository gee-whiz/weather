//
//  APIClient.swift
//  Weather
//
//  Created by George on 2018/03/09.
//  Copyright © 2018 george kapoya. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import CoreLocation


class WeatherService: WeatherServiceProtocol {
    
    
    var weather = [Weather]()
    
    enum WeatherDataResult {
        case Success([Weather])
        case Failure(String)
    }
    
    
    func getWeatherForecast(_ location: CLLocation, completionHandler: @escaping (WeatherDataResult) -> Void) {
        guard let url = location.generateURL(url: WEATHER_FORECAST_URL) else {
            completionHandler(WeatherDataResult.Failure(SERVICE_ERROR))
            return
        }
        Alamofire.request(url, method: .get, parameters: nil
            ,encoding: URLEncoding.default, headers: HEADER).responseJSON { (response) in
                if response.result.error == nil {
                    self.weather.removeAll()
                    guard let data = response.data else {return}
                    let json = JSON(data: data)
                    let list = json["list"].arrayValue
                    //debugPrint(response.result)
                    for item in list.dropFirst(1) {
                        let temp_day = item["dt"].stringValue
                        let temp_min  = item["temp"]["min"].stringValue
                        let temp_max  = item["temp"]["max"].stringValue
                        let weather = item["weather"].array
                        let description = weather![0]["description"].stringValue
                        let icon = weather![0]["icon"].stringValue
                        let temp = ""
                        let name =  ""
                        let forecastWeather = Weather(temperature: temp,temperatureMin: temp_min, temperatureMax: temp_max, tempDay: temp_day, summary: description, icon: icon, locationName: name)
                        self.weather.append(forecastWeather)
                    }
                    completionHandler(WeatherDataResult.Success(self.weather))
                }else{
                    completionHandler(WeatherDataResult.Failure(DATA_ERROR))
                }
        }
        
    }
    
    func getCurrentWeather(_ location: CLLocation, completionHandler: @escaping (WeatherDataResult) -> Void) {
        guard let url = location.generateURL(url: CURRENT_WEATHER_URL) else {
            completionHandler(WeatherDataResult.Failure(SERVICE_ERROR))
            return
        }
        Alamofire.request(url, method: .get, parameters: nil
            ,encoding: URLEncoding.default, headers: HEADER).responseJSON { (response) in
                if response.result.error == nil {
                    self.weather.removeAll()
                    guard let data = response.data else {return}
                    let json = JSON(data: data)
                    let name = json["name"].stringValue
                    let temp = json["main"]["temp"].stringValue
                    let temp_day = json["dt"].stringValue
                    let temp_min  = json["main"]["temp_min"].stringValue
                    let temp_max  = json["main"]["temp_max"].stringValue
                    let weather = json["weather"].arrayValue
                    let description = weather[0]["description"].stringValue
                    let icon = weather[0]["icon"].stringValue
                    let currentWeather = Weather(temperature: temp,temperatureMin: temp_min, temperatureMax: temp_max, tempDay: temp_day, summary: description, icon: icon, locationName: name)
                    completionHandler(WeatherDataResult.Success([currentWeather]))
                }else{
                    completionHandler(WeatherDataResult.Failure(DATA_ERROR))
                }
        }
        
    }
    
    
    
    
    
}
