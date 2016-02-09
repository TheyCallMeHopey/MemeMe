//
//  ViewController.swift
//  Meme Me
//
//  Created by Hope on 12/1/15.
//  Copyright © 2015 Hope Elizabeth. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate
{
    @IBOutlet weak var chooseImageView: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let memeTextAttributes = [NSStrokeColorAttributeName : UIColor.blackColor(), NSForegroundColorAttributeName : UIColor.whiteColor(), NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!, NSStrokeWidthAttributeName : -3.0]
        
        topTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.defaultTextAttributes = memeTextAttributes
        topTextField.textAlignment = NSTextAlignment.Center
        bottomTextField.textAlignment = NSTextAlignment.Center
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        if textField == topTextField
        {
            topTextField.resignFirstResponder()
        }
        else if textField == bottomTextField
        {
            bottomTextField.resignFirstResponder()
        }
        
        return true;
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            chooseImageView.image = image
            self.dismissViewControllerAnimated(true, completion: nil)
            topTextField.hidden = false;
            bottomTextField.hidden = false;
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

