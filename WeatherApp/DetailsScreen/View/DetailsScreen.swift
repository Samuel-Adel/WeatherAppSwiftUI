//
//  DetailsScreen.swift
//  WeatherApp
//
//  Created by Samuel Adel on 20/05/2024.
//

import SwiftUI

struct DetailsScreen: View {
    var forecast:ForeCastDay
    var isDayTime:Bool
    init(forecast: ForeCastDay, isDayTime: Bool) {
        self.forecast = forecast
        self.isDayTime = isDayTime
    }
    var body: some View {
        ZStack{
            backgroundImageView(from: forecast.hour[0].time)
            VStack(spacing: 10) {
                ForEach(0..<forecast.hour.count) { index in
                    if isHourNowOrAfter(dateString:forecast.hour[index].time){
                        DetailsItem(forecastDayHour: forecast.hour[index], isDayTime: isDayTime)
                    }
                }
                Spacer()
                Spacer()
            }
            .padding(.top,100)
            .padding([.leading, .trailing], 20)
        }
        
    }
    func backgroundImageView(from dateString: String) -> Image {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd HH:mm"
                if let date = formatter.date(from: dateString) {
                    let calendar = Calendar.current
                    let hour = calendar.component(.hour, from: date)
                    if 6 <= hour && hour < 17 {
                        return Image("Day")
                    } else {
                        return Image("Night")
                    }
                } else {
                    return Image("Day")
                }
    }
    func isHourNowOrAfter(dateString: String) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        if let date = dateFormatter.date(from: dateString) {
            let calendar = Calendar.current
            let hourOfDate = calendar.component(.hour, from: date)
            let currentHour = calendar.component(.hour, from: Date())
            
            return hourOfDate >= currentHour
        } else {
            return false
        }
    }
}

struct DetailsScreen_Previews: PreviewProvider {
    static var previews: some View {
        DetailsScreen(forecast: ForeCastDay.empty, isDayTime: false)
    }
}
