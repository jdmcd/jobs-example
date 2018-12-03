import FluentSQLite
import Vapor
import Jobs
import Redis

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {

    /// Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)

    /// Register middleware
    var middlewares = MiddlewareConfig() // Create _empty_ middleware config
    /// middlewares.use(FileMiddleware.self) // Serves files from `Public/` directory
    middlewares.use(ErrorMiddleware.self) // Catches errors and converts to HTTP response
    services.register(middlewares)

    /// Redis
    //MARK: - Redis
    try services.register(RedisProvider())
    
    //MARK: - Databases
    services.register { container -> DatabasesConfig in
        guard let redisUrlString = Environment.get("REDIS_URL") else { throw Abort(.internalServerError) }
        guard let redisUrl = URL(string: redisUrlString) else { throw Abort(.internalServerError) }
        let redisConfig = try RedisDatabase(config: RedisClientConfig(url: redisUrl))
        
        var databaseConfig = DatabasesConfig()
        databaseConfig.add(database: redisConfig, as: .redis)
        return databaseConfig
    }
    
    /// Jobs
    let redisClient = RedisClient
    JobsProvider(persistenceLayer: <#T##JobsPersistenceLayer#>, refreshInterval: <#T##TimeAmount#>, persistenceKey: <#T##String#>)
}
