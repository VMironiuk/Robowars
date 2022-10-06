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
        let sut = ChooseRobotsViewController(robots: [])
        XCTAssertNotNil(sut.view)
    }
    
    func test_chooseRobotsVC_doesNotInformDelegateIfNoRobots() {
        let sut = ChooseRobotsViewController(robots: [])
        let chooseRobotsSpy = ChooseRobotsSpy()
        
        _ = sut.view
        sut.delegate = chooseRobotsSpy
        
        XCTAssertTrue(chooseRobotsSpy.firstRobotDidChangeCallCount == .zero)
        XCTAssertTrue(chooseRobotsSpy.secondRobotDidChangeCallCount == .zero)
    }
    
    // MARK: - Helpers
    
    private final class ChooseRobotsSpy: ChooseRobotsViewControllerDelegate {
        private(set) var firstRobotDidChangeCallCount: Int = .zero
        private(set) var secondRobotDidChangeCallCount: Int = .zero
    }
}
