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
        let job = EmailJob(maxRetryCount: 0, to: "to@to.com", from: "from@from.com", message: "message")
        return try queue.dispatch(job: job).transform(to: .ok)
    }
}
