//
//  EventPopoverContainerView.swift
//  CombineMarbleDebugger
//
//  Created by Mataranga, Vlad on 30.05.2023.
//

import SwiftUI

struct EventPopoverContainerView<Content: View>: View {
    
    @State var isPopover: Bool = false
    
    let event: EventPopoverProtocol
    
    let content: () -> Content
    
    var body: some View {
        Button(action: { isPopover = true }) {
            content()
        }
        .popover(isPresented: $isPopover, arrowEdge: .bottom) {
            VStack {
                if let valeu = event.value {
                    Text("Valeu")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text(valeu)
                        .bold()
                        .foregroundColor(.primary)
                        .padding(.bottom, 3)
                }
                Text("Time")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text(event.date.longTimeString)
                    .foregroundColor(.primary)
                    .bold()
            }
            .padding()
        }
        .buttonStyle(.plain)
    }
}
