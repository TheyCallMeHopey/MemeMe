//
//  MemeEditorViewController.swift
//  Meme Me
//
//  Created by Hope on 12/1/15.
//  Copyright © 2015 Hope Elizabeth. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate
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
        topTextField.textAlignment = NSTextAlignment.Center
        bottomTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.textAlignment = NSTextAlignment.Center
    }
    
    override func prefersStatusBarHidden() -> Bool
    {
        return true
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool)
    {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
   
    func keyboardWillShow(notification: NSNotification)
    {
        if bottomTextField.isFirstResponder()
        {
            view.frame.origin.y = -getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillHide(notification: NSNotification)
    {
        view.frame.origin.y = 0
    }
    
    func subscribeToKeyboardNotifications()
    {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications()
    {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat
    {
        let userInfo = notification.userInfo!
        let keyboardSize = userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height
    }
    
    func textFieldDidBeginEditing(textField: UITextField)
    {
        if textField.text == "TOP" || textField.text == "BOTTOM"
        {
            textField.text = ""
        }
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
            view.frame.origin.y = 0
        }
        
        return true;
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            chooseImageView.image = image
            dismissViewControllerAnimated(true, completion: nil)
            topTextField.hidden = false
            bottomTextField.hidden = false
            chooseImageView.hidden = false
        }
    }
    
    func generateMemedImage() -> UIImage
    {
        navigationBar.hidden = true
        toolBar.hidden = true
        
        UIGraphicsBeginImageContext(view.frame.size)
        view.drawViewHierarchyInRect(view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        navigationBar.hidden = false
        toolBar.hidden = false
        
        return memedImage
    }
    
    func save()
    {
        meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: chooseImageView.image!, memedImage: generateMemedImage())
        
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
    }
    
    func originalImage()
    {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func chooseImage(sender: AnyObject)
    {
        originalImage()
        UIImagePickerControllerSourceType.PhotoLibrary
    }
    
    @IBAction func openCamera(sender: AnyObject)
    {
        if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera))
        {
            originalImage()
            UIImagePickerControllerSourceType.Camera
        }
        else
        {
            let alertController = UIAlertController(title: "", message: "CAMERA IS UNAVAILABLE", preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            
            alertController.addAction(okAction)
            presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func cancel(sender: AnyObject)
    {
        topTextField.hidden = true
        bottomTextField.hidden = true
        chooseImageView.hidden = true
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func createMeme(sender: AnyObject)
    {
        if(topTextField.text == "TOP" || topTextField.text == "" || bottomTextField.text == "BOTTOM" || bottomTextField.text == "")
        {
            let alertController = UIAlertController(title: "", message: "YOUR MEME IS NOT FINISHED", preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            
            alertController.addAction(okAction)
            presentViewController(alertController, animated: true, completion: nil)
        }
        
        else
        {
            let theMemedImage = generateMemedImage()
            
            let nextController = UIActivityViewController(activityItems: [theMemedImage], applicationActivities: nil)
            presentViewController(nextController, animated: true, completion: nil)
            
            save()
        }
    }
}

