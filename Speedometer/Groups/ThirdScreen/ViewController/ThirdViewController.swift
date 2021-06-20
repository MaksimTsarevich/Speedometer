//
//  ThirdViewController.swift
//  Speedometer
//
//  Created by denby on 12/15/20.
//  Copyright © 2020 denby. All rights reserved.
//

import UIKit
import RealmSwift
import Realm

class ThirdViewController: UIViewController {
    
    var settings: Settings!
    
    
    private var realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        }
    
    @IBAction func segmentsettings(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            try! realm.write{
                settings.unit = 0
            }
            configure()
        }
        else if sender.selectedSegmentIndex == 1{
            try! realm.write{
                settings.unit = 1
            }
            configure()
        }
        else if sender.selectedSegmentIndex == 2{
            try! realm.write{
                settings.unit = 2
            }
            configure()
        }
    }
}

extension ThirdViewController{
    func configure(){
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
}


