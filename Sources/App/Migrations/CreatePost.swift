//
//  CreatePost.swift
//
//
//  Created by Brian Hasenstab on 11/7/23.
//

import Fluent

final class CreatePost: AsyncMigration {
    func prepare(on database: FluentKit.Database) async throws {
        try await database.schema(Post.schema)
            .id()
            .field("title", .string, .required)
            .field("blurb", .string, .required)
            .field("body", .string, .required)
            .field("categories", .array(of: .string), .required)
            .field("created_at", .datetime, .required)
            .field("updated_at", .datetime, .required)
            .create()
    }
    
    func revert(on database: Database) async throws {
        try await database.schema(Post.schema)
            .delete()
    }
    
}
