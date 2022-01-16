//
//  DailyAstronomy.swift
//  NASA_APP
//
//  Created by Decagon on 15/01/2022.
//

import Foundation

final class DailyAstronomyViewModel {
    private var apiService = ApiService()
    var astronomyDetail: NasaModel?
    var date = ""
    var completion: ( () -> Void)?

//    var error: ObservableObject<NasaModel?> = ObservableObject(nil)
    
    func fetchNasaData () {
        apiService.getNasaPlanetaryData { [weak self] result in
            switch result {
            case .success(let fetchedNasaData):
//                self?.error.value = fetchedNasaData
                self?.astronomyDetail = fetchedNasaData
                
                self?.date = fetchedNasaData.date
                self?.completion?()
            case .failure(let error):
                print("Error processing json data: \(error)")
            }
        }
    }
}
