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
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        segmentedControl.delegate = self
        
        scrollView.contentSize = CGSize(width: self.scrollView.frame.width * CGFloat(segmentedControl.numberOfSegments),
                                        height: self.scrollView.frame.height)
        
        print(scrollView.frame)
        print(scrollView.contentSize)
        
        for i in 0..<segmentedControl.segmentedControl.numberOfSegments {
            let rect = CGRect.init(x: (CGFloat(i) * scrollView.frame.width), y: 0, width: scrollView.frame.width, height: scrollView.frame.height)
            let layout = UICollectionViewFlowLayout()
            layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
            layout.itemSize = CGSize(width: self.view.frame.width - CGFloat(16), height: 50)
            let collectionView: UICollectionView = UICollectionView(frame: rect, collectionViewLayout: layout)
            
            collectionView.delegate = self
            collectionView.dataSource = self
            
            let nib = UINib(nibName: "CustomCollectionViewCell", bundle: nil)
            collectionView.register(nib, forCellWithReuseIdentifier: "CustomCell")
            
            collectionView.backgroundColor = UIColor.init(hue: CGFloat(0.25 * Float(i)), saturation: 1, brightness: 1, alpha: 1)
            
            scrollView.addSubview(collectionView)
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        
        segmentedControl.segmentedControl.selectedSegmentIndex = Int(pageIndex)
        segmentedControl.animateHighlight(to: Int(pageIndex))
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCollectionViewCell

        cell.cellLabel.text = "[\(indexPath.section + 1),\(indexPath.row)]"

        return cell
    }
}


extension ViewController: CustomSegmentedControlViewDelegate {
    func customSegmentedControlValueChanged(selectedIndex: Int, numberOfSections: Int) {
        let index = round(scrollView.contentOffset.x/view.frame.width)
        
        var frame = scrollView.frame;
        frame.origin.x = frame.size.width * CGFloat(selectedIndex);
        frame.origin.y = 0;
        
        self.scrollView.scrollRectToVisible(frame, animated: true)
    }
}
