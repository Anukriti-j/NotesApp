import Foundation

enum HTTPMethod: String {
    case GET = "GET"
}

struct Endpoint {
    var path: String
    var method: HTTPMethod
    
    init(path: String, method: HTTPMethod) {
        self.path = path
        self.method = method
    }
}
