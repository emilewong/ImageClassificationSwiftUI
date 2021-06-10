//
//  OCRReader.swift
//  ImageClassificationSwiftUI
//
//  Created by Emile Wong on 19/5/2021.
//

import SwiftUI
import TesseractOCR

struct OCRReader: View {
    // MARK: - PROPERTIES
    @State private var showSheet: Bool = false
    @State private var showPhotoOptions: Bool = false
    @State private var image: UIImage?
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    @State private var classificationLabel: String = ""
    @State private var confidencelabel: String = ""
    
//    let operationQueue = OperationQueue()
//
//    weak var imageToRecognize: UIImageView!
//    weak var activityIndicator :UIActivityIndicatorView!
    
    // MARK: - FUNCTION
    
//    func recognizeImageWithTesseract(image: UIImage) {
//        // Animate a progress activity indicator
//        //[self.activityIndicator startAnimating];
//
//        // Create a new `G8RecognitionOperation` to perform the OCR asynchronously
//        // It is assumed that there is a .traineddata file for the language pack
//        // you want Tesseract to use in the "tessdata" folder in the root of the
//        // project AND that the "tessdata" folder is a referenced folder and NOT
//        // a symbolic group in your project
//
//        guard let operation = G8RecognitionOperation(language: "eng") else { return }
//
//        // Use the original Tesseract engine mode in performing the recognition
//        // (see G8Constants.h) for other engine mode options
//        operation.tesseract.engineMode = .tesseractOnly
//
//        // Let Tesseract automatically segment the page into blocks of text
//        // based on its analysis (see G8Constants.h) for other page segmentation
//        // mode options
//        operation.tesseract.pageSegmentationMode = .autoOnly
//
//        // Optionally limit the time Tesseract should spend performing the
//        // recognition
//        //operation.tesseract.maximumRecognitionTime = 1.0
//
//        // Set the delegate for the recognition to be this class
//        // (see `progressImageRecognitionForTesseract` and
//        // `shouldCancelImageRecognitionForTesseract` methods below)
//        //operation.delegate = self
//
//        // Optionally limit Tesseract's recognition to the following whitelist
//        // and blacklist of characters
//        //operation.tesseract.charWhitelist = "01234"
//        //operation.tesseract.charBlacklist = "56789"
//
//        // Set the image on which Tesseract should perform recognition
//        operation.tesseract.image = image;
//
//        // Optionally limit the region in the image on which Tesseract should
//        // perform recognition to a rectangle
//        //operation.tesseract.rect = CGRect(x: 20, y: 20, width: 100, height: 140)
//
//        // Specify the function block that should be executed when Tesseract
//        // finishes performing recognition on the image
//        operation.recognitionCompleteBlock =  { (tesseract : G8Tesseract?) in
//
//            // Fetch the recognized text
//            let recognizedText = tesseract?.recognizedText
//
//            // Remove the animated progress activity indicator
//            self.activityIndicator.stopAnimating()
//
//            let alertController = UIAlertController(title: "OCR Result", message: recognizedText, preferredStyle: .alert)
//
//
//            let alertAction = UIAlertAction(title: "Ok", style: .default)
//
//            alertController.addAction(alertAction)
//
//            //            self.present(alertController, animated: true)
//        };
//
//        // Display the image to be recognized in the view
//        self.imageToRecognize.image = operation.tesseract.thresholdedImage
//
//        // Finally, add the recognition operation to the queue
//        self.operationQueue.addOperation(operation)
//    }
    
    
    // MARK: - BODY
    var body: some View {
    
        VStack{
            VStack {
                HStack {
                    Text("OCR Reader")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                        .padding(.leading, 40)
                    Spacer()
                    
                    Button(action: {
                        self.showSheet = true
                    }, label: {
                        Image(systemName: "photo.fill")
                            .resizable()
                            .frame(width: 25, height: 25, alignment: .topTrailing)
                            .padding(.top, 10)
                            .padding(.trailing, 12)
                    }) //: BUTTON
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
                    
                    
                }
                
                Image(uiImage: image ?? UIImage(named: "placeholder")!)
                    .resizable()
//                    .frame(width: 375, height: 485, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .aspectRatio(contentMode: .fit)
                    .padding(10)
                
                Spacer()
                
            } //: VSTACK
            .sheet(isPresented: $showPhotoOptions) {
                ImagePicker(image: self.$image, isShown: self.$showPhotoOptions, sourceType: self.sourceType)
            } //: SHEET
        } //: VSTACK
        Spacer()
    } //: VIEW
}



// MARK: - PREVIEW
struct OCRReader_Previews: PreviewProvider {
    static var previews: some View {
        OCRReader()
    }
}
