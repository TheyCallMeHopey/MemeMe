//
//  MemeTableViewController.swift
//  Meme Me
//
//  Created by Hope on 3/8/16.
//  Copyright © 2016 Hope Elizabeth. All rights reserved.
//

import UIKit

class MemeTableViewController : UITableViewController
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
        
        self.editing = false
        self.tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return memes.count
    }
    
    //Time to move the row into next location?
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool
    {
        return true
    }
    
    //Set up
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("TableViewCell")!
        let meme = self.memes[indexPath.row]

        cell.textLabel?.text = meme.topText + "-" + meme.bottomText
        cell.detailTextLabel?.text = ""
        cell.imageView?.image = meme.memedImage
        
        return cell
    }
    
    //Display in Meme View
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let memeViewController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeViewController") as! MemeViewController
        memeViewController.meme   = self.memes[indexPath.row]
        
        self.navigationController!.pushViewController(memeViewController, animated: true)
    }
    
    //Move the item
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath)
    {
        let moveItem = memes[fromIndexPath.row]
        memes.removeAtIndex(fromIndexPath.row)
        memes.insert(moveItem, atIndex: toIndexPath.row)
    }
    
    //Delete
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        let applicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        memes.removeAtIndex(indexPath.row)
        
        applicationDelegate.memes = memes
        self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }

    func edit()
    {
        self.editing = !self.editing
    }
    
    func updateMemes()
    {
        let applicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        memes = applicationDelegate.memes
    }
}
