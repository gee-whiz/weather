//
//  WeatherPresenter.swift
//  Weather
//
//  Created by George on 2018/03/09.
//  Copyright © 2018 george kapoya. All rights reserved.
//

import Foundation
import CoreLocation


class WeatherPresenter: LocationProtocol  {
    private var locationService: LocationService
    private var weatherService: WeatherServiceProtocol
    var errorMsg: Observable<String>
    var currentWeather: Observable<[Weather]>
    var weatherForecast: Observable<[Weather]>
  

    init() {
      self.locationService = LocationService()
      self.weatherService  = WeatherService()
      self.currentWeather  = Observable([])
      self.weatherForecast = Observable([])
      self.errorMsg = Observable("")
    
    }
    
    func startMonitoringLocation() {
        locationService.delegate = self
        locationService.requestLocation()
    }
   
    func locationDidUpdate(_ service: LocationService, location: CLLocation) {
        weatherService.getCurrentWeather(location, completionHandler: {(results) in
            switch (results) {
            case .Success(let weatherData):
                 self.currentWeather.value = weatherData
                 self.errorMsg.value  = ""
            case .Failure(let error):
               self.errorMsg.value  = error
            }
        })
        
        weatherService.getWeatherForecast(location, completionHandler: {(results) in
            switch (results) {
            case .Success(let weatherData):
                self.weatherForecast.value = weatherData
                self.errorMsg.value  = ""
            case .Failure(let error):
                self.errorMsg.value  = error
            }
        })
    }
    
    
    
    
    
    
    
    
    
}
