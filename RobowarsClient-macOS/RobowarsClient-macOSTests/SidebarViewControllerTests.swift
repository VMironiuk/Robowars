//
//  SidebarViewControllerTests.swift
//  RobowarsClient-macOSTests
//
//  Created by Volodymyr Myroniuk on 13.10.2022.
//

import XCTest
@testable import RobowarsClient_macOS

final class SidebarViewControllerTests: XCTestCase {
    
    func test_sidebarVC_createsItsView() {
        let sut = SidebarViewController()
        _ = sut.view
    }
    
    func test_sidebarVC_doesNotInformItsDelegateOnInitIfThereNoRobotsAndGameMode() {
        let delegate = SidebarSpy()
        let sut = SidebarViewController(
            chooseRobotsViewController: ChooseRobotsViewController(),
            chooseGameModeViewController: ChooseGameModeViewController(),
            delegate: delegate)
        
        XCTAssertEqual(delegate.firstRobotDidChangeCallCount, .zero)
        XCTAssertEqual(delegate.secondRobotDidChangeCallCount, .zero)
        XCTAssertEqual(delegate.gameModeDidChangeCallCount, .zero)
    }
    
    // MARK: - Helpers
    
    private final class SidebarSpy: SidebarViewControllerDelegate {
        private(set) var firstRobotDidChangeCallCount: Int = .zero
        private(set) var secondRobotDidChangeCallCount: Int = .zero
        private(set) var gameModeDidChangeCallCount: Int = .zero
    }
}
