//
//  OtherGroupsCell.swift
//  VK
//
//  Created by Sergey Melnik on 12.04.2022.
//

import UIKit

class OtherGroupsCell: UITableViewCell {
    
    @IBOutlet weak var groupImage: UIImageView!
    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var followersCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        groupImage.layer.cornerRadius = 15;
        groupImage.layer.masksToBounds = true;
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func setup(group: Group) {
        
        do {
            try groupImage.image = UIImage(data: NSData(contentsOf: group.image50.asURL()) as Data )
        } catch {
            print(error)
        }
        groupName.text = group.name
//        followersCount.text = String(group.countMembers)
    }
}
