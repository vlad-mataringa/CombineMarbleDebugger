//
//  StreamDiagram.swift
//  CombineMarbleDebugger
//
//  Created by Mataranga, Vlad on 14.05.2023.
//

import CombineMarbleCommon

struct StreamDiagram {
    let upstream1: MarbleTimeline
    let upstream2: MarbleTimeline?
    let downstream: MarbleTimeline
    let operatorType: PublisherType
}
