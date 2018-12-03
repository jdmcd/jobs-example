import Vapor
import Jobs

public func routes(_ router: Router, _ container: Container) throws {
    let queue = try container.make(QueueService.self)
    try router.register(collection: TodoController(queue: queue))
}
