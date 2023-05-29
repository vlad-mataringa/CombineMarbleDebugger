//
//  MarbleEvent.swift
//  CombineMarbleDebugger
//
//  Created by Mataranga, Vlad on 14.05.2023.
//

import Foundation

struct MarbleEvent: Identifiable, Comparable {
    
    let id: UUID = .init()
    let date: Date
    let value: String?
    
    static func < (lhs: MarbleEvent, rhs: MarbleEvent) -> Bool { lhs.date < rhs.date }
}
