//
//  LabelTableCell.swift
//  issue-tracker-01
//
//  Created by 조호근 on 5/17/24.
//

import UIKit

class LabelTableCell: UITableViewCell {

    static let identifier: String = "LabelTableCell"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.backgroundColor = .systemBackground
        configureFont()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func configureFont() {
        self.nameLabel.applyStyle(fontManager: FontManager(weight: .medium, size: .small), textColor: .gray50)
        self.descriptionLabel.applyStyle(fontManager: FontManager(weight: .medium, size: .medium), textColor: .gray800)
    }
    
    func setLabel(_ data: Label) {
        self.nameLabel.text = data.name
        self.nameLabel.backgroundColor = UIColor(hex: data.color)
        self.descriptionLabel.text = data.description
    }
}
