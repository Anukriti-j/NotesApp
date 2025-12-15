import Foundation
import MyNetworkingKit

protocol NotesService {
    func fetchPosts() async throws -> [NoteResponse]
}

final class NotesServiceImplementation: NotesService {
    let apiClient: APIService
    
    init(apiClient: APIService = APIClient()) {
        self.apiClient = apiClient
    }
    
    func fetchPosts() async throws -> [NoteResponse] {
        return try await apiClient.request(endpoint: APIConstants.baseURL.rawValue, response: [NoteResponse].self)
    }
}


