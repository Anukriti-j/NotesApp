import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case decodingError
    
    var errorDescription: String {
        switch self {
        case .invalidURL:
            StringConstants.invalidURL.rawValue
        case .invalidResponse:
            StringConstants.invalidResponse.rawValue
        case .decodingError:
            StringConstants.decodingError.rawValue
        }
    }
}
