import Foundation
import Jobs
import Vapor

struct EmailJob: Job {
    let to: String
    let from: String
    let message: String
    
    func dequeue(context: JobContext, worker: EventLoopGroup) -> EventLoopFuture<Void> {
        print(to)
        print(from)
        print(message)
        
        return worker.future(error: Abort(.badRequest))
    }
    
    func error(context: JobContext, error: Error, worker: EventLoopGroup) -> EventLoopFuture<Void> {
        print(error)
        return worker.future()
    }
}
