//
//  ForecastDayView.swift
//  WeatherApp
//
//  Created by Samuel Adel on 20/05/2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct ForecastDayView: View {
    var forecastDay:ForeCastDay
    var isDayTime:Bool
    init(forecastDay: ForeCastDay, isDayTime: Bool) {
        self.forecastDay = forecastDay
        self.isDayTime = isDayTime
    }
    var body: some View {
        HStack {
            Text(getDayName(dateString: forecastDay.date)).padding().foregroundColor(isDayTime ?.black : .white).bold()
       Spacer()
            if let url = URL(string: "https:\(forecastDay.day.condition.icon)") {
                            WebImage(url: url)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                        }
            Spacer()
            Spacer()
            Spacer()
            Text("\(Int(forecastDay.day.minTempCelvin))° - \(Int(forecastDay.day.maxTempCelvin))°").foregroundColor(isDayTime ?.black : .white).bold()
                     Spacer()
        }
    }
    func getDayName( dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = dateFormatter.date(from: dateString) else {
            return "Day"
        }
        let today = Date()
           if Calendar.current.isDate(date, inSameDayAs: today) {
               return "Today"
           }
        dateFormatter.dateFormat = "EEEE"
        return String(dateFormatter.string(from: date).prefix(3))
    }
}

struct ForecastDayView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastDayView(forecastDay: ForeCastDay.empty,isDayTime: false)
    }
}
