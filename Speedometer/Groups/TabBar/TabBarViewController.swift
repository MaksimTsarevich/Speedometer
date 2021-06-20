//
//  TabBarViewController.swift
//  Speedometer
//
//  Created by denby on 12/15/20.
//  Copyright © 2020 denby. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
        
}

// MARK: -
// MARK: - Configure

private extension TabBarViewController {
        
   func configure() {
        configureViewControllers()
    }
        
    func configureViewControllers() {
        let firstVC = UIStoryboard(name: "First", bundle: nil).instantiateInitialViewController() as! FirstViewController
        firstVC.view.backgroundColor = .black
        let firstTabBarItem = UITabBarItem()
        firstTabBarItem.image = UIImage(named: "speedometer")
        firstTabBarItem.selectedImage = UIImage(named: "speedometer")
        firstTabBarItem.title = "Speedometer"
        firstVC.tabBarItem = firstTabBarItem
            
        let secondVC = UIStoryboard(name: "Second", bundle: nil).instantiateInitialViewController() as! SecondViewController
        secondVC.view.backgroundColor = .black
        let secondTabBarItem = UITabBarItem()
        secondTabBarItem.image = UIImage(named: "history")
        secondTabBarItem.selectedImage = UIImage(named: "history")
        secondTabBarItem.title = "History"
        secondVC.tabBarItem = secondTabBarItem
            
        let thirdVC = UIStoryboard(name: "Third", bundle: nil)
            .instantiateInitialViewController() as! ThirdViewController
        thirdVC.view.backgroundColor = .black
        let thirdTabBarItem = UITabBarItem()
        thirdTabBarItem.image = UIImage(named: "setting")
        thirdTabBarItem.selectedImage = UIImage(named: "setting")
        thirdTabBarItem.title = "Setting"
        thirdVC.tabBarItem = thirdTabBarItem
            
        viewControllers = [firstVC, secondVC, thirdVC]
    }
}

