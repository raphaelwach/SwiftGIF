//
//  GIF.swift
//
//
//  Created by Raphaël Wach on 03/01/2024.
//

import Foundation
import ImageIO

class GIF: ObservableObject {
    
    @Published var image: CGImage?
    private var images: [(image: CGImage, delayTime: Double)] = []
    private var index: Int = 0
    
    public init(_ data: Data) {
        guard let imageSource = CGImageSourceCreateWithData(data as CFData, nil) else {
            return
        }
        let count = CGImageSourceGetCount(imageSource)
        guard let properties = CGImageSourceCopyProperties(imageSource, nil) as? [String : Any] else {
            return
        }
        guard let gif = properties["{GIF}"] as? [String : Any] else {
            return
        }
        guard let frameInfo = gif["FrameInfo"] as? [[String : Any]] else {
            return
        }
        for i in 0..<count {
            guard let cgImage = CGImageSourceCreateImageAtIndex(imageSource, i, nil) else {
                continue
            }
            let frame = frameInfo[i]
            let delayTime = frame["DelayTime"] as? Double ?? 0
            self.images.append((image: cgImage, delayTime: delayTime))
        }
        self.showNext()
    }
    
    func showNext() {
        if self.index == self.images.count {
            self.index = 0
        }
        self.image = self.images[self.index].image
        Timer.scheduledTimer(withTimeInterval: self.images[self.index].delayTime, repeats: false) { _ in
            self.index += 1
            self.showNext()
        }
    }

}
