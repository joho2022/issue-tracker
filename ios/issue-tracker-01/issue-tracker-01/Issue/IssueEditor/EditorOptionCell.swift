//
//  EditorOptionCell.swift
//  issue-tracker-01
//
//  Created by 조호근 on 5/17/24.
//

import UIKit

class EditorOptionCell: UITableViewCell {
    
    static let identifier: String = "EditorOptionCell"

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentLabel.text = nil
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.titleLabel.text = nil
        self.contentLabel.text = nil
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            UIView.animate(withDuration: 0.1,
                           animations: {
                self.contentView.transform = CGAffineTransform(scaleX: 1.015, y: 1.015)
            }, completion: { _ in
                UIView.animate(withDuration: 0.1) {
                    self.contentView.transform = CGAffineTransform.identity
                }
            })
        }
    }
    
    func configureTitle(title: String) {
        self.titleLabel.text = title
    }
}
