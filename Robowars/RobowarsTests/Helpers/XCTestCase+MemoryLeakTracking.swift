//
//  XCTestCase+MemoryLeakTracking.swift
//  RobowarsTests
//
//  Created by Volodymyr Myroniuk on 12.08.2022.
//

import XCTest

extension XCTestCase {
    func trackForMemoryLeak(_ instance: AnyObject, file: StaticString = #filePath, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should have been deallocated. Potential memory leak.", file: file, line: line)
        }
    }
}
