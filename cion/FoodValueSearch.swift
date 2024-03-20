//
//  FoodValueSearch.swift
//  cion
//
//  Created by Rahul K M on 28/02/24.
//

//import SwiftUI
//
//struct FoodValueSearchView: View {
//    @Environment(\.presentationMode) var presentationMode
//    @State private var foodName = ""
//    @State private var responseText = "Enter a food name to get started!"
//    @State private var isLoading = false // State for loading animation
//
//    var body: some View {
//        VStack(alignment: .leading) {
//            HStack {
//                Button(action: {
//                    presentationMode.wrappedValue.dismiss()
//                }) {
//                    Text("< Back")
//                        .foregroundColor(.primaryColor)
//                        .padding()
//                        .background(Color.secondaryColor)
//                        .clipShape(Capsule())
//                }
//                Spacer()
//            }
//            .padding(.bottom, 20)
//
//            Text("Nutritional Value Finder")
//                .font(.title)
//                .fontWeight(.bold)
//                .foregroundColor(.primaryColor)
//                .padding(.bottom, 20)
//
//            TextField("Enter food name", text: $foodName)
//                .padding()
//                .background(Color.inputFieldBackground)
//                .cornerRadius(10)
//                .padding(.bottom, 20)
//
//            Button("Submit") {
//                submitFoodValueSearch()
//            }
//            .buttonStyle(ModernButtonStyle())
//            .padding(.top, 30)
//
//            Spacer()
//
//            if isLoading {
//                ProgressView()
//                    .progressViewStyle(CircularProgressViewStyle(tint: .primaryColor))
//                    .scaleEffect(1.5)
//                    .padding()
//            } else {
//                Text(responseText)
//                    .padding()
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .background(Color.secondaryColor.opacity(0.3))
//                    .cornerRadius(10)
//                    .padding(.bottom, 20) // Push the response a little up
//            }
//        }
//        .padding()
//        .background(Color.background.ignoresSafeArea())
//        .navigationBarBackButtonHidden(true)
//        .navigationBarItems(leading: Button(action: {
//            presentationMode.wrappedValue.dismiss()
//        }) {
//            Text("Back")
//                .foregroundColor(.primaryColor)
//                .padding()
//                .background(Color.secondaryColor)
//                .clipShape(Capsule())
//        })
//    }
//
//    private func submitFoodValueSearch() {
//        guard !foodName.isEmpty else {
//            responseText = "Please enter a food name."
//            return
//        }
//
//        isLoading = true
//
//        let prompt = "\(foodName) give me the nutritional value of this food like calories, protein, fat, carbs etc, keep the response short and to the point, give it in A:B format, no sentences, and inlcude a one line fact about that food."
//
//        OpenAIManager.shared.analyzeText(text: prompt) { result in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let text):
//                    self.responseText = text
//                case .failure(let error):
//                    print("Error analyzing text: \(error.localizedDescription)")
//                }
//                self.isLoading = false
//            }
//        }
//    }
//}

//import SwiftUI
//import Firebase
//
//struct FoodValueSearchView: View {
//    @Environment(\.presentationMode) var presentationMode
//    @State private var foodName = ""
//    @Binding var responseText: String
//    @Binding var loggedFoodItems: [String]
//    @State private var isLoading = false // State for loading animation
//
//    var body: some View {
//        VStack(alignment: .leading) {
//            HStack {
//                Button(action: {
//                    presentationMode.wrappedValue.dismiss()
//                }) {
//                    Text("< Back")
//                        .foregroundColor(.primaryColor)
//                        .padding()
//                        .background(Color.secondaryColor)
//                        .clipShape(Capsule())
//                }
//                Spacer()
//            }
//            .padding(.bottom, 20)
//
//            Text("Nutritional Value Finder")
//                .font(.title)
//                .fontWeight(.bold)
//                .foregroundColor(.primaryColor)
//                .padding(.bottom, 20)
//
//            TextField("Enter food name", text: $foodName)
//                .padding()
//                .background(Color.inputFieldBackground)
//                .cornerRadius(10)
//                .padding(.bottom, 20)
//
//            Button("Submit") {
//                submitFoodValueSearch()
//            }
//            .buttonStyle(ModernButtonStyle())
//            .padding(.top, 30)
//
//            Spacer()
//
//            if isLoading {
//                ProgressView()
//                    .progressViewStyle(CircularProgressViewStyle(tint: .primaryColor))
//                    .scaleEffect(1.5)
//                    .padding()
//            } else {
//                Text(responseText)
//                    .padding()
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .background(Color.secondaryColor.opacity(0.3))
//                    .cornerRadius(10)
//                    .padding(.bottom, 20) // Push the response a little up
//
//                Button("Log") {
//                    logFoodItem()
//                }
//                .buttonStyle(ModernButtonStyle())
//                .padding(.top, 20)
//            }
//        }
//        .padding()
//        .background(Color.background.ignoresSafeArea())
//        .navigationBarBackButtonHidden(true)
//        .navigationBarItems(leading: Button(action: {
//            presentationMode.wrappedValue.dismiss()
//        }) {
//            Text("Back")
//                .foregroundColor(.primaryColor)
//                .padding()
//                .background(Color.secondaryColor)
//                .clipShape(Capsule())
//        })
//    }
//
//    private func submitFoodValueSearch() {
//        guard !foodName.isEmpty else {
//            responseText = "Please enter a food name."
//            return
//        }
//
//        isLoading = true
//
//        let prompt = "\(foodName) give me the nutritional value of this food like calories, protein, fat, carbs etc, keep the response short and to the point, give it in A:B format, no sentences, and inlcude a one line fact about that food."
//
//        OpenAIManager.shared.analyzeText(text: prompt) { result in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let text):
//                    self.responseText = text
//                case .failure(let error):
//                    print("Error analyzing text: \(error.localizedDescription)")
//                }
//                self.isLoading = false
//            }
//        }
//    }
//
//    private func logFoodItem() {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "EEE, MMM d, y"
//        let today = formatter.string(from: Date())
//
//        let newItem = "\(today): \(responseText)"
//        loggedFoodItems.append(newItem)
//    }
//}
//
//struct FoodValueSearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        FoodValueSearchView(responseText: .constant(""), loggedFoodItems: .constant([]))
//    }
//}

