//
//  WeatherTests.swift
//  WeatherTests
//
//  Created by George on 2018/03/09.
//  Copyright © 2018 george kapoya. All rights reserved.
//

import XCTest
@testable import Weather




class WeatherTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testWeatherData() {
        
        let testExpectation = expectation(description: "Alamofire")
        
       
        var forecastWeatherData = [Weather]()
        var currentWeatherData = [Weather]()
        let vc = WeatherViewController()
        let weatherService = WeatherPresenter()
        weatherService.startMonitoringLocation()
        var currentWeatherCalled = false
        var forecastWeatherCalled = false

        weatherService.currentWeather.observe {
           (results) in
                    currentWeatherData = results
                    currentWeatherCalled  = true
                    testExpectation.fulfill()
            
                }
        weatherService.weatherForecast.observe {
                    (results) in
                    forecastWeatherData = results
                    forecastWeatherCalled = true
                }
        

         XCTAssertTrue(currentWeatherCalled)
         XCTAssertTrue(forecastWeatherCalled)
         XCTAssertEqual(vc.currentWeatherData.count, currentWeatherData.count)
         XCTAssertEqual(vc.forecastWeatherData.count, forecastWeatherData.count)
        
        waitForExpectations(timeout: 5, handler: .none)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
