# VYSP.AI Swift Client Library

For use with the VYSP.AI API for securing AI and LLM applications. Visit [VYSP.AI](https://vysp.ai) for more information.

## Features

- Check user inputs and outputs for compliance with security rules.
- Easy integration with existing Swift applications.
- Support for asynchronous network calls using modern Swift concurrency features.

## Requirements

- iOS 15.0+ / macOS 12.0+ / tvOS 15.0+ / watchOS 8.0+
- Swift 5.5+
- Xcode 13.0+

## Prerequisites

You need a [VYSP.AI](https://dashboard.vysp.ai/signup) account, with at least one [Gate](https://docs.vysp.ai/basic-concepts-of-vysp.ai-security-api) configured.

### VYSP.AI Setup

#### Get started on the VYSP.AI Platform
Navigate to [VYSP.AI](https://dashboard.vysp.ai/signup)
Sign up for an account, and move on to the next step.

#### Create a Gate
Once you're logged in, go to "Gates" in the sidebar or navigate to https://dashboard.vysp.ai/gates

Click "Add Gate" in the top right, and enter a name for your application, like "Chat Application"

#### Add Rule
Go to the Flows page in the sidebar, and you'll see that two flows were created, one input flow and one output flow.

Go to the Input Flow and click "Add Rule". Enter a name, and select "Prompt Injection Detection". Click "Submit" and you'll see that the rule was created.

Add any other rules you want to use.

## Installation

### Using Swift Package Manager

Add to your project by adding it as a dependency in your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/vysp-ai/vysp-swift.git", .upToNextMajor(from: "0.0.1"))
]
```

Then, add to your target dependencies:

```swift
targets: [
    .target(
        name: "YourTarget",
        dependencies: ["VYSPClient"]),
]
```

## Usage

To use in your project, import the package and initialize the client with necessary API keys. Here are examples demonstrating how to check inputs and outputs:

### Inititalize the client
```swift
import VYSP
import Foundation

let client = VYSPClient(tenantApiKey: "your_tenant_api_key", gateApiKey: "your_gate_api_key")
```

### Check User Input
```swift
async {
    do {
        let result = try await client.checkInput(clientRefUserId: "user123", prompt: "test input")
        print("Input check result: \(result)")
    } catch {
        print("Error occurred: \(error)")
    }
}
```

### Check User Output
```swift
import Foundation

async {
    do {
        let result = try await client.checkOutput(clientRefUserId: "user123", prompt: "test input", modelOutput: "test output")
        print("Output check result: \(result)")
    } catch {
        print("Error occurred: \(error)")
    }
}

```

## API Reference

 - `checkInput(clientRefUserId: String, prompt: String, clientRefInternal: Bool, metadata: [String: Any]) -> Any`: Checks a given input against configured security rules.
 - `checkOutput(clientRefUserId: String, prompt: String, modelOutput: String, clientRefInternal: Bool, metadata: [String: Any]) -> Any`: Checks a given output against configured security rules.

## Contributing

Contributions to the project are welcome! If you have suggestions or improvements, please fork the repository and submit a pull request.

## Reporting Issues

If you encounter any bugs or issues, please report them in the repository's issues section on GitHub.