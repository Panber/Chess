//
//  LineRadarChartDataSet.swift
//  Charts
//
//  Created by Daniel Cohen Gindi on 26/2/15.
//
//  Copyright 2015 Daniel Cohen Gindi & Philipp Jahoda
//  A port of MPAndroidChart for iOS
//  Licensed under Apache License 2.0
//
//  https://github.com/danielgindi/ios-charts
//

import Foundation
import CoreGraphics
import UIKit

var blue = UIColor(red:0.36, green:0.56, blue:0.79, alpha:1.0)
var red = UIColor(red:0.89, green:0.36, blue:0.36, alpha:1.0)

public class LineRadarChartDataSet: LineScatterCandleChartDataSet
{
    public var fillColor = blue
    public var fillAlpha = CGFloat(0.33)
    private var _lineWidth = CGFloat(1.0)
    public var drawFilledEnabled = true
    
    /// line width of the chart (min = 0.2, max = 10)
    /// 
    /// **default**: 1
    public var lineWidth: CGFloat
    {
        get
        {
            return _lineWidth
        }
        set
        {
            if (newValue < 0.2)
            {
                _lineWidth = 0.2
            }
            else if (newValue > 10.0)
            {
                _lineWidth = 10.0
            }
            else
            {
                _lineWidth = newValue
            }
        }
    }
    
    public var isDrawFilledEnabled: Bool
    {
        return drawFilledEnabled
    }
    
    // MARK: NSCopying
    
    public override func copyWithZone(zone: NSZone) -> AnyObject
    {
        let copy = super.copyWithZone(zone) as! LineRadarChartDataSet
        copy.fillColor = fillColor
        copy._lineWidth = _lineWidth
        copy.drawFilledEnabled = drawFilledEnabled
        return copy
    }
}
