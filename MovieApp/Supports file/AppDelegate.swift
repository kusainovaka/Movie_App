//
//  AppDelegate.swift
//  MovieApp
//
//  Created by Kamila Kusainova on 18.11.2018.
//  Copyright © 2018 Kamila Kusainova. All rights reserved.
//

import UIKit
import AVKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        splashVideo()
        return true
    }
    
    private func splashVideo() {
        let screen = UIScreen.main.bounds
        let launchVC = UIStoryboard.init(name: "LaunchScreen", bundle: nil)
        let rootVC = launchVC.instantiateViewController(withIdentifier: "splashController")
        let videoView = UIView(frame: screen)
        
        let videoUrl = URL(fileURLWithPath: Bundle.main.path(forResource: "Main_iPad", ofType: "mp4")!)
        let player = AVPlayer(url: videoUrl)
        
        let videoSubLayer = AVPlayerLayer(player: player)
        videoSubLayer.frame = screen
        videoView.layer.addSublayer(videoSubLayer)
        videoSubLayer.videoGravity = .resizeAspectFill
        player.play()
        player.actionAtItemEnd = .none
        
        rootVC.view.addSubview(videoView)
        window?.rootViewController = rootVC
        window?.makeKeyAndVisible()
        
        NotificationCenter.default.addObserver(self, selector: #selector(dismissLaunchVC), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player.currentItem)
    }
    
    @objc func dismissLaunchVC() {
        guard let myWindow = window else { return }
        UIView.transition(with: myWindow , duration: 0.3, options: .transitionCrossDissolve, animations: {
            myWindow.rootViewController = MenuViewController()
            myWindow.makeKeyAndVisible()
        }, completion: nil)
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        splashVideo()
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
}

