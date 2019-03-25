//
//  MovieCollectionViewCell.swift
//  MarshPlay Assignment
//
//  Created by Nakul Hindustani on 22/03/19.
//  Copyright © 2019 Nakul Hindustani. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieYear: UILabel!
    
    // Showing the data on the collection view through model
    func loadData(model: MovieDataModel) {
        self.movieImageView.downloaded(from: model.Poster ?? "")
        self.movieName.text = model.Title
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy" //Your New Date format as per requirement change it own
        if let newDate = dateFormatter.date(from: model.Year ?? "") {
            print(newDate)
            let timesAgo = newDate.getElapsedInterval()
            self.movieYear.text = "Type: \(model.type ?? "")" + ", Released: " + timesAgo
        } else {
            self.movieYear.text = "Type: \(model.type ?? "")" + ", Released: " + (model.Year ?? "")
        }
    }
}
