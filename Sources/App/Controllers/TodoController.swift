import Vapor
import Jobs

final class TodoController {    
    func addToQueue(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        return req.jobs.dispatch(EmailJob.self, .init(to: "test@test.com"), maxRetryCount: 10).transform(to: .ok)
    }
}
