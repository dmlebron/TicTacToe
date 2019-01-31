//
//  MarkTests.swift
//  TicTacToeTests
//
//  Created by david martinez on 1/29/19.
//  Copyright © 2019 dmlebron. All rights reserved.
//

import XCTest
@testable import TicTacToe

class MarkTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func test_Image_X() {
        let mark = Mark.x
        let image = mark.image
        
        XCTAssertTrue(image == UIImage.x)
    }
    
    func test_Image_O() {
        let mark = Mark.o
        let image = mark.image
        
        XCTAssertTrue(image == UIImage.o)
    }

}
