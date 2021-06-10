//
//  MobileNetV2View.swift
//  ImageClassificationSwiftUI
//
//  Created by Emile Wong on 15/5/2021.
//

import SwiftUI
import CoreML

struct MobileNetV2View: View {
    // MARK: - PROPERTIES
    @State private var currentIndex: Int = 0
    @State private var classificationLabel: String = ""
    @State private var confidenceLabel: String = ""
    
    let photos = ["banana","tiger","bottle", "dog", "cat", "banana", "apple", "avocado"]
    
    let model: MobileNetV2 = {
        do {
            let config = MLModelConfiguration()
            return try MobileNetV2(configuration: config)
        } catch {
            print(error)
            fatalError("Couldn't create MobileNetV2")
        }
    }()

    private func performImageClassification() {
        let currentImageName = photos[currentIndex]
        
        guard let img = UIImage(named: currentImageName),
              case let resizedImage = img.resizeTo(size: CGSize(width: 224, height: 224)),
              let buffer = resizedImage.toBuffer() else {
            return
        }
        
        let output = try? model.prediction(image: buffer)
        
        if let output = output {
            //            self.classificationLabel = output.classLabel
            let results = output.classLabelProbs.sorted{ $0.1 > $1.1}
            
            classificationLabel = "\(results[0].key)"
            confidenceLabel = "\(results[0].value * 100)% confidence"
        }
        
        
    }

    // MARK: - BODY
    var body: some View {
        
        VStack {
            Image(photos[currentIndex])
                .resizable()
                .frame(width: 200, height: 200)
            HStack {
                Spacer()
                Button(action: {
                    if self.currentIndex >= self.photos.count {
                        self.currentIndex = self.currentIndex - 1
                    } else {
                        self.currentIndex = 0
                    }
                }, label: {
                    Image(systemName: "arrow.backward")
                })
                .font(.largeTitle)
                .padding()
                .foregroundColor(Color.white)
                .frame(width: 100)
                .background(Color.orange)
                .cornerRadius(10)
                
                
                Spacer()
                
                Button(action: {
                    if self.currentIndex < self.photos.count - 1 {
                        self.currentIndex = self.currentIndex + 1
                    } else {
                        self.currentIndex = 0
                    }
                }, label: {
                    Image(systemName: "arrow.forward")
                })
                .font(.largeTitle)
                .padding()
                .foregroundColor(Color.white)
                .frame(width: 100)
                .background(Color.orange)
                .cornerRadius(10)
                
                Spacer()
                
                
            }.padding()
            
            Button(action: {
                // classify the image here
                performImageClassification()
                
            }, label: {
                Text("Classify")
            })
            .font(.title)
            .padding()
            .foregroundColor(Color.white)
            .frame(width: 200)
            .background(Color.blue)
            .cornerRadius(10)
            
            Text(classificationLabel)
                .font(.caption2)
                .padding()
            Text(confidenceLabel)
                .font(.headline)
                .padding()
        }
    }
}

// MARK: - PREVIEW
struct MobileNetV2View_Previews: PreviewProvider {
    static var previews: some View {
        MobileNetV2View()
    }
}
