//
//  SelfieCell.swift
//  selfieGram
//
//  Created by Ernest Thu on 2017-11-16.
//  Copyright © 2017 Ernest Thu. All rights reserved.
//

import UIKit
import Parse



class SelfieCell: UITableViewCell {

    @IBOutlet weak var selfieImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    var post:Post? {
        
        // didSet is run when we set this variable in FeedViewController
        didSet{
            if let post = post {
                
                // I've added the below line to prevent flickering of images
                // This always resets the image to blank, waits for the image to download, and then sets it
                selfieImageView.image = nil
                
                let imageFile = post.image
                imageFile.getDataInBackground(block: {(data, error) -> Void in
                    if let data = data {
                        let image = UIImage(data: data)
                        self.selfieImageView.image = image
                    }
                })
                
                usernameLabel.text = post.user.username
                commentLabel.text = post.comment
                
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func likeButtonClicked(_ sender: UIButton) {
        // the ! symbol means NOT
        // We are therefore setting the button's selected state to
        // the opposite of what it was. This is a great way to toggle buttons
        //
        sender.isSelected = !sender.isSelected
        
        // Get rid of Optionals
        if let post = post,
            let user = PFUser.current() {
            
            // like button has been selected and we should add a like from currentUser
            if sender.isSelected {
                
                // PFRelation has a useful method called addObject that adds the unique element
                // you are passing in as the argument. It will never add multiple copies
                // of the same element (in this case user)
                post.likes.add(user)
                
                // We have modified the likes property on post. We must now save it to Parse
                post.saveInBackground(block: { (success, error) -> Void in
                    if success {
                        print("like from user successfully saved")
                    }else{
                        print("error is \(error)")
                    }
                })
            } else { // like button has been deselected and we should remove the like
                
                // PFRelation also has a useful method called removeObject that removes
                // the element if there is an element to be removed.
                post.likes.remove(user)
                post.saveInBackground(block: { (success, error) -> Void in
                    if success {
                        print("like from user successfully removed")
                    }else{
                        print("error is \(error)")
                    }
                })
                
            }
        }

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
