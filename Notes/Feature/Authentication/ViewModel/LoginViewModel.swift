import Foundation
import SwiftUI
import CoreData

@MainActor
final class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var showPassword = false
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var showAlert = false
    
    init() {
        StorageManager.manager.setUpGuestUser()
    }
    
    func isFormValid() -> Bool {
        guard !email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
            !password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            errorMessage = StringConstants.requiredField.rawValue
            showAlert = true
            return false
        }
        return true
    }
    
    func login() {
        print("Login called")
        isLoading = true
        defer {
            isLoading = false
        }
        do {
            try StorageManager.manager.authenticateUser(email: email, password: password)
        } catch {
            errorMessage = StringConstants.userNotFound.rawValue
            showAlert = true
        }
    }
}
