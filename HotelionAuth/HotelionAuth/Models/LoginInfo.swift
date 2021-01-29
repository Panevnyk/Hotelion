//
//  LoginInfo.swift
//  SaleUp
//
//  Created by sxsasha on 12.03.18.
//  Copyright © 2018 Devlight. All rights reserved.
//

import Foundation

final class LoginInfo: Decodable {
    var token = ""
    var userId = 0
    var fullName = ""
    var providerType = ""
    
    /// CodingKeys
    enum CodingKeys: String, CodingKey {
        case token
        case userId
        case fullName
        case providerType
    }
    
    convenience init(from decoder: Decoder) throws {
        self.init()
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        userId = try container.decode(Int.self, forKey: .userId)
        token = (try? container.decode(String.self, forKey: .token)) ?? ""
        fullName = (try? container.decode(String.self, forKey: .fullName)) ?? ""
        providerType  = (try? container.decode(String.self, forKey: .providerType)) ?? ""
    }
    
    init() {
        
    }
    
    init(socialLoginInfo: SocialLoginInfo, name: String) {
        self.token = socialLoginInfo.token
        self.userId = socialLoginInfo.userId
        self.providerType = socialLoginInfo.providerType
        self.fullName = name
    }
}

final class SocialLoginInfo: Decodable {
    var token = ""
    var userId = 0
    var providerType = ""
    
    /// CodingKeys
    enum CodingKeys: String, CodingKey {
        case token
        case userId
        case providerType
    }
}
