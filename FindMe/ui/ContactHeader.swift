//
//  FeedHeaderCollectionReusableView.swift
//  Cyfa
//
//  Created by Codebendr on 29/08/2018.
//  Copyright © 2018 Psyphertxt Limited. All rights reserved.
//

import UIKit

class ContactHeader: UICollectionReusableView {
    
    @IBOutlet weak var txt: UILabel!
    
    override func prepareForReuse() {
        txt.text = nil
    }
    
    var section: String? {
        didSet {
            if let section = section {
                txt.text = section
            }
        }
    }
        
}
