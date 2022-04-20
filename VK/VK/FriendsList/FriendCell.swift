//
//  FriendCell.swift
//  VK
//
//  Created by Sergey Melnik on 12.04.2022.
//

import UIKit

class FriendCell: UITableViewCell {
    
    @IBOutlet private var friendName: UILabel!
    @IBOutlet private var friendImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.friendImage.layer.cornerRadius = 15.0;
        self.friendImage.layer.masksToBounds = true;
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup(friend: Friend) {
        self.friendName.text = friend.name
        do {
            try self.friendImage.image = UIImage(data: NSData(contentsOf: friend.image50.asURL()) as Data )
        } catch {
            print(error)
        }
    }
}
