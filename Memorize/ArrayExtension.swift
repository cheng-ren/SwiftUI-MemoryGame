//
//  ArrayExtension.swift
//  Memorize
//
//  Created by 任成 on 2020/6/1.
//  Copyright © 2020 任成. All rights reserved.
//

import Foundation

extension Array where Element: Identifiable {
    func firstIndex(of matching: Element) -> Int? {
        return self.firstIndex { $0.id == matching.id }
    }
}
