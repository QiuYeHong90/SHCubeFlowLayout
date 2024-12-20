//
//  ViewController.swift
//  SHCubeFlowLayout
//
//  Created by 秋叶红 on 11/11/2024.
//  Copyright (c) 2024 秋叶红. All rights reserved.
//
import SHCubeFlowLayout
import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataCount
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var index = Int(scrollView.contentOffset.x / scrollView.bounds.size.width)
        let allCount = self.collectionView(self.collectionView, numberOfItemsInSection: 0)
        index = min(index, allCount - 1)
        index = max(index, 0)
        if index == allCount - 1 {
            self.dataCount += 20
            self.collectionView.reloadData()
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as! ItemCell
        cell.label.text = "\(indexPath.row)"
        cell.backgroundColor = indexPath.row % 2 == 0 ? UIColor.red : UIColor.yellow
        return cell
    }
  
    
    var dataCount: Int = 20
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var flowLayout: SHCubleFlowLayout!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.dataSource = self
        collectionView.register(UINib.init(nibName: "ItemCell", bundle: nil), forCellWithReuseIdentifier: "ItemCell")
        collectionView.clipsToBounds = false
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .green
        collectionView.dataSource = self
        collectionView.delegate = self
    }


    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        flowLayout.itemSize = .init(width: self.view.bounds.width * 1, height: self.view.bounds.height - self.view.safeAreaInsets.top - self.view.safeAreaInsets.bottom)
        print("-=-=====")
        self.collectionView.reloadData()
    }
}
