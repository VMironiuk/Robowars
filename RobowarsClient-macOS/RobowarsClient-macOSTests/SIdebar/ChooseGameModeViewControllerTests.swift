//
//  ChooseGameModeViewControllerTests.swift
//  RobowarsClient-macOSTests
//
//  Created by Volodymyr Myroniuk on 08.10.2022.
//

import XCTest
import Robowars
@testable import RobowarsClient_macOS

final class ChooseGameModeViewControllerTests: XCTestCase {
    
    func test_chooseGameModeVC_createsItsView() {
        let (sut, _) = makeSUT()
        _ = sut.view
    }
    
    func test_chooseGameModeVC_doesNotInformDelegateOnAssignmentIfThereAreNoGameModes() {
        let (sut, chooseGameModeSpy) = makeSUT()

        _ = sut.view
        sut.delegate = chooseGameModeSpy

        XCTAssertTrue(chooseGameModeSpy.gameModeDidChangeCallCount == .zero)
    }
    
    func test_chooseGameModeVC_informsDelegateOnAssignmentIfThereAreGameModes() {
        let (sut, chooseGameModeSpy) = makeSUT(with: [.classic])

        _ = sut.view
        sut.delegate = chooseGameModeSpy

        XCTAssertTrue(chooseGameModeSpy.gameModeDidChangeCallCount == 1)
    }
    
    func test_chooseGameModeVC_comboBoxDoesNotContainItemsIfThereAreNoGameModes() {
        let (sut, _) = makeSUT()
        
        _ = sut.view
        
        XCTAssertEqual(sut.gameModeComboBox.numberOfItems, .zero)
    }
    
    func test_chooseGameModeVC_comboBoxContainsSameAmountOfItemsLikeAmountOfGameModes() {
        let (sut, _) = makeSUT(with: [.classic, .flyweight])
        
        _ = sut.view
        
        XCTAssertEqual(sut.gameModeComboBox.numberOfItems, 2)
    }

    func test_chooseGameModeVC_comboBoxTitlesAndGameModesTitlesAreEqual() {
        let gameModes: [GameMode] = [.classic, .flyweight, .classic, .classic]
        let (sut, _) = makeSUT(with: gameModes)
        
        _ = sut.view
        
        XCTAssertEqual(sut.comboBox(sut.gameModeComboBox, objectValueForItemAt: 0) as! String, gameModes[0].title)
        XCTAssertEqual(sut.comboBox(sut.gameModeComboBox, objectValueForItemAt: 1) as! String, gameModes[1].title)
        XCTAssertEqual(sut.comboBox(sut.gameModeComboBox, objectValueForItemAt: 2) as! String, gameModes[2].title)
        XCTAssertEqual(sut.comboBox(sut.gameModeComboBox, objectValueForItemAt: 3) as! String, gameModes[3].title)
    }

    func test_chooseGameModeVC_informsItsDelegateAboutNewGameModeSelection() {
        let gameModes: [GameMode] = [.classic, .flyweight, .classic]
        let (sut, chooseGameModeSpy) = makeSUT(with: gameModes)
        
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
    
    private func makeSUT(with gameModes: [GameMode] = []) -> (ChooseGameModeViewController, ChooseGameModeSpy) {
        let sut = ChooseGameModeViewController(gameModes: gameModes)
        let chooseGameModeSpy = ChooseGameModeSpy()
        
        trackForMemoryLeak(sut)
        trackForMemoryLeak(chooseGameModeSpy)
        
        return (sut, chooseGameModeSpy)
    }
    
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
