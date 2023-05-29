//
//  DragAndDropView.swift
//  CombineMarbleDebugger
//
//  Created by Mataranga, Vlad on 14.05.2023.
//

import SwiftUI

struct DragAndDropView: View {
    @State private var dragOver = false

    var body: some View {
        Image(systemName: "figure.play")
            .scaledToFill()
            .frame(width: 100, height: 100)
            .onDrop(of: ["public.file-url"], isTargeted: $dragOver, perform: onDropAction(_:))
            .border(dragOver ? Color.red : Color.clear)
    }
    
    func onDropAction(_ providers: [NSItemProvider]) -> Bool {
        providers.first?.loadDataRepresentation(forTypeIdentifier: "public.file-url", completionHandler: { (data, error) in
            if let data = data,
               let path = NSString(data: data, encoding: 4),
               let url = URL(string: path as String) {
                print("MyFileManager.getLogEvents(for: \(url)")
            }
        })
        return true
    }
}
