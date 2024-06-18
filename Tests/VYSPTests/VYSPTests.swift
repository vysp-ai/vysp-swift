import XCTest
@testable import VYSP

final class VYSPTests: XCTestCase {
    var client: VYSPClient!
    
    override func setUp() {
        super.setUp()
        // Initialize your client here, adjust parameters as needed
        client = VYSPClient(tenantApiKey: "your_tenant_api_key", gateApiKey: "your_gate_api_key")
    }
    
    func testCheckInput() async throws {
        // test data setup
        let clientRefUserId = "user123"
        let prompt = "test prompt"
        let clientRefInternal = true
        let metadata = ["sample": "data"]
        
        // get checkInput result
        let result = try await client.checkInput(clientRefUserId: clientRefUserId, prompt: prompt, clientRefInternal: clientRefInternal, metadata: metadata)
        
        
        if let resultDict = result as? [String: Any], let status = resultDict["status"] as? String {
            XCTAssertEqual(status, "success", "Expected status to be 'success'")
        } else {
            XCTFail("Failed to parse response as dictionary")
        }
    }
    
    func testCheckOutput() async throws {
        // test data setup
        let clientRefUserId = "user123"
        let prompt = "test prompt"
        let modelOutput = "model output"
        let clientRefInternal = false
        let metadata = ["sample": "data"]
        
        // get checkOutput result
        let result = try await client.checkOutput(clientRefUserId: clientRefUserId, prompt: prompt, modelOutput: modelOutput, clientRefInternal: clientRefInternal, metadata: metadata)
        
        
        if let resultDict = result as? [String: Any], let status = resultDict["status"] as? String {
            XCTAssertEqual(status, "success", "Expected status to be 'success'")
        } else {
            XCTFail("Failed to parse response as dictionary")
        }
    }
}
