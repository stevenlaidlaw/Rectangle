//
//  UpperLeftCalculation.swift
//  Rectangle, Ported from Spectacle
//
//  Created by Ryan Hanson on 6/14/19.
//  Copyright © 2019 Ryan Hanson. All rights reserved.
//

import Foundation

class UpperLeftCalculation: WindowCalculation, RepeatedExecutionsInThirdsCalculation {

    override func calculateRect(_ params: RectCalculationParameters) -> RectResult {
        let last = params.lastAction, lastAction = last?.action, lastSubAction = last?.subAction

        if lastAction == .topLeft {
            switch lastSubAction {
            case .topLeft:
                return WindowCalculationFactory.upperRightCalculation.calculateRect(params)
            case .topRight:
                return WindowCalculationFactory.lowerLeftCalculation.calculateRect(params)
            case .bottomLeft:
                return WindowCalculationFactory.lowerRightCalculation.calculateRect(params)
            default:
                break
            }
        }

        return calculateFirstRect(params)
    }
    
    func calculateFractionalRect(_ params: RectCalculationParameters, fraction: Float) -> RectResult {
        let visibleFrameOfScreen = params.visibleFrameOfScreen

        var rect = visibleFrameOfScreen
        
        rect.size.width = floor(visibleFrameOfScreen.width * CGFloat(fraction))
        
        rect.size.height = floor(visibleFrameOfScreen.height / 2.0)
        rect.origin.y = visibleFrameOfScreen.maxY - rect.height
        return RectResult(rect, resultingAction: .topLeft, subAction: .topLeft)
    }
}
