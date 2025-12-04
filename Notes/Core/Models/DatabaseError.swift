import Foundation

enum DatabaseError: Error {
    case userNotFound
    
    var errorDescription: String {
        switch self {
        case .userNotFound:
            StringConstants.userNotFound.rawValue
        }
    }
}
