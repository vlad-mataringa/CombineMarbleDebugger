//
//  MainViewModel.swift
//  CombineMarbleDebugger
//
//  Created by Mataranga, Vlad on 29.05.2023.
//

import Foundation
import Combine

class MainViewModel: ObservableObject {
    
    @Published var logsList: MarbleLogsList?
    @Published var selectedLog: MarbleModel?
    
    init() {
        if let url = URL(string: "file:///Users/matarangavlad/Downloads/marble_log_57BDE517.txt") {
            do {
                if let logsList = try MyFileManager.getLogEvents(for: url) {
                    self.logsList = logsList
                }
            } catch {
                print(error)
            }
        }
    }
}
