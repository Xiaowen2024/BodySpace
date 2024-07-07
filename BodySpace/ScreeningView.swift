//
//  ScreeningView.swift
//  BodySpace
//
//  Created by Xiaowen Yuan on 7/6/24.
//

import SwiftUI
import PhotosUI
import Photos

struct ScreeningView: View {
    @State private var selectedImage: UIImage?
    @State private var showLibrary = false
    @State private var isAuthorized = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    func requestPhotoLibraryAuthorization() {
            PHPhotoLibrary.requestAuthorization { status in
                DispatchQueue.main.async {
                    switch status {
                    case .authorized:
                        // Permission granted
                        isAuthorized = true
                        addDefaultImagesToLibrary()
                    case .denied, .restricted, .notDetermined:
                        // Handle other cases
                        alertMessage = "Photo library access is required to add default images."
                        showAlert = true
                    @unknown default:
                        fatalError("Unknown authorization status")
                    }
                }
            }
    }
    
    
    
    func addDefaultImagesToLibrary() {
        let imageNames = ["defaultImage"]

        for imageName in imageNames {
            if let image = UIImage(named: imageName) {
                PHPhotoLibrary.shared().performChanges({
                    let request = PHAssetChangeRequest.creationRequestForAsset(from: image)
                }) { success, error in
                    if success {
                        print("\(imageName) added to photo library")
                    } else if let error = error {
                        print("Error adding \(imageName) to photo library: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
                   VStack {
                       if let selectedImage = selectedImage {
                           Spacer(minLength: 10)
                           Image(uiImage: selectedImage)
                               .resizable()
                               .scaledToFit()
                               .frame(width: geometry.size.width/4 * 3, height: geometry.size.height/3 * 2)
                       } else {
                           Spacer(minLength: 10)
                           Image("defaultImage")
                               .resizable()
                               .scaledToFit()
                               .frame(width: geometry.size.width/4 * 3, height: geometry.size.height/3 * 2)
                       }
                       
                       Spacer() // Push content to the bottom

                       VStack {
                           Spacer() // Center horizontally

                           Text("Select photo")
                               .font(.headline)
                               .frame(maxWidth: geometry.size.width / 6)
                               .frame(height: 40)
                               .background(Color.blue)
                               .cornerRadius(16)
                               .foregroundColor(.white)
                               .onTapGesture {
                                   showLibrary = true
                               }

                           Spacer() 
                           Text("Start Analysis")
                               .font(.headline)
                               .frame(maxWidth: geometry.size.width / 6)
                               .frame(height: 40)
                               .background(Color.blue)
                               .cornerRadius(16)
                               .foregroundColor(.white)
                               .onTapGesture {
                                   showLibrary = true
                               }

                       }
                       .padding(.horizontal, 20)
                       .sheet(isPresented: $showLibrary) {
                           // Pick an image from the photo library:
                           ImagePicker(sourceType: .photoLibrary, selectedImage: self.$selectedImage)

                           //  If you wish to take a photo from camera instead:
                           // ImagePicker(sourceType: .camera, selectedImage: self.$image)
                       }

                       Spacer(minLength: geometry.size.height/8 ) // Optional: Add some space at the bottom if needed
                   }
                   .frame(width: geometry.size.width)
//                   .onAppear {
//                              requestPhotoLibraryAuthorization()
//                          }
//                          .alert(isPresented: $showAlert) {
//                              Alert(title: Text("Permission Denied"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
//                          }
               }
               .edgesIgnoringSafeArea(.all)
    }
        
}

struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) private var presentationMode
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @Binding var selectedImage: UIImage?

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {

        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator

        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {

    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

        var parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.selectedImage = image
            }

            parent.presentationMode.wrappedValue.dismiss()
        }

    }
}

#Preview {
    ScreeningView()
}
