import Foundation
import Jobs
import Vapor

struct EmailJob: Job {
    let to: String
    let from: String
    let message: String
    
    func dequeue(context: JobContext, worker: EventLoopGroup) -> EventLoopFuture<Void> {
        return worker.future(error: Abort(.badRequest, reason: "Something went wrong"))
    }
    
    func error(context: JobContext, error: Error, worker: EventLoopGroup) -> EventLoopFuture<Void> {
        return worker.future()
    }
}
