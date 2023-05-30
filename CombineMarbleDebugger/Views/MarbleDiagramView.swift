//
//  MarbleDiagramView.swift
//  CombineMarbleDebugger
//
//  Created by Mataranga, Vlad on 14.05.2023.
//

import SwiftUI

struct MarbleDiagramView: View {
    
    enum Constatns {
        static let diagramMarkSize: CGFloat = 40
        static let timelineColor: Color = .init(white: 0.4)
    }
    
    let timeline: MarbleTimeline
    let startDate: Date
    let timeUnit: TimeInterval
    let width: CGFloat
    
    var body: some View {
        ZStack(alignment: .leading) {
            Group {
                Rectangle()
                    .frame(width: width, height: AppConstatns.diagramThickness)
                    .offset(x: -AppConstatns.timeUnitSize)
                Image(systemName: "arrow.forward")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: Constatns.diagramMarkSize, height: Constatns.diagramMarkSize)
                    .offset(x: width - AppConstatns.timeUnitSize - 30)
                complitionView
            }.foregroundColor(Constatns.timelineColor)
            
            
            
            ForEach(timeline.events) { event in
                MarbleEventView(event: event)
                    .offset(x: offset(for: event.date) - AppConstatns.halfMarbleSize)
            }
        }
    }
    
    @ViewBuilder
    var complitionView: some View {
        if let complition = timeline.complition {
            EventPopoverContainerView(event: complition) {
                Group {
                    if complition.type == .error {
                        Image(systemName: "xmark")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: Constatns.diagramMarkSize, height: Constatns.diagramMarkSize)
                    } else {
                        Rectangle()
                            .frame(width: AppConstatns.diagramThickness, height: Constatns.diagramMarkSize)
                            .cornerRadius(AppConstatns.diagramThickness / 2)
                    }
                }
            }.offset(x: offset(for: complition.date) - AppConstatns.diagramThickness / 2)
        }
    }
     
    private func offset(for date: Date) -> CGFloat {
        Date.difference(lhs: date, rhs: startDate).getCGFloat(for: timeUnit)
    }
}
