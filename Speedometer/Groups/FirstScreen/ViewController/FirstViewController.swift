//
//  FIrstViewController.swift
//  Speedometer
//
//  Created by denby on 12/15/20.
//  Copyright © 2020 denby. All rights reserved.
//
import CoreLocation
import UIKit
import RealmSwift


class FirstViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var DistanceLabel: UILabel!
    @IBOutlet weak var CircleViev: UIView!
    @IBOutlet weak var CircleView2: UIView!
    @IBOutlet weak var MaxspeedLabel: UILabel!
    @IBOutlet weak var SpeedLabel: UILabel!
    @IBOutlet weak var Unit: UILabel!
    
    private var realm = try! Realm()
    var settings: Settings!
    var record: RecordModel!
    
    weak var locationDelegate: CLLocationManagerDelegate?
    
    var count:Int = 0
    let locationManager = CLLocationManager()
    var viewIsPresent = false
    var speed: CLLocationSpeed = CLLocationSpeed()
    var speeds = [CGFloat]()
    let max = 60
    var maxSpeedM = 0
    var maxSpeedKm = 0
    var maxSpeedMiles = 0
    var timer: Timer = Timer()
    var secondsPassed = 0.0
    var timeFor60 = 0.0
    var timeFor100 = 0.0
    var timeFor150 = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        CircleViev.layer.cornerRadius = 156
        CircleView2.layer.cornerRadius = 156
        
        locationManager.delegate = self
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.startUpdatingLocation()
        speeds.removeAll()
        secondsPassed = 0.0
        configure()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        viewIsPresent = true
        locationManager.startUpdatingLocation()
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Location: \(String(describing: manager.location))")
        
        _ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true){ [self] timer in
        guard let speed = manager.location?.speed else {return}
            var a: Int = Int(speed)
            recordTime(speed: CGFloat(a))
            if a < 0{
                a = 0
            }
            
            if speeds.count == max {
                speeds.remove(at: 0)
            }
            
            var total: CGFloat = 0.0
            speeds.forEach { a in
                total += a
                if a > 1 {
                    startTimer()
                } else if Int(a) < maxSpeedKm {
                    timer.invalidate()
                
                }
            }
            /*if a > 1{
                startTimer()
            } else if Int(a) < maxSpeedKm{
                timer.invalidate()
            }*/
            
            if settings.unit == 0 {
                SpeedLabel.text = "\(a)"
                if Int(a) > maxSpeedM{
                    maxSpeedM = Int(a)
                }
                MaxspeedLabel.text = "\(maxSpeedM)"
                Unit.text = "m/s"
            }
            else if settings.unit == 1 {
                a = a * Int(3.6)
                SpeedLabel.text = "\(a)"
                if Int(a) > maxSpeedKm{
                    maxSpeedKm = Int(a)
                }
                MaxspeedLabel.text = "\(maxSpeedKm)"
                Unit.text = "km/h"
                
                /*if a > 59 && 65 > a{
                    //timer.invalidate()
                    timeFor60 = secondsPassed
                    try! realm.write{
                        record.timeFor60 = String(format: "%.1f",timeFor60)
                    }
                }
                
                if a > 99 && 105 > a{
                    //timer.invalidate()
                    timeFor100 = secondsPassed
                    try! realm.write{
                        record.timeFor100 = String(format: "%.1f",timeFor100)
                    }
                }
                
                if a > 149 && 155 > a{
                    //timer.invalidate()
                    timeFor150 = secondsPassed
                    try! realm.write{
                        record.timeFor150 = String(format: "%.1f",timeFor150)
                    }
                }*/
            }
            else if settings.unit == 2{
                a = a * Int(2.237)
                SpeedLabel.text = "\(a)"
                if Int(a) > maxSpeedMiles{
                    maxSpeedMiles = Int(a)
                }
                MaxspeedLabel.text = "\(maxSpeedMiles)"
                Unit.text = "miles/h"
            }
            
            updateCourse(course: manager.location!.course)
        }
        
    }
}

extension FirstViewController{
    func updateCourse(course: CLLocationDirection){
        var courseString = ""
        switch course{
        case 24...68:
            courseString = "N/E"
        case 68...113:
            courseString = "E"
        case 113...168:
            courseString = "S/E"
        case 168...203:
            courseString = "S"
        case 203...248:
            courseString = "S/W"
        case 248...294:
            courseString = "W"
        case 294...338:
            courseString = "N/W"
        default:
            courseString = "N"
        }
        
        DistanceLabel.text = "\(courseString)"
    }
    
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
    }
    
    @objc func timerCounter()->Void{
        secondsPassed = secondsPassed + 0.1
    }
    
    func recordTime(speed: CGFloat){
        if speed > 59 && 65 > speed{
            //timer.invalidate()
            print(count)
            timeFor60 = Double(count)
            try! realm.write{
                record.timeFor60 = String(format: "%.1f",timeFor60)
            }
        }
        
        if speed > 99 && 105 > speed{
            //timer.invalidate()
            timeFor100 = secondsPassed
            try! realm.write{
                record.timeFor100 = String(format: "%.1f",timeFor100)
            }
        }
        
        if speed > 149 && 155 > speed{
            //timer.invalidate()
            timeFor150 = secondsPassed
            try! realm.write{
                record.timeFor150 = String(format: "%.1f",timeFor150)
            }
        }
    }
    
    func configure(){
        configureRecordModel()
        configureSettingModel()
        receivingSettings()
    }
    
    func receivingSettings(){
        settings = realm.objects(Settings.self).first
    }
    
    func configureSettingModel(){
        if let settings = realm.objects(Settings.self).first {
            self.settings = settings
        } else {
            settings = Settings()
            settings.unit = 0
            settings.id = "0"
            save(settings: settings)
        }
    }
    func save(settings: Settings) {
        try! realm.write {
            realm.add(settings, update: .all)
        }
    }
    
    func configureRecordModel(){
        if let record = realm.objects(RecordModel.self).first{
            self.record = record
        } else {
            record = RecordModel()
            record.timeFor60 = "0.0"
            record.timeFor100 = "0.0"
            record.timeFor150 = "0.0"
            save(record: record)
        }
    }
    
    func save(record:RecordModel){
        try! realm.write{
            realm.add(record, update: .all)
        }
    }
}
