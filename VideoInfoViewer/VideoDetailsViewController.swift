//
//  VideoDetailsViewController.swift
//  VideoInfoViewer
//
//  Created by Hool, Rory on 5/9/16.
//  Copyright © 2016 RoryHool. All rights reserved.
//

import UIKit

class VideoDetailsViewController: UIViewController {

    var videoURL: NSURL?
    var thumbnailURL: NSURL?
    
    @IBOutlet weak var thumbnailView: UIImageView!
    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var atomStructureButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Video Info"
        
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        backButton.action = #selector(VideoDetailsViewController.clickBack(_:))
        backButton.target = self
        
        self.navigationItem.leftBarButtonItem = backButton
        
        thumbnailView?.image = UIImage(named: thumbnailURL!.path! )
        
        updateProperties()
    }
    
    func updateProperties() {
        if let tv = textView {
            let size = MediaUtils.getVideoResolution(videoURL!)
            var text = ""
            if let name = videoURL?.lastPathComponent {
                text += "Name: \(name)\n"
            }
            text += "Resolution: \(Int(size.width))x\(Int(size.height))\n"
            text += "MimeType:   \(MediaUtils.getVideoMimeType(videoURL!))\n"
            text += "Frame Rate: \(MediaUtils.getVideoFrameRate(videoURL!)) fps\n"
            text += "File Size:  \(MediaUtils.getVideoFileSize(videoURL!))\n"
            text += "Duration: \n"
            text += "Bitrate: \n"
            text += "Date: \n"
            tv.text = text
        }
    }
    
    @IBAction func clickBack(sender: UIBarButtonItem) {
        let nc = parentViewController as? UINavigationController
        if let navController = nc {
            navController.popViewControllerAnimated(true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }    
    
    @IBAction func onClickAtomStructureButton(sender: UIButton) {
        let nc = parentViewController as? UINavigationController
        if let navController = nc {
            let atomStructureController = self.storyboard!.instantiateViewControllerWithIdentifier("atomStructure") as! AtomStructureViewController
            atomStructureController.videoURL = videoURL
            navController.pushViewController(atomStructureController, animated: true)
        }
    }
}
