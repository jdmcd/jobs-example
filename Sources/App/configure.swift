import Vapor
import Redis
import RedisJobs

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    services.register(Router.self) { container -> EngineRouter in
        let router = EngineRouter.default()
        try routes(router, container)
        return router
    }

    /// Register middleware
    var middlewares = MiddlewareConfig() // Create _empty_ middleware config
    /// middlewares.use(FileMiddleware.self) // Serves files from `Public/` directory
    middlewares.use(ErrorMiddleware.self) // Catches errors and converts to HTTP response
    services.register(middlewares)

    /// Redis
    //MARK: - Redis
    try services.register(RedisProvider())
    
    let redisUrlString = "redis://localhost:6379"
    guard let redisUrl = URL(string: redisUrlString) else { throw Abort(.internalServerError) }
    let redisConfig = try RedisDatabase(config: RedisClientConfig(url: redisUrl))
    
    var databaseConfig = DatabasesConfig()
    databaseConfig.add(database: redisConfig, as: .redis)
    services.register(databaseConfig)
    
    services.register(JobsPersistenceLayer.self) { container -> RedisJobs in
        return RedisJobs(database: redisConfig, eventLoop: container.next())
    }
    
    try jobs(&services)
}
