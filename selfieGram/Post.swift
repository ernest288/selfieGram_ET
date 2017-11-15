//
//  Post.swift
//  selfieGram
//
//  Created by Ernest Thu on 2017-11-09.
//  Copyright © 2017 Ernest Thu. All rights reserved.
//

import Foundation
import UIKit

class Post {
    let image:UIImage
    let user:User
    let comment:String
    
    init(image:UIImage, user:User, comment:String){
        self.image = image
        self.user = user
        self.comment = comment
    }
}
