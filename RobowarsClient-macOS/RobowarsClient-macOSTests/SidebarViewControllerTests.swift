//
//  SidebarViewControllerTests.swift
//  RobowarsClient-macOSTests
//
//  Created by Volodymyr Myroniuk on 13.10.2022.
//

import XCTest
@testable import RobowarsClient_macOS

final class SidebarViewControllerTests: XCTestCase {
    
    func test_sidebarVC_createsItsView() {
        let sut = SidebarViewController()
        _ = sut.view
    }
}
