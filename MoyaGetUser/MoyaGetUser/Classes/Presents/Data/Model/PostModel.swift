//
//  PostModel.swift
//  MoyaGetUser
//
//  Created by ken.phanith on 2018/09/18.
//  Copyright © 2018 Pich. All rights reserved.
//

import Foundation

struct PostModel: Decodable{
    var userId: Int
    var id: Int
    var title: String
    var body: String
    
}
