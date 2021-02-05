//
//  FirstScreenControllerViewController.swift
//  printful_test_task
//
//  Created by Qasem Zreaq on 2/5/21.
//  Copyright © 2021 Qasem Zreaq. All rights reserved.
//

import UIKit

class FirstScreenControllerViewController: UIViewController {
   
    @IBOutlet weak var moviesTable: UITableView!
    private var viewModel = MovieViewModel()
    var details = ""
    var imageUrl = ""
    
    override func viewDidLoad() {

        super.viewDidLoad()
        loadData ()
                
        // Do any additional setup after loading the view.
    }
    private func loadData () {
        
        viewModel.fetchData { [weak self ] in
            self?.moviesTable.dataSource = self
            self?.moviesTable.delegate = self
            self?.moviesTable.reloadData()
            
            
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "GODETAILS") {
            let vc = segue.destination as! DetailsScreenViewController
            vc.imageUrl = imageUrl
            vc.details = details
        }
    }
    
}

//MARK: table view data source

extension FirstScreenControllerViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getNumberOfMovies(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! CellControllerTableViewCell
        let movie = viewModel.cellForRowAt(indexPath: indexPath)
        cell.setCellVlue(movie: movie)
        return cell 
    }
    

}

//MARK:table viwe delegate

extension FirstScreenControllerViewController :UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let movie = viewModel.cellForRowAt(indexPath: indexPath)
        details = movie.overview!
        imageUrl = movie.posterImage!
        performSegue(withIdentifier: "GODETAILS", sender: nil)
        
        }
    
        }

    

