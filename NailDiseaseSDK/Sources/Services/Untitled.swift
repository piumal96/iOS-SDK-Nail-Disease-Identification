//
//  Untitled.swift
//  NailDiseaseSDK
//
//  Created by Piumal Kumara on 2025-02-12.
//

import TensorFlowLite
import Foundation

class TFLiteModelHandler: ObservableObject {
    @Published var inferenceResult: [Float] = []

    private var interpreter: Interpreter?
    private var modelFileName: String

    init(modelFileName: String = "model") {
        self.modelFileName = modelFileName
        loadModel()
    }

    private func loadModel() {
        guard let modelPath = Bundle.main.path(forResource: modelFileName, ofType: "tflite") else {
            print("Failed to load model.tflite. Ensure the file exists in your Xcode project and is added to the Copy Bundle Resources.")
            return
        }

        do {
            interpreter = try Interpreter(modelPath: modelPath)
            try interpreter?.allocateTensors()
            print("Model loaded and tensors allocated successfully.")
        } catch {
            print("Failed to create the TensorFlow Lite interpreter: \(error)")
        }
    }

    func runInference(inputData: Data) throws {
        guard let interpreter = interpreter else {
            throw NSError(domain: "TFLiteModelHandler", code: 1, userInfo: [NSLocalizedDescriptionKey: "Interpreter is not initialized."])
        }

        do {
            let inputTensor = try interpreter.input(at: 0)
            guard inputData.count == inputTensor.data.count else {
                throw NSError(domain: "TFLiteModelHandler", code: 2, userInfo: [NSLocalizedDescriptionKey: "Input data size does not match model input size."])
            }

            try interpreter.copy(inputData, toInputAt: 0)
            try interpreter.invoke()
            let outputTensor = try interpreter.output(at: 0)
            inferenceResult = outputTensor.data.toArray(type: Float.self)
        } catch {
            throw error
        }
    }
}

extension Data {
    func toArray<T>(type: T.Type) -> [T] {
        return self.withUnsafeBytes {
            Array(UnsafeBufferPointer<T>(start: $0.bindMemory(to: T.self).baseAddress, count: self.count / MemoryLayout<T>.stride))
        }
    }
}
