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
            chooseRobotsViewController: ChooseRobotsViewController(firstRobots: [], secondRobots: []),
            chooseGameModeViewController: ChooseGameModeViewController(gameModes: []),
            chooseGameSpeedViewController: ChooseGameSpeedViewController(gameSpeeds: []),
            gameEngine: SidebarSpy(),
            delegate: SideBarDelegate())
        
        _ = sut.view
    }
    
    func test_sidebarVC_doesNotInformGameEngineOnInitIfThereNoRobotsAndGameModesAndGameSpeeds() {
        let gameEngine = SidebarSpy()
        _ = makeSUT(
            chooseRobotsViewController: ChooseRobotsViewController(firstRobots: [], secondRobots: []),
            chooseGameModeViewController: ChooseGameModeViewController(gameModes: []),
            chooseGameSpeedViewController: ChooseGameSpeedViewController(gameSpeeds: []),
            gameEngine: gameEngine,
            delegate: SideBarDelegate())
        
        XCTAssertEqual(gameEngine.firstRobotUpdateCallCount, .zero)
        XCTAssertEqual(gameEngine.secondRobotUpdateCallCount, .zero)
        XCTAssertEqual(gameEngine.gameModeUpdateCallCount, .zero)
        XCTAssertEqual(gameEngine.gameSpeedUpdateCallCount, .zero)
    }
    
    func test_sidebarVC_viewDidLoad_informsGameEngineAboutGameModeChangeIfThereAreGameModesButNoRobotsAndNoGameSpeeds() {
        let gameEngine = SidebarSpy()
        let sut = makeSUT(
            chooseRobotsViewController: ChooseRobotsViewController(firstRobots: [], secondRobots: []),
            chooseGameModeViewController: ChooseGameModeViewController(gameModes: [.classic]),
            chooseGameSpeedViewController: ChooseGameSpeedViewController(gameSpeeds: []),
            gameEngine: gameEngine,
            delegate: SideBarDelegate())
        _ = sut.view

        XCTAssertEqual(gameEngine.firstRobotUpdateCallCount, .zero)
        XCTAssertEqual(gameEngine.secondRobotUpdateCallCount, .zero)
        XCTAssertEqual(gameEngine.gameModeUpdateCallCount, 1)
        XCTAssertEqual(gameEngine.gameSpeedUpdateCallCount, .zero)
    }
    
    func test_sidebarVC_viewDidLoad_informsGameEngineAboutRobotsChangeIfThereAreRobotsButNoGameModesAndNoGameSpeeds() {
        let gameEngine = SidebarSpy()
        let sut = makeSUT(
            chooseRobotsViewController: ChooseRobotsViewController(firstRobots: [DummyRobot()], secondRobots: [DummyRobot()]),
            chooseGameModeViewController: ChooseGameModeViewController(gameModes: []),
            chooseGameSpeedViewController: ChooseGameSpeedViewController(gameSpeeds: []),
            gameEngine: gameEngine,
            delegate: SideBarDelegate())
        _ = sut.view

        XCTAssertEqual(gameEngine.firstRobotUpdateCallCount, 1)
        XCTAssertEqual(gameEngine.secondRobotUpdateCallCount, 1)
        XCTAssertEqual(gameEngine.gameModeUpdateCallCount, .zero)
        XCTAssertEqual(gameEngine.gameSpeedUpdateCallCount, .zero)
    }
    
    func test_sidebarVC_viewDidLoad_informsGameEngineAboutRobotsAndGameModesChangeIfThereAreRobotsAndGameModesButNoGameSpeeds() {
        let gameEngine = SidebarSpy()
        let sut = makeSUT(
            chooseRobotsViewController: ChooseRobotsViewController(firstRobots: [DummyRobot()], secondRobots: [DummyRobot()]),
            chooseGameModeViewController: ChooseGameModeViewController(gameModes: [.classic]),
            chooseGameSpeedViewController: ChooseGameSpeedViewController(gameSpeeds: []),
            gameEngine: gameEngine,
            delegate: SideBarDelegate())
        _ = sut.view

        XCTAssertEqual(gameEngine.firstRobotUpdateCallCount, 1)
        XCTAssertEqual(gameEngine.secondRobotUpdateCallCount, 1)
        XCTAssertEqual(gameEngine.gameModeUpdateCallCount, 1)
        XCTAssertEqual(gameEngine.gameSpeedUpdateCallCount, .zero)
    }
    
    func test_sidebarVC_viewDidLoad_informsGameEngineAboutRobotsAndGameModeAndGameSpeedChangeIfThereAreRobotsAndGameModesAndGameSpeeds() {
        let gameEngine = SidebarSpy()
        let sut = makeSUT(
            chooseRobotsViewController: ChooseRobotsViewController(firstRobots: [DummyRobot()], secondRobots: [DummyRobot()]),
            chooseGameModeViewController: ChooseGameModeViewController(gameModes: [.classic]),
            chooseGameSpeedViewController: ChooseGameSpeedViewController(gameSpeeds: [.slow]),
            gameEngine: gameEngine,
            delegate: SideBarDelegate())
        _ = sut.view

        XCTAssertEqual(gameEngine.firstRobotUpdateCallCount, 1)
        XCTAssertEqual(gameEngine.secondRobotUpdateCallCount, 1)
        XCTAssertEqual(gameEngine.gameModeUpdateCallCount, 1)
        XCTAssertEqual(gameEngine.gameSpeedUpdateCallCount, 1)
    }
    
    func test_sidebarVC_informsGameEngineAboutManualRobotsAndGameModeAndGameSpeedChanges() {
        let gameEngine = SidebarSpy()
        let chooseRobotsVC = ChooseRobotsViewController(
            firstRobots: [DummyRobot(), DummyRobot(), DummyRobot()],
            secondRobots: [DummyRobot(), DummyRobot(), DummyRobot()]
        )
        let chooseModeVC = ChooseGameModeViewController(gameModes: [.classic, .flyweight])
        let chooseSpeedVC = ChooseGameSpeedViewController(gameSpeeds: [.slow, .fast])
        let sut = makeSUT(
            chooseRobotsViewController: chooseRobotsVC,
            chooseGameModeViewController: chooseModeVC,
            chooseGameSpeedViewController: chooseSpeedVC,
            gameEngine: gameEngine,
            delegate: SideBarDelegate())
        
        _ = sut.view
        _ = chooseRobotsVC.view
        _ = chooseModeVC.view
        chooseRobotsVC.firstRobotComboBox.selectItem(at: 1)
        chooseRobotsVC.secondRobotComboBox.selectItem(at: 2)
        chooseModeVC.gameModeComboBox.selectItem(at: 1)
        chooseSpeedVC.gameSpeedComboBox.selectItem(at: 1)
        chooseRobotsVC.secondRobotComboBox.selectItem(at: .zero)

        XCTAssertEqual(gameEngine.firstRobotUpdateCallCount, 2)
        XCTAssertEqual(gameEngine.secondRobotUpdateCallCount, 3)
        XCTAssertEqual(gameEngine.gameModeUpdateCallCount, 2)
        XCTAssertEqual(gameEngine.gameSpeedUpdateCallCount, 2)
    }
    
    func test_sidebarVC_viewDidLoad_gameEngineReceivesCorrectRobotsAndGameModeAndGameSpeed() {
        let robots: [RobotProtocol] = [DummyRobot(name: "r1"), DummyRobot(name: "r2"), DummyRobot(name: "r3")]
        let gameModes: [GameMode] = [.classic, .flyweight]
        let gameSpeeds: [GameSpeed] = [.slow, .fast, .blazinglyFast]
        let gameEngine = SidebarSpy()
        let sut = makeSUT(
            chooseRobotsViewController: ChooseRobotsViewController(firstRobots: robots, secondRobots: robots),
            chooseGameModeViewController: ChooseGameModeViewController(gameModes: gameModes),
            chooseGameSpeedViewController: ChooseGameSpeedViewController(gameSpeeds: gameSpeeds),
            gameEngine: gameEngine,
            delegate: SideBarDelegate())
        _ = sut.view
        
        XCTAssertEqual(robots[.zero].name, gameEngine.firstRobot!.name)
        XCTAssertEqual(robots[.zero].name, gameEngine.secondRobot!.name)
        XCTAssertEqual(gameModes[.zero], gameEngine.gameMode!)
        XCTAssertEqual(gameSpeeds[.zero], gameEngine.gameSpeed!)
    }
    
    func test_sidebarVC_gameEngineReceivesCorrectFirstRobotOnManualFirstRobotChange() {
        let robots: [RobotProtocol] = [DummyRobot(name: "r1"), DummyRobot(name: "r2"), DummyRobot(name: "r3")]
        let chooseRobotsVC = ChooseRobotsViewController(firstRobots: robots, secondRobots: robots)
        let gameModes: [GameMode] = [.classic, .flyweight]
        let gameSpeeds: [GameSpeed] = [.slow, .fast, .blazinglyFast]
        let gameEngine = SidebarSpy()
        let sut = makeSUT(
            chooseRobotsViewController: chooseRobotsVC,
            chooseGameModeViewController: ChooseGameModeViewController(gameModes: gameModes),
            chooseGameSpeedViewController: ChooseGameSpeedViewController(gameSpeeds: gameSpeeds),
            gameEngine: gameEngine,
            delegate: SideBarDelegate())
        
        _ = sut.view
        _ = chooseRobotsVC.view
        chooseRobotsVC.firstRobotComboBox.selectItem(at: 1)
        
        XCTAssertEqual(robots[1].name, gameEngine.firstRobot!.name)
        XCTAssertEqual(robots[.zero].name, gameEngine.secondRobot!.name)
        XCTAssertEqual(gameModes[.zero], gameEngine.gameMode!)
        XCTAssertEqual(gameSpeeds[.zero], gameEngine.gameSpeed!)
    }
    
    func test_sidebarVC_gameEngineReceivesCorrectSecondRobotOnManualSecondRobotChange() {
        let robots: [RobotProtocol] = [DummyRobot(name: "r1"), DummyRobot(name: "r2"), DummyRobot(name: "r3")]
        let chooseRobotsVC = ChooseRobotsViewController(firstRobots: robots, secondRobots: robots)
        let gameModes: [GameMode] = [.classic, .flyweight]
        let gameSpeeds: [GameSpeed] = [.slow, .fast, .blazinglyFast]
        let gameEngine = SidebarSpy()
        let sut = makeSUT(
            chooseRobotsViewController: chooseRobotsVC,
            chooseGameModeViewController: ChooseGameModeViewController(gameModes: gameModes),
            chooseGameSpeedViewController: ChooseGameSpeedViewController(gameSpeeds: gameSpeeds),
            gameEngine: gameEngine,
            delegate: SideBarDelegate())
        
        _ = sut.view
        _ = chooseRobotsVC.view
        chooseRobotsVC.secondRobotComboBox.selectItem(at: 2)
        
        XCTAssertEqual(robots[.zero].name, gameEngine.firstRobot!.name)
        XCTAssertEqual(robots[2].name, gameEngine.secondRobot!.name)
        XCTAssertEqual(gameModes[.zero], gameEngine.gameMode!)
        XCTAssertEqual(gameSpeeds[.zero], gameEngine.gameSpeed!)
    }
    
    func test_sidebarVC_gameEngineReceivesCorrectGameModeOnManualGameModeChange() {
        let robots: [RobotProtocol] = [DummyRobot(name: "r1"), DummyRobot(name: "r2"), DummyRobot(name: "r3")]
        let gameModes: [GameMode] = [.classic, .flyweight]
        let gameSpeeds: [GameSpeed] = [.slow, .fast, .blazinglyFast]
        let chooseGameModeVC = ChooseGameModeViewController(gameModes: gameModes)
        let gameEngine = SidebarSpy()
        let sut = makeSUT(
            chooseRobotsViewController: ChooseRobotsViewController(firstRobots: robots, secondRobots: robots),
            chooseGameModeViewController: chooseGameModeVC,
            chooseGameSpeedViewController: ChooseGameSpeedViewController(gameSpeeds: gameSpeeds),
            gameEngine: gameEngine,
            delegate: SideBarDelegate())
        
        _ = sut.view
        _ = chooseGameModeVC.view
        chooseGameModeVC.gameModeComboBox.selectItem(at: 1)
        
        XCTAssertEqual(robots[.zero].name, gameEngine.firstRobot!.name)
        XCTAssertEqual(robots[.zero].name, gameEngine.secondRobot!.name)
        XCTAssertEqual(gameModes[1], gameEngine.gameMode!)
        XCTAssertEqual(gameSpeeds[.zero], gameEngine.gameSpeed!)
    }

    func test_sidebarVC_gameEngineReceivesCorrectGameSpeedOnManualGameSpeedChange() {
        let robots: [RobotProtocol] = [DummyRobot(name: "r1"), DummyRobot(name: "r2"), DummyRobot(name: "r3")]
        let gameModes: [GameMode] = [.classic, .flyweight]
        let gameSpeeds: [GameSpeed] = [.slow, .fast, .blazinglyFast]
        let chooseGameSpeedVC = ChooseGameSpeedViewController(gameSpeeds: gameSpeeds)
        let gameEngine = SidebarSpy()
        let sut = makeSUT(
            chooseRobotsViewController: ChooseRobotsViewController(firstRobots: robots, secondRobots: robots),
            chooseGameModeViewController: ChooseGameModeViewController(gameModes: gameModes),
            chooseGameSpeedViewController: chooseGameSpeedVC,
            gameEngine: gameEngine,
            delegate: SideBarDelegate())
        
        _ = sut.view
        _ = chooseGameSpeedVC.view
        chooseGameSpeedVC.gameSpeedComboBox.selectItem(at: 1)
        
        XCTAssertEqual(robots[.zero].name, gameEngine.firstRobot!.name)
        XCTAssertEqual(robots[.zero].name, gameEngine.secondRobot!.name)
        XCTAssertEqual(gameModes[.zero], gameEngine.gameMode!)
        XCTAssertEqual(gameSpeeds[1], gameEngine.gameSpeed!)
    }

    // MARK: - Helpers
    
    private func makeSUT(
        chooseRobotsViewController: ChooseRobotsViewController,
        chooseGameModeViewController: ChooseGameModeViewController,
        chooseGameSpeedViewController: ChooseGameSpeedViewController,
        gameEngine: SidebarSpy,
        delegate: SidebarViewControllerDelegate,
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> SidebarViewController {
        let sut = SidebarViewController(
            chooseRobotsViewController: chooseRobotsViewController,
            chooseGameModeViewController: chooseGameModeViewController,
            chooseGameSpeedViewController: chooseGameSpeedViewController,
            gameEngine: gameEngine,
            delegate: delegate)
                
        trackForMemoryLeak(sut, file: file, line: line)
        trackForMemoryLeak(chooseRobotsViewController, file: file, line: line)
        trackForMemoryLeak(chooseGameModeViewController, file: file, line: line)
        trackForMemoryLeak(gameEngine, file: file, line: line)
        trackForMemoryLeak(delegate, file: file, line: line)
        
        return sut
    }
    
    private final class SidebarSpy: GameEngineProtocol {
        private var firstRobots: [RobotProtocol] = []
        private var secondRobots: [RobotProtocol] = []
        private var gameModes: [GameMode] = []
        private var gameSpeeds: [GameSpeed]  = []

        var isValid: Bool {
            true
        }
                
        weak var delegate: GameEngineDelegate?
        
        var firstRobotUpdateCallCount: Int {
            firstRobots.count
        }
        
        var secondRobotUpdateCallCount: Int {
            secondRobots.count
        }
        
        var gameModeUpdateCallCount: Int {
            gameModes.count
        }
        
        var  gameSpeedUpdateCallCount: Int {
            gameSpeeds.count
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
        
        var gameSpeed: GameSpeed? {
            gameSpeeds.last
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
        
        func update(gameSpeed: GameSpeed) {
            gameSpeeds.append(gameSpeed)
        }
    }
    
    private final class SideBarDelegate: SidebarViewControllerDelegate {
        func sidebarViewController(
            _ sidebarViewController: SidebarViewController,
            didChangeFirstRobot robot: RobotProtocol,
            withShips ships: [CGRect]
        ) {
            
        }
        
        func sidebarViewController(
            _ sidebarViewController: SidebarViewController,
            didChangeSecondRobot robot: RobotProtocol,
            withShips ships: [CGRect]
        ) {
            
        }
        
        func sidebarViewController(_ sidebarViewController: SidebarViewController, firstRobotDidShootWithResult result: ShootResult) {
            
        }
        
        func sidebarViewController(_ sidebarViewController: SidebarViewController, secondRobotDidShootWithResult result: ShootResult) {
            
        }
        
        func sidebarViewController(_ sidebarViewController: SidebarViewController, firstRobotDidWinWithMessage message: String) {
            
        }
        
        func sidebarViewController(_ sidebarViewController: SidebarViewController, secondRobotDidWinWithMessage message: String) {
            
        }
        
        func sidebarViewController(_ sidebarViewController: SidebarViewController, firstRobotDidLoseWithMessage message: String) {
            
        }
        
        func sidebarViewController(_ sidebarViewController: SidebarViewController, secondRobotDidLoseWithMessage message: String) {
            
        }
        
        func sidebarViewController(_ sidebarViewController: SidebarViewController, didChangeGameModeWithBattleFieldSize battlefieldSize: CGSize) {
            
        }
        
        func sidebarViewController(_ sidebarViewController: SidebarViewController, didFailWithError error: Error?) {
            
        }
    }
}
