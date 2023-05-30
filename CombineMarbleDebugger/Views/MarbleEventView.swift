//
//  MarbleEventView.swift
//  CombineMarbleDebugger
//
//  Created by Mataranga, Vlad on 14.05.2023.
//

import SwiftUI

struct MarbleEventView: View {
    
    let event: MarbleEvent
    
    var body: some View {
        EventPopoverContainerView(event: event) {
            ZStack {
                Circle()
                    .foregroundColor(.red)
                if let value = event.value {
                    Text(value)
                        .lineLimit(1)
                        .minimumScaleFactor(0.2)
                }
            }
            .frame(width: AppConstatns.marbleSize, height: AppConstatns.marbleSize)
            .shadow(radius: 5)
        }
    }
}
