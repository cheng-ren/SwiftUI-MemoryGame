//
//  GridLayout.swift
//  Memorize
//
//  Created by 任成 on 2020/6/1.
//  Copyright © 2020 任成. All rights reserved.
//

import SwiftUI

struct GridLayout {
    var size: CGSize
    var rowCount: Int = 0
    var columnCount: Int = 0
    
    init(itemCount: Int, nearAspectRatio desiredAspectRatio: Double = 1, in size: CGSize) {
        self.size = size
        
        var tempArr = [(Int, Int)]()
        for index in 2..<itemCount {
            if itemCount % index == 0 {
                tempArr.append((index, itemCount / index))
            }
        }
        var tempInterval = itemCount
        for (rowCount, columeCount) in tempArr.reversed() {
            let interval = abs(columeCount - rowCount)
            if tempInterval <= interval  { continue }
            tempInterval = interval
            self.rowCount = rowCount
            self.columnCount = columeCount
        }
    }
    
    var itemSize: CGSize {
        CGSize(width: size.width / CGFloat(columnCount), height: size.height / CGFloat(rowCount))
    }
    
    func location(ofItemAt index: Int) -> CGPoint {
        CGPoint(x: CGFloat(index % columnCount) * self.itemSize.width + self.itemSize.width / 2, y: CGFloat(index / (columnCount)) * self.itemSize.height + self.itemSize.height / 2)
    }
}
