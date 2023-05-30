//
//  MarbleModel.swift
//  CombineMarbleDebugger
//
//  Created by Mataranga, Vlad on 14.05.2023.
//

import Foundation

class MarbleModel: Identifiable {
    let id: UUID
    var tag: String?
    var suncsriotionTime: Date?
    var timelines: [Int: MarbleTimeline] = [:]
    var treeMap: [Int: MarbleTree] = [:]
    var complition: MarbleComplitionEvent?
    
    init(id: UUID) {
        self.id = id
    }
    
    var tree: MarbleTree? { treeMap[1] }
    
    var lastDate: Date?
    var timeLenght: TimeInterval?
    
    func finishDataInjection() {
        lastDate = complition?.date ?? timelines.values.compactMap { $0.lastDate }.max()
        if let suncsriotionTime = suncsriotionTime, let lastDate = lastDate {
            timeLenght = Date.difference(lhs: lastDate, rhs: suncsriotionTime)
        } else {
            timeLenght = 0
        }
        // TODO: remove this
        for timeline in timelines.values {
            timeline.complition = complition
        }
    }
}
