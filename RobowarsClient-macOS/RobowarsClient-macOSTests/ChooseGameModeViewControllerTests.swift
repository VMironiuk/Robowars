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
    
    func test_chooseGameModeVC_init_createsView() {
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

    // MARK: - Helpers
    
    private final class ChooseGameModeSpy: ChooseGameModeViewControllerDelegate {
        private(set) var gameModeDidChangeCallCount: Int = .zero
        
        func chooseGameModeViewController(_ viewController: ChooseGameModeViewController, gameModeDidChange gameMode: GameMode) {
            gameModeDidChangeCallCount += 1
        }
    }
}
