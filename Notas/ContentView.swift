//
//  ContentView.swift
//  Notas
//
//  Created by Adrian Aranda Campanario on 2/7/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {

    var viewModel: ViewModel = .init()
    @State var showCreateNote: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.notes) { note in
                    NavigationLink(value: note) {
                        VStack(alignment: .leading) {
                            Text(note.title)
                                .foregroundStyle(.primary)
                            Text(note.getText)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .status) {
                    Button(action: {
                        showCreateNote.toggle()
                    }, label: {
                        Label("Crear nota", systemImage: "square.and.pencil")
                            .labelStyle(TitleAndIconLabelStyle())
                    })
                    .buttonStyle(.bordered)
                    .tint(.blue)
                    .bold()
                }
            }
            .navigationTitle("Notas")
            .navigationDestination(for: Note.self, destination: { note in
                UpdateNoteView(viewModel: viewModel, identifier: note.identifier, title: note.title, text: note.getText)
            })
            .fullScreenCover(isPresented: $showCreateNote, content: {
                CreateNoteView(viewModel: viewModel)
            })
        }
    }
}

#Preview {
    ContentView(viewModel: .init(notes: [
        .init(title: "Nota 1", text: "Descripción nota 1", createdAt: .now),
        .init(title: "Nota 2", text: "Descripción nota 2", createdAt: .now)
    ]))
}
