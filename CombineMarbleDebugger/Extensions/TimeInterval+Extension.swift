//
//  TimeInterval+Extension.swift
//  CombineMarbleDebugger
//
//  Created by Mataranga, Vlad on 14.05.2023.
//

import Foundation

extension TimeInterval {
    func getCGFloat(for timeUnit: TimeInterval) -> CGFloat {
        CGFloat(self / timeUnit) * AppConstatns.timeUnitSize
    }
}
