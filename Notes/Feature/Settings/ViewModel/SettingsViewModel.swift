import Foundation

final class SettingsViewModel: ObservableObject {
    
    func logout() {
        StorageManager.manager.clearSession()
    }
}
