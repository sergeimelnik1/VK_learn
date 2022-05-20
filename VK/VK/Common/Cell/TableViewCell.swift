//
//  TableViewCell.swift
//  VK
//
//  Created by Sergey Melnik on 20.05.2022.
//

import UIKit

final class TableViewCell: UITableViewCell {
    
    @IBOutlet private var groupName: UILabel!
    @IBOutlet private var groupImage: UIImageView!
    @IBOutlet private var separatorView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.groupImage.layer.cornerRadius = 15.0;
        self.groupImage.layer.masksToBounds = true;
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        self.accessoryType = .none
        super.prepareForReuse()
        self.separatorView.isHidden = false
    }
    
    func hideSeparator() {
        separatorView.isHidden = true
    }
    
    func setup(name: String, image: String) {
        self.groupName.text = name
        do {
            try self.groupImage.image = UIImage(data: NSData(contentsOf: image.asURL()) as Data)
        } catch {
            print(error)
        }
    }
}
