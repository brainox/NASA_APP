//
//  ApiService.swift
//  NASA_APP
//
//  Created by Decagon on 15/01/2022.
//

import Foundation

class ApiService {
    private var dataTask: URLSessionDataTask?
    
    func getNasaPlanetaryData(completion: @escaping (Result<NasaModel, Error>) -> Void) {
        let nasePlanetaryApiURL = "https://api.nasa.gov/planetary/apod?api_key=oULyHsHwdAadptJq30yF7X9eGxFqkCsycsIATpMy"
        
        
        
        guard let url = URL(string: nasePlanetaryApiURL) else { return }
        
        dataTask = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            if let error = error {
                completion(.failure(error))
                print("Datatask error: \(error.localizedDescription)")
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("Empty Response")
                return
            }
            
            print("The response code is \(response.statusCode)")
            
            guard let data = data else {
                print("Empty data")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(NasaModel.self, from: data)
                
                
                completion(.success(jsonData))
                
                
                
            } catch let error {
                completion(.failure(error))
            }
        })
        dataTask?.resume()
    }
    
    func getNasaPlanetaryDataWithDate(dateString: String, completion: @escaping (Result<NasaModel, Error>) -> Void) {
        let dateQuery =  "&date=\(dateString)&"
        let nasePlanetaryApiURL = "https://api.nasa.gov/planetary/apod?api_key=oULyHsHwdAadptJq30yF7X9eGxFqkCsycsIATpMy\(dateQuery)"
        
        guard let url = URL(string: nasePlanetaryApiURL) else { return }
        
        dataTask = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            if let error = error {
                completion(.failure(error))
                print("Datatask error: \(error.localizedDescription)")
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("Empty Response")
                return
            }
            
            print("The response code is \(response.statusCode)")
            
            guard let data = data else {
                print("Empty data")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(NasaModel.self, from: data)
                
                
                completion(.success(jsonData))
                
                
                
            } catch let error {
                completion(.failure(error))
            }
        })
        dataTask?.resume()
    }
    
}
