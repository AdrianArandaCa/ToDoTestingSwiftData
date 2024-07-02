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
    func remove(note: Note) throws
    func update(note: Note) throws
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
    func update(note: Note) throws {
        container.mainContext
    }
    
    @MainActor
    func remove(note: Note) throws {
        container.mainContext.delete(note)
        do {
            try container.mainContext.save()
        } catch {
            print("Error \(error.localizedDescription)")
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
