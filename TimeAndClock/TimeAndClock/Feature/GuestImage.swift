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
        
    private init() {
        
    }

    private var model: MLModel?

    func initModel() -> Void {
        guard let modelPath = Bundle.main.url(forResource: "yolo", withExtension: "mlmodel") else {
            print("Cannot find YOLO mlmodel")
            return
        }
        print("Success find YOLO mlmodel")
        do {
            let modelc = try MLModel.compileModel(at: modelPath)
            self.model = try MLModel.init(contentsOf: modelc)
            print("Success load model")
            return
        } catch {
            print(error)
            return
        }
    }
    
    func processImage(image: UIImage) -> String? {
        
        guard let cgImage = image.cgImage else {
            print("Failed to load image")
            return nil
        }
        
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
                
                return value ?? "nil"
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
