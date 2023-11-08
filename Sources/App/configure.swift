import NIOSSL
import Fluent
import FluentSQLiteDriver
import Leaf
import Vapor

// configures your application
public func configure(_ app: Application) async throws {
     app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    app.databases.use(DatabaseConfigurationFactory.sqlite(.file("db.sqlite")), as: .sqlite)

    app.migrations.add(CreatePost())

    app.views.use(.leaf)

    if !app.environment.isRelease {
        try await app.autoMigrate()
    }
    // register routes
    try routes(app)
}
