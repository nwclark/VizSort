//
//  NumberLinesView.swift
//  VizSort
//
//  Created by Nathan Clark on 12/27/21.
//
// Copyright © 2021 Nathan Clark
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the “Software”), to
// deal in the Software without restriction, including without limitation the
// rights to use, copy, modify, merge, publish, distribute, sublicense,
// and/or sell copies of the Software, and to permit persons to whom the
// Software is furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
// IN THE SOFTWARE.

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
//                    print("number[\(index)] = \(self.dataModel.numbers[index]) xPos: \(xPos) yTop: \(yTop)")
                    path.move(to: CGPoint(x: xPos, y: geometry.size.height))
                    path.addLine(to: CGPoint(x: xPos, y: yTop))
                }
            }
            .stroke(.black)
        }
    }
}

struct NumberLinesView_Previews: PreviewProvider {
    static var previews: some View {
        NumberLinesView()
            .environmentObject(DataModel())
    }
}
