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
    var albumImage: UIImage? // Optional because we cannot guarantee a good url string.
    
    func fetchAlbumImage(from dataUrl: URL) {
        // Ref: https://stackoverflow.com/questions/39813497/swift-3-display-image-from-url/39813761
        let session = URLSession(configuration: .default)
        let downloadTask = session.dataTask(with: dataUrl) { (data, response, error) in
            if let e = error {
                print("Unable to download album image: \(e)")
            }
            // Ensure a valid response was returned
            if let res = response as? HTTPURLResponse {
                if let imageData = data {
                    self.albumImage = UIImage(data: imageData)
                } else {
                    print("Unable to convert response to UIImage. Status Code: \(res.statusCode)")
                }
            }
        }
        downloadTask.resume() // Run the request without blocking.
    }
    
    init(artistName: String, releaseDate: String, name: String, imageUrl: String) {
        self.artistName = artistName
        self.releaseDate = releaseDate
        self.name = name
        self.imageUrl = URL(string: imageUrl)!
        fetchAlbumImage(from: self.imageUrl)
    }
}
