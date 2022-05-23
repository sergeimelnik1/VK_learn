//
//  CurrentFriendViewController.swift
//  VK
//
//  Created by Sergey Melnik on 12.04.2022.
//

import UIKit

class CurrentFriendViewController: UIViewController {

    var output : CurrentFriendViewOutput?
    
    @IBOutlet var bar: Bar!//нужно для работы xib
    @IBOutlet var collectionImage: UICollectionView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.bar.output = self//нужно для работы xib
        bar.setup(backButtonText: "Назад", title: "Мой друг")
        overrideUserInterfaceStyle = .light
        self.collectionImage.delegate = self
        self.collectionImage.dataSource = self
        self.collectionImage.register(UINib(nibName: "ViewCell", bundle: nil), forCellWithReuseIdentifier: "ViewCell")
    }
}
extension CurrentFriendViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    //центрирование cell по центру
    func centerItemsInCollectionView(cellWidth: Double, numberOfItems: Double, spaceBetweenCell: Double, collectionView: UICollectionView) -> UIEdgeInsets {
        let totalWidth = cellWidth * numberOfItems
        let totalSpacingWidth = spaceBetweenCell * (numberOfItems - 1)
        let leftInset = (collectionView.frame.width - CGFloat(totalWidth + totalSpacingWidth)) / 2
        let rightInset = leftInset
        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
    }
    // MARK: UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ViewCell", for: indexPath) as! ViewCell
        cell.setup(name: self.output?.getFriendValue()?.name ?? "", image: self.output?.getFriendValue()?.image200 ?? "")
        return cell
    }
}

extension CurrentFriendViewController: CurrentFriendViewInput {
    func getVC() -> UIViewController {
        return self
    }
}

extension CurrentFriendViewController: BarOutput {
    
    func openOtherGroups() {
        
    }
    
    func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }
}
