//
//  SidebarViewControllerTests.swift
//  RobowarsClient-macOSTests
//
//  Created by Volodymyr Myroniuk on 13.10.2022.
//

import XCTest
import Robowars
@testable import RobowarsClient_macOS

final class SidebarViewControllerTests: XCTestCase {
    
    func test_sidebarVC_createsItsView() {
        let sut = SidebarViewController()
        trackForMemoryLeak(sut)
        _ = sut.view
    }
    
    func test_sidebarVC_doesNotInformItsDelegateOnInitIfThereNoRobotsAndGameMode() {
        let delegate = SidebarSpy()
        _ = makeSUT(
            chooseRobotsViewController: ChooseRobotsViewController(),
            chooseGameModeViewController: ChooseGameModeViewController(),
            delegate: delegate)
        
        XCTAssertEqual(delegate.firstRobotDidChangeCallCount, .zero)
        XCTAssertEqual(delegate.secondRobotDidChangeCallCount, .zero)
        XCTAssertEqual(delegate.gameModeDidChangeCallCount, .zero)
    }
    
    func test_sidebarVC_init_informsItsDelegateAboutGameModeChangeIfThereAreGameModesButNoRobots() {
        let delegate = SidebarSpy()
        _ = makeSUT(
            chooseRobotsViewController: ChooseRobotsViewController(),
            chooseGameModeViewController: ChooseGameModeViewController(gameModes: [.classic]),
            delegate: delegate)

        XCTAssertEqual(delegate.firstRobotDidChangeCallCount, .zero)
        XCTAssertEqual(delegate.secondRobotDidChangeCallCount, .zero)
        XCTAssertEqual(delegate.gameModeDidChangeCallCount, 1)
    }
    
    func test_sidebarVC_init_informsItsDelegateAboutRobotsChangeIfThereAreRobotsButNoGameModes() {
        let delegate = SidebarSpy()
        _ = makeSUT(
            chooseRobotsViewController: ChooseRobotsViewController(robots: [DummyRobot()]),
            chooseGameModeViewController: ChooseGameModeViewController(),
            delegate: delegate)

        XCTAssertEqual(delegate.firstRobotDidChangeCallCount, 1)
        XCTAssertEqual(delegate.secondRobotDidChangeCallCount, 1)
        XCTAssertEqual(delegate.gameModeDidChangeCallCount, .zero)
    }
    
    func test_sidebarVC_init_informsItsDelegateAboutRobotsAndGameModesChangeIfThereAreRobotsAndGameModes() {
        let delegate = SidebarSpy()
        _ = makeSUT(
            chooseRobotsViewController: ChooseRobotsViewController(robots: [DummyRobot()]),
            chooseGameModeViewController: ChooseGameModeViewController(gameModes: [.classic]),
            delegate: delegate)

        XCTAssertEqual(delegate.firstRobotDidChangeCallCount, 1)
        XCTAssertEqual(delegate.secondRobotDidChangeCallCount, 1)
        XCTAssertEqual(delegate.gameModeDidChangeCallCount, 1)
    }
    
    func test_sidebarVC_informsItsDelegateAboutManualGameModesChanges() {
        let delegate = SidebarSpy()
        let chooseModeVC = ChooseGameModeViewController(gameModes: [.classic, .flyweight])
        let sut = makeSUT(
            chooseRobotsViewController: ChooseRobotsViewController(robots: [DummyRobot()]),
            chooseGameModeViewController: chooseModeVC,
            delegate: delegate)
        
        _ = sut.view
        _ = chooseModeVC.view
        chooseModeVC.gameModeComboBox.selectItem(at: 1)

        XCTAssertEqual(delegate.firstRobotDidChangeCallCount, 1)
        XCTAssertEqual(delegate.secondRobotDidChangeCallCount, 1)
        XCTAssertEqual(delegate.gameModeDidChangeCallCount, 2)
    }
    
    func test_sidebarVC_informsItsDelegateAboutManualRobotsChanges() {
        let delegate = SidebarSpy()
        let chooseRobotsVC = ChooseRobotsViewController(robots: [DummyRobot(), DummyRobot(), DummyRobot()])
        let sut = makeSUT(
            chooseRobotsViewController: chooseRobotsVC,
            chooseGameModeViewController: ChooseGameModeViewController(gameModes: [.classic, .flyweight]),
            delegate: delegate)
        
        _ = sut.view
        _ = chooseRobotsVC.view
        chooseRobotsVC.firstRobotComboBox.selectItem(at: 1)
        chooseRobotsVC.secondRobotComboBox.selectItem(at: 2)

        XCTAssertEqual(delegate.firstRobotDidChangeCallCount, 2)
        XCTAssertEqual(delegate.secondRobotDidChangeCallCount, 2)
        XCTAssertEqual(delegate.gameModeDidChangeCallCount, 1)
    }
    
    func test_sidebarVC_informsItsDelegateAboutManualRobotsAndGameModeChanges() {
        let delegate = SidebarSpy()
        let chooseRobotsVC = ChooseRobotsViewController(robots: [DummyRobot(), DummyRobot(), DummyRobot()])
        let chooseModeVC = ChooseGameModeViewController(gameModes: [.classic, .flyweight])
        let sut = makeSUT(
            chooseRobotsViewController: chooseRobotsVC,
            chooseGameModeViewController: chooseModeVC,
            delegate: delegate)
        
        _ = sut.view
        _ = chooseRobotsVC.view
        _ = chooseModeVC.view
        chooseRobotsVC.firstRobotComboBox.selectItem(at: 1)
        chooseRobotsVC.secondRobotComboBox.selectItem(at: 2)
        chooseModeVC.gameModeComboBox.selectItem(at: 1)
        chooseRobotsVC.secondRobotComboBox.selectItem(at: .zero)

        XCTAssertEqual(delegate.firstRobotDidChangeCallCount, 2)
        XCTAssertEqual(delegate.secondRobotDidChangeCallCount, 3)
        XCTAssertEqual(delegate.gameModeDidChangeCallCount, 2)
    }

    // MARK: - Helpers
    
    private func makeSUT(
        chooseRobotsViewController: ChooseRobotsViewController,
        chooseGameModeViewController: ChooseGameModeViewController,
        delegate: SidebarViewControllerDelegate
    ) -> SidebarViewController {
        let sut = SidebarViewController(
            chooseRobotsViewController: chooseRobotsViewController,
            chooseGameModeViewController: chooseGameModeViewController,
            delegate: delegate)
                
        trackForMemoryLeak(sut)
        trackForMemoryLeak(chooseRobotsViewController)
        trackForMemoryLeak(chooseGameModeViewController)
        trackForMemoryLeak(delegate)
        
        return sut
    }
    
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
