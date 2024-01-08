//
//  HistorySearch.swift
//  Intra42
//
//  Created by Marc Mosca on 08/01/2024.
//

import SwiftData
import SwiftUI

@Model
final class HistorySearch
{
    let login: String
    let email: String
    let image: String
    
    init(login: String, email: String, image: String)
    {
        self.login = login
        self.email = email
        self.image = image
    }
}
