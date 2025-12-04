import Foundation

struct LoggerInterceptor {
    
    static func logRequest(_ request: URLRequest) {
#if DEBUG
        print("\n REQUEST")
        
        if let method = request.httpMethod, let url = request.url?.absoluteString {
            print("[\(method)] \(url)")
        }
    
#endif
    }
    
    static func logResponse(data: Data, response: URLResponse) {
#if DEBUG
        print("\n RESPONSE ")
        
        if let http = response as? HTTPURLResponse {
            print("Status Code:", http.statusCode)
        }
        
        let body = String(data: data, encoding: .utf8) ?? "<Invalid Data>"
        print("Response Body:", body)
        print("====================================================\n")
#endif
    }
   
}
