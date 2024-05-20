////
////  CurrentWeatherDetailsView.swift
////  WeatherApp
////
////  Created by Samuel Adel on 20/05/2024.
////
//
//import SwiftUI
//
//struct CurrentWeatherDetailsView: View {
//    var body: some View {
//        VStack {
//                  ForEach(0..<2) { row in
//                      HStack {
//                          ForEach(0..<2) { column in
//                              let index = row * 2 + column
//                              if index < items.count {
//                                  Text(items[index])
//                                      .padding()
//                                      .border(Color.black)
//                              } else {
//                                  Spacer()
//                              }
//                          }
//                      }
//                  }
//              }
//          }
//    }
//}
//
//struct CurrentWeatherDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        CurrentWeatherDetailsView()
//    }
//}
