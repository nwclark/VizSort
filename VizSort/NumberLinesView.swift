//
//  NumberLinesView.swift
//  VizSort
//
//  Created by Nathan Clark on 12/27/21.
//

import SwiftUI

struct NumberLinesView: View {

    @EnvironmentObject var dataModel: DataModel

    var body: some View {
        GeometryReader { geometry in
            let xScale = geometry.size.width / CGFloat(DataModel.size)
            Path { path in
                (0..<DataModel.size).forEach { index in
                    let xPos = CGFloat(index) * xScale
                    let yTop = geometry.size.height - (CGFloat(self.dataModel.numbers[index])/CGFloat(Int.max) * geometry.size.height)
//                    print("xPos: \(xPos) yTop: \(yTop)")
                    path.move(to: CGPoint(x: xPos, y: geometry.size.height))
                    path.addLine(to: CGPoint(x: xPos, y: yTop))
                }
            }
            .stroke(.black)
//            .animation(.spring() , value: dataModel.numbers)
        }
    }
}

struct NumberLinesView_Previews: PreviewProvider {
    static var previews: some View {
        NumberLinesView()
            .environmentObject(DataModel())
    }
}
