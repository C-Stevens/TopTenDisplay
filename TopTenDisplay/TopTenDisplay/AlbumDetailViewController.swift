//
//  AlbumDetailViewController.swift
//  TopTenDisplay
//
//  Created by Colin Stevens on 10/18/18.
//  Copyright © 2018 Colin Stevens. All rights reserved.
//

import UIKit

class AlbumDetailViewController: UIViewController {

    @IBOutlet weak var albumArtwork: UIImageView!
    @IBOutlet weak var albumLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var explicitLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    
    var albumChoice: Album?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        albumLabel.text = albumChoice?.name
        artistLabel.text = albumChoice?.artistName
        albumArtwork.image = albumChoice?.albumImage
        rankLabel.text = "Currently ranked #\(albumChoice?.rank ?? 0)"
        explicitLabel.text = albumChoice?.isExplicit == true ? "Not safe for work" : "Safe for work"
        releaseLabel.text = "Released on \(albumChoice?.releaseDate ?? "")"

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
