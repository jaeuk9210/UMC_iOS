//
//  WeatherViewController.swift
//  Week9
//
//  Created by 정재욱 on 11/30/23.
//

import UIKit
import CoreLocation

import FlexLayout
import PinLayout
import RxSwift
import RxCocoa
import Combine

enum weatherIcon: String {
    case clear = "sun.max.fill"
    case fewClouds = "cloud.sun"
    case scatteredClouds = "cloud.fill"
    case showerRain = "cloud.rain.fill"
    case rain = "cloud.sun.rain.fill"
    case thunderstorm = "cloud.bolt.fill"
    case snow = "snow"
    case mist = "cloud.fog.fill"
}

class WeatherViewController: UIViewController, CLLocationManagerDelegate {

    var locationManager: CLLocationManager!

    var latitude: Double?
    var longitude: Double?

    private let rootFlexView = UIView()

    private lazy var weatherImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .darkGray
        imageView.contentMode = .scaleAspectFit
        return imageView
    } ()

    private lazy var weatehrDescriptionLabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .black)
        label.textAlignment = .center
        return label
    } ()

    private lazy var currentTempLabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        return label
    } ()

    private lazy var currentTempText = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.text = "현재기온"
        label.textAlignment = .center
        return label
    } ()

    private lazy var maxTempLabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return label
    } ()
    
    private lazy var maxTempText = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.text = "최고기온"
        label.textAlignment = .center
        return label
    } ()

    private lazy var minTempLabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return label
    } ()

    private lazy var minTempText = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.text = "최저기온"
        label.textAlignment = .center
        return label
    } ()

    private let disposeBag = DisposeBag()
    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white

        locationManager = CLLocationManager()
        locationManager.delegate = self

        locationManager.requestWhenInUseAuthorization()

        locationManager.desiredAccuracy = kCLLocationAccuracyBest

        locationManager.startUpdatingLocation()

        let coordinate = locationManager.location?.coordinate
        latitude = round((coordinate?.latitude ?? 0) * 100) / 100
        longitude = round((coordinate?.longitude ?? 0) * 100) / 100

        setLayout()
        fatchWeather(lon: longitude ?? 0, lat: latitude ?? 0, lang: "kr")
        
        locationManager.stopUpdatingLocation()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        rootFlexView.pin.all(view.pin.safeArea)
        rootFlexView.flex.layout()

        weatehrDescriptionLabel.flex.markDirty()
        currentTempLabel.flex.markDirty()
        maxTempLabel.flex.markDirty()
        minTempLabel.flex.markDirty()
        currentTempText.flex.markDirty()
        maxTempText.flex.markDirty()
        minTempText.flex.markDirty()
    }

    private func setLayout() {
        view.addSubview(rootFlexView)
        rootFlexView.flex.direction(.column).alignItems(.center).define { flex in
            flex.addItem(weatherImageView).size(200)
            flex.addItem(weatehrDescriptionLabel).marginBottom(20)
            flex.addItem().width(80%).direction(.row).justifyContent(.spaceBetween).define { flex in
                flex.addItem().direction(.column).define { flex in
                    flex.addItem(currentTempText).display(.none)
                    flex.addItem(currentTempLabel)
                }
                flex.addItem().direction(.column).define { flex in
                    flex.addItem(maxTempText).display(.none)
                    flex.addItem(maxTempLabel)
                }
                flex.addItem().direction(.column).define { flex in
                    flex.addItem(minTempText).display(.none)
                    flex.addItem(minTempLabel)
                }
            }
        }
    }

    private func fatchWeather(lon: Double, lat: Double, lang: String) {
        guard let langEncoded = lang.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
            let url = URL.urlForWeatherAPI(lat, lon, langEncoded) else {
            return
        }
        let resource = Resource<WeatherResult>(url: url)

        URLRequest.load(resource: resource)
            .catchAndReturn(WeatherResult.empty)
            .subscribe { [weak self] result in
                DispatchQueue.main.async {
                    self?.displayWeather(result)
                }
            }.disposed(by: disposeBag)
    }

    private func displayWeather(_ weather: WeatherResult?) {
        if let weather = weather {
            var weatherImage: UIImage?
            let id = weather.weather[0].id
            let group = Int(id/100)
            switch group {
            case 2:
                weatherImage = UIImage(systemName: weatherIcon.thunderstorm.rawValue)
            
            case 3:
                weatherImage = UIImage(systemName: weatherIcon.showerRain.rawValue)
            
            case 5:
                switch id % 100 {
                case 11:
                    weatherImage = UIImage(systemName: weatherIcon.snow.rawValue)
                case 20, 21, 22, 31:
                    weatherImage = UIImage(systemName: weatherIcon.showerRain.rawValue)
                default:
                    weatherImage = UIImage(systemName: weatherIcon.rain.rawValue)
                }
            
            case 6:
                weatherImage = UIImage(systemName: weatherIcon.snow.rawValue)
            
            case 7:
                weatherImage = UIImage(systemName: weatherIcon.mist.rawValue)
            
            case 8:
                switch id % 100 {
                case 1:
                    weatherImage = UIImage(systemName: weatherIcon.fewClouds.rawValue)
                case 2, 3, 4:
                    weatherImage = UIImage(systemName: weatherIcon.scatteredClouds.rawValue)
                default:
                    weatherImage = UIImage(systemName: weatherIcon.clear.rawValue)
                }
            
            default:
                weatherImage = nil
            }

            self.weatherImageView.image = weatherImage
            self.weatehrDescriptionLabel.text = "\(weather.weather[0].description)"
            self.currentTempText.flex.display(.flex)
            self.currentTempLabel.text = "\(weather.main.temp) ℃"
            self.maxTempText.flex.display(.flex)
            self.maxTempLabel.text = "\(weather.main.temp_max) ℃"
            self.minTempText.flex.display(.flex)
            self.minTempLabel.text = "\(weather.main.temp_min) ℃"
            self.navigationController?.navigationBar.topItem?.title = weather.name
            rootFlexView.flex.layout()
        } else {
            self.weatherImageView.image = UIImage(systemName: weatherIcon.clear.rawValue)
            self.currentTempText.flex.display(.flex)
            self.currentTempLabel.text = "N/A ℃"
            self.maxTempText.flex.display(.flex)
            self.maxTempLabel.text = "N/A ℃"
            self.minTempText.flex.display(.flex)
            self.minTempLabel.text = "N/A ℃"
            rootFlexView.flex.layout()
        }
    }
}

