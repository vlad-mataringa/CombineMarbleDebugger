//
//  MarbleLogsList.swift
//  CombineMarbleDebugger
//
//  Created by Mataranga, Vlad on 14.05.2023.
//

import Foundation
import CombineMarbleCommon

class MarbleLogsList {
    private(set) var marbleModels: [UUID: MarbleModel] = [:]
    private(set) var groupedByTag: [String: [MarbleModel]] = [:]
    
    private func safeMarbleInit(_ id: UUID) {
        if marbleModels[id] == nil {
            marbleModels[id] = .init(id: id)
        }
    }
    
    private func safeTimlineInit(for id: UUID, index: Int) {
        safeMarbleInit(id)
        if marbleModels[id]?.timelines[index] == nil {
            marbleModels[id]?.timelines[index] = .init(id: index)
        }
    }

    func addEvent(_ event: LogEvent<ValueLog>) {
        guard let content = event.content else { return }
        
        safeTimlineInit(for: event.id, index: content.index)
        
        guard let timeline = marbleModels[event.id]?.timelines[content.index] else {
            return
        }
         
        let marbleEvent = MarbleEvent(date: event.date, value: content.value)
        
        timeline.events.append(marbleEvent)
    }
    
    // TODO: this need to have in consideration the node action, need to fix the logging library first
    func addComplitionEvent(_ event: LogEvent<String?>) {
        safeMarbleInit(event.id)
        
        guard let model = marbleModels[event.id] else {
            return
        }
        switch event.type {
        case .cancel:
            model.complition = .init(date: event.date, type: .cancel)
        case .finish:
            model.complition = .init(date: event.date, type: .finsih)
        case .error:
            model.complition = .init(date: event.date, type: .error)
        default:
            return
        }
    }
    
    func addSubscriptionEvent(_ event: LogEvent<SubscriotionLog>) {
        safeMarbleInit(event.id)
        
        guard let subscriotionLog = event.content,
              let model = marbleModels[event.id] else {
            return
        }
        
        model.tag = subscriotionLog.tag
        model.suncsriotionTime = event.date
        let reversedList = subscriotionLog.list.reversed()
        
        for node in reversedList {
            let index = node.index
            let left   = model.treeMap[2 * index]
            let right  = model.treeMap[2 * index + 1]
            model.treeMap[index] =  MarbleTree(type: node.type, index: index, left: left, right: right)
        }
    }
    
    func finishDataInjection() {
        for model in marbleModels.values {
            model.finishDataInjection()
            guard let tag = model.tag else { continue }
            if groupedByTag[tag] == nil {
                groupedByTag[tag] = []
            }
            groupedByTag[tag]?.append(model)
        }
    }
}
