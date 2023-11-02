//
//  GuestImage.swift
//  TimeAndClock
//
//  Created by Eky on 01/11/23.
//

import Foundation

import UIKit
import CoreML
import Vision

class GuestImage {
    
    static let shared = GuestImage()
        
    private init() {}

    private var model: MLModel?

    func initModel() {
        
//        guard Bundle.main.url(forResource: "SqueezeNetFP16", withExtension: "mlmodel") != nil else {
//            print("Cannot find mlmodel")
//            return
//        }
//
//        if let modelUrl = Bundle.main.url(forResource: "SqueezeNetFP16", withExtension: "mlmodel") {
//            do {
//                let modelc = try MLModel.compileModel(at: modelUrl)
//                self.model = try MLModel.init(contentsOf: modelc)
//                print("Success load model")
//                return
//            } catch {
//                print(error)
//                return
//            }
//        }
        
        let defaultConfig = MLModelConfiguration()
        let squeezeNet = try? SqueezeNetFP16(configuration: defaultConfig)
        
        guard let imageClassifier = squeezeNet else {
            fatalError("App failed to create an image classifier model instance.")
        }

        // Get the underlying model instance.
        model = imageClassifier.model
    }
    
    func processImage(image cgImage: CGImage) -> String? {
        
        do {
            if (model != nil) {
                let imageConstraint = model!.modelDescription.inputDescriptionsByName["image"]!.imageConstraint!
                            
                let imageOptions: [MLFeatureValue.ImageOption: Any] = [
                    .cropAndScale: VNImageCropAndScaleOption.scaleFill.rawValue
                ]
                
                let featureValue = try MLFeatureValue(cgImage: cgImage, constraint: imageConstraint, options: imageOptions)
                let featureProviderDict = try MLDictionaryFeatureProvider(dictionary: ["image" : featureValue])
                let prediction = try model!.prediction(from: featureProviderDict)
                let value = prediction.featureValue(for: "classLabel")?.stringValue
                
                prediction.featureNames.forEach() { name in
                    let val = prediction.featureValue(for: name)?.stringValue
                    print(val!)
                }
                
                return value
            } else {
                print("Model is not initilize")
                return nil
            }
        } catch {
            return nil
        }
    }
    
//    private func loadCGImage(fromPath path: String) -> CGImage? {
//        let fileURL = URL(fileURLWithPath: path)
//
//        guard let imageSource = CGImageSourceCreateWithURL(fileURL as CFURL, nil) else {
//            print("Failed to create image source from file: \(path)")
//            return nil
//        }
//
//        guard let cgImage = CGImageSourceCreateImageAtIndex(imageSource, 0, nil) else {
//            print("Failed to create CGImage from image source: \(path)")
//            return nil
//        }
//
//        return cgImage
//    }
}
