//
//  XCTestCase+MemoryLeakTracking.swift
//  RobowarsClient-macOSTests
//
//  Created by Volodymyr Myroniuk on 14.10.2022.
//

import XCTest

extension XCTestCase {
    func trackForMemoryLeak(_ instance: AnyObject, file: StaticString = #filePath, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should have been deallocated. Potential memory leak.", file: file, line: line)
        }
    }
}
