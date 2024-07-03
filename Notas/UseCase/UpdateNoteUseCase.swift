//
//  UpdateNoteUseCase.swift
//  Notas
//
//  Created by Adrian Aranda Campanario on 2/7/24.
//

import Foundation

protocol UpdateNoteProtocol {
    func updateNote(identifier: UUID, title: String, text: String?) throws
}

struct UpdateNoteUseCase: UpdateNoteProtocol {
    var notesDatabase: NotesDatabaseProtocol
    
    init(notesDatabase: NotesDatabaseProtocol = NotesDatabase.shared) {
        self.notesDatabase = notesDatabase
    }
    
    func updateNote(identifier: UUID, title: String, text: String?) throws {
        try notesDatabase.update(identifier: identifier, title: title, text: text)
    }
}
