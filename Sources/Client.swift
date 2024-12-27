import Foundation
#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif
import HTTPType

public class Client: Session {
    static var shared = Client()
    
    private var session: URLSession
    
    public init(configuration: URLSessionConfiguration = .default) {
        self.session = URLSession(configuration: configuration)
    }
    
    public func send(_ request: HTTPRequest) async throws -> HTTPResponse {
        let (data, response) = try await session.data(for: request.transformURLRequest())
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw HTTPSessionError.transformResponseFailed
        }
        
        return try httpResponse.toHTTPResponse(data: data)
    }
    
    public func appendAdditionalHeader(_ key: String, value: String) {
        let configuation = session.configuration
        var newHeaders = configuation.httpAdditionalHeaders ?? [:]
        newHeaders[key] = value
        configuation.httpAdditionalHeaders = newHeaders
        
        session = URLSession(configuration: configuation)
    }
    
    public var additionalHeader: [String: String]? {
        session.configuration.httpAdditionalHeaders as? [String: String]
    }
}

extension HTTPURLResponse {
    func toHTTPResponse(data: Data?) throws -> HTTPResponse {
        guard let headers = allHeaderFields as? [String: String] else {
            throw HTTPSessionError.transformResponseFailed
        }
        
        return HTTPResponse(
            statusCode: UInt(statusCode),
            headers: headers,
            body: data
        )
    }
}
