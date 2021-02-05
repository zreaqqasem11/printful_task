//
//  DetailsScreenViewController.swift
//  printful_test_task
//
//  Created by Qasem Zreaq on 2/5/21.
//  Copyright © 2021 Qasem Zreaq. All rights reserved.
//

import UIKit

class DetailsScreenViewController: UIViewController {
    @IBOutlet var movieImage: UIImageView!
    @IBOutlet var movieDetails: UILabel!
    var imageUrl = ""
    var details = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        movieDetails.text = details
        getImage(url: URL(string: "https://image.tmdb.org/t/p/w300" + imageUrl)!)
       
        // Do any additional setup after loading the view.
    }
    
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
                           self.movieImage.image = image
                       }
                   }
               }.resume()
           
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
