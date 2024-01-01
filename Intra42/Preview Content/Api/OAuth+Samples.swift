//
//  OAuth+Samples.swift
//  Intra42
//
//  Created by Marc Mosca on 01/01/2024.
//

import Foundation

extension Api.Types.OAuth.AppToken
{
    
    static let sample = Self.init(accessToken: "1a66f638b55a50566c368081bf908b1d37bad323e1ec2f94ff59655350b73f74")
    
}

extension Api.Types.OAuth.UserToken
{
    
    static let sample = Self.init(
        accessToken: "538a8e2d0fddbf5f84990add37b2b25a47421e2e14c3a6227fc49adfe85986b2",
        refreshToken: "fbf60918ee43eb6ec206d724c93c9e0a98a75d73e57619b3351032262cdd3532"
    )
    
}
