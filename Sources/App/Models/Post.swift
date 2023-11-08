//
//  Post.swift
//
//
//  Created by Brian Hasenstab on 11/7/23.
//

import Fluent
import Vapor

final class Post: Model, Content {
    static let schema = "posts"
    
    @ID(key: .id) var id: UUID?
    @Field(key: "title") var title: String
    @Field(key: "blurb") var blurb: String
    @Field(key: "body") var body: String
    @Field(key: "categories") var categories: [String]
    
    @Timestamp(key: "created_at", on: .create) var createdAt: Date?
    @Timestamp(key: "updated_at", on: .update) var updatedAt: Date?

    init() {}
}
