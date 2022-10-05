//
//  ChooseRobotsViewControllerTests.swift
//  RobowarsClient-macOSTests
//
//  Created by Volodymyr Myroniuk on 05.10.2022.
//

import XCTest
@testable import RobowarsClient_macOS

final class ChooseRobotsViewControllerTests: XCTestCase {
    
    func test_chooseRobotsVC_init_createsView() {
        let sut = ChooseRobotsViewController()
        XCTAssertNotNil(sut.view)
    }
}
