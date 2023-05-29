//
//  MarbleDiagramView.swift
//  CombineMarbleDebugger
//
//  Created by Mataranga, Vlad on 14.05.2023.
//

import SwiftUI

struct MarbleDiagramView: View {
    
    let timeline: MarbleTimeline
    let startDate: Date
    let timeUnit: TimeInterval
    let width: CGFloat
    
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .foregroundColor(.blue)
                .frame(width: width, height: AppConstatns.diagramThickness)
                .offset(x: -AppConstatns.timeUnitSize)
            ForEach(timeline.events) { event in
                MarbleEventView(event: event)
                    .offset(x: marbleOffset(for: event.date))
            }
        }
    }
    
    private func marbleOffset(for date: Date) -> CGFloat {
        Date.difference(lhs: date, rhs: startDate).getCGFloat(for: timeUnit) - AppConstatns.halfMarbleSize
    }
}
