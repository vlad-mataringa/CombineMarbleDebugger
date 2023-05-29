//
//  CombineMarbleDebuggerApp.swift
//  CombineMarbleDebugger
//
//  Created by Mataranga, Vlad on 24.05.2023.
//

import SwiftUI

@main
struct CombineMarbleDebuggerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: MarbleViewModel())
        }
    }
}
