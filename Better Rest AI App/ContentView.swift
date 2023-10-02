//
//  ContentView.swift
//  Better Rest AI App
//
//  Created by Shubham on 02/10/23.
//

import CoreML
import SwiftUI

struct ContentView: View {
    // MARK: Properties
    @State private var sleepAmount = 8.0
    @State private var wakeUp = Date.now
    @State private var coffeeAmount = 1
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    // MARK: Body
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text("When do you want to wake up?")
                    .font(.headline)
                
                DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                    .labelsHidden()
                
                Text("Desired amount of sleep")
                    .font(.headline)
                
                Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                
                Text("Daily coffee intake")
                    .font(.headline)
                
                Stepper(coffeeAmount == 1 ? "1 cup" : "\(coffeeAmount) cups", value: $coffeeAmount, in: 1...20, step: 1)
            }
            .padding()


            .navigationTitle("Better Rest")
            .toolbar {
                Button("Calculate", action: calculateBetime)
            }
            .alert(alertTitle, isPresented: $showingAlert) {
                Button("OK") {
                    
                }
            } message: {
                Text(alertMessage)
            }
        }
    }
    
    func calculateBetime() {
        do {
            let config = MLModelConfiguration()
            let model = try Sleep_Calculator_Model(configuration: config)
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Int64(hour + minute), estimatedSleep: sleepAmount, coffee: Int64(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            alertTitle = "Your ideal bedtime is"
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
            
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was problem to calculate your bedtime"
            print("Error while getting ml model is :: \(error.localizedDescription)")
        }
        
        showingAlert = true
    }
}

#Preview {
    ContentView()
}



//            Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
//
//            DatePicker("Please pick a date", selection: $wakeUp, in: Date.now..., displayedComponents: .date)
//                .labelsHidden()
//            
//            Text(Date.now, format: .dateTime.year().day().month().hour().minute())
//            Text(Date.now.formatted(date: .long, time: .shortened))

//func trivialExample() {
//    let components = Calendar.current.dateComponents([.hour, .minute], from: Date.now)
//    let hour = components.hour ?? 0
//    let minute = components.minute ?? 0
//}
