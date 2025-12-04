import SwiftUI

struct NoteCardView: View {
    let note: NoteResponse
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(note.title)
                .font(.headline)
            
            Text(note.body)
                .font(.caption)
                .lineLimit(2)
            
            //TODO: handle timestamp
            Text("updated timestamp")
                .font(.caption2)
                .fontWeight(.bold)
                .foregroundStyle(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(.thinMaterial)
        .cornerRadius(16)
        .shadow(radius: 2, y: 1)
    }
}

#Preview {
    NoteCardView(note: NoteResponse(userID: 1, id: 1, title: "test", body: "Test body"))
}
