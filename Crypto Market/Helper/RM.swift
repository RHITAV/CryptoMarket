//
//  RM.swift
//  Crypto Market
//
//  Created by Ryan Hall on 2/10/2023.
//

import Foundation
import UIKit

public class RM {
    
    static let shared = RM()
    
    var bounds: CGRect = UIScreen.main.bounds
    let baseWidth: CGFloat =  414
    let baseHeight: CGFloat = 896
        
    func getDeviceWidth() -> CGFloat{
        return bounds.size.width
    }
    
    func getDeviceHeight() -> CGFloat{
        return bounds.size.height
    }
    
    //Calculate device width compare to base device
    func width(_ value: CGFloat) -> CGFloat {
        let resoulationDiffernece = baseWidth/getDeviceWidth()
        let actualWidth = CGFloat(value)/resoulationDiffernece
        return actualWidth
    }
    
    //Calculate device height compare to base device
    func height(_ value: CGFloat) -> CGFloat {
        let resoulationDiffernece = baseHeight/getDeviceHeight()
        let actualHeight = CGFloat(value)/resoulationDiffernece
        return actualHeight
    }
}
