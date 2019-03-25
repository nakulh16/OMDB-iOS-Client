//
//  MovieDetailViewController.swift
//  MarshPlay Assignment
//
//  Created by Nakul Hindustani on 22/03/19.
//  Copyright © 2019 Nakul Hindustani. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieYear: UILabel!
    
    var movieNameString: String?
    var movieYearString: String?
    var movieImage: String?
    var type: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Movie Detail"
        
        self.movieImageView.downloaded(from: movieImage ?? "")
        self.movieName.text = movieNameString
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        if let newDate = dateFormatter.date(from: movieYearString ?? "") {
            print(newDate)
            let timesAgo = newDate.getElapsedInterval()
            self.movieYear.text = "Type: \(type ?? "")" + ", Released: " + timesAgo
        } else {
            self.movieYear.text = "Type: \(type ?? "")" + ", Released: " + (movieYearString ?? "")
        }
    }
}
