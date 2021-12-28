//
//  ContentView.swift
//  VizSort
//
//  Created by Nathan Clark on 12/27/21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var dataModel: DataModel

    var body: some View {
        VStack {
            NumberLinesView()
                .padding()

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
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(DataModel())
    }
}
