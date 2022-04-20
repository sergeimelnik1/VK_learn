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
        friendImage.layer.cornerRadius = 15.0;
        friendImage.layer.masksToBounds = true;
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setup(friend: Friend) {
        friendName.text = friend.name
        do {
            try friendImage.image = UIImage(data: NSData(contentsOf: friend.image50.asURL()) as Data )
        } catch {
            print(error)
        }
    }
    
//    func configure(withPhoto photos: Photo) {
//        if let url = URL(string: ), let imageData: NSData = NSData(contentsOf: url) {
//            friendImage.image = UIImage(data: imageData as Data)
//    }
}
