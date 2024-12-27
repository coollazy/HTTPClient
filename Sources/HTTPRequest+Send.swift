import Foundation
#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif
import HTTPType

public extension HTTPRequest {
    func transformURLRequest() throws -> URLRequest {
        guard let url else {
            throw HTTPSessionError.transformRequestFailed
        }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        request.httpMethod = method.rawValue
        request.httpBody = body
        
        return request
    }
    
    func send() async throws -> HTTPResponse {
        try await Client.shared.send(self)
    }
    
    func send(client: Client) async throws -> HTTPResponse {
        try await client.send(self)
    }
}
