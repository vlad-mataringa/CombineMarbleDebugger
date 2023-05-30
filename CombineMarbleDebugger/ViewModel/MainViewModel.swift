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
        if let url = URL(string: "file:///Users/matarangavlad/Downloads/marble_log_AF67336A.txt") {
            loadLogs(for: url)
        }
    }
    
    func loadLogs(for url: URL) {
        Task {
            do {
                if let logsList = try MyFileManager.getLogEvents(for: url) {
                    await MainActor.run {
                        self.logsList = logsList
                        self.selectedLog = logsList.marbleModels.values.first
                    }
                }
            } catch {
                print(error)
            }
        }
    }
    
    func removeLogs() {
        logsList = nil
    }
}
