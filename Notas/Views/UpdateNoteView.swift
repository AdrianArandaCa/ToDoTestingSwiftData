//
//  UpdateNoteView.swift
//  Notas
//
//  Created by Adrian Aranda Campanario on 2/7/24.
//

import SwiftUI

struct UpdateNoteView: View {
    var viewModel: ViewModel
    let identifier: UUID
    @State var title: String = ""
    @State var text: String = ""
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            Form {
                Section {
                    TextField("", text: $title, prompt: Text("*Titulo"), axis: .vertical)
                    TextField("", text: $text, prompt: Text("*Texto"), axis: .vertical)
                }
            }
            Button(action: {
                viewModel.removeNote(identifier: identifier)
                dismiss()
            }, label: {
                Text("Eliminar nota")
                    .foregroundStyle(.gray)
                    .underline()
            })
        }
        .background(Color(uiColor: .systemGroupedBackground))
        .toolbar {
            ToolbarItem {
                Button {
                    viewModel.updateNote(identifier: identifier, newTitle: title, newText: text)
                    dismiss()
                } label: {
                    Text("Guardar nota")
                }
            }
        }
        .navigationTitle("Modificar Nota")
    }
}

#Preview {
    NavigationStack {
        UpdateNoteView(viewModel: .init(), identifier: .init(), title: "Suscribete a SwiftBeta", text: "Aprende")
    }
}
