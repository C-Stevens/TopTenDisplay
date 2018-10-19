//
//  TopTenViewController.swift
//  TopTenDisplay
//
//  Created by Colin Stevens on 10/17/18.
//  Copyright © 2018 Colin Stevens. All rights reserved.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var cellAlbumNameLabel: UILabel!
    @IBOutlet weak var cellArtistNameLabel: UILabel!
    @IBOutlet weak var cellRankLabel: UILabel!
}

class TopTenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var albums: [Album] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "albumCell", for: indexPath) as! AlbumTableViewCell
        cell.cellAlbumNameLabel.text = albums[indexPath.row].name
        cell.cellArtistNameLabel.text = albums[indexPath.row].artistName
        cell.cellImageView.image = albums[indexPath.row].albumImage
        cell.cellRankLabel.text = String(indexPath.row + 1)
        return cell
    }
    
    func fetchTopAlbums(count: Int = 10) {
        guard let dataUrl = URL(string: "https://rss.itunes.apple.com/api/v1/us/apple-music/top-albums/all/\(count)/explicit.json") else { return }
        let downloadTask = URLSession.shared.dataTask(with: dataUrl) { (data, response, error) in
            guard let data = data, error == nil else {
                return
            }
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                if let dict = jsonResponse as? [String: AnyObject] {
                    if let feed = dict["feed"], let results = feed["results"] as? [[String: Any]] {
                        for res in results {
                            self.albums.append(Album(artistName: res["artistName"] as! String,
                                                releaseDate: res["releaseDate"] as! String,
                                                name: res["name"] as! String,
                                                imageUrl: res["artworkUrl100"] as! String))
                        }
                        DispatchQueue.main.async { // Update tableView
                            self.tableView.reloadData()
                        }
                    }
                }
            } catch { return }
        }
        downloadTask.resume() // Run the request without blocking.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchTopAlbums(count: 10)
        print("View loaded.")

        // Do any additional setup after loading the view.
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
