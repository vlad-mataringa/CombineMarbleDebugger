//
//  MainView.swift
//  CombineMarbleDebugger
//
//  Created by Mataranga, Vlad on 29.05.2023.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var viewModel: MainViewModel
    
    var body: some View {
        HStack {
            listView
                .background(Color.gray)
                .listStyle(.automatic)
                .frame(width: 305)
                .padding()
            if let log = viewModel.selectedLog {
                DiagramsView(viewModel: MarbleViewModel(model: log))
            }
        }
       
    }
    
    @ViewBuilder
    var listView: some View {
        if let sections = viewModel.logsList?.groupedByTag {
            List {
                ForEach(Array(sections.keys), id: \.self) { tag in
                    if let list = sections[tag] {
                        Section(tag) {
                            ForEach(list) { log in
                                makeCellView(for: log)
                                    .onTapGesture { viewModel.selectedLog = log }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func makeCellView(for model: MarbleModel) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(model.id.uuidString)
            HStack {
                if let date = model.suncsriotionTime {
                    VStack(alignment: .leading) {
                        Text("Subscription")
                            .foregroundColor(.gray)
                        Text(date.longTimeString)
                    }
                }
                Spacer()
                if let date = model.lastDate {
                    VStack(alignment: .leading) {
                        Text("Last ")
                            .foregroundColor(.gray)
                        Text(date.longTimeString)
                    }
                }
                Spacer()
            }
        }
        .font(.subheadline)
        .padding(5)
        .frame(width: 270)
        .background(Color.red)
        .cornerRadius(5)
       
    }
    
    func makeSectionHeader(for sectionTitle: String) -> some View {
        Text(sectionTitle)
            .font(.body)
            .bold()
            .cornerRadius(5)
            .padding()
    }
}
