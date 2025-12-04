import Foundation

enum DatabaseError: Error {
    case userNotFound
    case deletionError
    case saveError
    case fetchError
    
    var errorDescription: String {
        switch self {
        case .userNotFound:
            StringConstants.userNotFound.rawValue
        case .deletionError:
            StringConstants.deletionError.rawValue
        case .fetchError:
            StringConstants.fetchError.rawValue
        case .saveError:
            StringConstants.saveError.rawValue
        }
    }
}
