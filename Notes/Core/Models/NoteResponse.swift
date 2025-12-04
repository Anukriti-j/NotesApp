import Foundation

struct NoteResponse: Codable, Identifiable, Equatable {
    let userID: Int?
    let id: Int
    let title, body: String
    
    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}

