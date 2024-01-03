//
//  ContentView.swift
//  Intra42
//
//  Created by Marc Mosca on 01/01/2024.
//

import SwiftUI

struct ContentView: View
{
    
    // MARK: - Private properties
    
    @AppStorage("userIsConnected") private var userIsConnected: Bool?
    
    // MARK: - Body
    
    var body: some View
    {
        if userIsConnected != true
        {
            OnBoardingView()
        }
        else
        {
            Text("Home")
        }
    }
    
}

// MARK: - Previews

#Preview
{
    ContentView()
}
