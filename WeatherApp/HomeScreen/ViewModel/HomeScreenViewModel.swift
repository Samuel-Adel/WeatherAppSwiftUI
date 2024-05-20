//
//  HomeScreenViewModel.swift
//  WeatherApp
//
//  Created by Samuel Adel on 20/05/2024.
//
import MapKit
import Foundation
class HomeScreenViewModel:NSObject,CLLocationManagerDelegate, ObservableObject{
    var locationManager: CLLocationManager?
    @Published var region:MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 30.135646, longitude: 31.56489643), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    let network: Fetchable
   @Published var weatherModel:WeatherModel = WeatherModel.empty
    init(network: Fetchable) {
        self.network = network
    }
    func fetchData(lon:Double,lat:Double) {
        print(getURl(lon: lon,lat: lat))
        network.fetchWeatherData(urlString: getURl(lon: lon,lat: lat)){
            [weak self]
            result in
               switch result {
               case .success(let weather):
                   DispatchQueue.main.async {
                       self?.weatherModel=weather
                   }
               case .failure(let error):
                   print("Failed to fetch weather data: \(error)")
               }
        }
    }
    private func getURl(lon:Double,lat:Double)->String{
        return "\(APIHelper.baseURl)forecast.json?key=\(APIHelper.apiKey)&q=\(lon),\(lat)&days=3&aqi=yes&alerts=no"
    }
    func checkIfLocatoinServicesIsEnabled(){
        if CLLocationManager.locationServicesEnabled(){
            locationManager = CLLocationManager()
            locationManager!.delegate = self
        }else{
            print("Pls enable your locatoin services")
        }
    }
    func checkLocatoinAuth(completion:@escaping (MKCoordinateRegion)->Void){
        guard let locationManager = locationManager else{return}
        switch locationManager.authorizationStatus{
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("can't access location")
        case .denied:
            print("change it from settings")
        case .authorizedAlways,.authorizedWhenInUse:
            region = MKCoordinateRegion(center: locationManager.location?.coordinate ?? CLLocationCoordinate2D(latitude: 30.135646, longitude: 31.56489643) , span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        @unknown default:
          break
        }
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocatoinAuth{
            [weak self]
            value in
            self?.fetchData(lon: value.center.longitude, lat: value.center.latitude)
        }
    }
}
