//
//  MarbleEvent.swift
//  CombineMarbleDebugger
//
//  Created by Mataranga, Vlad on 14.05.2023.
//

import Foundation

protocol EventPopoverProtocol {
    var value: String? { get }
    var date: Date { get }
}

struct MarbleEvent: Identifiable, Comparable, EventPopoverProtocol {
    
    let id: UUID = .init()
    let date: Date
    let value: String?
    
    static func < (lhs: MarbleEvent, rhs: MarbleEvent) -> Bool { lhs.date < rhs.date }
}

struct MarbleComplitionEvent: EventPopoverProtocol {
    enum MarbleComplitionType: String {
        case finsih
        case cancel
        case error
    }
    
    let date: Date
    let type: MarbleComplitionType
    
    var value: String? {
        type.rawValue
    }
}
