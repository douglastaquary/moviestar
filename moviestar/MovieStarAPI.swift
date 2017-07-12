//
//  MovieStarAPI.swift
//  moviestar
//
//  Created by Douglas Taquary on 09/07/17.
//  Copyright © 2017 Douglas Taquary. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import Alamofire

enum MovieStarAPI {
    
    case xAuth(response_type: String, client_id: String, redirect_uri: String)
}

extension MovieStarAPI: TargetType {
    
    
    var base: String { return "https://api.trakt.tv" }
    var baseURL: URL { return URL(string: base)! }
    
    
    var path: String {
        switch self {
        case .xAuth:
            return "/oauth/authorize"
        }
    }
    
    var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .xAuth(let response_type, let client_id, let redirect_uri):
            return ["response_type": response_type as AnyObject,
                    "client_id": client_id as AnyObject,
                    "redirect_uri" : redirect_uri]
        }
    }
    
    var parameterEncoding: Moya.ParameterEncoding {
        switch self {
        default:
            return URLEncoding.default
        }
        
    }
    
    var task: Task {
        return .request
    }
    
    var sampleData: Data {
        switch self {
        case .xAuth:
            return stubbedResponse("xAuth")
        }
    }
}


// MARK: Provider Support

func stubbedResponse(_ filename: String) -> Data! {
    @objc class TestClass: NSObject { }
    
    let bundle = Bundle(for: TestClass.self)
    let path = bundle.path(forResource: filename, ofType: "json")
    return (try? Data(contentsOf: URL(fileURLWithPath: path!)))
}


private extension String {
    var URLEscapedString: String {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)!
    }
}

func url(_ route: TargetType) -> String {
    return route.baseURL.appendingPathComponent(route.path).absoluteString
}

