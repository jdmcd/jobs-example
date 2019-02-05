import Foundation
import Jobs
import Vapor

struct Email: Codable, JobData {
    let to: String
}

struct EmailJob: Job {
    func dequeue(_ context: JobContext, _ data: Email) -> EventLoopFuture<Void> {
        print(data)
        return context.eventLoop.future()
    }
}
