//
//  Bar.swift
//  VK
//
//  Created by Sergey Melnik on 12.05.2022.
//

import UIKit

@IBDesignable class Bar: UIView {
    
    var output: BarOutput?//нужно для работы xib

    @IBOutlet weak var myLabel: UILabel!
    
    @IBAction func openOtherGroupsButton(_ sender: Any) {
        self.output?.openOtherGroups()
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
        setup()
    }
    
    func loadFromNib() -> UIView {
        let nib = UINib(nibName: nibName, bundle: nil)
        let view = nib.instantiate(withOwner: self).first as! UIView
        
        return view
      }
    
    func setup() {
        view = loadFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        addSubview(view)
    }
}
