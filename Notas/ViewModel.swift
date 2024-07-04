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
    var databaseError: DatabaseError?
    
    var createNoteUseCase: CreateNoteProtocol
    var fetchAllNotesUseCase: FetchAllNotesProtocol
    var updateNoteUseCase: UpdateNoteProtocol
    var removeNoteUseCase: RemoveNoteProtocol
    
    init(notes: [Note] = [], createNoteUseCase: CreateNoteProtocol = CreateNoteUseCase(),
         fetchAllNotesUseCase: FetchAllNotesProtocol = FetchAllNotesUseCase(),
         updateNoteUseCase: UpdateNoteProtocol = UpdateNoteUseCase(),
         removeNoteUseCase: RemoveNoteProtocol = RemoveNoteUseCase()) {
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
        do {
            try updateNoteUseCase.updateNote(identifier: identifier, title: newTitle, text: newText)
        } catch {
            print("Error \(error.localizedDescription)")
        }
    }
    
    func removeNote(identifier: UUID) {
        do {
            try removeNoteUseCase.removeNote(identifier: identifier)
            fetchAllNotes()
        } catch let error as DatabaseError {
            print("Error \(error.localizedDescription)")
            databaseError = error
        }catch {
            print("Error \(error.localizedDescription)")
        }
    }
}
