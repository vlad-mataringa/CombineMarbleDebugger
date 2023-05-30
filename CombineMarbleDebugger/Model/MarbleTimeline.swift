//
//  MarbleTimeline.swift
//  CombineMarbleDebugger
//
//  Created by Mataranga, Vlad on 14.05.2023.
//

import Foundation

class MarbleTimeline: Identifiable {
    let id: Int

    var events: [MarbleEvent] = []
    var complition: MarbleComplitionEvent?
    
    var firstDate: Date? {
        events.min()?.date
    }
    
    var lastDate: Date? {
        events.max()?.date
    }
    
    init(id: Int) {
        self.id = id
    }
}
