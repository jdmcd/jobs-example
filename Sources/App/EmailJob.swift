import Foundation
import Jobs
import Vapor

struct Email: Codable {
    let to: String
}

struct EmailJob: Job {
    typealias Payload = Email
    
    func dequeue(_ context: JobContext, _ payload: EmailJob.Payload) -> EventLoopFuture<Void> {
        print(payload)
        return context.eventLoop.future()
    }
}
