//
//  VideoViewController.swift
//  MovieApp
//
//  Created by Kamila Kusainova on 18.11.2018.
//  Copyright © 2018 Kamila Kusainova. All rights reserved.
//

import UIKit
import AVKit

class VideoViewController: AVPlayerViewController {
    
    var playerCV: AVPlayer?
    var movieName: String?
    var playerCurrentTime: CMTime?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        player = playerCV
        player?.play()
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerCV?.currentItem)
        
        let accessTime = UserDefaults().getAccessTime(name: movieName!)
        guard accessTime.isNaN else {
            playerCV?.seek(to: CMTime(seconds: accessTime - 3, preferredTimescale: 43))
            return
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let currentTime = playerCV?.currentTime().seconds,
            let name = movieName else { return }
        guard let allDuration = playerCV?.currentItem?.duration.seconds,
            allDuration == currentTime else {
                UserDefaults().setAccessTime(time: currentTime, name: name)
                return
        }
        UserDefaults().setAccessTime(time: 0, name: name)
    }
    
    @objc func playerDidFinishPlaying() {
        self.dismiss(animated: true, completion: {
            guard let name = self.movieName else { return }
            UserDefaults().setAccessTime(time: 0, name: name)
        })
    }
}
