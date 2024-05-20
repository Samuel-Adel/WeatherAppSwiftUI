//
//  DetailsItem.swift
//  WeatherApp
//
//  Created by Samuel Adel on 20/05/2024.
//

import SwiftUI
import SDWebImageSwiftUI
struct DetailsItem: View {
    var forecastDayHour:Hour
    var isDayTime:Bool
    init(forecastDayHour: Hour, isDayTime: Bool) {
        self.forecastDayHour = forecastDayHour
        self.isDayTime = isDayTime
    }
    var body: some View {
        HStack {
            Text(getHourAMPM(dateString: forecastDayHour.time)).padding().foregroundColor(isDayTime ?.black : .white).bold()
       Spacer()
       Spacer()
            if let url = URL(string: "https:\(forecastDayHour.condition.icon)") {
                            WebImage(url: url)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                        }
            Spacer()
            Spacer()
            Text("\(Int(forecastDayHour.tempC))°").foregroundColor(isDayTime ?.black : .white).bold()
               }
    }
    func getHourAMPM(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        guard let date = dateFormatter.date(from: dateString) else {
            return "00:00"
        }
        
        let calendar = Calendar.current
        let currentHour = calendar.component(.hour, from: Date())
        let providedHour = calendar.component(.hour, from: date)
        
        if currentHour == providedHour {
            return "Now"
        } else {
            dateFormatter.dateFormat = "h:mm a"
            let hourAMPMString = dateFormatter.string(from: date)
            return hourAMPMString
        }
    }

    
}

struct DetailsItem_Previews: PreviewProvider {
    static var previews: some View {
        DetailsItem(forecastDayHour: Hour.empty, isDayTime: false)
    }
}
