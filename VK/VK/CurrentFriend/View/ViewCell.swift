//
//  ViewCell.swift
//  VK
//
//  Created by Sergey Melnik on 26.04.2022.
//

import UIKit
import UIKit

class ViewCell: UICollectionViewCell {
    @IBOutlet private weak var friendImage: UIImageView!
    @IBOutlet private weak var friendName: UILabel!
    @IBOutlet private var separatorView: UIView!

    func hideSeparator() {
        separatorView.isHidden = true
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
