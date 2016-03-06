//
//  PostsTableViewCell.swift
//  instagram
//
//  Created by Lucas Andrade on 3/3/16.
//  Copyright © 2016 LucasAndradeRibeiro. All rights reserved.
//

import UIKit
import ParseUI

class PostsTableViewCell: UITableViewCell {

    @IBOutlet weak var textViewDescription: UITextView!
    @IBOutlet weak var buttonWithName: UIButton!
    @IBOutlet weak var imageViewFetched: PFImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //adding blur effect
        let blur2 = UIVisualEffectView(effect: UIBlurEffect(style:
            UIBlurEffectStyle.Light))
        blur2.frame = self.textViewDescription.frame
        blur2.userInteractionEnabled = false //This allows touches to forward to the button.
        textViewDescription.insertSubview(blur2, atIndex: 0)
        
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
