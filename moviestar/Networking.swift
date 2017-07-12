//
//  Networking.swift
//  moviestar
//
//  Created by Douglas Taquary on 09/07/17.
//  Copyright © 2017 Douglas Taquary. All rights reserved.
//

import Moya
import RxSwift
//import JWT


class OnlineProvider<Target>: RxMoyaProvider<Target> where Target: TargetType {
    
    init(endpointClosure: @escaping EndpointClosure = MoyaProvider.defaultEndpointMapping,
         plugins: [PluginType] = []) {
        super.init(endpointClosure: endpointClosure, plugins: plugins)
    }
}


protocol NetworkingType {
    associatedtype T: TargetType
    var provider: OnlineProvider<MovieStarAPI> { get }
}


struct Networking: NetworkingType {
    typealias T = MovieStarAPI
    let provider: OnlineProvider<MovieStarAPI>
}




extension Networking {
    func request(_ token: MovieStarAPI) -> Observable<Moya.Response> {
        return self.provider.request(token)
    }
}


extension NetworkingType {
    static func newDefaultNetworking() -> Networking {
        return Networking(provider: newProvider([NetworkLoggerPlugin(verbose: true)]))
    }
    
    
    static func endpointsClosure<T>(_ Authorization: String? = nil) -> (T) -> Endpoint<T> where T: TargetType {
        return { target in
            var endpoint: Endpoint<T> = Endpoint<T>(url: url(target), sampleResponseClosure: {.networkResponse(200, target.sampleData)}, method: target.method, parameters: target.parameters)
            
            // If we were given an Authorization, add it
            if let Authorization = Authorization {
                endpoint = endpoint.adding(httpHeaderFields: ["Authorization": Authorization])
            }
            
            return endpoint.adding(newHTTPHeaderFields: ["trakt-api-version": "2", "trakt-api-key": APIKeys().clientID])
        }
    }

}


private func newProvider<T>(_ plugins: [PluginType]) -> OnlineProvider<T> where T: TargetType {
    return OnlineProvider(plugins: plugins)
}


