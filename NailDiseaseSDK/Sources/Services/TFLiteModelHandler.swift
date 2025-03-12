//
//  Untitled.swift
//  NailDiseaseSDK
//
//  Created by Piumal Kumara on 2025-02-12.
//

import TensorFlowLite
import Foundation
import Combine

public class TFLiteTest {
    public static func testPrint() {
        print("✅ TensorFlow Lite is integrated successfully!")
    }
}

public class TFLiteModelHandler: ObservableObject {
    @Published public var inferenceResult: [Float] = []
    private var interpreter: Interpreter?
    
    // Class labels for the model
    private let labels = [
        "Acral Lentiginous Melanoma",
        "Blue Finger",
        "Clubbing",
        "Healthy Nail",
        "Onychogryphosis",
        "Pitting"
    ]
    public init(modelName: String) {
        loadModel()
    }
    let frameworkBundle = Bundle(for: TFLiteModelHandler.self)

    private func loadModel() {
        guard let modelPath = frameworkBundle.path(forResource: "model", ofType: "tflite") else {
            fatalError("Failed to load model.tflite. Ensure the file exists in your Xcode project and is added to the Copy Bundle Resources.")
        }

        print("Model path: \(modelPath)")

        do {
            interpreter = try Interpreter(modelPath: modelPath)
            try interpreter?.allocateTensors()
            print("Model loaded and tensors allocated successfully.")
        } catch {
            fatalError("Failed to create the TensorFlow Lite interpreter: \(error.localizedDescription)")
        }
    }

    /// Runs inference on input data and updates `inferenceResult`
    public func runInference(inputData: Data) {
        guard let interpreter = interpreter else {
            print("Interpreter is not initialized.")
            return
        }
        
        do {
            let inputTensor = try interpreter.input(at: 0)
            print("Model expects input size: \(inputTensor.shape.dimensions)")
            
            guard inputData.count == inputTensor.data.count else {
                print("Error: Input data size \(inputData.count) does not match model input size \(inputTensor.data.count)")
                return
            }

            try interpreter.copy(inputData, toInputAt: 0)
            try interpreter.invoke()

            let outputTensor = try interpreter.output(at: 0)

            // ✅ Fix: Ensure UI updates are done on the main thread
            DispatchQueue.main.async {
                self.inferenceResult = outputTensor.data.toArray(type: Float.self)
                print("Inference Result: \(self.inferenceResult)")
            }

        } catch {
            print("Error during inference: \(error.localizedDescription)")
        }
    }

    
    /// Returns the predicted label based on inference results
    public func getInferenceLabel() -> String {
        guard !inferenceResult.isEmpty else {
            return "No inference result available"
        }

        // Ensure the number of labels matches the result length
        guard labels.count == inferenceResult.count else {
            print("Warning: Label count (\(labels.count)) does not match result count (\(inferenceResult.count)).")
            return "Label mismatch error"
        }

        // Find the index of the highest probability
        guard let maxIndex = inferenceResult.firstIndex(of: inferenceResult.max() ?? 0) else {
            return "Unknown result"
        }

        return labels[maxIndex]
    }
}

extension Data {
    func toArray<T>(type: T.Type) -> [T] {
        return self.withUnsafeBytes {
            Array(UnsafeBufferPointer<T>(start: $0.bindMemory(to: T.self).baseAddress, count: self.count / MemoryLayout<T>.stride))
        }
    }
}
