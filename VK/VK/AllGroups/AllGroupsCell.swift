//
//  AllGroupsCell.swift
//  VK
//
//  Created by Sergey Melnik on 12.04.2022.
//

import UIKit

class AllGroupsCell: UITableViewCell {

    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var groupImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        groupImage.layer.cornerRadius = 15.0;
        groupImage.layer.masksToBounds = true;
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setup(group: Group) {
        groupName.text = group.name
        do {
            try groupImage.image = UIImage(data: NSData(contentsOf: group.image50.asURL()) as Data )
        } catch {
            print(error)
        }
    }
}
