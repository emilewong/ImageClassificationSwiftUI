//
//  NavigationContentView.swift
//  ImageClassificationSwiftUI
//
//  Created by Emile Wong on 15/5/2021.
//

import SwiftUI

struct NavigationContentView: View {
    // MARK: - PROPERTIES
    
    
    // MARK: - BODY
    var body: some View {
        
        NavigationView {
            VStack {
                NavigationLink(
                    destination: MobileNetV2View(),
                    label: {
                        Text("MobileNet V2")
                    }).padding()
                
                NavigationLink(
                    destination: FruitClassifier(),
                    label: {
                        Text("Fruit Classifier")
                    })
                    .padding()
                
                NavigationLink(
                    destination: OCRReader(),
                    label: {
                        Text("OCR Reader")
                    })
                    .padding()
                
            } //: VASTACK
            .navigationTitle("iOS Machine Learning")
            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            .padding()
            
        } //: NAVIGATION
        
    }
}
// MARK: - PREVIEW
struct NavigationContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationContentView()
    }
}
