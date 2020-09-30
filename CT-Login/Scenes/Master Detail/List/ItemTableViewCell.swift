//
//  ItemTableViewCell.swift
//  CT-Login
//
//  Created by Mac Mini 2 on 9/30/20.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

    @IBOutlet private weak var fullNameLabel: UILabel!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var companyLabel: UILabel!
    
    func configure(_ itemModel: ItemModel) {
        fullNameLabel.text = itemModel.name
        userNameLabel.text = itemModel.userName
        companyLabel.text = itemModel.company
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        fullNameLabel.text = nil
        userNameLabel.text = nil
        companyLabel.text = nil
    }
}
