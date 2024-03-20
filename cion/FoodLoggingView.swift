//
//  FoodLoggingView.swift
//  cion
//
//  Created by Rahul K M on 07/03/24.
//

//import SwiftUI
//
//struct FoodLoggingView: View {
//    @State private var loggedFoodItems: [String] = []
//    @Binding var loggedFoodItemsBinding: [String]
//
//    var body: some View {
//        List(loggedFoodItems, id: \.self) { item in
//            Text(item)
//        }
//        .navigationBarTitle("Food Logging")
//        .onAppear {
//            let formatter = DateFormatter()
//            formatter.dateFormat = "EEE, MMM d, y"
//            let today = formatter.string(from: Date())
//
//            loggedFoodItems = loggedFoodItemsBinding.filter { $0.starts(with: today) }
//        }
//        .onDisappear {
//            loggedFoodItemsBinding = loggedFoodItems
//        }
//    }
//}

import SwiftUI

struct FoodLoggingView: View {
    @State private var loggedFoodItems: [String] = []
    @Binding var loggedFoodItemsBinding: [String]

    var body: some View {
        NavigationView {
            List(loggedFoodItems, id: \.self) { item in
                HStack {
                    Text(item)
                        .font(.headline)
                        .foregroundColor(.primary)
                    Spacer()
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                        .onTapGesture {
                            loggedFoodItems.removeAll(where: { $0 == item })
                            loggedFoodItemsBinding.removeAll(where: { $0 == item })
                        }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle("Food Logging", displayMode: .large)
            .navigationBarItems(trailing: Button(action: {
                let formatter = DateFormatter()
                formatter.dateFormat = "EEE, MMM d, y"
                let today = formatter.string(from: Date())

                loggedFoodItems = loggedFoodItemsBinding.filter { $0.starts(with: today) }
            }, label: {
                Image(systemName: "arrow.clockwise")
                    .font(.title)
                    .foregroundColor(.primary)
            }))
            .onAppear {
                let formatter = DateFormatter()
                formatter.dateFormat = "EEE, MMM d, y"
                let today = formatter.string(from: Date())

                loggedFoodItems = loggedFoodItemsBinding.filter { $0.starts(with: today) }
            }
            .onDisappear {
                loggedFoodItemsBinding = loggedFoodItems
            }
        }
    }
}

struct FoodLoggingView_Previews: PreviewProvider {
    static var previews: some View {
        FoodLoggingView(loggedFoodItemsBinding: .constant(["Sample logged food item"]))
    }
}
