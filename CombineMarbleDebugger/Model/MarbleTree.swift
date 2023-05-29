//
//  MarbleTree.swift
//  CombineMarbleDebugger
//
//  Created by Mataranga, Vlad on 14.05.2023.
//

import Foundation
import CombineMarbleCommon

class MarbleTree: Identifiable {
    var id: Int { index }
    
    let type: PublisherType
    let index: Int
    let left: MarbleTree?
    let right: MarbleTree?
    
    init(type: PublisherType, index: Int, left: MarbleTree?, right: MarbleTree?) {
        self.type = type
        self.index = index
        self.left = left
        self.right = right
    }
}
