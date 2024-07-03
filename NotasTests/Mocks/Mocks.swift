//
//  Mocks.swift
//  NotasTests
//
//  Created by Adrian Aranda Campanario on 3/7/24.
//

import Foundation
@testable import Notas

var mockDatabase: [Note] = []

struct CreateNoteUseCaseMock: CreateNoteProtocol {
    func createNote(title: String, text: String) throws {
        let note = Note(title: title, text: text, createdAt: .now)
        mockDatabase.append(note)
    }
}

struct FetchAllNotesUseCaseMock: FetchAllNotesProtocol {
    func fetchAll() throws -> [Notas.Note] {
        return mockDatabase
    }
}

struct UpdateNoteUseCaseMock: UpdateNoteProtocol {
    func updateNote(identifier: UUID, title: String, text: String?) throws {
        if let index = mockDatabase.firstIndex(where: {$0.identifier == identifier }) {
            mockDatabase[index].title = title
            mockDatabase[index].text = text
        }
    }
}

struct RemoveNoteUseCaseMock: RemoveNoteProtocol {
    func removeNote(identifier: UUID) throws {
        if let index = mockDatabase.firstIndex(where: {$0.identifier == identifier }) {
            mockDatabase.remove(at: index)
        }
//        mockDatabase.removeAll(where: { $0.identifier == identifier })
    }
}
