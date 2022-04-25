//
//  OtherGroupsCell.swift
//  VK
//
//  Created by Sergey Melnik on 12.04.2022.
//

import UIKit

class OtherGroupsCell: UITableViewCell {
    
    @IBOutlet weak var groupImage: UIImageView!
    @IBOutlet private weak var groupName: UILabel!
    @IBOutlet private var separatorView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func hideSeparator() {
        separatorView.isHidden = true
    }
    func setup(group: Group) {
        do {
            try groupImage.image = UIImage(data: NSData(contentsOf: group.image50.asURL()) as Data )
        } catch {
            print(error)
        }
        groupName.text = group.name
    }
}
