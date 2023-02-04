//
//  PhotoramaViewController.swift
//  Photorama
//
//  Created by Firdavsii Majidzoda on 2/4/23.
//

import Foundation
import UIKit

class PhotoramaViewController: UIViewController {
    @IBOutlet var interestingPhotosButton: UIButton!
    @IBOutlet var recentPhotosButton: UIButton!
    var store: PhotoStore!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "interestingPhotosSegue":
            let photoVC = segue.destination as! PhotosViewController
            photoVC.store = store
            photoVC.endPoint = EndPoint.interestingPhotos
            navigationItem.title = ""
        case "recentPhotosSegue":
            let photoVC = segue.destination as! PhotosViewController
            photoVC.store = store
            photoVC.endPoint = EndPoint.recentPhotos
            navigationItem.title = ""
        default:
            fatalError("unexpected error in segue")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Photorama"
    }
    
    
}
