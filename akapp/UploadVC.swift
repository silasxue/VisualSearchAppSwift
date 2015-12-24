//
//  UploadImageViewController.swift
//  ParseTutorial
//
//  Created by Ron Kliffer on 3/6/15.
//  Copyright (c) 2015 Ron Kliffer. All rights reserved.
//

import UIKit
import Parse


class UploadImageViewController: UIViewController {
  
    @IBOutlet weak var imageToUpload: UIImageView!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var loadingSpinner: UIActivityIndicatorView!
    @IBOutlet var searchBtn: UIButton!
    @IBOutlet var selectBtn: UIButton!
  
  var username: String?
  var wallPost: WallPost?

  override func viewDidLoad() {
    super.viewDidLoad()
  }
    
   override func viewDidAppear(animated: Bool) {
    if imageToUpload.image == nil{
        searchBtn.hidden = true
    }
   }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if  segue.destinationViewController is EditorController  {
            commentTextField.resignFirstResponder()
            navigationItem.rightBarButtonItem?.enabled = false
            loadingSpinner.startAnimating()
            let pictureData = UIImagePNGRepresentation(imageToUpload.image!)
            let file = PFFile(name: "image", data: pictureData!)
            
            file!.saveInBackgroundWithBlock({ (succeeded, error) -> Void in
                if succeeded {
                    self.saveWallPost(file!)
                } else if let error = error {
                    self.showErrorView(error)
                }
            })
            let editorController = segue.destinationViewController as! EditorController
            editorController.post = nil
            editorController.image = imageToUpload.image
            editorController.index = 0
        }
    }
 
   
  
  @IBAction func selectPicturePressed(sender: AnyObject) {
    let imagePicker = UIImagePickerController()
    imagePicker.delegate = self
    imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary  //    imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
    presentViewController(imagePicker, animated: true, completion: nil)
  }
  
    
    
  func saveWallPost(file: PFFile)
  {
    wallPost = WallPost(image: file, user: PFUser.currentUser()!, comment: self.commentTextField.text)
    wallPost!.saveInBackgroundWithBlock{ succeeded, error in
      if succeeded {
        self.loadingSpinner.stopAnimating()
//            self.navigationController?.popViewControllerAnimated(true)
      } else {
        if let _ = error?.userInfo["error"] as? String {
          self.showErrorView(error!)
        }
      }
    }
  }
  
}

extension UploadImageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
    imageToUpload.image = image
    searchBtn.hidden = false
    selectBtn.titleLabel?.text = "Change picture"
    selectBtn.setNeedsDisplay()
    picker.dismissViewControllerAnimated(true, completion: nil)
  }
}
