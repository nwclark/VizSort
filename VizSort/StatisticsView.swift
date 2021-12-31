//
//  StatisticsView.swift
//  VizSort
//
//  Created by Nathan Clark on 12/30/21.
//

import SwiftUI

struct StatisticsView: View {
    var stats: DataModel.SortStatistics

    var body: some View {
        VStack {
            HStack {
                Text("Elements:")
                    .font(.headline)
                Text("\(stats.elements)")
                    .font(.body)
            }

            HStack {
                Text("Processing Time:")
                    .font(.headline)
                if let procTime = stats.processingTime {
                    Text("\(procTime)")
                        .font(.body)
                } else {
                    Text("--")
                        .font(.body)
                }
            }

            HStack {
                Text("Steps:")
                    .font(.headline)
                Text("\(stats.steps)")
            }
        }
    }
}

struct StatisticsView_Previews: PreviewProvider {
    static let stats = DataModel.SortStatistics(elements: 100,
                                                steps: 1021,
                                                startTime: Date(),
                                                stopTime: Date())
    static var previews: some View {
        StatisticsView(stats: Self.stats)
    }
}
