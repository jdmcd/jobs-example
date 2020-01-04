import Vapor
import JobsRedisDriver

// Called before your application initializes.
func configure(_ app: Application) throws {
    try app.jobs.use(.redis(url: "redis://localhost:6379"))
    try routes(app)
    try jobs(app)
}
