//
//  NetworkServiceTests.swift
//  WeatherAppTests
//
//  Created by Isaac Iniongun on 17/05/2024.
//

import XCTest
@testable import WeatherApp

final class NetworkServiceTests: XCTestCase {
    
    private var networkService: NetworkService!
    
    override func setUpWithError() throws {
        let urlSession = URLSession(configuration: .mockDefault)
        networkService = NetworkService(urlSession: urlSession)
    }
    
    override func tearDownWithError() throws {
        networkService = nil
        MockURLProtocol.data = nil
        MockURLProtocol.error = nil
        MockURLProtocol.urlResponse = nil
    }
    
    func testMakeRequestValidatesInvalidURLs() throws {
        let expectation = expectation(description: "MakeRequest .invalidURL expectation")
        
        networkService.makeRequest(
            responseType: EmptyTestModel.self,
            requestMethod: .get,
            remotePath: .emptyPath,
            parameters: [:]
        ) { result in
            switch result {
            case .success:
                XCTFail("Shouldn't have succeeded")
            case .failure(let error):
                XCTAssertEqual(error, .invalidURL, "makeRequest should return '.invalidURL' when RemotePath points to an invalid resource")
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testMakeRequestFailure() {
        let expectation = expectation(description: "MakeRequest failure expectation")
        let expectedError = NetworkError.requestFailure(reason: "Bad Network")
        MockURLProtocol.error = expectedError
        
        networkService.makeRequest(
            responseType: EmptyTestModel.self,
            requestMethod: .get,
            remotePath: .currentWeather,
            parameters: [:]
        ) { result in
            switch result {
            case .success:
                XCTFail("Shouldn't have succeeded")
            case .failure(let error):
                XCTAssertNotNil(error, "makeRequest should return '.requestFailure'")
                XCTAssertEqual(error.localizedDescription, expectedError.localizedDescription, "makeRequest should return consistent error message")
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testMakeRequestDecodingError() {
        let expectation = expectation(description: "makeRequest decoding expectation")
        let jsonData = "{\"status\":200, \"message\":\"Invalid JSON\"}".data(using: .utf8)
        MockURLProtocol.data = jsonData
        
        networkService.makeRequest(
            responseType: SuccessTestModel.self,
            requestMethod: .get,
            remotePath: .currentWeather,
            parameters: [:]
        ) { result in
            switch result {
            case .success:
                XCTFail("Shouldn't have succeeded")
            case .failure(let error):
                XCTAssertNotNil(error, "there should be an error")
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testMakeRequestSuccess() {
        let expectation = expectation(description: "makeRequest expectation")
        let jsonData = "{\"success\":true}".data(using: .utf8)
        MockURLProtocol.data = jsonData
        
        networkService.makeRequest(
            responseType: SuccessTestModel.self,
            requestMethod: .get,
            remotePath: .currentWeather,
            parameters: [:]
        ) { result in
            switch result {
            case .success(let response):
                XCTAssertTrue(response.success, "'response.success' should be true")
                expectation.fulfill()
            case .failure:
                XCTFail("Shouldn't have failed")
            }
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testMakeRequestResourceNotFound() {
        let expectation = expectation(description: "makeRequest expectation")
        let urlResponse = HTTPURLResponse(
            url: .google1,
            statusCode: 400,
            httpVersion: nil,
            headerFields: nil
        )
        MockURLProtocol.urlResponse = urlResponse
        
        networkService.makeRequest(
            responseType: SuccessTestModel.self,
            requestMethod: .get,
            remotePath: .currentWeather,
            parameters: [:]
        ) { result in
            switch result {
            case .success:
                XCTFail("Shouldn't have succeeded")
            case .failure(let error):
                XCTAssertEqual(error, .resourceNotFound, "error should be '.resourceNotFound'")
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testMakeRequestServerFailure() {
        let expectation = expectation(description: "makeRequest expectation")
        let urlResponse = HTTPURLResponse(
            url: .google1,
            statusCode: 500,
            httpVersion: nil,
            headerFields: nil
        )
        MockURLProtocol.urlResponse = urlResponse
        
        networkService.makeRequest(
            responseType: SuccessTestModel.self,
            requestMethod: .get,
            remotePath: .currentWeather,
            parameters: [:]
        ) { result in
            switch result {
            case .success:
                XCTFail("Shouldn't have succeeded")
            case .failure(let error):
                XCTAssertEqual(error, .serverFailure, "error should be '.serverFailure'")
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
}
