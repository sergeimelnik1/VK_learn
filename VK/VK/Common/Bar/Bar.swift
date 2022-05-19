//
//  Bar.swift
//  VK
//
//  Created by Sergey Melnik on 12.05.2022.
//

import UIKit

@IBDesignable class Bar: UIView {
    
    var output: BarOutput?//нужно для работы xib

    @IBOutlet private var myLabel: UILabel!
    @IBOutlet private var openOtherGroupImage: UIImageView!
    @IBOutlet private var backButton: UIButton!
    @IBOutlet private var openOtherGroupsButton: UIButton!
    
    @IBAction func openOtherGroupsButton(_ sender: Any) {
        self.output?.openOtherGroups()
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.output?.dismiss()
    }
    
    var textLabelText: String {
        get {
            return myLabel.text!
        }
        set(textLabelText) {
            myLabel.text = textLabelText
        }
    }
    var view: UIView!
    var nibName: String = "Bar"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        view = loadFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
    
    func loadFromNib() -> UIView {
        let nib = UINib(nibName: nibName, bundle: nil)
        let view = nib.instantiate(withOwner: self).first as! UIView
        
        return view
      }
}

extension Bar {
    func setup(_ backName: String, _ nextButtonImage: String, _ title: String) {
        //тут куски кода, которые можно использовать для шаблона xib
        if backName != "" {
            self.backButton.setTitle(backName, for: .normal)
        } else {
            self.backButton.isHidden = true
        }
        if nextButtonImage != "" {
            self.openOtherGroupImage.image = UIImage(named: nextButtonImage)
        } else {
            self.openOtherGroupsButton.isHidden = true
        }
        if title != "" {
            self.textLabelText = title
        } else {
            self.myLabel.isHidden = true
        }
    }
}
