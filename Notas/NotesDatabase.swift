//
//  NotesDatabase.swift
//  Notas
//
//  Created by Adrian Aranda Campanario on 2/7/24.
//

import Foundation
import SwiftData

enum DatabaseError: Error {
    case errorInsert
    case errorFetch
    case errorUpdate
    case errorRemove
}

protocol NotesDatabaseProtocol {
    func fetchAll() throws -> [Note]
    func insert(note: Note) throws
    func remove(identifier: UUID) throws
    func update(identifier: UUID, title: String, text: String?) throws
}

class NotesDatabase: NotesDatabaseProtocol {
    static let shared: NotesDatabase = NotesDatabase()
    
    @MainActor
    var container: ModelContainer = setupContainer(inMemory: false)
    
    private init() { }
    
    @MainActor 
    static func setupContainer(inMemory: Bool) -> ModelContainer {
        do {
            let container = try ModelContainer(for: Note.self, configurations: ModelConfiguration(isStoredInMemoryOnly: inMemory))
            container.mainContext.autosaveEnabled = true
            return container
        } catch {
            print("Error \(error.localizedDescription)")
            fatalError()
        }
    }
    
    @MainActor
    func insert(note: Note) throws {
        container.mainContext.insert(note)
        do {
            try container.mainContext.save()
        } catch {
            print("Error \(error.localizedDescription)")
            throw DatabaseError.errorInsert
        }
    }
    
    @MainActor
    func update(identifier: UUID, title: String, text: String?) throws {
        let notePredicate = #Predicate<Note> {
            $0.identifier == identifier
        }
        
        var fetchDescriptor = FetchDescriptor<Note>(predicate: notePredicate)
        fetchDescriptor.fetchLimit = 1
        
        do {
            guard let updateNote = try container.mainContext.fetch(fetchDescriptor).first else {
                throw DatabaseError.errorUpdate
            }
            
            updateNote.title = title
            updateNote.text = text
            
            try container.mainContext.save()
        } catch {
            print("Error actualizando información")
            throw DatabaseError.errorUpdate
        }
    }
    
    @MainActor
    func remove(identifier: UUID) throws {
        let notePredicate = #Predicate<Note> {
            $0.identifier == identifier
        }
        
        var fetchDescriptor = FetchDescriptor<Note>(predicate: notePredicate)
        fetchDescriptor.fetchLimit = 1
        
        do {
            guard let deleteNote = try container.mainContext.fetch(fetchDescriptor).first else {
                throw DatabaseError.errorRemove
            }
            
            container.mainContext.delete(deleteNote)
            try container.mainContext.save()
        } catch {
            print("Error borrando información")
            throw DatabaseError.errorRemove
        }
    }
    
    @MainActor
    func fetchAll() throws -> [Note] {
        let fetchDescriptor = FetchDescriptor<Note>(sortBy: [SortDescriptor<Note>(\.createdAt)])
        do {
            return try container.mainContext.fetch(fetchDescriptor)
        } catch {
            print("Error \(error.localizedDescription)")
            throw DatabaseError.errorFetch
        }
    }
}
