//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Samuel Adel on 20/05/2024.
//

import Foundation

struct WeatherModel:Codable{
    var location:Location
    var current:Current
    var forecast:Forecast
  static  let empty = WeatherModel(
    location: Location(name: "", region: ""),
        current: Current(
            lastUpdatedEpoch: 0,
            date: "",
            tempC: 0.0,
            isDay: 0,
            condition: Condition(text: "", icon: "", code: 0),
            windKph: 0.0,
            pressureMb: 0.0,
            pressureIn: 0.0,
            humidity: 0,
            cloud: 0,
            feelslikeC: 0.0,
            visKm: 0.0,
            uv: 0.0
        ),
    forecast: Forecast.empty
    )
}
struct Current: Codable {
    let lastUpdatedEpoch: Int
    let date:String
    let tempC: Double
    let isDay: Int
    let condition: Condition
    let windKph: Double
    let pressureMb: Double
    let pressureIn: Double
    let humidity: Double
    let cloud: Double
    let feelslikeC: Double
    let visKm: Double
    let uv: Double
    
    enum CodingKeys: String, CodingKey {
        case lastUpdatedEpoch = "last_updated_epoch"
        case date = "last_updated"
        case tempC = "temp_c"
        case isDay = "is_day"
        case condition
        case windKph = "wind_kph"
        case pressureMb = "pressure_mb"
        case pressureIn = "pressure_in"
        case humidity
        case feelslikeC = "feelslike_c"
        case visKm = "vis_km"
        case uv
        case cloud
    }
}
struct Location:Codable{
    var name:String
    var region:String
    static let empty = Location(name: "", region: "")
}
struct Forecast:Codable{
    var forecastday: [ForeCastDay]
    static let empty = Forecast(forecastday: [ForeCastDay.empty,ForeCastDay.empty,ForeCastDay.empty])
}

struct ForeCastDay : Codable,Identifiable{
    var id : Int{dateEpoch}
    var dateEpoch : Int
    let date: String
    let day:Day
    let hour: [Hour]
    enum CodingKeys: String,CodingKey {
        case date
        case dateEpoch = "date_epoch"
        case hour
        case day
    }
    static var empty: ForeCastDay {
           return ForeCastDay(
               dateEpoch: 0,
               date: "",
               day: Day.empty,
               hour: [Hour.empty]
           )
       }
}
struct Condition: Codable {
    let text: String
    let icon: String
    let code: Int
    static var empty: Condition {
           return Condition(
               text: "",
               icon: "",
               code: 0
           )
       }
}

struct Hour: Codable,Identifiable {
    var id : Int{timeEpoch}
    let timeEpoch: Int
    let time: String
    let tempC: Double
    let condition: Condition
    enum CodingKeys: String, CodingKey {
        case timeEpoch = "time_epoch"
        case time
        case tempC = "temp_c"
        case condition
    }
    static var empty: Hour {
            return Hour(
                timeEpoch: 0,
                time: "",
                tempC: 0.0,
                condition: Condition.empty
            )
        }
}
struct Day: Codable {
    let maxTempCelvin: Double
    let minTempCelvin: Double
    let avgTempCelvin: Double
    let maxWindKph: Double
    let avgVisKm: Double
    let avgHumidity: Double
    let condition: Condition
    let uv: Double
    
    enum CodingKeys: String, CodingKey {
        case maxTempCelvin = "maxtemp_c"
        case minTempCelvin = "mintemp_c"
        case avgTempCelvin = "avgtemp_c"
        case maxWindKph = "maxwind_kph"
        case avgVisKm = "avgvis_km"
        case avgHumidity = "avghumidity"
        case condition
        case uv
    }
    static var empty: Day {
         return Day(
             maxTempCelvin: 0.0,
             minTempCelvin: 0.0,
             avgTempCelvin: 0.0,
             maxWindKph: 0.0,
             avgVisKm: 0.0,
             avgHumidity: 0.0,
             condition: Condition.empty,
             uv: 0.0
         )
     }
}
