//
//  CurrentFriendCell.swift
//  VK
//
//  Created by Sergey Melnik on 12.04.2022.
//

import UIKit

class CurrentFriendCell: UICollectionViewCell {
    @IBOutlet weak var friendImage: UIImageView!
    @IBOutlet weak var friendName: UILabel!
    
    
    func setup(name: String, image: UIImage) {
        friendImage.image = image
        friendName.text = name
    }
}
