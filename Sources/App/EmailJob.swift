import Foundation
import Jobs
import Vapor

struct EmailJob: Job {
    var maxRetryCount = 0
    let to: String
    let from: String
    let message: String
    
    func dequeue(context: JobContext, worker: EventLoopGroup) -> EventLoopFuture<Void> {
        print(to)
        print(from)
        print(message)
        
        return worker.future()
    }
    
    func error(context: JobContext, error: Error, worker: EventLoopGroup) -> EventLoopFuture<Void> {
        print(error)
        return worker.future()
    }
}
