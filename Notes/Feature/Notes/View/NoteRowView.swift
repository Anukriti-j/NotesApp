import SwiftUI

struct NoteRowView: View {
    let note: Note
    let isLast: Bool
    let loadNext: () async -> Void

    var body: some View {
        NavigationLink {
            NoteDetailView(note: note)
        } label: {
            NoteCardView(note: note)
        }
        .onAppear {
            if isLast {
                Task { await loadNext() }
            }
        }
    }
}
