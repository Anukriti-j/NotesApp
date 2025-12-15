import SwiftUI

struct NoteDetailView: View {
    let note: Note
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Title")
                        .font(.caption)
                        .foregroundColor(.gray)

                    Text(note.title ?? "Not found")
                        .font(.title2)
                        .fontWeight(.semibold)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Description")
                        .font(.caption)
                        .foregroundColor(.gray)

                    Text(note.body ?? "Not found")
                        .font(.body)
                        .foregroundColor(.primary)
                }
                
                Divider()
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Created At")
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    Text(formatDate(note.createdAt))
                        .font(.footnote)
                    
                    Text("Updated At")
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    Text(formatDate(note.updatedAt))
                        .font(.footnote)
                }
            }
            .padding()
        }
        .navigationTitle("Note Details")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func formatDate(_ date: Date?) -> String {
        guard let date else { return "Not found" }
        return date.formatted(date: .abbreviated, time: .shortened)
    }
}

#Preview {
    NoteDetailView(note: Note())
}
