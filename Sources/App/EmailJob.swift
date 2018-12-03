import Foundation
import Jobs
import Vapor

struct EmailJob: Job {
    var maxRetryCount = 0
    let to: String
    let from: String
    let message: String
    
    func dequeue(context: JobContext, worker: EventLoopGroup) throws -> EventLoopFuture<Void> {
        guard let emailService = context.emailService else { throw Abort(.internalServerError, reason: "Register email service") }
        let string = emailService.send(to: to, from: from, message: message)
        return worker.future()
    }
}
