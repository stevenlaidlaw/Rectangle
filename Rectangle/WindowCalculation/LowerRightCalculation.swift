//
//  LowerRightCalculation.swift
//  Rectangle, Ported from Spectacle
//
//  Created by Ryan Hanson on 6/14/19.
//  Copyright © 2019 Ryan Hanson. All rights reserved.
//

import Foundation

class LowerRightCalculation: WindowCalculation, RepeatedExecutionsInThirdsCalculation {

    override func calculateRect(_ params: RectCalculationParameters) -> RectResult {
        return calculateFirstRect(params)
    }
    
    func calculateFractionalRect(_ params: RectCalculationParameters, fraction: Float) -> RectResult {
        let visibleFrameOfScreen = params.visibleFrameOfScreen

        var rect = visibleFrameOfScreen
        
        rect.size.width = floor(visibleFrameOfScreen.width * CGFloat(fraction))
        rect.origin.x = visibleFrameOfScreen.maxX - rect.width
        rect.size.height = floor(visibleFrameOfScreen.height / 2.0)
        
        return RectResult(rect, resultingAction: .topLeft, subAction: .bottomRight)
    }
}
