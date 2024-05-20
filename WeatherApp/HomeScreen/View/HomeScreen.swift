//
//  HomeScreen.swift
//  WeatherApp
//
//  Created by Samuel Adel on 20/05/2024.
//

import SwiftUI
import SDWebImageSwiftUI
import MapKit

struct HomeScreen: View {
    @StateObject private var viewModel = HomeScreenViewModel(network: DataFetcher.shared)
    @State var isDayTime:Bool = false
    var body: some View {
        NavigationView{
            ZStack{
                backgroundImageView(from: viewModel.weatherModel.current.date)
                VStack{
                    Spacer()
                    Spacer()
                    VStack{
                        Text("\(viewModel.weatherModel.location.region)").font(.system(size: 35)).bold().foregroundColor(isDayTime ?.black : .white)
                        Text("\(Int(viewModel.weatherModel.current.tempC))°").font(.system(size: 35)).bold().foregroundColor(isDayTime ?.black : .white)
                        Text("\(viewModel.weatherModel.current.condition.text)").font(.system(size: 35)).foregroundColor(isDayTime ?.black : .white)
                        Text("H:\(Int(viewModel.weatherModel.forecast.forecastday[0].day.maxTempCelvin))° L:\(Int(viewModel.weatherModel.forecast.forecastday[0].day.maxTempCelvin))°").font(.system(size: 35)).foregroundColor(isDayTime ?.black : .white)
                        if let url = URL(string: "https:\(viewModel.weatherModel.current.condition.icon)") {
                            WebImage(url: url)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width:300, height: 100).shadow(radius: 75)
                        }
                    }
                    HStack {
                        Text("3-Day FORECAST")
                            .font(.system(size: 20))
                            .bold()
                            .padding(.horizontal).foregroundColor(isDayTime ?.black : .white)
                        Spacer()
                    }
                    VStack {
                        ForEach(0..<3) { index in
                            NavigationLink(destination: DetailsScreen(forecast: viewModel.weatherModel.forecast.forecastday[index], isDayTime: isDayTime)) {
                                ForecastDayView(forecastDay: viewModel.weatherModel.forecast.forecastday[index], isDayTime: isDayTime)
                            }
                        }
                    }.padding()
                    HStack{
                        VStack(alignment: .center) {
                        Text("Visibility") .font(.system(size: 20)).foregroundColor(isDayTime ?.black : .white).bold()
                            Text("\(Int(viewModel.weatherModel.current.visKm))KM") .font(.system(size: 20)).foregroundColor(isDayTime ?.black : .white).bold()
                        }
                      Spacer()
                        VStack(alignment: .center) {
                            Text("Humidity") .font(.system(size: 20)).foregroundColor(isDayTime ?.black : .white).bold()
                        Text("\(Int(viewModel.weatherModel.current.humidity))%") .font(.system(size: 20)).foregroundColor(isDayTime ?.black : .white).bold()
                        }
                    }.padding()
                    HStack{
                        VStack(alignment: .center) {
                        Text("Feels Like") .font(.system(size: 20)).foregroundColor(isDayTime ?.black : .white).bold()
                            Text("\(Int(viewModel.weatherModel.current.feelslikeC))°") .font(.system(size: 20)).foregroundColor(isDayTime ?.black : .white).bold()
                            
                        }
                      Spacer()
                        VStack(alignment: .center) {
                            Text("Pressure") .font(.system(size: 20)).foregroundColor(isDayTime ?.black : .white).bold()
                        Text("\(Int(viewModel.weatherModel.current.pressureIn))") .font(.system(size: 20)).foregroundColor(isDayTime ?.black : .white).bold()
                        }
                    }.padding()
                  
                    Spacer()
                    Spacer()
                }.onAppear{
                    viewModel.checkIfLocatoinServicesIsEnabled()
                }
            }
            
        }
        
    }
func backgroundImageView(from dateString: String) -> Image {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm"
            if let date = formatter.date(from: dateString) {
                let calendar = Calendar.current
                let hour = calendar.component(.hour, from: date)
                isDayTime = (6 <= hour && hour < 17)
                if 6 <= hour && hour < 17 {
                    return Image("Day")
                } else {
                    return Image("Night")
                }
            } else {
                return Image("Day")
            }
        }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
