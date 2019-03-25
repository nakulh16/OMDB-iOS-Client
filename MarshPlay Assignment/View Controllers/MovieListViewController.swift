//
//  MovieListViewController.swift
//  MarshPlay Assignment
//
//  Created by Nakul Hindustani on 22/03/19.
//  Copyright © 2019 Nakul Hindustani. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController {

    @IBOutlet weak var celebCollectionView: UICollectionView!
    
    var pageNumber: Int = 1
    var movieModel: MovieDataArrayModel?
    
    // Load Data of celeb
    func callCelebData(pageID: Int) {
        MovieDataArrayModel().callCelebAPI(pageID: pageID, success: { [weak self] response in
            if let celebData = response {
                if self?.pageNumber != 1 {
                    for newData in celebData.Search ?? [] {
                        self?.movieModel?.Search?.append(newData)
                    }
                } else {
                    self?.movieModel = celebData
                }
                DispatchQueue.main.async {
                    self?.celebCollectionView.reloadData()
                }
            }
        }) { (error) in
            print("Error loading celeb data")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = .red
        self.navigationController?.navigationBar.barTintColor = .red
        self.title = "Movie Finder"
        
        // API Calling to load movie data
        self.callCelebData(pageID: pageNumber)
        DispatchQueue.main.async {
            self.celebCollectionView.reloadData()
        }
    }
}

extension MovieListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieModel?.Search?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? MovieCollectionViewCell else { fatalError("Cell not found") }
        if let celebData = movieModel?.Search?[indexPath.row] {
            cell.loadData(model: celebData)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let detailController = self.storyboard?.instantiateViewController(withIdentifier: "detailView") as? MovieDetailViewController else {
            return
        }
        if let movieData = movieModel?.Search?[indexPath.row] {
            detailController.movieNameString = movieData.Title
            detailController.movieYearString = movieData.Year
            detailController.movieImage = movieData.Poster
            detailController.type = movieData.type
        }
        self.navigationController?.pushViewController(detailController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let array = movieModel?.Search else { return }
        if !array.isEmpty && indexPath.row + 1 == array.count && Int(movieModel?.totalResults! ?? "") ?? 0 > array.count {
            pageNumber += 1
            self.callCelebData(pageID: pageNumber)
            debugPrint("page number: \(pageNumber)")
        }
    }
}

extension MovieListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        return CGSize(width: collectionViewWidth/2 - 15, height: 260)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
