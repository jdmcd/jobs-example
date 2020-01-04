import Foundation

struct EmailService {
    func send(to: String, from: String, message: String) -> String {
        return "Sending message to: \(to), from: \(from), with message: \(message)"
    }
}
