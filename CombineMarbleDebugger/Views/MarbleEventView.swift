//
//  MarbleEventView.swift
//  CombineMarbleDebugger
//
//  Created by Mataranga, Vlad on 14.05.2023.
//

import SwiftUI

struct MarbleEventView: View {
    
    @State var isPopover: Bool = false
    
    let event: MarbleEvent
    
    var body: some View {
        Button(action: { isPopover = true }) {
            ZStack {
                Circle()
                    .foregroundColor(.red)
                if let value = event.value {
                    Text(value)
                }
            }
            .frame(width: AppConstatns.marbleSize, height: AppConstatns.marbleSize)
            .shadow(radius: 5)
        }
        .popover(isPresented: $isPopover, arrowEdge: .bottom) {
            VStack {
                if let valeu = event.value {
                    Text(valeu)
                }
                Text(event.date.longTimeString)
            }
            .padding()
        }
        .buttonStyle(PlainButtonStyle())
    }
}
