//
//  ViewControllerReactor.swift
//  MoyaGetUser
//
//  Created by ken.phanith on 2018/09/18.
//  Copyright © 2018 Pich. All rights reserved.
//

import Foundation
import RxSwift
import ReactorKit
import RxCocoa
import Moya

final class ViewControllerReactor: Reactor {
    
    enum Action {
        case clickBtn
//        case didLoad
    }
    enum Mutation {
//        case btnClicked([PostModel])
        case displayData([PostModel])
    }
    
    private let viewController: ViewController
    var postProvider = MoyaProvider<PostService>()
    
     var initialState: ViewControllerReactor.State
    
    init(viewController: ViewController) {
        self.viewController = viewController
        self.initialState = State(data: [])
    }
    
    struct State {
        var data: [PostModel]
    }
    
}

extension ViewControllerReactor {
    func mutate(action: ViewControllerReactor.Action) -> Observable<ViewControllerReactor.Mutation> {
        switch action {
        case .clickBtn:
            return Observable.empty()
        }
        
    }
    
    func reduce(state: ViewControllerReactor.State, mutation: ViewControllerReactor.Mutation) -> ViewControllerReactor.State {
        var newState = state
        switch mutation {
        case .displayData(let data):
            newState.data = data
            self.postProvider.request(.readPost) { (result) in
                switch result{
                case .success(let response):
                    let json = try! JSONSerialization.jsonObject(with: response.data, options: [])
                    print("!!!!!!")
                    print(json)
            
                case .failure(let error):
                    print(error)
                }
            }
        }
        return newState
        
    }
}
