//
//  SelectedImageView.swift
//  cion
//
//  Created by Rahul K M on 29/02/24.
//

//import SwiftUI
//
//struct SelectedImageView: View {
//    @State var image: UIImage
//    @State private var responseText = ""
//    @Environment(\.presentationMode) var presentationMode
//    @State private var showSelectedImageView = false
//    
//    var body: some View {
//        VStack {
//            Image(uiImage: image)
//                .resizable()
//                .scaledToFit()
//                .frame(width: 250, height: 250)
//            
//            Button("Submit") {
//                submitImage(image: image)
//            }
//            
//            if !responseText.isEmpty {
//                Text(responseText)
//            }
//        }
//        .padding()
//    }
//    
//    private func submitImage(image: UIImage) {
//        OpenAIManager.shared.analyzeImage(image: image) { result in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let response):
//                    self.responseText = response
//                case .failure(let error):
//                    self.responseText = "Error: \(error.localizedDescription)"
//                }
//                
//            }
//        }
//    }
//}
//
