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
        dailyAstronomyViewModel.fetchNasaData()
        self.view = self.homeView
        dailyAstronomyViewModel.completion = { [weak self] in
            
            DispatchQueue.main.async {
//                self?.homeView.dateLabel.text = self?.dailyAstronomyViewModel.date
                self?.homeView.populateViews()
            }
            
            print(self?.dailyAstronomyViewModel.date)
        }
        
        
//        print(dailyAstronomyViewModel.astronomyDetail?.date)

    }
}

