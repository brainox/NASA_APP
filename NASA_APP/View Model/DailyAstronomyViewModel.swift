//
//  DailyAstronomy.swift
//  NASA_APP
//
//  Created by Decagon on 15/01/2022.
//

import Foundation

final class DailyAstronomyViewModel {
    private var apiService = ApiService()

    var onLoadingfetchedCompletion: ((NasaModel) -> Void)?
    var onDateChangedFetchedCompletion: ((NasaModel) -> Void)?
    
    func fetchNasaData () {
        apiService.getNasaPlanetaryData { [weak self] result in
            switch result {
            case .success(let fetchedNasaData):
                self?.onLoadingfetchedCompletion?(fetchedNasaData)    
            case .failure(let error):
                print("Error processing json data: \(error)")
            }
        }
    }
    
    func fetchNasaDataWithDate(updateDateString: String) {
        apiService.getNasaPlanetaryDataWithDate(dateString: updateDateString) { [weak self] result in
            switch result {
            case .success(let newFetchedData):
                self?.onDateChangedFetchedCompletion?(newFetchedData)
            case .failure(let error):
                print("Error processing json data: \(error.localizedDescription)")
            }
        }
    }
}

