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
        let job = Email(to: "test@test.com")
        return try queue.dispatch(jobData: job, maxRetryCount: 10).transform(to: .ok)
    }
}
