//
//  ContentView.swift
//  Converter
//
//  Created by Luiz Filho on 15/03/21.
//

import SwiftUI

struct ContentView: View {
    @State private var value = ""
    @State private var fromUnit = 1
    @State private var toUnit = 1
    
    private let units = [UnitTemperature.celsius, UnitTemperature.fahrenheit, UnitTemperature.kelvin]
    
    var result: Double {
        let parsedValue = Double(value) ?? 0
        
        let fromMeasure = Measurement(value: parsedValue, unit: units[fromUnit])
        let toMeasure = fromMeasure.converted(to: units[toUnit])
        
        return toMeasure.value
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Value")){
                    TextField("Value", text: $value)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("From")){
                    Picker("From", selection: $fromUnit) {
                        ForEach(units.indices, id: \.self) {
                            Text("\(units[$0].symbol)")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("To")){
                    Picker("To", selection: $toUnit) {
                        ForEach(units.indices, id: \.self) {
                            Text("\(units[$0].symbol)")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
               
                Section(header: Text("Result")){
                    Text("\(result, specifier: "%.02f") \(units[toUnit].symbol)")
                }
            }
            .navigationBarTitle("Converter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
