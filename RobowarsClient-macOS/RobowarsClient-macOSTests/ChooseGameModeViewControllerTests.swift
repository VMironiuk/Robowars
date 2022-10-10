//
//  ChooseGameModeViewControllerTests.swift
//  RobowarsClient-macOSTests
//
//  Created by Volodymyr Myroniuk on 08.10.2022.
//

import XCTest
@testable import RobowarsClient_macOS

final class ChooseGameModeViewControllerTests: XCTestCase {
    
    func test_chooseGameModeVC_init_createsView() {
        let sut = ChooseGameModeViewController()
        XCTAssertNotNil(sut.view)
    }
}
