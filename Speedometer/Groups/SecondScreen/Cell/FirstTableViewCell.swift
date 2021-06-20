//
//  FirstTableViewCell.swift
//  Speedometer
//
//  Created by Maks Tsarevich on 12/16/20.
//  Copyright © 2020 denby. All rights reserved.
//

import UIKit

class FirstTableViewCell: UITableViewCell {

    
    @IBOutlet weak var SecondsLabel: UILabel!
    @IBOutlet weak var TimeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func againButton(_ sender: Any) {
        
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
