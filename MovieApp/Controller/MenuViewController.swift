//
//  MenuViewController.swift
//  MovieApp
//
//  Created by Kamila Kusainova on 18.11.2018.
//  Copyright © 2018 Kamila Kusainova. All rights reserved.
//

import UIKit
import AVKit

class MenuViewController: UIViewController {
    
    let backgroundImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = #imageLiteral(resourceName: "Background")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let namysLogo: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = #imageLiteral(resourceName: "02_Logo")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let ktkLogo: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = #imageLiteral(resourceName: "05_LogoKTK")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let screenWidth = UIScreen.main.bounds.width
        layout.itemSize = CGSize(width: (screenWidth - 180) / 2, height: 50)
        layout.sectionInset = UIEdgeInsets(top: 30, left: 60, bottom: 30, right: 60)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    var videoName = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let screenHeight  = view.frame.height
        
        view.addSubview(backgroundImage)
        [backgroundImage.leftAnchor.constraint(equalTo: view.leftAnchor),
         backgroundImage.rightAnchor.constraint(equalTo: view.rightAnchor),
         backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
         backgroundImage.topAnchor.constraint(equalTo: view.topAnchor)].forEach {
            $0.isActive = true
        }
        
        view.addSubview(ktkLogo)
        [ktkLogo.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -45),
         ktkLogo.topAnchor.constraint(equalTo: view.topAnchor, constant: 45),
         ktkLogo.widthAnchor.constraint(equalToConstant: 190),
         ktkLogo.heightAnchor.constraint(equalToConstant: 80)
            ].forEach {
                $0.isActive = true
        }
        
        view.addSubview(namysLogo)
        [namysLogo.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
         namysLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         namysLogo.widthAnchor.constraint(equalToConstant: (screenHeight - 50) / 1.8),
         namysLogo.heightAnchor.constraint(equalToConstant: (screenHeight - 50) / 1.8)
            ].forEach {
                $0.isActive = true
        }
        
        view.addSubview(collectionView)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: "VideoCell")
        [collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
         collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
         collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: (screenHeight / 2) + 120),
         collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ].forEach {
                $0.isActive = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getVideo()
    }
    
    func getVideo() {
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        do {
            let fileURLs = try fileManager.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil)
            fileURLs.forEach { (name) in
                let nameVideo = name.absoluteString
                videoName.append(nameVideo)
            }
        } catch {
            debugPrint("Error while enumerating files \(documentsURL.path): \(error.localizedDescription)")
        }
    }
    
    func removeString(_ sentence: String) -> String {
        var documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].absoluteString
        documentsURL.insert(string: "/private", int: 7)
        var allString = sentence
        if let range = allString.range(of: documentsURL) {
            allString.removeSubrange(range)
        }
        return allString.components(separatedBy: ".")[0]
    }
}

extension MenuViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videoName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCell", for: indexPath) as! VideoCell
        cell.videoName(removeString(videoName[indexPath.row]))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let videoUrl = URL(string: videoName[indexPath.row])
        let player = AVPlayer(url: videoUrl!)
        let videoVC = VideoViewController()
        videoVC.playerCV = player
        videoVC.movieName = removeString(videoName[indexPath.row])
        present(videoVC, animated: true, completion: nil)
    }
}
