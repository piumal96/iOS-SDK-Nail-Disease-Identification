//
//  ImageProcessorTest.swift
//  NailDiseaseSDKTests
//
//  Created by Piumal Kumara on 2025-03-10.
//

import XCTest
@testable import NailDiseaseSDK

final class ImageProcessorTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func loadTestImage(named imageName: String) -> UIImage? {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: imageName, withExtension: "jpg") else {
            return nil
        }
        guard let data = try? Data(contentsOf: url) else {
            return nil
        }
        return UIImage(data: data)
    }

 
    func testResizeImage() {
        guard let originalImage = loadTestImage(named: "test_image") else {
            XCTFail("Failed to load test image")
            return
        }
        
        let newSize = CGSize(width: 224, height: 224)
        let resizedImage = TFLiteImageProcessor.resize(originalImage, to: newSize)
        
        XCTAssertNotNil(resizedImage, "Resized image should not be nil")
        XCTAssertEqual(resizedImage?.size, newSize, "Resized image size should match the expected size")
    }

    func testConvertToBuffer() {
        guard let image = loadTestImage(named: "test_image") else {
            XCTFail("Failed to load test image")
            return
        }
        
        let buffer = TFLiteImageProcessor.convertToBuffer(image)
        
        XCTAssertNotNil(buffer, "Image buffer should not be nil")
        XCTAssertGreaterThan(buffer!.count, 0, "Buffer should contain data")
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
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
