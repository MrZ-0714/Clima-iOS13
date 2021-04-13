//
//  WeatherManager.swift
//  Clima
//
//  Created by Zimo Zhao on 4/12/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    let baseURL = "https://api.openweathermap.org/data/2.5/weather?"
    let cityName = "London"
    let apiKey = "&appid=22e016f4c12443ec4a5383e7ae043dfd"
    let unit = "&units=metric"
    
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
                    self.parseJSON(weatherData: safeData)
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data) {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            print(decodedData.main.temp)
        } catch {
            print(error)
        }
        
    }
}
