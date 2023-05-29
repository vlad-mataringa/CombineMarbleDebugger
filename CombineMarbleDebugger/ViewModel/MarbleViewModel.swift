//
//  MarbleViewModel.swift
//  CombineMarbleDebugger
//
//  Created by Mataranga, Vlad on 14.05.2023.
//

import Foundation

class MarbleViewModel: ObservableObject {
    
    @Published var timeUnit: TimeInterval = 1
    @Published var model: MarbleModel
    @Published var selectedNodeDiagram: StreamDiagram?
    
    var timeUnitsCount: UInt64 {
        if let timeLenght = model.timeLenght {
            return UInt64(round(timeLenght / timeUnit)) + AppConstatns.extraTimeIntervalsInTimeScale * 2
        }
        return 0
    }
    
    var timeScaleStartDate: TimeInterval? {
        guard var start = model.suncsriotionTime?.timeIntervalSince1970 else { return nil }
        start -= timeUnit * Double(AppConstatns.extraTimeIntervalsInTimeScale)
        return round(start)
    }
    
    init() {
        var model = MarbleModel(id: UUID())
        if let url = URL(string: "file:///Users/matarangavlad/Downloads/marble_log.txt") {
            do {
                let models = try MyFileManager.getLogEvents(for: url)
                if let myModel = models?.marbleModels.first?.value {
                    model = myModel
                }
            } catch {
                print(error)
            }
        }
        self.model = model
    }
    
    func getDate(for timeIndex: UInt64) -> String? {
        guard let timeScaleStartDate = timeScaleStartDate else { return nil }
        let date = Date(timeIntervalSince1970: timeScaleStartDate + Double(timeIndex) * timeUnit )
        return date.longTimeString
    }
    
    func selectNodeIndex(_ index: Int) {
        guard let downstream = model.timelines[index],
              let upstream1 = model.timelines[index * 2],
              let operatorType = model.treeMap[index]?.type else {
            return
        }
        
        let upstream2 = model.timelines[index * 2 + 1]
        
        let marbleDiagram = StreamDiagram(upstream1: upstream1,
                                          upstream2: upstream2,
                                          downstream: downstream,
                                          operatorType: operatorType)
        selectedNodeDiagram = marbleDiagram
    }
}

