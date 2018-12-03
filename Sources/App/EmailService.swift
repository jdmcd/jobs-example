import Foundation
import Vapor

struct EmailService: Service {
    func send(to: String, from: String, message: String) -> String {
        return "Sending message to: \(to), from: \(from), with message: \(message)"
    }
}
