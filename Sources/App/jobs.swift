//
//  jobs.swift
//  App
//
//  Created by Jimmy McDermott on 12/3/18.
//

import Foundation
import Vapor
import Jobs

public func jobs(_ services: inout Services, persistenceLayer: JobsPersistenceLayer) throws {
    /// Jobs
    let jobsProvider = JobsProvider(persistenceLayer: persistenceLayer, refreshInterval: .seconds(10))
    try services.register(jobsProvider)
    
    let emailService = EmailService()
    var jobContext = JobContext()
    jobContext.emailService = emailService
    services.register(emailService)
    
    //Register jobs
    var jobsConfig = JobsConfig()
    jobsConfig.add(EmailJob.self)
    services.register(jobsConfig)
    
    services.register { _ -> CommandConfig in
        var commandConfig = CommandConfig.default()
        commandConfig.use(JobsCommand(), as: "jobs")
        
        return commandConfig
    }
}

extension JobContext {
    var emailService: EmailService? {
        get {
            return userInfo[String(describing: self)] as? EmailService
        }
        set {
            userInfo[String(describing: self)] = newValue
        }
    }
}
