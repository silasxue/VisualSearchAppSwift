//
//  WallPostTableViewCell.swift
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
}
