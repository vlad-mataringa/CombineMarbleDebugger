//
//  DragAndDropView.swift
//  CombineMarbleDebugger
//
//  Created by Mataranga, Vlad on 14.05.2023.
//

import SwiftUI

struct DragAndDropView: View {
    @State private var dragOver = false
    
    let didDropFileAction: (URL) -> Void

    var body: some View {
        VStack {
            Image(systemName: "square.and.arrow.up.circle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80, height: 80)
                .onDrop(of: ["public.file-url"], isTargeted: $dragOver, perform: onDropAction(_:))
                .foregroundColor(dragOver ? .blue : .primary)
            Text("Drop here your logs file.")
                .font(.body)
                .padding()
        }
       
    }
    
    func onDropAction(_ providers: [NSItemProvider]) -> Bool {
        providers.first?.loadDataRepresentation(forTypeIdentifier: "public.file-url", completionHandler: { (data, error) in
            if let data = data,
               let path = NSString(data: data, encoding: 4),
               let url = URL(string: path as String) {
                print("did drop file with url: \(url)")
                didDropFileAction(url)
            }
        })
        return true
    }
}
