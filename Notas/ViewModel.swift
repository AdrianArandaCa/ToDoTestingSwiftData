//
//  ViewModel.swift
//  Notas
//
//  Created by Adrian Aranda Campanario on 2/7/24.
//

import Foundation
import Observation

@Observable
class ViewModel {
    var notes: [Note]
    
    var createNoteUseCase: CreateNoteUseCase
    var fetchAllNotesUseCase: FetchAllNotesUseCase
    var updateNoteUseCase: UpdateNoteUseCase
    var removeNoteUseCase: RemoveNoteUseCase
    
    init(notes: [Note] = [], createNoteUseCase: CreateNoteUseCase = CreateNoteUseCase(),
         fetchAllNotesUseCase: FetchAllNotesUseCase = FetchAllNotesUseCase(),
         updateNoteUseCase: UpdateNoteUseCase = UpdateNoteUseCase(),
         removeNoteUseCase: RemoveNoteUseCase = RemoveNoteUseCase()) {
        self.notes = notes
        self.createNoteUseCase = createNoteUseCase
        self.fetchAllNotesUseCase = fetchAllNotesUseCase
        self.updateNoteUseCase = updateNoteUseCase
        self.removeNoteUseCase = removeNoteUseCase
        fetchAllNotes()
    }
    
    func fetchAllNotes() {
        do {
            notes = try fetchAllNotesUseCase.fetchAll()
        } catch {
            print("Error \(error.localizedDescription)")
        }
    }
    
    func createNote(title: String, text: String) {
        do {
            try createNoteUseCase.createNote(title: title, text: text)
            fetchAllNotes()
        } catch {
            print("Error \(error.localizedDescription)")
        }
    }
    
    func updateNote(identifier: UUID, newTitle: String, newText: String?) {
        if let index = notes.firstIndex(where: { $0.identifier == identifier} ) {
            let updateNote = Note(identifier: identifier, title: newTitle, text: newText, createdAt: notes[index].createdAt)
            notes[index] = updateNote
        }
    }
    
    func removeNote(identifier: UUID) {
        do {
            if let index = notes.firstIndex(where: { $0.identifier == identifier }) {
                try removeNoteUseCase.removeNote(note: notes[index])
                fetchAllNotes()
            }
        } catch {
            print("Error \(error.localizedDescription)")
        }
    }
}
