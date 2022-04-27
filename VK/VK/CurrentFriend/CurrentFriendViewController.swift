//
//  CurrentFriendViewController.swift
//  VK
//
//  Created by Sergey Melnik on 12.04.2022.
//

import UIKit

class CurrentFriendViewController: UIViewController {
    
    var output : CurrentFriendViewOutput?

    @IBOutlet var collectionImage: UICollectionView!
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    var friend: Friend?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light
        self.collectionImage.delegate = self
        self.collectionImage.dataSource = self
        self.collectionImage.register(UINib(nibName: "ViewCell", bundle: nil), forCellWithReuseIdentifier: "ViewCell")
    }
    
    @objc private func logPrint() {
        print("done")
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
        cell.setup(name: friend!.name, image: friend!.image200)
        return cell
    }
}
extension CurrentFriendViewController: CurrentFriendViewInput {
    func getVC() -> UIViewController {
        return self
    }
}

