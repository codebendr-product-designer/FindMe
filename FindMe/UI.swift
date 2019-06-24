//
//  UI.swift
//  FindMe
//
//  Created by codebendr on 21/06/2019.
//  Copyright © 2019 just pixel. All rights reserved.
//

import UIKit

struct UI {
    
    static func registerCollectionViewNib(identifier: String, collectionView: UICollectionView) {
        
        let nib = UINib(nibName: identifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: identifier)
        
    }
    
    static func showError(_ action: @escaping () -> Void) -> UIAlertController {
        let alert:UIAlertController = UIAlertController(title: "General Error", message: "list should remain refreshable", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        alert.addAction(UIAlertAction(title: "Refresh", style: .default, handler: { _ in
            action()
        }))
        return alert
    }
    
    static func getCollectionViewCell(forCellReuseIdentifier identifier: String, collectionView: UICollectionView, cellForRowAtIndexPath indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell:UICollectionViewCell?
        
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        
        return cell!
    }
}
