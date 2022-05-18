//
//  AllGroupsCell.swift
//  VK
//
//  Created by Sergey Melnik on 12.04.2022.
//

import UIKit

class AllGroupsCell: UITableViewCell {

    @IBOutlet private weak var groupName: UILabel!
    @IBOutlet private weak var groupImage: UIImageView!
    @IBOutlet private var separatorView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.groupImage.layer.cornerRadius = 15.0;
        self.groupImage.layer.masksToBounds = true;
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func hideSeparator() {
        separatorView.isHidden = true
    }
    
    func setup(group: GroupModel) {
        self.groupName.text = group.name
        do {
            try self.groupImage.image = UIImage(data: NSData(contentsOf: group.image50.asURL()) as Data)
        } catch {
            print(error)
        }
    }
}
