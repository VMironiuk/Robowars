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
        let sut = makeSUT(
            chooseRobotsViewController: ChooseRobotsViewController(robots: []),
            chooseGameModeViewController: ChooseGameModeViewController(gameModes: []),
            gameEngine: SidebarSpy())
        
        _ = sut.view
    }
    
    func test_sidebarVC_doesNotInformGameEngineOnInitIfThereNoRobotsAndGameMode() {
        let gameEngine = SidebarSpy()
        _ = makeSUT(
            chooseRobotsViewController: ChooseRobotsViewController(robots: []),
            chooseGameModeViewController: ChooseGameModeViewController(gameModes: []),
            gameEngine: gameEngine)
        
        XCTAssertEqual(gameEngine.firstRobotUpdateCallCount, .zero)
        XCTAssertEqual(gameEngine.secondRobotUpdateCallCount, .zero)
        XCTAssertEqual(gameEngine.gameModeUpdateCallCount, .zero)
    }
    
    func test_sidebarVC_viewDidLoad_informsGameEngineAboutGameModeChangeIfThereAreGameModesButNoRobots() {
        let gameEngine = SidebarSpy()
        let sut = makeSUT(
            chooseRobotsViewController: ChooseRobotsViewController(robots: []),
            chooseGameModeViewController: ChooseGameModeViewController(gameModes: [.classic]),
            gameEngine: gameEngine)
        _ = sut.view

        XCTAssertEqual(gameEngine.firstRobotUpdateCallCount, .zero)
        XCTAssertEqual(gameEngine.secondRobotUpdateCallCount, .zero)
        XCTAssertEqual(gameEngine.gameModeUpdateCallCount, 1)
    }
    
    func test_sidebarVC_viewDidLoad_informsGameEngineAboutRobotsChangeIfThereAreRobotsButNoGameModes() {
        let gameEngine = SidebarSpy()
        let sut = makeSUT(
            chooseRobotsViewController: ChooseRobotsViewController(robots: [DummyRobot()]),
            chooseGameModeViewController: ChooseGameModeViewController(gameModes: []),
            gameEngine: gameEngine)
        _ = sut.view

        XCTAssertEqual(gameEngine.firstRobotUpdateCallCount, 1)
        XCTAssertEqual(gameEngine.secondRobotUpdateCallCount, 1)
        XCTAssertEqual(gameEngine.gameModeUpdateCallCount, .zero)
    }
    
    func test_sidebarVC_viewDidLoad_informsGameEngineAboutRobotsAndGameModesChangeIfThereAreRobotsAndGameModes() {
        let gameEngine = SidebarSpy()
        let sut = makeSUT(
            chooseRobotsViewController: ChooseRobotsViewController(robots: [DummyRobot()]),
            chooseGameModeViewController: ChooseGameModeViewController(gameModes: [.classic]),
            gameEngine: gameEngine)
        _ = sut.view

        XCTAssertEqual(gameEngine.firstRobotUpdateCallCount, 1)
        XCTAssertEqual(gameEngine.secondRobotUpdateCallCount, 1)
        XCTAssertEqual(gameEngine.gameModeUpdateCallCount, 1)
    }
    
    func test_sidebarVC_informsGameEngineAboutManualRobotsAndGameModeChanges() {
        let gameEngine = SidebarSpy()
        let chooseRobotsVC = ChooseRobotsViewController(robots: [DummyRobot(), DummyRobot(), DummyRobot()])
        let chooseModeVC = ChooseGameModeViewController(gameModes: [.classic, .flyweight])
        let sut = makeSUT(
            chooseRobotsViewController: chooseRobotsVC,
            chooseGameModeViewController: chooseModeVC,
            gameEngine: gameEngine)
        
        _ = sut.view
        _ = chooseRobotsVC.view
        _ = chooseModeVC.view
        chooseRobotsVC.firstRobotComboBox.selectItem(at: 1)
        chooseRobotsVC.secondRobotComboBox.selectItem(at: 2)
        chooseModeVC.gameModeComboBox.selectItem(at: 1)
        chooseRobotsVC.secondRobotComboBox.selectItem(at: .zero)

        XCTAssertEqual(gameEngine.firstRobotUpdateCallCount, 2)
        XCTAssertEqual(gameEngine.secondRobotUpdateCallCount, 3)
        XCTAssertEqual(gameEngine.gameModeUpdateCallCount, 2)
    }
    
    func test_sidebarVC_viewDidLoad_gameEngineReceivesCorrectRobotsAndGameMode() {
        let robots: [RobotProtocol] = [DummyRobot(name: "r1"), DummyRobot(name: "r2"), DummyRobot(name: "r3")]
        let gameModes: [GameMode] = [.classic, .flyweight]
        let gameEngine = SidebarSpy()
        let sut = makeSUT(
            chooseRobotsViewController: ChooseRobotsViewController(robots: robots),
            chooseGameModeViewController: ChooseGameModeViewController(gameModes: gameModes),
            gameEngine: gameEngine)
        _ = sut.view
        
        XCTAssertEqual(robots[.zero].name, gameEngine.firstRobot!.name)
        XCTAssertEqual(robots[.zero].name, gameEngine.secondRobot!.name)
        XCTAssertEqual(gameModes[.zero], gameEngine.gameMode!)
    }
    
    func test_sidebarVC_gameEngineReceivesCorrectFirstRobotOnManualFirstRobotChange() {
        let robots: [RobotProtocol] = [DummyRobot(name: "r1"), DummyRobot(name: "r2"), DummyRobot(name: "r3")]
        let chooseRobotsVC = ChooseRobotsViewController(robots: robots)
        let gameModes: [GameMode] = [.classic, .flyweight]
        let gameEngine = SidebarSpy()
        let sut = makeSUT(
            chooseRobotsViewController: chooseRobotsVC,
            chooseGameModeViewController: ChooseGameModeViewController(gameModes: gameModes),
            gameEngine: gameEngine)
        
        _ = sut.view
        _ = chooseRobotsVC.view
        chooseRobotsVC.firstRobotComboBox.selectItem(at: 1)
        
        XCTAssertEqual(robots[1].name, gameEngine.firstRobot!.name)
        XCTAssertEqual(robots[.zero].name, gameEngine.secondRobot!.name)
        XCTAssertEqual(gameModes[.zero], gameEngine.gameMode!)
    }
    
    func test_sidebarVC_gameEngineReceivesCorrectSecondRobotOnManualSecondRobotChange() {
        let robots: [RobotProtocol] = [DummyRobot(name: "r1"), DummyRobot(name: "r2"), DummyRobot(name: "r3")]
        let chooseRobotsVC = ChooseRobotsViewController(robots: robots)
        let gameModes: [GameMode] = [.classic, .flyweight]
        let gameEngine = SidebarSpy()
        let sut = makeSUT(
            chooseRobotsViewController: chooseRobotsVC,
            chooseGameModeViewController: ChooseGameModeViewController(gameModes: gameModes),
            gameEngine: gameEngine)
        
        _ = sut.view
        _ = chooseRobotsVC.view
        chooseRobotsVC.secondRobotComboBox.selectItem(at: 2)
        
        XCTAssertEqual(robots[.zero].name, gameEngine.firstRobot!.name)
        XCTAssertEqual(robots[2].name, gameEngine.secondRobot!.name)
        XCTAssertEqual(gameModes[.zero], gameEngine.gameMode!)
    }
    
    func test_sidebarVC_gameEngineReceivesCorrectGameModeOnManualGameModeChange() {
        let robots: [RobotProtocol] = [DummyRobot(name: "r1"), DummyRobot(name: "r2"), DummyRobot(name: "r3")]
        let gameModes: [GameMode] = [.classic, .flyweight]
        let chooseGameModeVC = ChooseGameModeViewController(gameModes: gameModes)
        let gameEngine = SidebarSpy()
        let sut = makeSUT(
            chooseRobotsViewController: ChooseRobotsViewController(robots: robots),
            chooseGameModeViewController: chooseGameModeVC,
            gameEngine: gameEngine)
        
        _ = sut.view
        _ = chooseGameModeVC.view
        chooseGameModeVC.gameModeComboBox.selectItem(at: 1)
        
        XCTAssertEqual(robots[.zero].name, gameEngine.firstRobot!.name)
        XCTAssertEqual(robots[.zero].name, gameEngine.secondRobot!.name)
        XCTAssertEqual(gameModes[1], gameEngine.gameMode!)
    }

    // MARK: - Helpers
    
    private func makeSUT(
        chooseRobotsViewController: ChooseRobotsViewController,
        chooseGameModeViewController: ChooseGameModeViewController,
        gameEngine: SidebarSpy
    ) -> SidebarViewController {
        let sut = SidebarViewController(
            chooseRobotsViewController: chooseRobotsViewController,
            chooseGameModeViewController: chooseGameModeViewController,
            gameEngine: gameEngine)
                
        trackForMemoryLeak(sut)
        trackForMemoryLeak(chooseRobotsViewController)
        trackForMemoryLeak(chooseGameModeViewController)
        trackForMemoryLeak(gameEngine)
        
        return sut
    }
    
    private final class SidebarSpy: GameEngineProtocol {
        private var firstRobots: [RobotProtocol] = []
        private var secondRobots: [RobotProtocol] = []
        private var gameModes: [GameMode] = []

        var isValid: Bool {
            true
        }
        
        var delegate: GameEngineDelegate?
        
        var firstRobotUpdateCallCount: Int {
            firstRobots.count
        }
        
        var secondRobotUpdateCallCount: Int {
            secondRobots.count
        }
        
        var gameModeUpdateCallCount: Int {
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
        
        func start() {
        }
        
        func update(firstRobot robot: RobotProtocol) {
            firstRobots.append(robot)
        }
        
        func update(secondRobot robot: RobotProtocol) {
            secondRobots.append(robot)
        }
        
        func update(gameMode: GameMode) {
            gameModes.append(gameMode)
        }
    }
}
