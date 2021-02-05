//
//  MovieViewModel.swift
//  printful_test_task
//
//  Created by Qasem Zreaq on 2/5/21.
//  Copyright © 2021 Qasem Zreaq. All rights reserved.
//

import Foundation

class MovieViewModel {
    
    private var apiService = ApiService ()
    private var  movies = [Movie]()
    
    
   func fetchData(completion: @escaping () -> ()) {
        
        // weak self - prevent retain cycles
    apiService.getData { [weak self] (result) in
            
            switch result {
            case .success(let listOf):
                self?.movies = listOf.movies
                completion()
            case .failure(let error):
                // Something is wrong with the JSON file or the model
                print("Error processing json data: \(error)")
            }
        }
    }
    
    func getNumberOfMovies (section: Int) -> Int {
        
        if movies.count != 0 {
            
            return movies.count
            
        }
        
        return 0
        
    }
    
    func cellForRowAt (indexPath: IndexPath) ->Movie {
        
        return movies[indexPath.row]
        
    }
    
    
}