import SwiftUI

struct FoodValueSearchView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var foodName = ""
    @State private var responseText = "Enter a food name to get started!"
    @State private var isLoading = false // State for loading animation
    @Binding var loggedFoodItems: [String]
    @State private var showLogButton = false // State for showing log button
    @State private var isLogged = false // State for checking if food item is already logged

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("< Back")
                        .foregroundColor(.primaryColor)
                        .padding()
                        .background(Color.secondaryColor)
                        .clipShape(Capsule())
                }
                Spacer()
            }
            .padding(.bottom, 20)

            Text("Nutritional Value Finder")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.primaryColor)
                .padding(.bottom, 20)

            TextField("Enter food name", text: $foodName)
                .padding()
                .background(Color.inputFieldBackground)
                .cornerRadius(10)
                .padding(.bottom, 20)

            Button("Submit") {
                submitFoodValueSearch()
            }
            .buttonStyle(ModernButtonStyle())
            .padding(.top, 30)

            Spacer()

            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .primaryColor))
                    .scaleEffect(1.5)
                    .padding()
            } else {
                Text(responseText)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.secondaryColor.opacity(0.3))
                    .cornerRadius(10)
                    .padding(.bottom, 20) // Push the response a little up

                if showLogButton {
                    Button(action: {
                        if !isLogged {
                            logFoodItem()
                            isLogged = true
                        }
                    }) {
                        Text(isLogged ? "Logged" : "Log")
                            .foregroundColor(.white)
                            .padding(.horizontal, 25)
                            .padding(.vertical, 12)
                            .background(isLogged ? Color.green : Color.buttonBackground)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .frame(width: 350, alignment: .center)
                    }
                    .padding(.top, 20)
                }
            }
        }
        .padding()
        .background(Color.background.ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Text("Back")
                .foregroundColor(.primaryColor)
                .padding()
                .background(Color.secondaryColor)
                .clipShape(Capsule())
        })
    }

    private func submitFoodValueSearch() {
        guard !foodName.isEmpty else {
            responseText = "Please enter a food name."
            return
        }

        isLoading = true

        let prompt = "\(foodName) give me the nutritional value of this food exactly in this formatcalories: X, protein: Y, fat: Z, carbs: P and  fibre: Q, don't say anything except this."

        OpenAIManager.shared.analyzeText(text: prompt) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let text):
                    self.responseText = text
                    self.showLogButton = true // Show log button once response is received
                case .failure(let error):
                    print("Error analyzing text: \(error.localizedDescription)")
                }
                self.isLoading = false
            }
        }
    }

    private func logFoodItem() {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, MMM d, y"
        let today = formatter.string(from: Date())

        let newItem = "\(today): \(responseText)"
        loggedFoodItems.append(newItem)
    }
}

struct FoodValueSearchView_Previews: PreviewProvider {
    static var previews: some View {
        FoodValueSearchView(loggedFoodItems: .constant([]))
    }
}

extension Color {
    static let primaryColor = Color.blue
    static let secondaryColor = Color.white
    static let background = Color("Background")
    static let inputFieldBackground = Color.gray.opacity(0.1)
    static let buttonBackground = Color.primaryColor
}

struct ModernButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal, 25) // Adjust horizontal padding for width
            .padding(.vertical, 12) // Adjust vertical padding for height
            .background(Color.buttonBackground)
            .foregroundColor(.secondaryColor)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
            .frame(width: 350, alignment: .center) // Set a minimum width for the button
    }
}

