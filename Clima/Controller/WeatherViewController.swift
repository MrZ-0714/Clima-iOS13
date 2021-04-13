//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate, WeatherManagerDelegate  {
    
    func didUpdateWeather(weather: WeatherModel) {
        print(weather.cityName)
    }
    
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var wearherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wearherManager.delegate = self
        searchTextField.delegate = self
    }
    
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
        print(searchTextField.text!)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        print(searchTextField.text!)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Need your input"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //use search text to get the weather.
        if let city = searchTextField.text {
            wearherManager.fetchWeather(cityName: city)
        }
        searchTextField.text = ""
    }
}

