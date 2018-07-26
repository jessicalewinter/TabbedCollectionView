//
//  ViewController.swift
//  FluidInterfaces
//
//  Created by Ada 2018 on 23/07/2018.
//  Copyright © 2018 academy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var segmentedControl: CustomSegmentedControlView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        segmentedControl.delegate = self
        let customCell = UINib(nibName: "CustomCollectionViewCell", bundle: nil)
        collectionView.register(customCell, forCellWithReuseIdentifier: "CustomCell")
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCollectionViewCell
        
        cell.cellLabel.text = "[\(indexPath.section + 1),\(indexPath.row)]"
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        segmentedControl.segmentedControl.selectedSegmentIndex = Int(pageIndex)
        
        segmentedControl.animateHighlight(to: Int(pageIndex))
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.frame.width - 16.0
        
        return CGSize(width: width, height: CGFloat(50))
    }
}

extension ViewController: CustomSegmentedControlViewDelegate {
    func customSegmentedControlValueChanged(selectedIndex: Int, numberOfSections: Int) {
        print("[\(selectedIndex),\(numberOfSections - 1)]")
        
        print(round(collectionView.contentOffset.x/view.frame.width))
        
        self.collectionView.scrollToItem(at: IndexPath(row: 0, section: selectedIndex), at: .centeredHorizontally, animated: true)
    }
}
