//
//  MemeCollectionViewController.swift
//  Meme Me
//
//  Created by Hope on 3/8/16.
//  Copyright © 2016 Hope Elizabeth. All rights reserved.
//

import UIKit

class MemeCollectionViewController : UICollectionViewController
{
    var memes: [Meme]!
        
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        updateMemes()
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(true)
        
        updateMemes()
        
        self.collectionView?.reloadData()
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return memes.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MemeCollectionViewCell", forIndexPath: indexPath) as! MemeCollectionViewCell
        let meme = self.memes[indexPath.row]
        
        if (self.editing)
        {
            cell.deleteImageView.hidden = false
        }
        else
        {
            cell.deleteImageView.hidden = true
        }
        
        cell.memeImageView?.image = meme.memedImage
        
        return cell
    }
    
    //Selecting
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath:NSIndexPath)
    {
        if (!self.editing)
        {
            let memeViewController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeViewController") as! MemeViewController
            memeViewController.meme = self.memes[indexPath.row]
            self.navigationController!.pushViewController(memeViewController, animated: true)
        }
        else
        {
            let applicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
            memes.removeAtIndex(indexPath.row)
            
            applicationDelegate.memes = memes
            self.collectionView?.reloadData()
        }
    }
    
    //Spacing and border
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat
    {
            return CGFloat(10.0)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat
    {
        return CGFloat(-8.0)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets
    {
            return UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    }

    func edit()
    {
        self.editing = !self.editing
        self.collectionView?.reloadData()
    }
    
    func updateMemes()
    {
        let applicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        memes = applicationDelegate.memes
    }
}
