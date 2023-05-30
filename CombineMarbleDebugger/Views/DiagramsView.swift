//
//  ContentView.swift
//  CombineMarbleDebugger
//
//  Created by Mataranga, Vlad on 14.05.2023.
//

import SwiftUI
import CombineMarbleCommon

struct DiagramsView: View {
    
    @ObservedObject var viewModel: MarbleViewModel
    
    var body: some View {
        HStack(alignment: .top) {
            treeView
            VStack(spacing: 5) {
                headerView
                scrollView
            }
        }
    }
    
    var headerView: some View {
        HStack(alignment: .center) {
            detailsView
            Slider(value: $viewModel.timeUnit, in: 0.1...15)
        }
    }
    
    var detailsView: some View {
        VStack(alignment: .leading) {
            if let title = viewModel.model.tag {
                Text(title)
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.primary)
            }
            Text(viewModel.model.id.uuidString)
                .font(.subheadline)
                .bold()
                .foregroundColor(.gray)
                .padding(.bottom, 2)
            
            HStack(spacing: 15) {
                makeTimeLabel("Day", viewModel.model.suncsriotionTime?.dateString)
                makeTimeLabel("Subscription time", viewModel.model.suncsriotionTime?.longTimeString)
                makeTimeLabel("Last event time", viewModel.model.lastDate?.longTimeString)
            }
        }
    }
    
    @ViewBuilder
    func makeTimeLabel(_ title: String, _ date: String?) -> some View {
        if let date = date {
            VStack(alignment: .leading) {
                Text(title)
                    .foregroundColor(.gray)
                Text(date)
                    .bold()
            }.font(.subheadline)
        }
    }
    
    @ViewBuilder
    var treeView: some View {
        if let tree = viewModel.model.tree {
            TreeDiagramView(tree: tree, node: { value in
                Button(action: { viewModel.selectNodeIndex(value.index) }) {
                    Text("\(value.type.rawValue)")
                        .foregroundColor(.black)
                        .padding(3)
                        .background(.white)
                        .cornerRadius(10)
                        .padding(5)
                }.buttonStyle(.plain)
            })
            .padding()
        }
    }
    
    var scrollView: some View {
        ScrollView(.horizontal) {
            VStack(alignment: .leading) {
                Spacer()
                marbleDiagramView
                timeScale
                Spacer()
            }
        }
        .padding()
        .border(.gray)
    }
    
    var marbleDiagramView: some View {
        Group {
            if let startDate = viewModel.marbleStartDate,
               let diagram = viewModel.selectedNodeDiagram {
                MarbleDiagramView(timeline: diagram.upstream1,
                                  startDate: startDate,
                                  timeUnit: viewModel.timeUnit,
                                  width: diagramWidth)

                if let upstream2 = diagram.upstream2 {
                    MarbleDiagramView(timeline: upstream2,
                                      startDate: startDate,
                                      timeUnit: viewModel.timeUnit,
                                      width: diagramWidth)
                }
                
                HStack {
                    Spacer()
                    Text(diagram.operatorType.rawValue)
                        .font(.title2)
                        .bold()
                    Spacer()
                }
                .frame(width: diagramWidth)
                .padding(.vertical)
                .background(Color.gray)
                .cornerRadius(10)
                .padding(.vertical)
                .offset(x: -AppConstatns.diagramOffset / 2)
                
                MarbleDiagramView(timeline: diagram.downstream,
                                  startDate: startDate,
                                  timeUnit: viewModel.timeUnit,
                                  width: diagramWidth)
            }
        }.offset(x: AppConstatns.diagramOffset)
    }
    
    var diagramWidth: CGFloat {
        CGFloat(viewModel.timeUnitsCount) * AppConstatns.timeUnitSize - AppConstatns.diagramOffset
    }
    
    var timeScale: some View {
        LazyHStack(spacing: AppConstatns.timeScaleStackSpacing) {
            ForEach(0..<UInt64(viewModel.timeUnitsCount), id: \.self) { index in
                VStack(alignment: .leading) {
                    HStack(alignment: .center, spacing: AppConstatns.timeScaleStackSpacing) {
                        timeScaleLine(large: true)
                        ForEach(0..<9) { _ in
                            timeScaleLine()
                        }
                    }
                    if let date = viewModel.getDate(for: index) {
                        Text(date)
                            .font(.footnote)
                            .frame(width: 80)
                            .offset(x: -40)
                    }
                }
            }
        }.frame(height: 100)
    }
    
    func timeScaleLine(large: Bool = false) -> some View {
        RoundedRectangle(cornerRadius: AppConstatns.timeScaleUnitWidth / 2)
            .foregroundColor(.gray)
            .frame(width: AppConstatns.timeScaleUnitWidth, height: large ? 50 : 10)
    }
}
