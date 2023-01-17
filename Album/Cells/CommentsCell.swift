//
//  CommentsCell.swift
//  Album
//
//  Created by Hüseyin HÖBEK on 14.01.2023.
//
 
import UIKit

class CommentsCell: UITableViewCell {

    var comment: CommentElement? {
        didSet {
            bindingItem()
        }
    }

    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func bindingItem() {
        guard let comment = comment else {return}
        emailLabel.text = comment.email
        commentLabel.text = comment.body
    }
}
