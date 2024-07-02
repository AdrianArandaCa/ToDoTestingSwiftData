//
//  ViewModelTest.swift
//  NotasTests
//
//  Created by Adrian Aranda Campanario on 2/7/24.
//

import XCTest
@testable import Notas

final class ViewModelTest: XCTestCase {
    
    var viewModel: ViewModel!

    override func setUpWithError() throws {
        viewModel = ViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCreateNote() {
        //Given
        let title = "Test Title"
        let text = "Test Text"
        
        //When
        viewModel.createNote(title: title, text: text)
        
        //Then
        XCTAssertEqual(viewModel.notes.count, 1)
        XCTAssertEqual(viewModel.notes.first?.title, title)
        XCTAssertEqual(viewModel.notes.first?.text, text)
    }
    
    func testCreateThreeNotes() {
        //Given
        let title = "Test Title"
        let text = "Test Text"
        let title2 = "Test Title 2"
        let text2 = "Test Text 2"
        let title3 = "Test Title 3"
        let text3 = "Test Text 3"
        
        //When
        viewModel.createNote(title: title, text: text)
        viewModel.createNote(title: title2, text: text2)
        viewModel.createNote(title: title3, text: text3)
        
        //Then
        XCTAssertEqual(viewModel.notes.count, 3)
        XCTAssertEqual(viewModel.notes.first?.title, title)
        XCTAssertEqual(viewModel.notes.first?.text, text)
        XCTAssertEqual(viewModel.notes[1].title, title2)
        XCTAssertEqual(viewModel.notes[1].text, text2)
        XCTAssertEqual(viewModel.notes[2].title, title3)
        XCTAssertEqual(viewModel.notes[2].text, text3)
    }
    
    /*func testUpdateNote() {
        //Given
        let title = "Test Title"
        let text = "Test Text"
        viewModel.createNote(title: title, text: text)
        
        let newTitle = "New title"
        let newText = "New text"
        
        //When
        if let identifier = viewModel.notes.first?.identifier {
            viewModel.updateNote(identifier: identifier, newTitle: newTitle, newText: newText)
            //Then
            XCTAssertEqual(viewModel.notes.first?.title, newTitle)
            XCTAssertEqual(viewModel.notes.first?.text, newText)
        } else {
            XCTFail("No note was created.")
        }
    }
    
    func testRemoveNote() {
        //Given
        let title = "Test Title"
        let text = "Test Text"
        viewModel.createNote(title: title, text: text)
        
        //When
        if let identifier = viewModel.notes.first?.identifier {
            viewModel.removeNote(identifier: identifier)
            //Then
            XCTAssertTrue(viewModel.notes.isEmpty)
        } else {
            XCTFail("No note was created.")
        }
    }*/
}
