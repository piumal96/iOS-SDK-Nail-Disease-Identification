//
//  NailDiseaseSDKTests.swift
//  NailDiseaseSDKTests
//
//  Created by Piumal Kumara on 2025-03-12.
//

import XCTest
@testable import NailDiseaseSDK
final class NailDiseaseSDKTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testModelLoading() {
        let frameworkBundle = Bundle(for: NailDiseaseClassifier.self)
        let modelPath = frameworkBundle.path(forResource: "model", ofType: "tflite")

        XCTAssertNotNil(modelPath, " model.tflite is missing in the bundle!")

        // Now, attempt to initialize the model handler
        let modelHandler = NailDiseaseClassifier()
        XCTAssertNotNil(modelHandler, " TFLiteModelHandler failed to initialize!")
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
