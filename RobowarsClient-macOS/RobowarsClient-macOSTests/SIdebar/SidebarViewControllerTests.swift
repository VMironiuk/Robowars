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
            chooseRobotsViewController: ChooseRobotsViewController(robots: []),
            chooseGameModeViewController: ChooseGameModeViewController(gameModes: []),
            delegate: delegate)
        
        XCTAssertEqual(delegate.firstRobotDidChangeCallCount, .zero)
        XCTAssertEqual(delegate.secondRobotDidChangeCallCount, .zero)
        XCTAssertEqual(delegate.gameModeDidChangeCallCount, .zero)
    }
    
    func test_sidebarVC_init_informsItsDelegateAboutGameModeChangeIfThereAreGameModesButNoRobots() {
        let delegate = SidebarSpy()
        _ = makeSUT(
            chooseRobotsViewController: ChooseRobotsViewController(robots: []),
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
            chooseGameModeViewController: ChooseGameModeViewController(gameModes: []),
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
    
    func test_sidebarVC_init_delegateReceivesCorrectRobotsAndGameMode() {
        let robots: [RobotProtocol] = [DummyRobot(name: "r1"), DummyRobot(name: "r2"), DummyRobot(name: "r3")]
        let gameModes: [GameMode] = [.classic, .flyweight]
        let delegate = SidebarSpy()
        _ = makeSUT(
            chooseRobotsViewController: ChooseRobotsViewController(robots: robots),
            chooseGameModeViewController: ChooseGameModeViewController(gameModes: gameModes),
            delegate: delegate)
        
        XCTAssertEqual(robots[.zero].name, delegate.firstRobot!.name)
        XCTAssertEqual(robots[.zero].name, delegate.secondRobot!.name)
        XCTAssertEqual(gameModes[.zero], delegate.gameMode!)
    }
    
    func test_sidebarVC_delegateReceivesCorrectFirstRobotOnManualFirstRobotChange() {
        let robots: [RobotProtocol] = [DummyRobot(name: "r1"), DummyRobot(name: "r2"), DummyRobot(name: "r3")]
        let chooseRobotsVC = ChooseRobotsViewController(robots: robots)
        let gameModes: [GameMode] = [.classic, .flyweight]
        let delegate = SidebarSpy()
        let sut = makeSUT(
            chooseRobotsViewController: chooseRobotsVC,
            chooseGameModeViewController: ChooseGameModeViewController(gameModes: gameModes),
            delegate: delegate)
        
        _ = sut.view
        _ = chooseRobotsVC.view
        chooseRobotsVC.firstRobotComboBox.selectItem(at: 1)
        
        XCTAssertEqual(robots[1].name, delegate.firstRobot!.name)
        XCTAssertEqual(robots[.zero].name, delegate.secondRobot!.name)
        XCTAssertEqual(gameModes[.zero], delegate.gameMode!)
    }
    
    func test_sidebarVC_delegateReceivesCorrectSecondRobotOnManualSecondRobotChange() {
        let robots: [RobotProtocol] = [DummyRobot(name: "r1"), DummyRobot(name: "r2"), DummyRobot(name: "r3")]
        let chooseRobotsVC = ChooseRobotsViewController(robots: robots)
        let gameModes: [GameMode] = [.classic, .flyweight]
        let delegate = SidebarSpy()
        let sut = makeSUT(
            chooseRobotsViewController: chooseRobotsVC,
            chooseGameModeViewController: ChooseGameModeViewController(gameModes: gameModes),
            delegate: delegate)
        
        _ = sut.view
        _ = chooseRobotsVC.view
        chooseRobotsVC.secondRobotComboBox.selectItem(at: 2)
        
        XCTAssertEqual(robots[.zero].name, delegate.firstRobot!.name)
        XCTAssertEqual(robots[2].name, delegate.secondRobot!.name)
        XCTAssertEqual(gameModes[.zero], delegate.gameMode!)
    }
    
    func test_sidebarVC_delegateReceivesCorrectGameModeOnManualGameModeChange() {
        let robots: [RobotProtocol] = [DummyRobot(name: "r1"), DummyRobot(name: "r2"), DummyRobot(name: "r3")]
        let gameModes: [GameMode] = [.classic, .flyweight]
        let chooseGameModeVC = ChooseGameModeViewController(gameModes: gameModes)
        let delegate = SidebarSpy()
        let sut = makeSUT(
            chooseRobotsViewController: ChooseRobotsViewController(robots: robots),
            chooseGameModeViewController: chooseGameModeVC,
            delegate: delegate)
        
        _ = sut.view
        _ = chooseGameModeVC.view
        chooseGameModeVC.gameModeComboBox.selectItem(at: 1)
        
        XCTAssertEqual(robots[.zero].name, delegate.firstRobot!.name)
        XCTAssertEqual(robots[.zero].name, delegate.secondRobot!.name)
        XCTAssertEqual(gameModes[1], delegate.gameMode!)
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
        private var firstRobots: [RobotProtocol] = []
        private var secondRobots: [RobotProtocol] = []
        private var gameModes: [GameMode] = []
        
        var firstRobotDidChangeCallCount: Int {
            firstRobots.count
        }
        
        var secondRobotDidChangeCallCount: Int {
            secondRobots.count
        }
        
        var gameModeDidChangeCallCount: Int {
            gameModes.count
        }
        
        var firstRobot: RobotProtocol? {
            firstRobots.last
        }
        
        var secondRobot: RobotProtocol? {
            secondRobots.last
        }
        
        var gameMode: GameMode? {
            gameModes.last
        }
        
        func sidebarViewController(
            _ viewController: SidebarViewController,
            firstRobotDidChange robot: RobotProtocol
        ) {
            firstRobots.append(robot)
        }
        
        func sidebarViewController(
            _ viewController: SidebarViewController,
            secondRobotDidChange robot: RobotProtocol
        ) {
            secondRobots.append(robot)
        }
        
        func sidebarViewController(
            _ viewController: SidebarViewController,
            gameModeDidChange gameMode: GameMode
        ) {
            gameModes.append(gameMode)
        }
    }
}
