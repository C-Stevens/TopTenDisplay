//
//  Album.swift
//  TopTenDisplay
//
//  Created by Colin Stevens on 10/17/18.
//  Copyright © 2018 Colin Stevens. All rights reserved.
//

import Foundation
import UIKit

class Album {
    let artistName, releaseDate, name: String
    let imageUrl: URL
    let isExplicit: Bool
    let rank: Int
    var albumImage: UIImage? // Optional because we cannot guarantee a good url string.
    
    func fetchAlbumImage(returnView: UIImageView, loaderView: UIActivityIndicatorView) {
        // Ref: https://stackoverflow.com/questions/39813497/swift-3-display-image-from-url/39813761
        let session = URLSession(configuration: .default)
        let downloadTask = session.dataTask(with: self.imageUrl) { (data, response, error) in
            if let e = error {
                print("Unable to download album image: \(e)")
            }
            // Ensure a valid response was returned
            if let res = response as? HTTPURLResponse {
                if let imageData = data {
                    self.albumImage = UIImage(data: imageData)
                    returnView.image = UIImage(data: imageData)
                    //loaderView.stopAnimating()
                    //loaderView.isHidden = true
                } else {
                    print("Unable to convert response to UIImage. Status Code: \(res.statusCode)")
                }
            }
        }
        downloadTask.resume() // Run the request without blocking.
    }
    
    init(artistName: String, releaseDate: String, name: String, imageUrl: String, explicit: Bool, rank: Int) {
        self.artistName = artistName
        self.releaseDate = releaseDate
        self.name = name
        self.isExplicit = explicit
        self.rank = rank
        self.imageUrl = URL(string: imageUrl)!
    }
}
