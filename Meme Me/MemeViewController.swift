//
//  MemeViewController.swift
//  Meme Me
//
//  Created by Hope on 3/8/16.
//  Copyright © 2016 Hope Elizabeth. All rights reserved.
//

import UIKit

class MemeViewController : UIViewController
{
    var meme: Meme!
    
    @IBOutlet weak var memeImage: UIImageView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        memeImage.image = meme.memedImage
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "edit"
        {
            if let _ = segue.destinationViewController as? MemeEditorViewController
            {
                let applicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
                
                applicationDelegate.editMeme = meme
            }
        }
    }
    
    func editMeme()
    {
        dismissViewControllerAnimated(true, completion: nil)
        performSegueWithIdentifier("edit", sender: self)
    }
    
    func deleteMeme()
    {
        let applicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        
        applicationDelegate.memes.removeLast()
        
        navigationController?.popViewControllerAnimated(true)
    }
}
