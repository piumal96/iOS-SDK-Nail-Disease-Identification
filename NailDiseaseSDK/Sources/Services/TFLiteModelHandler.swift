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

    public init(modelName: String) {
        loadModel()
    }
    let frameworkBundle = Bundle(for: TFLiteModelHandler.self)
    
    private func loadModel() {
        guard let modelPath =  frameworkBundle.path(forResource: "model", ofType: "tflite") else {
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
func runInference(inputData: Data) {
    guard let interpreter = interpreter else {
        print("Interpreter is not initialized.")
        return
    }

    do {
        // Validate input tensor size
        let inputTensor = try interpreter.input(at: 0)
        print("Model expects input size: \(inputTensor.shape.dimensions)")

        // Verify input data size matches model requirements
        guard inputData.count == inputTensor.data.count else {
            print("Error: Input data size \(inputData.count) does not match model input size \(inputTensor.data.count)")
            return
        }

        // Copy input data into the interpreter's input tensor
        try interpreter.copy(inputData, toInputAt: 0)

        // Run inference
        try interpreter.invoke()

        // Retrieve the output tensor and convert it to an array of Floats
        let outputTensor = try interpreter.output(at: 0)
        inferenceResult = outputTensor.data.toArray(type: Float.self)
        print("Inference Result: \(inferenceResult)")
    } catch {
        print("Error during inference: \(error.localizedDescription)")
    }
}
}


// Helper extension to convert Data to an array
extension Data {
    func toArray<T>(type: T.Type) -> [T] {
        return self.withUnsafeBytes {
            Array(UnsafeBufferPointer<T>(start: $0.bindMemory(to: T.self).baseAddress, count: self.count / MemoryLayout<T>.stride))
        }
    }
}
