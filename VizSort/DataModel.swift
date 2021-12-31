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

    /// Number of elements in the array to sort.
    static let size = 100

    @Published var numbers = Array<Int>(repeating: 0, count: DataModel.size)

    @Published var isProcessing: Bool = false

    @Published var statistics = SortStatistics(elements: DataModel.size)

    /// Populates the array with random `Int`s.
    func resetToRandom() {
        isProcessing = true
        statistics.reset()
        statistics.startTime = Date()

        var newNumbers = Array<Int>(repeating: 0, count: DataModel.size)
        DispatchQueue.global(qos: .userInitiated).async {
            (0..<DataModel.size).forEach { index in
                newNumbers[index] = Int.random(in: 0...Int.max)
                self.statistics.steps += 1
            }

            // Updates must be published on the main thread.
            DispatchQueue.main.async {
                self.numbers = newNumbers
                self.isProcessing = false
                self.statistics.stopTime = Date()
            }
        }
    }

    /// Uses BubbleSort to sort the array from smallest to largest. Publishes changes on the
    /// main thread.
    func sortInPlace() {
        isProcessing = true
        statistics.reset()
        statistics.startTime = Date()
        var workingNumbers = self.numbers

        DispatchQueue.global(qos: .userInitiated).async {
            // Le Bubblesort 🥂
            (1..<(DataModel.size - 1)).forEach { iteration in
                (0..<(DataModel.size - iteration)).forEach { index in
                    if workingNumbers[index + 1] < workingNumbers[index] {
                        let temp = workingNumbers[index]
                        workingNumbers[index] = workingNumbers[index + 1]
                        workingNumbers[index + 1] = temp
                    }
                    self.statistics.steps += 1

                    // Push updates on main thread after each pass through the array
                    DispatchQueue.main.sync {
                        self.numbers = workingNumbers
                    }
                }
            }
            DispatchQueue.main.async {
                self.isProcessing = false
                self.statistics.stopTime = Date()
            }
        }
    }

    /// Print the numbers array to the console.
    func printNumbers() {
        (0..<DataModel.size).forEach { index in
            print("numbers[\(index)]: \(numbers[index])")
        }
    }
}

extension DataModel {
    final class SortStatistics {
        var startTime: Date?
        var stopTime: Date?
        var elements: Int
        var steps: Int = 0

        init(elements: Int) {
            self.elements = elements
        }

        init(elements: Int, steps: Int = 0,  startTime: Date? = nil, stopTime: Date? = nil) {
            self.elements = elements
            self.steps = steps
            self.startTime = startTime
            self.stopTime = stopTime
        }

        func reset() {
            self.startTime = nil
            self.stopTime = nil
            self.steps = 0
        }

        var processingTime: TimeInterval? {
            guard let start = startTime,
                  let stop = stopTime else {
                      return nil
                  }
            return stop.timeIntervalSince(start)
        }
    }
}
