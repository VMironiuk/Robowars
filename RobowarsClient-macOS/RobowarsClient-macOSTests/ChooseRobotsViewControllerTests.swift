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
    
    func test_chooseRobotsVC_createsItsView() {
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
    
    func test_chooseRobotsVC_comboBoxesContainSameAmountOfItemsLikeAmountOfRobots() {
        let sut = ChooseRobotsViewController(robots: [DummyRobot(), DummyRobot(), DummyRobot()])
        
        _ = sut.view
        
        XCTAssertEqual(sut.firstRobotComboBox.numberOfItems, 3)
        XCTAssertEqual(sut.secondRobotComboBox.numberOfItems, 3)
    }
    
    func test_chooseRobotsVC_comboBoxesTitlesAndRobotNamesAreEqual() {
        let robots = [DummyRobot(name: "r1"), DummyRobot(name: "r2"), DummyRobot(name: "r3")]
        let sut = ChooseRobotsViewController(robots: robots)
        
        _ = sut.view
        
        XCTAssertEqual(sut.comboBox(sut.firstRobotComboBox, objectValueForItemAt: 0) as! String, robots[0].name)
        XCTAssertEqual(sut.comboBox(sut.firstRobotComboBox, objectValueForItemAt: 1) as! String, robots[1].name)
        XCTAssertEqual(sut.comboBox(sut.firstRobotComboBox, objectValueForItemAt: 2) as! String, robots[2].name)

        XCTAssertEqual(sut.comboBox(sut.secondRobotComboBox, objectValueForItemAt: 0) as! String, robots[0].name)
        XCTAssertEqual(sut.comboBox(sut.secondRobotComboBox, objectValueForItemAt: 1) as! String, robots[1].name)
        XCTAssertEqual(sut.comboBox(sut.secondRobotComboBox, objectValueForItemAt: 2) as! String, robots[2].name)
    }

    func test_chooseRobotsVC_informsItsDelegateAboutNewRobotsSelection() {
        let robots = [DummyRobot(name: "r1"), DummyRobot(name: "r2"), DummyRobot(name: "r3")]
        let sut = ChooseRobotsViewController(robots: robots)
        let chooseRobotsSpy = ChooseRobotsSpy()
        
        _ = sut.view
        sut.delegate = chooseRobotsSpy
        sut.firstRobotComboBox.selectItem(at: 1)
        sut.secondRobotComboBox.selectItem(at: 2)
        
        XCTAssertEqual(chooseRobotsSpy.firstRobot as! DummyRobot, robots[1])
        XCTAssertEqual(chooseRobotsSpy.secondRobot as! DummyRobot, robots[2])
        XCTAssertTrue(chooseRobotsSpy.firstRobotDidChangeCallCount == 2)
        XCTAssertTrue(chooseRobotsSpy.secondRobotDidChangeCallCount == 2)
        
        sut.secondRobotComboBox.selectItem(at: 0)
        XCTAssertEqual(chooseRobotsSpy.firstRobot as! DummyRobot, robots[1])
        XCTAssertEqual(chooseRobotsSpy.secondRobot as! DummyRobot, robots[0])
        XCTAssertTrue(chooseRobotsSpy.firstRobotDidChangeCallCount == 2)
        XCTAssertTrue(chooseRobotsSpy.secondRobotDidChangeCallCount == 3)
    }
    
    // MARK: - Helpers

    private final class ChooseRobotsSpy: ChooseRobotsViewControllerDelegate {
        private var firstRobots: [RobotProtocol] = []
        private var secondRobots: [RobotProtocol] = []
        
        var firstRobotDidChangeCallCount: Int {
            firstRobots.count
        }
        
        var secondRobotDidChangeCallCount: Int {
            secondRobots.count
        }
        
        var firstRobot: RobotProtocol? {
            firstRobots.last
        }
        
        var secondRobot: RobotProtocol? {
            secondRobots.last
        }

        func chooseRobotsViewController(
            _ viewController: ChooseRobotsViewController,
            firstRobotDidChangeWith robot: RobotProtocol
        ) {
            firstRobots.append(robot)
        }

        func chooseRobotsViewController(
            _ viewController: ChooseRobotsViewController,
            secondRobotDidChangeWith robot: RobotProtocol
        ) {
            secondRobots.append(robot)
        }
    }

    private final class DummyRobot: RobotProtocol, Equatable {
        var ships: [CGRect] {
            []
        }

        private(set) var name: String

        var winnerMessage: String {
            ""
        }

        var loserMessage: String {
            ""
        }
        
        init(name: String = "DummyRobot") {
            self.name = name
        }

        func set(battlefield: CGRect, ships: [CGSize]) {

        }

        func shoot() -> CGPoint {
            .zero
        }

        func shootResult(_ result: ShootResult, for coordinate: CGPoint) {

        }
        
        static func == (lhs: DummyRobot, rhs: DummyRobot) -> Bool {
            lhs.name == rhs.name
        }
    }
}
