//
//  HandleErrorsModifier.swift
//  Intra42
//
//  Created by Marc Mosca on 03/01/2024.
//

import SwiftUI

struct HandleErrorsModifier: ViewModifier
{
    
    // MARK: - Exposed properties
    
    let error: AppError?
    let action: (() -> Void)?
    
    // MARK: - Private properties
    
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - Body
    
    func body(content: Content) -> some View
    {
        content
            .alert("An error has occurred", isPresented: .constant(error != nil))
            {
                Button("OK")
                {
                    action?()
                    dismiss()
                }
            }
            message:
            {
                if let description = error?.errorDescription
                {
                    Text(description)
                }
            }
    }
    
}

// MARK: - Extensions

extension View
{
    
    func handleErrors(error: AppError?, action: (() -> Void)?) -> some View
    {
        modifier(HandleErrorsModifier(error: error, action: action))
    }
    
}
