//
//  SidebarViewControllerTests.swift
//  RobowarsClient-macOSTests
//
//  Created by Volodymyr Myroniuk on 13.10.2022.
//

import XCTest
@testable import Robowars
@testable import RobowarsClient_macOS

final class SidebarViewControllerTests: XCTestCase {
    
    func test_sidebarVC_createsItsView() {
        let sut = SidebarViewController()
        _ = sut.view
    }
    
    func test_sidebarVC_doesNotInformItsDelegateOnInitIfThereNoRobotsAndGameMode() {
        let delegate = SidebarSpy()
        _ = SidebarViewController(
            chooseRobotsViewController: ChooseRobotsViewController(),
            chooseGameModeViewController: ChooseGameModeViewController(),
            delegate: delegate)
        
        XCTAssertEqual(delegate.firstRobotDidChangeCallCount, .zero)
        XCTAssertEqual(delegate.secondRobotDidChangeCallCount, .zero)
        XCTAssertEqual(delegate.gameModeDidChangeCallCount, .zero)
    }
    
    func test_sidebarVC_init_informsItsDelegateAboutGameModeChangeIfThereAreGameModesButNoRobots() {
        let delegate = SidebarSpy()
        _ = SidebarViewController(
            chooseRobotsViewController: ChooseRobotsViewController(),
            chooseGameModeViewController: ChooseGameModeViewController(gameModes: [.classic]),
            delegate: delegate)
        
        XCTAssertEqual(delegate.firstRobotDidChangeCallCount, .zero)
        XCTAssertEqual(delegate.secondRobotDidChangeCallCount, .zero)
        XCTAssertEqual(delegate.gameModeDidChangeCallCount, 1)
    }
    
    // MARK: - Helpers
    
    private final class SidebarSpy: SidebarViewControllerDelegate {
        private(set) var firstRobotDidChangeCallCount: Int = .zero
        private(set) var secondRobotDidChangeCallCount: Int = .zero
        private(set) var gameModeDidChangeCallCount: Int = .zero
        
        func sidebarViewController(
            _ viewController: SidebarViewController,
            firstRobotDidChange robot: RobotProtocol
        ) {
            firstRobotDidChangeCallCount += 1
        }
        
        func sidebarViewController(
            _ viewController: SidebarViewController,
            secondRobotDidChange robot: RobotProtocol
        ) {
            secondRobotDidChangeCallCount += 1
        }
        
        func sidebarViewController(
            _ viewController: SidebarViewController,
            gameModeDidChange robot: GameMode
        ) {
            gameModeDidChangeCallCount += 1
        }
    }
}
