//
//  SlideInModifier.swift
//  Intra42
//
//  Created by Marc Mosca on 03/01/2024.
//

import SwiftUI

struct SlideInModifier: ViewModifier
{
    
    // MARK: - Exposed properties
    
    let rowHeight: CGFloat
    let duration: TimeInterval
    let delay: CGFloat
    
    // MARK: - Private properties
    
    @State private var animated = false
    
    // MARK: - Body
    
    func body(content: Content) -> some View
    {
        content
            .offset(y: animated ? 0 : rowHeight * 0.5)
            .opacity(animated ? 1 : 0)
            .onAppear
            {
                withAnimation(.easeInOut(duration: duration).delay(delay))
                {
                    animated.toggle()
                }
            }
    }
    
}

// MARK: - Extension

extension View
{
    
    func slideIn(rowHeight: CGFloat, duration: TimeInterval, delay: CGFloat) -> some View
    {
        modifier(SlideInModifier(rowHeight: rowHeight, duration: duration, delay: delay))
    }
    
}
