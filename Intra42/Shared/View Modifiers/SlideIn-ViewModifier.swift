//
//  SlideIn-ViewModifier.swift
//  Intra42
//
//  Created by Marc Mosca on 23/01/2024.
//

import SwiftUI

struct SlideInModifier: ViewModifier {
    
    // MARK: - Properties
    
    let rowHeight: CGFloat
    let duration: TimeInterval
    let delay: CGFloat
    
    // MARK: - Private properties
    
    @State private var animated = false
    
    // MARK: - Body
    
    func body(content: Content) -> some View {
        content
            .offset(y: animated ? 0 : rowHeight * 0.5)
            .opacity(animated ? 1 : 0)
            .onAppear {
                withAnimation(.easeInOut(duration: duration).delay(delay)) {
                    animated.toggle()
                }
            }
    }
    
}

// MARK: - View extension

extension View {
    
    func slideIn(rowHeight: CGFloat, duration: TimeInterval, delay: CGFloat) -> some View {
        modifier(SlideInModifier(rowHeight: rowHeight, duration: duration, delay: delay))
    }
    
}
