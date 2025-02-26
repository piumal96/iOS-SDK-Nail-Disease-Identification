//
//  Untitled.swift
//  NailDiseaseSDK
//
//  Created by Piumal Kumara on 2025-02-12.
//

import TensorFlowLite
import Foundation

public class TFLiteTest {
    public static func testPrint() {
        print("✅ TensorFlow Lite is integrated successfully!")
    }
}


public class TFLiteModelHandler {
    private var interpreter: Interpreter?

    public init() {
        loadModel()
    }

    private func loadModel() {
        // Get the correct bundle for the framework
        let frameworkBundle = Bundle(for: TFLiteModelHandler.self)

        // Try to locate the model in the framework bundle
        guard let modelPath = frameworkBundle.path(forResource: "model", ofType: "tflite") else {
            fatalError("Failed to load model.tflite.")
        }

        print(" Model path: \(modelPath)")

        do {
            interpreter = try Interpreter(modelPath: modelPath)
            try interpreter?.allocateTensors()
            print("Model loaded and tensors allocated successfully.")
        } catch {
            fatalError("Failed to create the TensorFlow Lite interpreter: \(error.localizedDescription)")
        }
    }
}
