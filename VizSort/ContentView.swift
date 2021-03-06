//
//  ContentView.swift
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

struct ContentView: View {
    @EnvironmentObject var dataModel: DataModel

    var body: some View {
        ZStack (alignment: .topLeading) {
            StatisticsView(stats: dataModel.statistics)
                .padding()
                .background(.gray)
                .border(.black, width: 2.0)

            VStack {
                // Array Lines.
                NumberLinesView()
                    .padding()

                // Row of buttons.
                HStack {
                    Button {
                        self.dataModel.resetToRandom()
                    } label: {
                        Text("Reset")
                    }
                    .padding()
                    .background(.red)
                    .foregroundColor(.white)
                    .cornerRadius(.infinity)

                    Button {
                        self.dataModel.sortInPlace()
                    } label: {
                        Text("Sort")
                    }
                    .padding()
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(.infinity)
                }
                .disabled(dataModel.isProcessing)
                .opacity(dataModel.isProcessing ? 0.6 : 1.0)
                .scaleEffect(dataModel.isProcessing ? 0.95 : 1.0)
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(DataModel())
    }
}
