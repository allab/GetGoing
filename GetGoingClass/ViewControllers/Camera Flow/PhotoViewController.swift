//
//  PhotoViewController.swift
//  GetGoingClass
//
//  Created by Alla Bondarenko on 2019-02-06.
//  Copyright © 2019 SMU. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {

    @IBOutlet weak var photoImageView: UIImageView!

    var photo: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()

        photoImageView.image = photo
    }
    
    @IBAction func savePhoto(_ sender: UIButton) {
        if let image = photo {
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        }
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
