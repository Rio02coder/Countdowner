//
//  AddCountdownForm.swift
//  Countdowner
//
//  Created by shmeelok chakraborty on 12/23/24.
//

import SwiftUI

func createCountdown(name: String, description: String, date: Date) -> Countdown {
    return Countdown(name: name, description: description, date: date)
}

func isFormCorrect(date: Date) -> Bool {
    getTimeIntervalNumberFromCurrentDate(date: date) > 0
}

struct AddCountdownForm: View {
    var closeHandler: () -> Void;
    var uid: String
    @State private var title: String = "";
    @State private var description: String = "";
    @State private var date: Date = Date();
    @State private var isAlertPresented: Bool = false;
    @State private var alertMessage: String = "";
    var body: some View {
        VStack {
            HStack {
                Button("Cancel", role: .cancel, action: {
                    closeHandler()
                })
                .applyCountdownAddFormCancelButtonStyle()
                Spacer()
                Text("New")
                    .applyCountdownAddFormTitleStyle()
                    .padding(.trailing, 27)
                Spacer()
                Button("Add") {
                    if !isFormCorrect(date: date) {
                        isAlertPresented = true
                        alertMessage = "Select a later date and time"
                    } else {
                        Task {
                            let newCountdown = createCountdown(name: title, description: description, date: date)
                            do {
                                try await addNewCountdown(uid, countdown: newCountdown)
                                closeHandler()
                            } catch {
                                isAlertPresented = true
                                alertMessage = "There has been an error in adding your countdown. Try again later."
                            }
                        }
                    }
                }
                .disabled(title == "" ? true : false)
                .font(.headline)
                .foregroundColor(title == "" ? .gray : .blue)
                .alert("Error", isPresented: $isAlertPresented) {
                    Button("Ok") {
                        isAlertPresented = false
                    }
                } message: {
                    Text(alertMessage)
                }

            }
            .padding(.horizontal)
            ScrollView {
                VStack {
                    RoundedRectangle(cornerRadius: 25)
                        .applyCountdownAddFormTitleAndDescriptionStyle()
                        .overlay(content: {
                            VStack {
                                TextField("", text: $title, prompt: Text("Title").foregroundColor(Color(red:146/255, green: 150/255, blue: 147/255)))
                                    .applyCountdownAddFormTextFieldStyle()
                                Divider()
                                    .applyCountdownAddFormDividerStyle()
                                TextField("", text: $description, prompt: Text("Description")
                                    .foregroundColor(Color(red:146/255, green: 150/255, blue: 147/255)))
                                    .applyCountdownAddFormTextFieldStyle()
                            }
                        })
                    DatePicker("End", selection: $date, in: Date()..., displayedComponents: .date).datePickerStyle(.graphical)
                        .colorScheme(.dark)
                        .padding()
                        .cornerRadius(8)
                    HStack {
                        Text("Time").foregroundColor(.white)
                            .applyCountdownAddFormTimeTextStyle()
                        DatePicker("", selection: $date, in: Date()..., displayedComponents: .hourAndMinute).datePickerStyle(.graphical)
                            .colorScheme(.dark)
                            .padding(.horizontal)
                            .cornerRadius(8)
                    }.padding()
                    
                }
            }
        }
    }
}

//#Preview {
//    AddCountdownForm()
//        .applyDefaultBackground()
//}
