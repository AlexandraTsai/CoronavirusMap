//
//  ChartViewModel.swift
//  Maps
//
//  Created by 蔡佳宣 on 2020/3/23.
//  Copyright © 2020 蔡佳宣. All rights reserved.
//

import Foundation

struct TimeSeries: Decodable {
    let US, italy, iran, unitedKingdom: [DayData]
    
    enum CodingKeys: String, CodingKey {
        case italy = "Italy"
        case US = "US"
        case iran = "Iran"
        case unitedKingdom = "United Kingdom"
    }
}

struct DayData: Decodable, Hashable, Identifiable {
    let id = UUID().uuidString
    let date: String
    let confirmed, deaths, recovered: Int
}

class ChartsViewModel: ObservableObject {
    
    init() {
        let urlString = "https://pomber.github.io/covid19/timeseries.json"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            
            guard let data = data else { return }
            
            do {
                let timeSeries = try JSONDecoder().decode(TimeSeries.self, from: data)
                timeSeries.US.forEach { (dayData) in
                    print(dayData.deaths)
                }
                print(timeSeries.US)
            } catch {
                print("JSON Decode failed:", error)
            }
        }.resume()
    }
    
    var timeSeries: TimeSeries!
    
    @Published var series = [DayData]()
    
    @Published var seledctedCountry = "Italy" {
        didSet {
            let dataSet: [DayData]
            if seledctedCountry == "US" {
                dataSet = timeSeries.US
            } else if seledctedCountry == "Italy" {
                dataSet = timeSeries.italy
            } else if seledctedCountry == "Iran" {
                dataSet = timeSeries.iran
            } else {
                dataSet = timeSeries.unitedKingdom
            }
        }
    }
    
}

