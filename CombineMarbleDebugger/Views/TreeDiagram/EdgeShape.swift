//
//  EdgeShape.swift
//  CombineMarbleDebugger
//
//  Created by Mataranga, Vlad on 14.05.2023.
//

import SwiftUI

struct EdgeShape: Shape {
    var from: CGPoint
    var to: CGPoint
    var animatableData: AnimatablePair<CGPoint, CGPoint> {
        get { AnimatablePair(from, to) }
        set {
            from = newValue.first
            to = newValue.second
        }
    }
    
    func path(in rect: CGRect) -> Path {
        Path { p in
            p.move(to: self.from)
            p.addLine(to: self.to)
        }
    }
}
