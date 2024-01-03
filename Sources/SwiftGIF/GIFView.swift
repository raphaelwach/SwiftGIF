//
//  GIFView.swift
//
//
//  Created by Raphaël Wach on 03/01/2024.
//

import SwiftUI

public struct GIFView: View {
    
    @ObservedObject private var gif: GIF
    
    public var body: some View {
        if let image = gif.image {
            Image(image, scale: 1.0, label: Text(""))
                .resizable()
                .scaledToFit()
        }
    }
    
    public init(data: Data) {
        self.gif = GIF(data)
    }
}
