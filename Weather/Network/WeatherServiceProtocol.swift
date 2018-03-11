//
//  WeatherServiceProtocol.swift
//  Weather
//
//  Created by George on 2018/03/09.
//  Copyright © 2018 george kapoya. All rights reserved.
//

import Foundation
import CoreLocation


protocol WeatherServiceProtocol {
      func getWeatherForecast(_ location: CLLocation,completionHandler: @escaping (WeatherService.WeatherDataResult) -> Void)
      func getCurrentWeather(_ location: CLLocation,completionHandler: @escaping (WeatherService.WeatherDataResult) -> Void)
}
