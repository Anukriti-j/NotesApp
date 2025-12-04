import Foundation

struct User {
    let userId: String
    let email: String
    let password: String
    
    init(userId: String, email: String, password: String) {
        self.userId = userId
        self.email = email
        self.password = password
    }
}
