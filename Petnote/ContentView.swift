//
//  ContentView.swift
//  Petnote
//
//  Created by João Marcelo Colombini Cardonha on 10/02/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = FitnessTrackerViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Fitness Tracker")
                    .font(.largeTitle.weight(.bold))
                    .padding()
                if viewModel.isAuthorized {
                    VStack {
                        Text("This Week")
                            .font(.title3)
                        
                        Text("Distance \(viewModel.distance)m")
                        Text("Time \(viewModel.time)min")
                        
                        Button {
                            Task {
                                await viewModel.fetchData()
                            }
                        } label: {
                            Text("Refresh")
                        }
                        .buttonStyle(.bordered)

                    }
                    
                } else {
                    VStack {
                        Text("Health Kit access required!")
                            .font(.headline)
                            .foregroundStyle(.red)
                        
                        Button {
                            Task {
                                await viewModel.requestHealthKitAuthorization()
                            }
                        } label: {
                            Text("Authorize HealthKit")
                        }
                        .buttonStyle(.borderedProminent)

                    }
                }
            }
            .onAppear {
                
            }
        }
    }
}

#Preview {
    ContentView()
}
