//
//  CellControllerTableViewCell.swift
//  printful_test_task
//
//  Created by Qasem Zreaq on 2/5/21.
//  Copyright © 2021 Qasem Zreaq. All rights reserved.
//

import UIKit

class CellControllerTableViewCell: UITableViewCell {
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var movieName: UILabel!
    @IBOutlet var movieDetails: UILabel!
    private var urlString = ""
    
    
    //MARK: call to set cell data
    
    func setCellVlue (movie:Movie) {
        updateUI(title: movie.title, overview: movie.overview, poster: movie.posterImage)
        
        
    }
    
    //MARK:update ui
    
    private func updateUI(title: String?, overview: String?, poster: String?) {
           
           self.movieName.text = title
           self.movieDetails.text = overview
           guard let posterString = poster else {return}
           urlString = "https://image.tmdb.org/t/p/w300" + posterString
           guard let posterImageURL = URL(string: urlString) else {
               self.profileImage.image = UIImage(named: "noImageAvailable")
               return
           }
                      
           getImage(url: posterImageURL)
           
       }
    
    //MARK:get image for each cell
    
    private func getImage(url: URL){
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
                   // Handle Error
                   if let error = error {
                       print("DataTask error: \(error.localizedDescription)")
                       return
                   }
                   
                   guard let data = data else {
                       // Handle Empty Data
                       print("Empty Data")
                       return
                   }
                   
                   DispatchQueue.main.async {
                       if let image = UIImage(data: data) {
                           self.profileImage.image = image
                       }
                   }
               }.resume()
           
    }

}
