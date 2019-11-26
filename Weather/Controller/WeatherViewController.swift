//
//  ViewController.swift
//  Weather
//
//  Created by George on 2018/03/06.
//  Copyright © 2018 george kapoya. All rights reserved.
//

import UIKit
import SDWebImage


private let weatherIdentifier = "weatherCell"
private let headerIdentifier = "headerCell"


class WeatherViewController: UIViewController{
    
    @IBOutlet weak var lblError: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var activityIndicator = UIActivityIndicatorView()
    var searchController = UISearchController()
    var forecastWeatherData = [Weather]()
    var currentWeatherData = [Weather]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate  = self
        self.activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge, color: .gray,  placeInTheCenterOf: view)
        NotificationCenter.default.addObserver(self, selector: #selector(checkNetwork), name: NSNotification.Name(rawValue: NETWORKAVAILBLE), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(checkNetwork), name: NSNotification.Name(rawValue: NETWORKNOTREACHABLE), object: nil)
        self.presenter  = WeatherPresenter()
        self.presenter?.startMonitoringLocation()
        self.activityIndicator.startAnimating()
    }
    
    var presenter: WeatherPresenter? {
        didSet {
            presenter?.currentWeather.observe {
                [unowned self] (results) in
                self.currentWeatherData = results.count > 0 ? results : []
            }
            presenter?.weatherForecast.observe {
                [unowned self] (results) in
                self.forecastWeatherData =  results.count > 0 ? results : []
                self.tableView.reloadData()
                self.activityIndicator.stopAnimating()
            }
            presenter?.errorMsg.observe { (error) in
                self.lblError.text = error
                self.lblError.setNeedsLayout()
                self.view.setNeedsLayout()
                self.activityIndicator.stopAnimating()
            }
        }
    }

}


extension WeatherViewController: UITableViewDelegate, UITableViewDataSource{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return   section == 0 ? self.currentWeatherData.count : self.forecastWeatherData.count
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 230 : 65
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: headerIdentifier  , for: indexPath) as! HeaderCell
            let item = self.currentWeatherData[indexPath.row]
            cell.lblLocationName.text = item .locationName
            cell.lblCurrentDay.text =  item.summary.capitalized
            cell.lblMaxTemp.text =    "Max \(item.temperatureMax.toZeroDecimal())\(METRIC)"
            cell.lblMinTemp.text =    "Min \(item.temperatureMin.toZeroDecimal())\(METRIC)"
            cell.lblTempreture.text = item.temperature.toZeroDecimal() + METRIC
            cell.imgWeatherIcon.sd_setImage(with: URL(string: item.icon.generateIconURL()), placeholderImage: UIImage(named: " "))
            return  cell
            
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: weatherIdentifier  , for: indexPath) as! WeatherCell
            cell.layer.masksToBounds  = false
            let item = self.forecastWeatherData[indexPath.row]
            cell.lblDay.text  = item.tempDay.toDayName()
            cell.imgForecastIcon.sd_setImage(with: URL(string: item.icon.generateIconURL()), placeholderImage: UIImage(named: " "))
            cell.lblMaxTempreture.text =  "Max \(item.temperatureMax.toZeroDecimal())\(METRIC)"
            cell.lblMinTempreture.text =  "Min \(item.temperatureMin.toZeroDecimal())\(METRIC)"
            return  cell
            
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return  self.forecastWeatherData.count > 0 ?  UITableView.automaticDimension : 0
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        (view as! UITableViewHeaderFooterView).backgroundView?.backgroundColor = UIColor.white
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let item = self.currentWeatherData[0]
        return   section == 0 ? "Today, \(item.tempDay.toFullDayName())".capitalized : "Weather forecast".capitalized
    }
    
    
    @objc func checkNetwork() {
        if !Connectivity.isConnectedToInternet() {
            self.lblError.text = NETWORK_ERROR
            self.lblError.setNeedsLayout()
            self.view.setNeedsLayout()
        }
    }
    
}
