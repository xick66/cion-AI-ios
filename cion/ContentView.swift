//
//  ContentView.swift
//  cion
//
//  Created by Rahul K M on 28/02/24.
//

//import SwiftUI
//import Firebase
//
//struct ContentView: View {
//    @State private var showCameraPicker = false
//    @State private var showFoodValueSearch = false
//    @State private var showPhotoLibraryPicker = false
//    @State private var selectedImage: UIImage?
//    @State private var navigateToImageReview = false
//    @State private var responseText = ""
//    @State private var loggedFoodItems: [String] = []
//
//    @State private var showFoodLogView = false
//
//    var body: some View {
//        NavigationView {
//            VStack(spacing: 20) {
//                Button("Click a picture") {
//                    showCameraPicker = true
//                }
//                .buttonStyle(CustomButtonStyle())
//
//                Button("Upload a picture") {
//                    showPhotoLibraryPicker = true
//                }
//                .buttonStyle(CustomButtonStyle())
//
//                Button("Food value") {
//                    showFoodValueSearch = true
//                }
//                .buttonStyle(CustomButtonStyle())
//
//                Button("Food Log") {
//                    showFoodLogView = true
//                }
//                .buttonStyle(CustomButtonStyle())
//
//                NavigationLink(destination: ImageReviewView(selectedImage: $selectedImage, responseText: $responseText, loggedFoodItems: $loggedFoodItems), isActive: $navigateToImageReview) {
//                    EmptyView()
//                }
//            }
//            .padding()
//            .sheet(isPresented: $showCameraPicker) {
//                CameraPickerResultView(isShown: $showCameraPicker, selectedImage: $selectedImage, navigateToImageReview: $navigateToImageReview)
//            }
//            .sheet(isPresented: $showPhotoLibraryPicker) {
//                PhotoLibraryPickerView(onImageSelected: { image in
//                    self.selectedImage = image
//                    self.navigateToImageReview = true
//                }, onDismiss: {
//                    self.showPhotoLibraryPicker = false
//                })
//            }
//            .fullScreenCover(isPresented: $showFoodValueSearch) {
//                FoodValueSearchView(loggedFoodItems: $loggedFoodItems)
//            }
//            .sheet(isPresented: $showFoodLogView) {
//                FoodLoggingView(loggedFoodItemsBinding: $loggedFoodItems)
//            }
//        }
//        .navigationViewStyle(StackNavigationViewStyle())
//    }
//}

import SwiftUI

struct ContentView: View {
    @State private var showCameraPicker = false
    @State private var showFoodValueSearch = false
    @State private var showPhotoLibraryPicker = false
    @State private var selectedImage: UIImage?
    @State private var navigateToImageReview = false
    @State private var responseText = ""
    @State private var loggedFoodItems: [String] = []

    @State private var showFoodLogView = false

    var body: some View {
        NavigationView {
            ZStack {
               
                LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.6), Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)

             
                VStack(spacing: 20) {
                   
                    HStack {
                        Text("Cion")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.leading)
                        Spacer()
                    }

                
                    VStack(spacing: 16) {
                        FeatureButton(title: "Click a picture", systemImage: "camera", action: { showCameraPicker = true })
                        FeatureButton(title: "Upload a picture", systemImage: "photo", action: { showPhotoLibraryPicker = true })
                        FeatureButton(title: "Food value", systemImage: "doc.text.magnifyingglass", action: { showFoodValueSearch = true })
                        FeatureButton(title: "Food Log", systemImage: "book", action: { showFoodLogView = true })
                    }

                    Spacer()

                    NavigationLink(destination: ImageReviewView(selectedImage: $selectedImage, responseText: $responseText, loggedFoodItems: $loggedFoodItems), isActive: $navigateToImageReview) {
                        EmptyView()
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
        .sheet(isPresented: $showCameraPicker) {
            CameraPickerResultView(isShown: $showCameraPicker, selectedImage: $selectedImage, navigateToImageReview: $navigateToImageReview)
        }
        .sheet(isPresented: $showPhotoLibraryPicker) {
            PhotoLibraryPickerView(onImageSelected: { image in
                selectedImage = image
                navigateToImageReview = true
            }, onDismiss: {
                showPhotoLibraryPicker = false
            })
        }
        .fullScreenCover(isPresented: $showFoodValueSearch) {
            FoodValueSearchView(loggedFoodItems: $loggedFoodItems)
        }
        .sheet(isPresented: $showFoodLogView) {
            FoodLoggingView(loggedFoodItemsBinding: $loggedFoodItems)
        }
    }

    private func FeatureButton(title: String, systemImage: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack {
                Image(systemName: systemImage)
                    .font(.title)
                Text(title)
                    .fontWeight(.medium)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(BlurView(style: .systemThinMaterialDark))
            .foregroundColor(.white)
            .cornerRadius(20)
            .shadow(color: .blue.opacity(0.6), radius: 10, x: 0, y: 10)
        }
    }
}

struct BlurView: UIViewRepresentable {
    var style: UIBlurEffect.Style

    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}


struct ImageReviewView: View {
    @Binding var selectedImage: UIImage?
    @Binding var responseText: String
    @Binding var loggedFoodItems: [String]
    @State private var isLogged = false

    var body: some View {
        ScrollView {
            VStack {
                if let image = selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding()

                    Button("Submit") {
                        submitImage(image: image)
                    }
                    .buttonStyle(ModernButtonStyle())
                    .padding()

                    Text(responseText)
                        .padding()

                    if !responseText.isEmpty {
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
                        .padding()
                    }
                } else {
                    Text("No image selected")
                        .padding()
                }
            }
        }
        .onAppear {
            isLogged = false
        }
    }

    private func submitImage(image: UIImage) {
        OpenAIManager.shared.analyzeImage(image: image) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.responseText = response
                case .failure(let error):
                    self.responseText = "Error: \(error.localizedDescription)"
                }
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


struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .foregroundColor(.white)
            .frame(height: 50)
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .cornerRadius(10)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



