//
//  constants.swift
//  Weather
//
//  Created by George on 2018/03/09.
//  Copyright © 2018 george kapoya. All rights reserved.
//

import Foundation




typealias completionHandler = (_ Success: Bool) ->()


//OenWeatherMap API_KEY
let API_KEY = "6bb2f235039eb8862b7255f5fe9faff6"


let BASE_URL = "https://api.openweathermap.org/data/2.5/"
let CURRENT_WEATHER_URL = "\(BASE_URL)weather?"
let WEATHER_FORECAST_URL = "\(BASE_URL)forecast/daily?"
let WEATHER_ICON_URL = "https://openweathermap.org/img/w/"

let HEADER = [
    "Content-Type": "application/json"
]

let NETWORKNOTREACHABLE =  "networkNotRechable"
let NETWORKAVAILBLE = "networkAvailble"
let kLocationDidChangeNotification = "LocationDidChangeNotification"


//Error msg
let SERVICE_ERROR = "We're having trouble connecting to weather service, please try again later."
let NETWORK_ERROR =  "No internet connection."
let DATA_ERROR  =  "We're having trouble processing weather data, please try again."

let METRIC = "ºc"




