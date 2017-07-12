import Foundation
import Keys

private let minimumKeyLength = 2

// Mark: - API Keys
struct APIKeys {
    let clientID: String
    let secret: String
    
    // MARK: Shared Keys
    fileprivate struct SharedKeys {
        static var instance = APIKeys()
    }
    
    static var sharedKeys: APIKeys {
        get {
            return SharedKeys.instance
        }
        
        set (newSharedKeys) {
            SharedKeys.instance = newSharedKeys
        }
    }
    
//    // MARK: Methods
    var stubResponses: Bool {
        return clientID.characters.count < minimumKeyLength || secret.characters.count < minimumKeyLength
    }
    
    // MARK: Initializers
    init(clientID: String, secret: String) {
        self.clientID = clientID
        self.secret = secret
    }
    
    init(keys: MovieStarKeys) {
        self.init(clientID: keys.movieStarAPIClientID , secret: keys.movieStarAPIClientSecret )
    }
    
    init() {
        let keys = MovieStarKeys()
        self.init(keys: keys)
    }
}
