//
//  CreateNoteView.swift
//  Notas
//
//  Created by Adrian Aranda Campanario on 2/7/24.
//

import SwiftUI

struct CreateNoteView: View {
    var viewModel: ViewModel
    @State var title: String = ""
    @State var text: String = ""
    
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("", text: $title, prompt: Text("*Titulo"), axis: .vertical)
                    TextField("", text: $text, prompt: Text("*Texto"), axis: .vertical)
                } footer: {
                    Text("* El titulo es obligatorio")
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cerrar")
                    }
                }
                
                ToolbarItem {
                    Button {
                        viewModel.createNote(title: title, text: text)
                        dismiss()
                    } label: {
                        Text("Crear nota")
                    }
                }
            }
            .navigationTitle("Nueva nota")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    CreateNoteView(viewModel: .init())
}
