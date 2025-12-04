import Foundation

protocol NotesService {
    func fetchPosts() async throws -> [NoteResponse]
}

final class NotesServiceImplementation: NotesService {
    let apiClient: APIService
    
    init(apiClient: APIService) {
        self.apiClient = apiClient
    }
    
    func fetchPosts() async throws -> [NoteResponse] {
        let endpoint = Endpoint(
            path: APIConstants.baseURL.rawValue,
            method: .GET
        )
        return try await apiClient.request(endpoint: endpoint, response: [NoteResponse].self)
    }
}
