//
//  SecondViewController.swift
//  Speedometer
//
//  Created by denby on 12/15/20.
//  Copyright © 2020 denby. All rights reserved.
//

import UIKit
import RealmSwift

class SecondViewController: UIViewController {

    @IBOutlet weak var StartAgainButton: UIButton!
    @IBOutlet weak var Table: UITableView!
    
    private var realm = try! Realm()
    
    var record: RecordModel!
    var speedTime = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        StartAgainButton.layer.cornerRadius = 20
        Table.delegate = self
        Table.dataSource = self
        Table.reloadData()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        receivingSettings()
        addTimeInArray()
    }
    
    @IBAction func StartAgainAction(_ sender: Any) {
        Table.reloadData()
    }
}

extension SecondViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cell(tableView, cellForRowAt: indexPath)
    }
    
    func cell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FirstTableViewCell", for: indexPath) as! FirstTableViewCell
        
        cell.TimeLabel.text = Constant.distance[indexPath.row]
        cell.SecondsLabel.text = speedTime[indexPath.row]
        
        return cell
    }
}

extension SecondViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

extension SecondViewController {
    
    enum Constant {
        static let distance = ["0-60 km/h", "0-100 km/h", "0-150 km/h"]
    }
    
    func configure(){
        receivingSettings()
    }
    
    func receivingSettings(){
        record = realm.objects(RecordModel.self).first
    }
    
    func addTimeInArray(){
        if speedTime.count == 0{
        speedTime.append(record.timeFor60)
        speedTime.append(record.timeFor100)
        speedTime.append(record.timeFor150)
        }
    }
}
