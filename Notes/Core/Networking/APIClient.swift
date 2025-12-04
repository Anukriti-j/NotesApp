import Foundation

protocol APIService {
    func request<T: Codable>(endpoint: Endpoint, response: T.Type) async throws -> T
}

final class APIClient: APIService {
    func request<T: Codable>(endpoint: Endpoint, response: T.Type) async throws -> T {
        
        guard let url = URL(string: endpoint.path) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        
        LoggerInterceptor.logRequest(request)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        LoggerInterceptor.logResponse(data: data, response: response)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch {
            throw NetworkError.decodingError
        }
    }
}

