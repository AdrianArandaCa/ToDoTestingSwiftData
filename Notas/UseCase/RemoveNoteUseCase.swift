//
//  RemoveNoteUseCase.swift
//  Notas
//
//  Created by Adrian Aranda Campanario on 2/7/24.
//

import Foundation
protocol RemoveNoteProtocol {
    func removeNote(identifier: UUID) throws
}

struct RemoveNoteUseCase: RemoveNoteProtocol {
    var notesDatabase: NotesDatabaseProtocol
    
    init(notesDatabase: NotesDatabaseProtocol = NotesDatabase.shared) {
        self.notesDatabase = notesDatabase
    }
    
    func removeNote(identifier: UUID) throws {
        try notesDatabase.remove(identifier: identifier)
    }
}
