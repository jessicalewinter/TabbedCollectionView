//
//  CustomCollectionViewCell.swift
//  FluidInterfaces
//
//  Created by Ada 2018 on 25/07/2018.
//  Copyright © 2018 academy. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cellLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
}
