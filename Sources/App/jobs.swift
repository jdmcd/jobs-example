//
//  jobs.swift
//  App
//
//  Created by Jimmy McDermott on 12/3/18.
//

import Foundation
import Vapor
import Jobs

public func jobs(_ app: Application) throws {
    app.jobs.add(EmailJob())
    app.commands.use(JobsCommand(application: app), as: "jobs")
}
