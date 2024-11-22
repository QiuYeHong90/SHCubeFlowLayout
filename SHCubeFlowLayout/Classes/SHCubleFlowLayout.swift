//
//  SHCubleFlowLayout.swift
//  DemoCube
//
//  Created by YeQiu on 2024/11/11.
//

import UIKit

open class SHCubleFlowLayout: UICollectionViewFlowLayout {
    
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
        attributtes.configAttributes(collectionView: self.collectionView, itemSize: self.itemSize)
        return attributtes
    }
    open override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
//        var arr = super.layoutAttributesForElements(in: rect)
//        if let arr = arr,arr.count > 0 {
//            var newArray: [UICollectionViewLayoutAttributes] = []
//            for item in arr {
//                if let attributes = self.layoutAttributesForItem(at: item.indexPath) {
//                    newArray.append(attributes)
//                }
////                item.configAttributes(collectionView: self.collectionView, itemSize: self.itemSize)
//            }
//            return newArray
//        }
        let rowCount = self.collectionView?.numberOfItems(inSection: 0) ?? 0
        if rowCount <= 0 {
            return []
        }
        let x: CGFloat = CGFloat(collectionView?.contentOffset.x ?? 0)
        let allW = self.collectionView?.bounds.size.width ?? 1
        let position = Int((x) / allW)
        let leftCount = max(position - 2, 0)
        let rightCount = min(position + 2, max(rowCount - 1, 0))
        
        
        
        var newArray: [UICollectionViewLayoutAttributes] = []
        for item in leftCount...rightCount {
            let indexPath = IndexPath.init(row: item, section: 0)
            if let attributes = self.layoutAttributesForItem(at: indexPath) {
                newArray.append(attributes)
            }
        }
        return newArray
    }
}

extension UICollectionViewLayoutAttributes {
    func configAttributes(collectionView: UICollectionView?, itemSize: CGSize) {
        
        var attributtes = self
        let indexPath = attributtes.indexPath
        let containerW = collectionView?.frame.size.width ?? 0
        let containerH = collectionView?.frame.size.height ?? 0
        let x: CGFloat = CGFloat(collectionView?.contentOffset.x ?? 0)
        let arc = CGFloat.pi * 2
        let rowCount = 4
        let allCount = collectionView?.numberOfItems(inSection: 0) ?? 0
        attributtes.center = .init(x: x + containerW * 0.5, y: containerH * 0.5)
//        attributtes.size = .init(width: self.itemSize.width - 100, height: self.itemSize.height - 213)
        attributtes.size = .init(width: itemSize.width, height: itemSize.height)
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
        
        let ruler = collectionView?.bounds.width ?? 1
        let position = (x) / ruler
        print("position---\(x)")
        attributtes.zIndex = allCount - abs(indexPath.row - Int(position))
        attributtes.isHidden = (abs(indexPath.row - Int(position)) > 5)
        print("attributtes.zIndex === \(attributtes.zIndex)")
    }
}
