//
//  WallPicturesTableViewController.swift
//  ParseTutorial
//
//  Created by Ron Kliffer on 3/8/15.
//  Copyright (c) 2015 Ron Kliffer. All rights reserved.
//

import UIKit
import Parse
import ParseUI



class WallPostTableViewCell: PFTableViewCell {
    @IBOutlet weak var postImage: PFImageView!
    @IBOutlet weak var createdByLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet var editBtn: UIButton!
    var current:WallPicturesTableViewController!
    var post:WallPost!
    
//    @IBAction func editBtnPressed(sender: AnyObject) {
//        let next = current.storyboard!.instantiateViewControllerWithIdentifier("EditorController") as! EditorController
//        next.post = post
//        current.presentViewController(next, animated: true, completion: nil)
//    }
    
}


class WallPicturesTableViewController: PFQueryTableViewController {
  
    var posts:[WallPost] = []
    var images:[Int:UIImage] = [:]
    
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(animated: Bool) {
    loadObjects()
  }
  
  override func queryForTable() -> PFQuery {
    let query = WallPost.query()
    return query!
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject!) -> PFTableViewCell? {
    let cell = tableView.dequeueReusableCellWithIdentifier("WallPostCell", forIndexPath: indexPath) as! WallPostTableViewCell
    let wallPost = object as! WallPost
    cell.postImage.file = wallPost.image
    cell.postImage.loadInBackground(nil) { percent in
        cell.progressView.progress = Float(percent)*0.01
        cell.progressView.hidden = true;
    }
    wallPost.image.getDataInBackgroundWithBlock({
        (imageData: NSData?, error: NSError?) -> Void in
        if (error == nil) {
            let image = UIImage(data:imageData!)
            self.images[indexPath.row] = image!
        }
    })
    cell.current = self
    cell.post = wallPost
    cell.editBtn.tag = indexPath.row
    let creationDate = wallPost.createdAt
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "MM/dd/yyyy"
    let dateString = dateFormatter.stringFromDate(creationDate!)
    
    if let username = wallPost.user.username {
      cell.createdByLabel.text = "by: \(username), \(dateString)"
    } else {
      cell.createdByLabel.text = "by anonymous: , \(dateString)"
    }
    
    cell.commentLabel.text = wallPost.comment
    cell.commentLabel.textColor = UIColor.blackColor()
    cell.createdByLabel.textColor = UIColor.blackColor()
//    cell.editBtn.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
    posts.append(wallPost)
    return cell
  }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if  sender is UIButton {
            let btn = sender as! UIButton
            let editorController = segue.destinationViewController as! EditorController
            editorController.post = posts[btn.tag]
            editorController.image = images[btn.tag]
            editorController.index = btn.tag
        }
    
    }
  
  // MARK: - Actions
  @IBAction func logOutPressed(sender: AnyObject) {
    PFUser.logOut()
    navigationController?.popToRootViewControllerAnimated(true)
  }
}
