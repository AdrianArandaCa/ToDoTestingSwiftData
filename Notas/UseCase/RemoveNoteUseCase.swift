//
//  RemoveNoteUseCase.swift
//  Notas
//
//  Created by Adrian Aranda Campanario on 2/7/24.
//

import Foundation
struct RemoveNoteUseCase {
    var notesDatabase: NotesDatabaseProtocol
    
    init(notesDatabase: NotesDatabaseProtocol = NotesDatabase.shared) {
        self.notesDatabase = notesDatabase
    }
    
    func removeNote(note: Note) throws {
        try notesDatabase.remove(note: note)
    }
}
