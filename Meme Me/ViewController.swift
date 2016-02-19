//
//  ViewController.swift
//  Meme Me
//
//  Created by Hope on 12/1/15.
//  Copyright © 2015 Hope Elizabeth. All rights reserved.
//

import UIKit

struct Meme
{
    var topText: String
    var bottomText: String
    var originalImage: UIImage
    var memedImage: UIImage
}

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate
{
    var meme: Meme!
    
    @IBOutlet weak var chooseImageView: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let memeTextAttributes = [NSStrokeColorAttributeName : UIColor.blackColor(), NSForegroundColorAttributeName : UIColor.whiteColor(), NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!, NSStrokeWidthAttributeName : -3.0]
        
        topTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.defaultTextAttributes = memeTextAttributes
        topTextField.textAlignment = NSTextAlignment.Center
        bottomTextField.textAlignment = NSTextAlignment.Center
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        self.subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool)
    {
        super.viewWillDisappear(animated)
        self.unsubscribeFromKeyboardNotifications()
    }
   
    func keyboardWillShow(notification: NSNotification)
    {
        if bottomTextField.isFirstResponder()
        {
            self.view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    func subscribeToKeyboardNotifications()
    {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications()
    {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat
    {
        let userInfo = notification.userInfo!
        let keyboardSize = userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height
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
            self.view.frame.origin.y = 0
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
    
    func generateMemedImage() -> UIImage
    {
        //TODO: Hide toolbar and navbar
        //self.navigationController!.navigationBar.hidden = true
        //navigationBar.hidden = true
        //toolBar.hidden = true
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        //TODO: Show toolbar and navbar
        //self.navigationController!.navigationBar.hidden = false
        //navigationBar.hidden = false
        //toolBar.hidden = false
        
        return memedImage
    }
    
    func save()
    {
        meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: chooseImageView.image!, memedImage: generateMemedImage())
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
            let alertController = UIAlertController(title: "", message: "CAMERA IS UNAVAILABLE", preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil )
            
            alertController.addAction(okAction)
            presentViewController(alertController, animated: true, completion: nil )
        }
    }
    
    @IBAction func createMeme(sender: AnyObject)
    {
        let theMemedImage = generateMemedImage()
        
        let nextController = UIActivityViewController(activityItems: [theMemedImage], applicationActivities: nil)
        self.presentViewController(nextController, animated: true, completion: nil)
    }
}

