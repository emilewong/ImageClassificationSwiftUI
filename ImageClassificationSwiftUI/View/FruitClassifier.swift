//
//  FruitClassifier.swift
//  ImageClassificationSwiftUI
//
//  Created by Emile Wong on 15/5/2021.
//

import SwiftUI
import UIKit
import CoreML
import Vision


struct FruitClassifier: View {
    // MARK: - PROPERTIES
    @State private var showSheet: Bool = false
    @State private var showPhotoOptions: Bool = false
    @State private var image: UIImage?
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    @State private var classificationLabel: String = ""
    @State private var confidencelabel: String = ""
    
    
    
    let model: AllFruitClassifierModel = {
        do {
            let config = MLModelConfiguration()
            return try AllFruitClassifierModel(configuration: config)
        } catch {
            print(error)
            fatalError("Couldn't create AllFruitClassifierModel")
        }
    }()
    
 
    // MARK: - BODY
    var body: some View {
        
        NavigationView {
            
            VStack {
                Spacer()
                Image(uiImage: image ?? UIImage(named: "placeholder")!)
                    .resizable()
                    .frame(width: 300, height: 300)
                
                Button("Choose Picture") {
                    // open action sheet
                    self.showSheet = true
                    
                } //: BUTTON
                .padding()
                .foregroundColor(Color.white)
                .background(Color.gray)
                .cornerRadius(10)
                .actionSheet(isPresented: $showSheet) {
                    ActionSheet(title: Text("Select Photo"), message: Text("Choose"), buttons: [
                        .default(Text("Photo Library")) {
                            // open photo library
                            self.showPhotoOptions = true
                            self.sourceType = .photoLibrary
                        },
                        .default(Text("Camera")) {
                            // open camera
                            self.showPhotoOptions = true
                            self.sourceType = .camera
                        },
                        .cancel()
                    ])
                    
                } //: ACTION SHEET
                
                Text(classificationLabel)
                    .font(.largeTitle)
                    .padding(.top, 80)
                
                Spacer()
                
                Button("Classify") {
                    
                    // perform image classification
                    guard let img = image,
                          case let resizedImage = img.resizeTo(size: CGSize(width: 224, height: 224)),
                          let buffer = resizedImage.toBuffer() else {
                        return
                    }
                    
                    let output = try? model.prediction(image: buffer)
                    
                    if let output = output {
                        //            self.classificationLabel = output.classLabel
                        let results = output.classLabelProbs.sorted{ $0.1 > $1.1}
                        
                        classificationLabel = "\(results[0].key)"
                        confidencelabel = "\(results[0].value * 100)% confidence"
                    }
                } //: Button
                .padding()
                .foregroundColor(Color.white)
                .background(Color.green)
                .cornerRadius(10)
                
                Text(classificationLabel)
                    .font(.caption2)
                    .padding()
                Text(confidencelabel)
                    .font(.headline)
                    .padding()
                
            } //: VSTACK
            .navigationBarTitle("Image Classification")
        } //: NAVIGATION
        .sheet(isPresented: $showPhotoOptions) {
            ImagePicker(image: self.$image, isShown: self.$showPhotoOptions, sourceType: self.sourceType)
        } //: SHEET
    } //: VIEW
}

// MARK: - PREVIEW
struct FruitClassifier_Previews: PreviewProvider {
    static var previews: some View {
        FruitClassifier()
    }
}
