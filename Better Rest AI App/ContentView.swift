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
//            Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
//            
//            DatePicker("Please pick a date", selection: $wakeUp, in: Date.now..., displayedComponents: .date)
//                .labelsHidden()
            
            Text(Date.now, format: .dateTime.year().day().month().hour().minute())
            Text(Date.now.formatted(date: .long, time: .shortened))
        }
        .padding()
    }
    
    func trivialExample() {
        let components = Calendar.current.dateComponents([.hour, .minute], from: Date.now)
        let hour = components.hour ?? 0
        let minute = components.minute ?? 0
    }
}

#Preview {
    ContentView()
}
