//
//  Movie Model.swift
//  MarshPlay Assignment
//
//  Created by Nakul Hindustani on 22/03/19.
//  Copyright © 2019 Nakul Hindustani. All rights reserved.
//

import Foundation

class MovieDataModel: Decodable {
    var Title: String?
    var Year: String?
    var Poster: String?
    var imdbID: String?
    var type: String?
    
    enum CodingKeys: String, CodingKey {
        case Title, Year, Poster, imdbID
        case type = "Type"
    }
}

class MovieDataArrayModel: Decodable {
    var Search: [MovieDataModel]?
    var totalResults: String?
    var Response: String?
}

extension MovieDataArrayModel {
    func callCelebAPI(pageID: Int, success: @escaping ((_ response: MovieDataArrayModel?) -> Void), failure: @escaping ((_ error: NSError?) -> Void)) {
        ConnectionManager.instance.callAPI(pageID: pageID, success: { (response) in
            var celebModel = MovieDataArrayModel()
            if let responseDict = response as? [String: Any] {
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: responseDict, options: .prettyPrinted)
                    celebModel = try JSONDecoder().decode(MovieDataArrayModel.self, from: jsonData)
                    success(celebModel)
                } catch {
                    print(error)
                }
            }
            
        }, failure: failure)
    }
}
