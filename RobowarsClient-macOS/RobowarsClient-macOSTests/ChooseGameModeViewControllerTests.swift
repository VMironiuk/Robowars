//
//  ChooseGameModeViewControllerTests.swift
//  RobowarsClient-macOSTests
//
//  Created by Volodymyr Myroniuk on 08.10.2022.
//

import XCTest
@testable import RobowarsClient_macOS
@testable import Robowars

final class ChooseGameModeViewControllerTests: XCTestCase {
    
    func test_chooseGameModeVC_createsItsView() {
        let sut = ChooseGameModeViewController()
        XCTAssertNotNil(sut.view)
    }
    
    func test_chooseGameModeVC_doesNotInformDelegateOnAssignmentIfThereAreNoGameModes() {
        let sut = ChooseGameModeViewController()
        let chooseGameModeSpy = ChooseGameModeSpy()

        _ = sut.view
        sut.delegate = chooseGameModeSpy

        XCTAssertTrue(chooseGameModeSpy.gameModeDidChangeCallCount == .zero)
    }
    
    func test_chooseGameModeVC_informsDelegateOnAssignmentIfThereAreGameModes() {
        let sut = ChooseGameModeViewController(gameModes: [.classic])
        let chooseGameModeSpy = ChooseGameModeSpy()

        _ = sut.view
        sut.delegate = chooseGameModeSpy

        XCTAssertTrue(chooseGameModeSpy.gameModeDidChangeCallCount == 1)
    }
    
    func test_chooseGameModeVC_comboBoxDoesNotContainItemsIfThereAreNoGameModes() {
        let sut = ChooseGameModeViewController()
        
        _ = sut.view
        
        XCTAssertEqual(sut.gameModeComboBox.numberOfItems, .zero)
    }
    
    func test_chooseGameModeVC_comboBoxContainsSameAmountOfItemsLikeAmountOfGameModes() {
        let sut = ChooseGameModeViewController(gameModes: [.classic, .flyweight])
        
        _ = sut.view
        
        XCTAssertEqual(sut.gameModeComboBox.numberOfItems, 2)
    }

    func test_chooseGameModeVC_comboBoxTitlesAndGameModesTitlesAreEqual() {
        let gameModes: [GameMode] = [.classic, .flyweight, .classic, .classic]
        let sut = ChooseGameModeViewController(gameModes: gameModes)
        
        _ = sut.view
        
        XCTAssertEqual(sut.comboBox(sut.gameModeComboBox, objectValueForItemAt: 0) as! String, gameModes[0].title)
        XCTAssertEqual(sut.comboBox(sut.gameModeComboBox, objectValueForItemAt: 1) as! String, gameModes[1].title)
        XCTAssertEqual(sut.comboBox(sut.gameModeComboBox, objectValueForItemAt: 2) as! String, gameModes[2].title)
        XCTAssertEqual(sut.comboBox(sut.gameModeComboBox, objectValueForItemAt: 3) as! String, gameModes[3].title)
    }

    func test_chooseGameModeVC_informsItsDelegateAboutNewGameModeSelection() {
        let gameModes: [GameMode] = [.classic, .flyweight, .classic]
        let sut = ChooseGameModeViewController(gameModes: gameModes)
        let chooseGameModeSpy = ChooseGameModeSpy()
        
        _ = sut.view
        sut.delegate = chooseGameModeSpy
        sut.gameModeComboBox.selectItem(at: 1)
        
        XCTAssertEqual(chooseGameModeSpy.gameMode, gameModes[1])
        XCTAssertTrue(chooseGameModeSpy.gameModeDidChangeCallCount == 2)
        
        sut.gameModeComboBox.selectItem(at: 2)
        XCTAssertEqual(chooseGameModeSpy.gameMode, gameModes[2])
        XCTAssertTrue(chooseGameModeSpy.gameModeDidChangeCallCount == 3)
    }

    // MARK: - Helpers
    
    private final class ChooseGameModeSpy: ChooseGameModeViewControllerDelegate {
        private var gameModes: [GameMode] = []
        
        var gameModeDidChangeCallCount: Int {
            gameModes.count
        }
        
        var gameMode: GameMode? {
            gameModes.last
        }
        
        func chooseGameModeViewController(_ viewController: ChooseGameModeViewController, gameModeDidChange gameMode: GameMode) {
            gameModes.append(gameMode)
        }
    }
}
