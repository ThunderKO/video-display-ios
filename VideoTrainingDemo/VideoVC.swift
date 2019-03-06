//
//  VideoVC.swift
//  VideoTrainingDemo
//
//  Created by Farren Tong on 11/2/2019.
//  Copyright © 2019 FEHD EdUHK. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class VideoVC: UIViewController {


    @IBOutlet weak var playButton: UIButton!
    @IBAction func onClickPlay(_ sender: Any) {
        
        guard let url = URL(string: "https://2015fix.s3.amazonaws.com/vpw-1269.mp4") else {
            return
        }
        
        // Create an AVPlayer, passing it the HTTP Live Streaming URL.
        let player = AVPlayer(url: url)
        
        // Create a new AVPlayerViewController and pass it a reference to the player.
        let controller = AVPlayerViewController()
        controller.player = player
        
        // Modally present the player and call the player's play() method when complete.
        present(controller, animated: true) {
            player.play()
        }
        
    }
    @IBOutlet weak var thumbupButton: UIButton!
    
    @IBOutlet weak var downloadButton: UIButton!
    
    
    //
    // Implement UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    
    //
    // Main Content
    
    @IBAction func clickThumbup(_ sender: Any) {
        if self.thumbupButton.alpha >= 1.0 {
            self.thumbupButton.alpha = 0.5
        } else {
            self.thumbupButton.alpha = 1.0
        }
    }
    
    @IBAction func clickDownload(_ sender: Any) {
        if self.downloadButton.alpha >= 1.0 {
            self.downloadButton.alpha = 0.5
        } else {
            self.downloadButton.alpha = 1.0
        }
    }
    
}
