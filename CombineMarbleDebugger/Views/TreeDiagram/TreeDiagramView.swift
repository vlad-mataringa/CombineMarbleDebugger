//
//  TreeDiagramView.swift
//  CombineMarbleDebugger
//
//  Created by Mataranga, Vlad on 14.05.2023.
//

import SwiftUI

struct TreeDiagramView<V: View>: View {
    let tree: MarbleTree
    let node: (MarbleTree) -> V

    typealias Key = CollectDictionary<MarbleTree.ID, Anchor<CGPoint>>

    var body: some View {
        VStack(alignment: .center) {
            if tree.left != nil || tree.right != nil {
                HStack(alignment: .bottom, spacing: 10) {
                    if let left = tree.left {
                        TreeDiagramView(tree: left, node: self.node)
                    }
                    if let right = tree.right {
                        TreeDiagramView(tree: right, node: self.node)
                    }
                }
            }
            node(tree)
                .anchorPreference(key: Key.self, value: .center, transform: {
                    [self.tree.id: $0]
                })
        }.backgroundPreferenceValue(Key.self, { (centers: [MarbleTree.ID: Anchor<CGPoint>]) in
            GeometryReader { proxy in
                if let left = tree.left {
                    EdgeShape(
                        from: proxy[centers[self.tree.id]!],
                        to: proxy[centers[left.id]!]
                    ).stroke(lineWidth: 3)
                }
                if let right = tree.right {
                    EdgeShape(
                        from: proxy[centers[self.tree.id]!],
                        to: proxy[centers[right.id]!]
                    ).stroke(lineWidth: 3)
                }
            }
        })
    }
}
