//
//  ContentView.swift
//  Better Rest AI App
//
//  Created by Shubham on 02/10/23.
//

import SwiftUI

struct ContentView: View {
    // MARK: Properties
    @State private var sleepAmount = 8.0
    @State private var wakeUp = Date.now
    
    // MARK: Body
    var body: some View {
        VStack {
            Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
            
            DatePicker("Please pick a date", selection: $wakeUp, in: Date.now..., displayedComponents: .date)
                .labelsHidden()
        }
        .padding()
    }
    
    func exampleDate() {
        let tommorow = Date.now.addingTimeInterval(86400)
        let range = Date.now...tommorow
    }
}

#Preview {
    ContentView()
}
