//
//  CreateNoteViewSnapshotTest.swift
//  NotasTests
//
//  Created by Adrian Aranda Campanario on 4/7/24.
//

import XCTest
import SnapshotTesting
@testable import Notas

final class CreateNoteViewSnapshotTest: XCTestCase {

    func testCreateNoteView() throws {
        let createNoteView = CreateNoteView(viewModel: .init())
        assertSnapshot(of: createNoteView, as: .image)
    }
    
    func testCreateNoteViewWithData() throws {
        let createNoteView = CreateNoteView(viewModel: .init(), 
                                            title: "Title 1",
                                            text: "Text 1")
        assertSnapshot(of: createNoteView, as: .image)
        
    }
}
