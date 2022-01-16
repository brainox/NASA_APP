//
//  ViewController.swift
//  NASA_APP
//
//  Created by Decagon on 14/01/2022.
//

import UIKit

class ViewController: UIViewController {
    
    var homeView = PictureOfTheDayView()
    var dailyAstronomyViewModel = DailyAstronomyViewModel()
    
    var apiService = ApiService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = self.homeView
    }
}



