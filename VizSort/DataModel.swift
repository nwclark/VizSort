//
//  DataModel.swift
//  VizSort
//
//  Created by Nathan Clark on 12/27/21.
//

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
