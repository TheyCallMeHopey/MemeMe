//
//  ViewController.swift
//  Meme Me
//
//  Created by Hope on 12/1/15.
//  Copyright © 2015 Hope Elizabeth. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    @IBOutlet weak var chooseImageView: UIImageView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            chooseImageView.image = image
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    @IBAction func chooseImage(sender: AnyObject)
    {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func openCamera(sender: AnyObject)
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        {
            let chooseImage = UIImagePickerController()
            chooseImage.delegate = self
            chooseImage.sourceType = UIImagePickerControllerSourceType.Camera
            presentViewController(chooseImage, animated: true, completion: nil)
        }
        else
        {
            let alertController = UIAlertController(title: "", message: " CAMERA IS UNAVAILABLE", preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil )
            
            alertController.addAction(okAction)
            presentViewController(alertController, animated: true, completion: nil )
        }
    }
}

