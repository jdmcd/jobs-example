import Vapor
import Jobs

final class TodoController: RouteCollection {
    let queue: QueueService
    
    init(queue: QueueService) {
        self.queue = queue
    }
    
    func boot(router: Router) throws {
        router.get("/queue", use: addToQueue)
    }
    
    func addToQueue(req: Request) throws -> Future<HTTPStatus> {
        let job = EmailJob(to: "to@to.com", from: "from@from.com", message: "\(Int.random(in: 0...100))")
        return queue.dispatch(job: job, maxRetryCount: 10).transform(to: .ok)
    }
}
