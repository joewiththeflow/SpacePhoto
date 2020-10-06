//
//  ViewController.swift
//  SpacePhoto
//
//  Created by Joseph on 07/05/2020.
//  Copyright © 2020 Joseph Doogan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var copyrightLabel: UILabel!
    
    // Create an instance of PhotoInfoController which can be used to make network requests
    let photoInfoController = PhotoInfoController()
    
    // Query dictionary with "DEMO_KEY" key only, that can be used to get today's Astronomy Picture of the Day
    let todayQuery: [String: String] = [
        "api_key": "DEMO_KEY",
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Clear the text from the labels
        descriptionLabel.text = ""
        copyrightLabel.text = ""
        
        // Make the network request for today's picture by passing in 'todayQuery' query,
        // specifying appropriate name for the PhotoItem object which will be passed to the completion handler
        photoInfoController.fetchPhotoInfo(matching: todayQuery) { (photoInfo) in
            
            // Ensure photoItem object is not 'nil' before calling updateUI() method to update user interface
            if let photoInfo = photoInfo {
                self.updateUI(with: photoInfo)
            }
        }
    }

    func updateUI(with photoInfo: PhotoInfo) {
        
        // Create a URLSessionDataTask object from the shared URLSession, using the photoInfo.url to access image data
        let task = URLSession.shared.dataTask(with: photoInfo.url) { (data, response, error) in
            
            // Unwrap and ensure the returned image data is not 'nil' with 'guard', and attempt to create a UIImage from the data
            guard let data = data,
                let image = UIImage(data: data) else { return }
            
            // Use DispatchQueue type to send user interface code to the 'main' queue
            DispatchQueue.main.async {
                
                // Set the navigation item title of the view controller
                self.title = photoInfo.title
                
                // Set the image of the image view
                self.imageView.image = image
                
                // Set the text of the description label
                self.descriptionLabel.text = photoInfo.description
                
                // Set the text of the copyright label or hide the label if no copyright information exists
                if let copyright = photoInfo.copyright {
                    self.copyrightLabel.text = "Copyright \(copyright)"
                } else {
                    self.copyrightLabel.isHidden = true
                }
            }
            
        }
        
        // Send the request by resuming the task
        task.resume()
    }

}

