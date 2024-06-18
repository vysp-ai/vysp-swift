import Foundation

enum VYSPError: Error {
    case notFound
    case badRequest
    case authenticationFailed
    case apiError
    case invalidURL
    case serializationError
}

@available(macOS 12, iOS 15, watchOS 8, tvOS 15, *)
class VYSPClient {
    var tenantApiKey: String
    var gateApiKey: String
    var installationType: String
    var baseUrl: String

    init(tenantApiKey: String, gateApiKey: String, installationType: String = "cloud", installationUrl: String? = nil) {
        self.tenantApiKey = tenantApiKey
        self.gateApiKey = gateApiKey
        self.installationType = installationType
        self.baseUrl = (installationType == "cloud") ? "https://vyspcloud.com/" : (installationUrl ?? "")
    }

    private func sendRequest(endpoint: String, direction: String, method: String = "POST", data: [String: Any]? = nil) async throws -> Any {
        guard let url = URL(string: "\(baseUrl)\(endpoint)") else {
            throw VYSPError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = method
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(tenantApiKey, forHTTPHeaderField: "X-Tenant-Key")
        request.addValue(gateApiKey, forHTTPHeaderField: "X-Gate-Key")
        request.addValue(direction, forHTTPHeaderField: "X-Check-Type")

        if let data = data {
            request.httpBody = try JSONSerialization.data(withJSONObject: data, options: [])
        }

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw VYSPError.apiError
        }

        switch httpResponse.statusCode {
        case 200..<300:
            return try JSONSerialization.jsonObject(with: data, options: [])
        case 404:
            throw VYSPError.notFound
        case 400:
            throw VYSPError.badRequest
        case 401, 403:
            throw VYSPError.authenticationFailed
        default:
            throw VYSPError.apiError
        }
    }

    func checkInput(clientRefUserId: String, prompt: String, clientRefInternal: Bool = false, metadata: [String: Any] = [:]) async throws -> Any {
        let data: [String: Any] = [
            "client_ref_user_id": clientRefUserId,
            "client_ref_internal": clientRefInternal,
            "prompt": prompt,
            "log_metadata": metadata,
        ]
        return try await sendRequest(endpoint: "gate_check", direction: "input", data: data)
    }

    func checkOutput(clientRefUserId: String, prompt: String, modelOutput: String, clientRefInternal: Bool = false, metadata: [String: Any] = [:]) async throws -> Any {
        let data: [String: Any] = [
            "client_ref_user_id": clientRefUserId,
            "client_ref_internal": clientRefInternal,
            "prompt": prompt,
            "model_output": modelOutput,
            "log_metadata": metadata,
        ]
        return try await sendRequest(endpoint: "gate_check", direction: "output", data: data)
    }
}
