//
//  Date+Extension.swift
//  CombineMarbleDebugger
//
//  Created by Mataranga, Vlad on 14.05.2023.
//

import Foundation

public extension Date {
    
    var longTimeString: String {
        DateFormatter.longStyleTimeFormatter.string(from: self)
    }
    
    var dateString: String {
        DateFormatter.dateFormatter.string(from: self)
    }
    
    static func difference(lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSince1970 - rhs.timeIntervalSince1970
    }
}
