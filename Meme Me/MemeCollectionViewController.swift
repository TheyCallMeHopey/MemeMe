//
//  MemeCollectionViewController.swift
//  Meme Me
//
//  Created by Hope on 3/8/16.
//  Copyright © 2016 Hope Elizabeth. All rights reserved.
//

import UIKit

class MemeCollectionViewController : UIViewController
{
    var memes: [Meme]
    {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
}
