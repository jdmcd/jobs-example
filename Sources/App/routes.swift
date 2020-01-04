import Vapor
import Jobs

public func routes(_ app: Application) throws {
    let controller = TodoController()
    app.routes.get("/queue", use: controller.addToQueue)
}
