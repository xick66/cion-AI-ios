//
//  CameraPickerResult.swift
//  cion
//
//  Created by Rahul K M on 29/02/24.
//

import SwiftUI

struct CameraPickerResultView: View {
    @Binding var isShown: Bool
    @State private var showCameraPicker = false
    @State private var image: UIImage?
    @State private var responseText = ""
    @Binding var selectedImage: UIImage?
    @Binding var navigateToImageReview: Bool

    var body: some View {
        VStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }

            if let image = image {
                Button("Submit") {
                    submitImage()
                }
                .padding()
            }
        }
        .fullScreenCover(isPresented: $showCameraPicker) {
            ImagePicker(image: self.$image, sourceType: .camera, isPresented: self.$showCameraPicker)
        }
        .onAppear {
            self.showCameraPicker = true
        }
    }

    private func submitImage() {
        guard let image = image else {
            print("Image is nil")
            return
        }

        selectedImage = image
        navigateToImageReview = true
    }
}

