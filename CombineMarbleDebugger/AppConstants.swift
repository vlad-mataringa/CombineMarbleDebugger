//
//  AppConstants.swift
//  CombineMarbleDebugger
//
//  Created by Mataranga, Vlad on 14.05.2023.
//

import Foundation

enum AppConstatns {
    static let timeUnitSize: CGFloat = 100
    static let timeSubUnitSize: CGFloat = timeUnitSize / 10
    static let timeScaleUnitWidth: CGFloat = 2
    static let timeScaleStackSpacing: CGFloat = timeSubUnitSize - timeScaleUnitWidth
    
    static let marbleSize: CGFloat = 40
    static let halfMarbleSize: CGFloat = marbleSize / 2
    static let diagramThickness: CGFloat = 4
    static let diagramOffset: CGFloat = CGFloat(extraTimeIntervalsInTimeScale) * timeUnitSize
    
    static let minTimeUnit: TimeInterval = 1
    static let maxTimeUnit: TimeInterval = 3600
    static let extraTimeIntervalsInTimeScale: Double = 2 // at every end
}
