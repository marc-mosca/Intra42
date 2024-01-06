//
//  Profile+UserInformations.swift
//  Intra42
//
//  Created by Marc Mosca on 06/01/2024.
//

import SwiftUI

extension ProfileView
{
    
    struct UserInformations: View
    {
        
        // MARK: - Exposed properties
        
        let user: Api.Types.User
        
        // MARK: - Body
        
        var body: some View
        {
            List
            {
                Section("General")
                {
                    HRow(title: "Name", value: user.displayname)
                    HRow(title: "Email", value: user.email)
                    HRow(title: "Phone number", value: user.phone)
                }
                
                Section("Cursus")
                {
                    HRow(title: "Grade", value: user.mainCursus?.grade ?? "N/A")
                    HRow(title: "Level", value: user.mainCursus?.level.formatted() ?? "0.0")
                    HRow(title: "Correction points", value: user.correctionPoint.formatted())
                    HRow(title: "Wallets", value: user.wallet.formatted())
                    HRow(title: "Promotion", value: "\(user.poolMonth.capitalized) \(user.poolYear)")
                }
            }
            .navigationTitle("Informations")
        }
        
    }
    
}
