//
//  DateFormatter+Extension.swift
//  CombineMarbleDebugger
//
//  Created by Mataranga, Vlad on 14.05.2023.
//

import Foundation

public extension DateFormatter {
    
    private convenience init(dateFormat: String) {
        self.init()
        self.dateFormat = dateFormat
    }

    static var longStyleTimeFormatter = DateFormatter(dateFormat: "HH:mm:ss.SSS")
    static var dateFormatter = DateFormatter(dateFormat: "dd.MM.yyyy")
    static var longStyleDateFormatter = DateFormatter(dateFormat: "dd.MM.yyyy'T'HH:mm:ss.SSS")

    private convenience init(dateStyle: DateFormatter.Style = .none, timeStyle: DateFormatter.Style = .none) {
        self.init()
        self.dateStyle = dateStyle
        self.timeStyle = timeStyle
    }
}
