//
//  PostController.swift
//
//
//  Created by Brian Hasenstab on 11/7/23.
//

import Fluent
import Vapor

struct PostController: RouteCollection {
    func feed(request: Request) async throws -> Response {
        return .init(status: .ok)
    }
    
    func index(request: Request) async throws -> View {
        let posts = try await Post.query(on: request.db).all()
        
        return try await request.view.render("posts", ["posts": posts])
    }

    func view(request: Request) async throws -> View {
        guard let stringId = request.parameters.get("post_id"),
              let id = UUID(uuidString: stringId) else {
            print(request.parameters)
            print("Cannot pull post id")
            return try await request.view.render("post")
        }
        
        guard let post = try await Post.find(id, on: request.db) else {
            return try await request.view.render("post")
        }

        return try await request.view.render("post", ["post": post])
    }

    func create(request: Request) async throws -> Post {
        let post = try request.content.decode(Post.self)
        try await post.save(on: request.db)
        return post
    }

    func boot(routes: RoutesBuilder) throws {
        routes.get("posts", use: index)
        routes.get("posts", ":post_id", use: view)
        routes.post("posts", use: create)
        routes.get("feed", use: feed)
    }
}
