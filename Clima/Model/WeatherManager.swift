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
    let weatherURL = "&appid=22e016f4c12443ec4a5383e7ae043dfd&units=metric"
    
    func fetchWeather(cityName: String) {
        let urlString = "\(baseURL)q=\(cityName)&appid=22e016f4c12443ec4a5383e7ae043dfd&units=metric"
        print("\(urlString)")
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url, completionHandler: handle(data: response: error:))
            task.resume()
            
        }
        
    }
    
    func handle(data: Data?, response: URLResponse?, error: Error?) -> Void {
        if error != nil {
            print(error!)
            return
        }
        
        if let safeData = data {
            let dataString = String(data: safeData, encoding: .utf8)
            print(dataString)
        }
    }
}
