//
//  ChooseRobotsViewControllerTests.swift
//  RobowarsClient-macOSTests
//
//  Created by Volodymyr Myroniuk on 05.10.2022.
//

import XCTest
import Robowars
@testable import RobowarsClient_macOS

final class ChooseRobotsViewControllerTests: XCTestCase {
    
    func test_chooseRobotsVC_init_createsView() {
        let sut = ChooseRobotsViewController()
        XCTAssertNotNil(sut.view)
    }

    func test_chooseRobotsVC_doesNotInformDelegateOnAssignmentIfThereAreNoRobots() {
        let sut = ChooseRobotsViewController()
        let chooseRobotsSpy = ChooseRobotsSpy()

        _ = sut.view
        sut.delegate = chooseRobotsSpy

        XCTAssertTrue(chooseRobotsSpy.firstRobotDidChangeCallCount == .zero)
        XCTAssertTrue(chooseRobotsSpy.secondRobotDidChangeCallCount == .zero)
    }

    func test_chooseRobotsVC_informsDelegateOnAssignmentIfThereAreRobots() {
        let sut = ChooseRobotsViewController(robots: [DummyRobot()])
        let chooseRobotsSpy = ChooseRobotsSpy()

        _ = sut.view
        sut.delegate = chooseRobotsSpy

        XCTAssertTrue(chooseRobotsSpy.firstRobotDidChangeCallCount == 1)
        XCTAssertTrue(chooseRobotsSpy.secondRobotDidChangeCallCount == 1)
    }
    
    func test_chooseRobotsVC_comboBoxesDoNotContainItemsIfThereAreNoRobots() {
        let sut = ChooseRobotsViewController()
        
        _ = sut.view
        
        XCTAssertEqual(sut.firstRobotComboBox.numberOfItems, .zero)
        XCTAssertEqual(sut.secondRobotComboBox.numberOfItems, .zero)
    }

    // MARK: - Helpers

    private final class ChooseRobotsSpy: ChooseRobotsViewControllerDelegate {
        private(set) var firstRobotDidChangeCallCount: Int = .zero
        private(set) var secondRobotDidChangeCallCount: Int = .zero

        func chooseRobotsViewController(
            _ viewController: ChooseRobotsViewController,
            firstRobotDidChangeWith robot: RobotProtocol
        ) {
            firstRobotDidChangeCallCount += 1
        }

        func chooseRobotsViewController(
            _ viewController: ChooseRobotsViewController,
            secondRobotDidChangeWith robot: RobotProtocol
        ) {
            secondRobotDidChangeCallCount += 1
        }
    }

    private final class DummyRobot: RobotProtocol {
        var ships: [CGRect] {
            []
        }

        var name: String {
            "DummyRobot"
        }

        var winnerMessage: String {
            ""
        }

        var loserMessage: String {
            ""
        }

        func set(battlefield: CGRect, ships: [CGSize]) {

        }

        func shoot() -> CGPoint {
            .zero
        }

        func shootResult(_ result: Robowars.ShootResult, for coordinate: CGPoint) {

        }
    }
}
