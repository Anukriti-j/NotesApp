import Foundation

protocol NotesService {
    func fetchPosts() async throws -> [PostResponse]
}

final class NotesServiceImplementation: NotesService {
    let apiClient: APIService
    
    init(apiClient: APIService) {
        self.apiClient = apiClient
    }
    
    func fetchPosts() async throws -> [PostResponse] {
        let endpoint = Endpoint(
            path: APIConstants.baseURL.rawValue,
            method: .GET
        )
        return try await apiClient.request(endpoint: endpoint, response: [PostResponse].self)
    }
}
