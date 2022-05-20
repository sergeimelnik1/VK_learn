//
//  ViewCell.swift
//  VK
//
//  Created by Sergey Melnik on 26.04.2022.
//

import UIKit

class ViewCell: UICollectionViewCell {
    @IBOutlet private weak var friendImage: UIImageView!
    @IBOutlet private weak var friendName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(name: String, image: String) {
        self.friendName.text = name
        do {
            try self.friendImage.image = UIImage(data: NSData(contentsOf: image.asURL()) as Data )
        } catch {
            print(error)
        }
    }
}
