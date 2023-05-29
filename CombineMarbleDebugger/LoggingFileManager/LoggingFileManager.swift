//
//  LoggingFileManager.swift
//  CombineMarbleDebugger
//
//  Created by Mataranga, Vlad on 14.05.2023.
//

import Foundation
import CombineMarbleCommon

class MyFileManager {
    
    static func getLogEvents(for fileUrl: URL) throws -> MarbleLogsList? {
        let model: MarbleLogsList = .init()
        
        guard let lines = String(data: try Data(contentsOf: fileUrl), encoding: .utf8)?.split(separator: "\n") else {
            return nil
        }
        
        for line in lines {
            if let data = line.data(using: .utf8) {
                if let subscriptionEvent = try? LogEvent<SubscriotionLog>.decode(data: data), subscriptionEvent.type == .subscribe {
                    model.addSubscriptionEvent(subscriptionEvent)
                } else if let valueLog = try? LogEvent<ValueLog>.decode(data: data), valueLog.type == .event {
                    model.addEvent(valueLog)
                }
            }
        }

        model.finishDataInjection()
        
        return model
    }
}
