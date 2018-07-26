//
//  CustomSegmentedControlView.swift
//  FluidInterfaces
//
//  Created by Ada 2018 on 24/07/2018.
//  Copyright © 2018 academy. All rights reserved.
//

import UIKit

class CustomSegmentedControlView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var delegate: CustomSegmentedControlViewDelegate?
    
    var fontName: String = "Helvetica"
    var fontSize: CGFloat = 18
    
    var highlightedColor: UIColor = UIColor.init(red: 0, green: 122/255, blue: 1, alpha: 1)
    var foregroundColor: UIColor = UIColor.lightGray
    
    let highligthSelectedSegment = UIView()
    
    
    // MARK - View
    

    
    func animateHighlight(to index: Int) {
        UIView.animate(withDuration: 0.3) {
            self.highligthSelectedSegment.frame.origin.x = (self.segmentedControl.frame.width / CGFloat(self.segmentedControl.numberOfSegments)) * CGFloat(index)
        }
    }
    
    // MARK - Actions
    
    @IBAction func segmentedControllValueChanged(_ sender: Any) {
        delegate?.customSegmentedControlValueChanged(selectedIndex: segmentedControl.selectedSegmentIndex, numberOfSections: segmentedControl.numberOfSegments)
        
        animateHighlight(to: self.segmentedControl.selectedSegmentIndex)
        
    }
    
    // MARK - Initializers
    
    private func customInit() {
        Bundle.main.loadNibNamed("CustomSegmentedControl", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
        self.viewDidLoad()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customInit()
        self.viewDidLoad()
    }
}
