//
//  DataModel.swift
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

import Foundation


final class DataModel: ObservableObject {

    static let size = 500

    @Published var numbers = Array<Int>(repeating: 0, count: DataModel.size)


    func resetToRandom() {
        var newNumbers = Array<Int>(repeating: 0, count: DataModel.size)
        DispatchQueue.global(qos: .userInitiated).async {
            (0..<DataModel.size).forEach { index in
                newNumbers[index] = Int.random(in: 0...Int.max)
            }

            DispatchQueue.main.async {
                self.numbers = newNumbers
            }
        }
    }

    func sortInPlace() {
        var workingNumbers = self.numbers // copy?

        DispatchQueue.global(qos: .userInitiated).async {
            // Le Bubblesort 🥂
            (1..<(DataModel.size - 1)).forEach { iteration in
                (0..<(DataModel.size - iteration)).forEach { index in
                    if workingNumbers[index + 1] < workingNumbers[index] {
                        let temp = workingNumbers[index]
                        workingNumbers[index] = workingNumbers[index + 1]
                        workingNumbers[index + 1] = temp
                    }
                    DispatchQueue.main.sync {
                        self.numbers = workingNumbers
                    }
                }
            }
        }
    }
}
