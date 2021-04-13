//
//  WeatherManager.swift
//  Clima
//
//  Created by Zimo Zhao on 4/12/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(weather: WeatherModel)
}

struct WeatherManager {
    let baseURL = "https://api.openweathermap.org/data/2.5/weather?"
    let cityName = "London"
    let apiKey = "&appid=22e016f4c12443ec4a5383e7ae043dfd"
    let unit = "&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(baseURL)q=\(cityName)\(unit)\(apiKey)"
        print("\(urlString)")
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseJSON(weatherData: safeData) {
                        self.delegate?.didUpdateWeather(weather: weather)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            let sys = decodedData.sys
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp, sys: sys)
            
            return weather
        } catch {
            print(error)
            return nil
        }
        
    }
    
}
