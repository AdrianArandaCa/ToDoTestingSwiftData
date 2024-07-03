//
//  ViewModelIntegrationTest.swift
//  NotasTests
//
//  Created by Adrian Aranda Campanario on 2/7/24.
//

import XCTest
@testable import Notas

final class ViewModelIntegrationTest: XCTestCase {

    var sut: ViewModel!
    
    @MainActor
    override func setUpWithError() throws {
        let database = NotesDatabase.shared
        database.container = NotesDatabase.setupContainer(inMemory: true)
        
        let createNoteUseCase = CreateNoteUseCase(notesDatabase: database)
        let fetchAllNotesUseCase = FetchAllNotesUseCase(notesDatabase: database)
        let removeNoteUseCase = RemoveNoteUseCase(notesDatabase: database)
        let updateNoteUseCase = UpdateNoteUseCase(notesDatabase: database)
        
        sut = ViewModel(createNoteUseCase: createNoteUseCase, 
                        fetchAllNotesUseCase: fetchAllNotesUseCase,
                        updateNoteUseCase: updateNoteUseCase,
                        removeNoteUseCase: removeNoteUseCase)
    }

    @MainActor
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    @MainActor
    func testCreateNote() {
        //Given
        sut.createNote(title: "Hello 1", text: "Text 1")
        //When
        let note = sut.notes.first
        //Then
        XCTAssertNotNil(note)
        XCTAssertEqual(note?.title, "Hello 1")
        XCTAssertEqual(note?.text, "Text 1")
        XCTAssertEqual(sut.notes.count, 1, "Deberia haber una nota en la base de datos")
    }
    
    @MainActor
    func testCreateTwoNote() {
        //Given
        sut.createNote(title: "Hello 1", text: "Text 1")
        sut.createNote(title: "Hello 2", text: "Text 2")
        
        //When
        let firstNote = sut.notes.first
        let lastNote = sut.notes.last
        
        //Then
        XCTAssertNotNil(firstNote)
        XCTAssertEqual(firstNote?.title, "Hello 1")
        XCTAssertEqual(firstNote?.text, "Text 1")
        XCTAssertNotNil(lastNote)
        XCTAssertEqual(lastNote?.title, "Hello 2")
        XCTAssertEqual(lastNote?.text, "Text 2")
        XCTAssertEqual(sut.notes.count, 2, "Deberia haber una nota en la base de datos")
    }
    
    @MainActor
    func testFetchAllNotes() {
        //Given
        sut.createNote(title: "Note 1", text: "Text 1")
        sut.createNote(title: "Note 2", text: "Text 2")
        
        //When
        let firstNote = sut.notes.first
        let lastNote = sut.notes.last
        
        //Then
        XCTAssertEqual(sut.notes.count, 2, "There should be two notes in the database")
        XCTAssertEqual(firstNote?.title, "Note 1", "First note's title should be 'Note 1'")
        XCTAssertEqual(firstNote?.text, "Text 1", "First note's text should be 'Text 1'")
        XCTAssertEqual(lastNote?.title, "Note 2", "Last note's title should be 'Note 2'")
        XCTAssertEqual(lastNote?.text, "Text 2", "Last note's title should be 'Text 1'")
    }
    
    @MainActor
    func testUpdateNote() {
        //Given
        sut.createNote(title: "Hello 1", text: "Text 1")
        let newTitle = "Hello 2"
        let newText = "Text 2"
        
        //When
        if let note = sut.notes.first {
            sut.updateNote(identifier: note.identifier, newTitle: newTitle, newText: newText)
            sut.fetchAllNotes()
            //Then
            XCTAssertEqual(sut.notes.count, 1)
            XCTAssertEqual(sut.notes.first?.title, newTitle)
            XCTAssertEqual(sut.notes.first?.text, newText)
        } else {
            XCTFail("No note was created.")
        }
    }
    
    @MainActor
    func testDeleteNote() {
        //Given
        sut.createNote(title: "Hello 1", text: "Text 1")
        
        //When
        if let identifier = sut.notes.first?.identifier {
            sut.removeNote(identifier: identifier)
            //Then
            XCTAssertTrue(sut.notes.isEmpty)
        } else {
            XCTFail("No note was created.")
        }
    }
}
