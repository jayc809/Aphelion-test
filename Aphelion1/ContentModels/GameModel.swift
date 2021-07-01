//
//  GameModel.swift
//  Aphelion
//
//  Created by Jay on 2021/6/15.
//

import Foundation
import SwiftUI

class GameModel: ObservableObject {
    
    @Published var tilePositionArray = [CGFloat]()
    @Published var tileScaleArray = [CGFloat]()
    
    init(){
        setupPositionArray()
    }
    
    func setupPositionArray() {
        for i in Array(stride(from: 0.01, through: 1.20, by: 0.01)) {
            
            let factor = 0.9 * pow(CGFloat(i), 2.25) + 0.1
            let yPosition = ((Constants.tapLinePosition - Constants.tileYMin) * factor) + Constants.tileYMin
            
            tilePositionArray.append(yPosition)
            tileScaleArray.append(factor)
            
        }
    }
    
}
