//
//  CountdownView.swift
//  Countdowner
//
//  Created by shmeelok chakraborty on 12/24/24.
//

import SwiftUI

struct CountdownView: View {
    var uid: String
    var countdown: Countdown = Countdown(name: "CSE 583 Assignment")
    var closeAction: () -> Void
    var headerColor: LinearGradient
    @State private var showDeleteConfirmation = false
    @State private var isDeleted = false
    
    var body: some View {
        ZStack {
            VStack {
                // Top banner
//                Color.red
//                    .frame(height: 150)
//                    .ignoresSafeArea(edges: .top)
//                    .overlay(content: {
//                        Text(countdown.name)
//                            .font(.title)
//                            .fontDesign(.rounded)
//                            .fontWeight(.heavy)
//                            .foregroundColor(.white)
//                            .multilineTextAlignment(.center)
//                            .padding(.bottom)
//                    })
                ZStack(alignment: .topLeading) {
                    // Gradient Background
                    headerColor
                        .frame(height: shouldRespectSafeArea() ? 90 : 150)
                    .ignoresSafeArea(edges: shouldRespectSafeArea() ? [] : .top)
                    Button(action: {
                        closeAction()
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .padding()
                    }
                    .padding(.top, 10) // Respect Safe Area
                    .padding(.leading, 10) // Position within Safe Area
                }

                // Content
                if !isDeleted {
                        VStack(spacing: 20) {
                            CountdownTimerView(expirationDate: countdown.date)
                            Divider()
                                .background(.white)
                                .padding(.horizontal)
                                .padding(.horizontal)
                            Text(countdown.name)
                                .font(.title)
                                .fontDesign(.rounded)
                                .fontWeight(.heavy)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding(.top)
                                .padding(.top)
                            Text(countdown.description != nil ? countdown.description! : "")
                                .font(.body)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.leading)
                                .padding()
                            Spacer()
                            // Delete button
                            Button(role: .destructive) {
                                withAnimation {
                                    showDeleteConfirmation = true
                                }
                            } label: {
                                Text("Delete Countdown")
                                    .fontWeight(.bold)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.red.opacity(0.9))
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                    .padding(.horizontal)
                            }
                            .padding(.horizontal)
                            .padding(.bottom)
                        }
                        .frame(maxHeight: .infinity)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
            
            // Delete confirmation
            if showDeleteConfirmation {
                VStack {
                    Text("Are you sure you want to delete this countdown?")
                        .font(.headline)
                        .multilineTextAlignment(.center)
                        .padding()
                        .foregroundColor(.white)
                    
                    HStack {
                        Button("Cancel") {
                            withAnimation {
                                showDeleteConfirmation = false
                            }
                        }
                        .padding()
                        .background(Color.gray.opacity(1))
                        .cornerRadius(10)
                        
                        Button("Delete") {
                            Task {
                                do {
                                    try await deleteCountdown(uid, countdownToDelete: countdown)
                                    withAnimation {
                                        isDeleted = true
                                        showDeleteConfirmation = false
                                    }
                                    closeAction()
                                } catch {
                                    withAnimation {
                                        showDeleteConfirmation = false
                                    }
                                }
                            }
                        }
                        .padding()
                        .background(Color.red.opacity(1))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black.opacity(0.6).ignoresSafeArea())
                .transition(.opacity)
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

// Countdown Timer View
struct CountdownTimerView: View {
    var expirationDate: Date
    @State private var remainingTime: String = ""
    
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        Text(remainingTime)
            .font(.system(size: 90, weight: .bold, design: .serif))
            .foregroundColor(.white)
            .onAppear {
                updateTime()
            }
            .onReceive(timer) { _ in
                updateTime()
            }
    }
    
    func updateTime() {
            let now = Date()
            let difference = expirationDate.timeIntervalSince(now)
            
            if difference <= 0 {
                remainingTime = "Done"
            } else if difference < 24 * 3600 {
                // Show real-time countdown if less than 24 hours
                let hours = Int(difference) / 3600
                let minutes = (Int(difference) % 3600) / 60
                let seconds = Int(difference) % 60
                remainingTime = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
            } else {
                // Show approximate duration if more than 24 hours
                remainingTime = getTimeIntervalNumberFromCurrentDateAsStr(date: expirationDate)
            }
        }
}

#Preview {
    CountdownView(uid: "", closeAction: {}, headerColor: LinearGradient(colors: [.pink, .red], startPoint: .topLeading, endPoint: .bottomTrailing))
        .applyDefaultBackground()
}
