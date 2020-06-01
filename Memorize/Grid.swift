//
//  Grid.swift
//  Memorize
//
//  Created by 任成 on 2020/6/1.
//  Copyright © 2020 任成. All rights reserved.
//

import SwiftUI

struct Grid<Item, ItemView>: View where Item: Identifiable, ItemView: View {
    var items: [Item]
    var viewForItem: (Item) -> ItemView
    
    init(_ items: [Item], viewForItem: @escaping (Item) -> ItemView) {
        self.items = items
        self.viewForItem = viewForItem
    }
    
    var body: some View {
        return GeometryReader { geometry in
            ForEach(self.items) { item in
                self.body(for: item, in: GridLayout(itemCount: self.items.count, in: geometry.size))
            }
        }
    }
    
    func body(for item: Item, in layout: GridLayout) -> some View {
        let index = items.firstIndex(of: item)!
        return self.viewForItem(item)
            .frame(width: layout.itemSize.width, height: layout.itemSize.height)
            .position(layout.location(ofItemAt: index))
    }
}
