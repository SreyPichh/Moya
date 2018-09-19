//
//  PostService.swift
//  MoyaGetUser
//
//  Created by ken.phanith on 2018/09/18.
//  Copyright © 2018 Pich. All rights reserved.
//

import Foundation
import Moya

enum PostService {
    case createPost(userId: Int, title: String)
    case readPost
    case updatePost(id: Int, title: String)
    case deletePost(id: Int)
    
}

//TargetType Protocol implement

extension PostService: TargetType {
    var baseURL: URL {
        return URL(string: "https://jsonplaceholder.typicode.com")!
    }

    var path: String {
        switch self {
        case .createPost(_, _), .readPost:
            return "/posts"

        case .deletePost(let id), .updatePost(let id, _):
            return "/posts/\(id)"
        }
    }

    var method: Moya.Method {
        switch self {
        case .createPost(_, _):
            return .post
        case .readPost:
            return .get

        case .updatePost(_, _):
            return .put

        case .deletePost(_):
            return .delete
        }
    }

    var sampleData: Data {
        switch self {
        case .createPost(let userId, let title):
            return "{'userId': '\(userId)', 'title': '\(title)'}".data(using: .utf8)!

        case .readPost:
            return Data()

        case .updatePost(let id, let title):
            return "{'id': '\(id)', 'title': '\(title)'}".data(using: .utf8)!

        case .deletePost(let id):
            return "{'id': '\(id)'}".data(using: .utf8)!

        }
    }

    var task: Task {
        switch self {
        case .readPost, .deletePost(_):
            return .requestPlain

        case .createPost(_, let title), .updatePost(_, let title):
            return .requestParameters(parameters: ["title": title], encoding: JSONEncoding.default)
        }
    }

    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }


}


