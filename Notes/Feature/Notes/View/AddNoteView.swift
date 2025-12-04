import SwiftUI

struct AddNoteView: View {
    @StateObject private var viewModel = AddNoteViewModel()
    
    var body: some View {
        VStack {
            Form {
                Section {
                    TextField("Title", text: $viewModel.title)
                } header: {
                    Text("Title")
                }

                Section {
                    TextEditor(text: $viewModel.description)
                } header: {
                    Text("Description")
                }
            }
            
            HStack {
                Spacer()
                Button {
                    viewModel.resetNote()
                } label: {
                    Text("Reset")
                }
                Spacer()
                
                Button {
                    viewModel.saveNote()
                } label: {
                    Text("Save")
                }
                Spacer()
            }
            .padding()
           
        }
        .navigationTitle("Add a new Note")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    AddNoteView()
}
