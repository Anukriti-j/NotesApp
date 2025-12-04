import SwiftUI

struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()
    
    var body: some View {
        VStack {
            Form {
                Button {
                    viewModel.logout()
                } label: {
                    Text(StringConstants.logOut.rawValue)
                }
                .foregroundStyle(.red)
            }
        }
        .navigationTitle(StringConstants.settings.rawValue)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    SettingsView()
}
