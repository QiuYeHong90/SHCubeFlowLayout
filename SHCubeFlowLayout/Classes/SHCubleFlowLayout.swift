//
//  SHCubleFlowLayout.swift
//  DemoCube
//
//  Created by YeQiu on 2024/11/11.
//

import UIKit

open class SHCubleFlowLayout: UICollectionViewLayout {
    open var itemSize: CGSize = .zero
    
    open override var collectionViewContentSize: CGSize {
        let containerW = self.collectionView?.frame.size.width ?? 0
        let containerH = self.collectionView?.frame.size.height ?? 0
        let rowCount = self.collectionView?.numberOfItems(inSection: 0) ?? 0
        let contentSizeW = containerW * (CGFloat(rowCount))
        return CGSize(width: contentSizeW, height: containerH)
    }
    
    open override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    open override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
       
        let attributtes = UICollectionViewLayoutAttributes.init(forCellWith: indexPath)
        let containerW = self.collectionView?.frame.size.width ?? 0
        let containerH = self.collectionView?.frame.size.height ?? 0
        let x: CGFloat = CGFloat(self.collectionView?.contentOffset.x ?? 0)
        let arc = CGFloat.pi * 2
        let rowCount = 4
        let allCount = self.collectionView?.numberOfItems(inSection: 0) ?? 0
        attributtes.center = .init(x: x + containerW * 0.5, y: containerH * 0.5)
//        attributtes.size = .init(width: self.itemSize.width - 100, height: self.itemSize.height - 213)
        attributtes.size = .init(width: self.itemSize.width, height: self.itemSize.height)
        var transform = CATransform3DIdentity;
        transform.m34 = -1 / 700;
        let radius = attributtes.size.width / 2 / tan(arc / 2.0 / CGFloat(rowCount) )
        let angle = CGFloat(indexPath.row % 4) * arc / 4 - ((x/containerW) + 1) / CGFloat(rowCount) * arc + 1 / CGFloat(rowCount) * arc
        
        
        transform = CATransform3DRotate(transform, angle, 0, 1, 0)
        print("radius ---\(radius)")
        let rate: CGFloat = 0.785
        transform = CATransform3DTranslate(transform, 0, 0, radius * rate)
        
        transform = CATransform3DScale(transform, 1 * rate , 1 * rate,1)
        attributtes.transform3D = transform
        
        let ruler = self.collectionView?.bounds.midX ?? 0
        let position = (x) / self.itemSize.width
        print("position---\(x)")
        attributtes.zIndex = allCount - abs(indexPath.row - Int(position))
        return attributtes
    }
    open override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let arr = super.layoutAttributesForElements(in: rect)
        if let arr = arr,arr.count > 0 {
            return arr
        }
        let rowCount = self.collectionView?.numberOfItems(inSection: 0) ?? 0
        var newArray: [UICollectionViewLayoutAttributes] = []
        for item in 0..<rowCount {
            let indexPath = IndexPath.init(row: item, section: 0)
            if let attributes = self.layoutAttributesForItem(at: indexPath) {
                newArray.append(attributes)
            }
        }
        return newArray
    }
}
