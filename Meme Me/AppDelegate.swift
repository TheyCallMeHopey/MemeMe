//
//  AppDelegate.swift
//  Meme Me
//
//  Created by Hope on 12/1/15.
//  Copyright © 2015 Hope Elizabeth. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
    var window: UIWindow?
    var memes = [Meme]()
    var editMeme = Meme(topText: "TOP", bottomText: "BOTTOM", originalImage: UIImage(), memedImage: UIImage())
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool
    {
        return true
    }

    func applicationWillResignActive(application: UIApplication)
    {
    }

    func applicationDidEnterBackground(application: UIApplication)
    {
    }

    func applicationWillEnterForeground(application: UIApplication)
    {
    }

    func applicationDidBecomeActive(application: UIApplication)
    {
    }

    func applicationWillTerminate(application: UIApplication)
    {
    }
}

