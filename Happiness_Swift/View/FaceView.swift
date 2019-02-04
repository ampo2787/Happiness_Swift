//
//  FaceView.swift
//  Happiness_Swift
//
//  Created by JihoonPark on 04/02/2019.
//  Copyright © 2019 JihoonPark. All rights reserved.
//

import UIKit

protocol FaceViewDelegate {
    func smilenessForFaceView(requestor:FaceView) -> CGFloat
}

class FaceView: UIView {
    
    let MIN_FACE_SCALE:CGFloat = 0.05
    let MAX_FACE_SCALE:CGFloat = 1.5
    let DEFAULT_FACE_SCALE:CGFloat = 0.9
    
    var delegate : FaceViewDelegate?
    var faceScale: CGFloat?
    var smileness: CGFloat?
    
    
    func reset() {
        faceScale = DEFAULT_FACE_SCALE
    }
    
    func drawCircleAtCenterPoint(centerPoint:CGPoint, Radius:CGPoint, context:CGContext) {
        <#function body#>
    }
    
    func drawFaceAtCenterPoint(faceCenterPoint:CGPoint, Radius:CGPoint, context:CGContext) {
        <#function body#>
    }
    
    func drawEyesBasedOnFaceCenterPoint(faceCenterPoint:CGPoint, Radius:CGPoint, context:CGContext) {
        <#function body#>
    }
    
    func drawNoseBasedOnFaceCenterPoint(faceCenterPoint:CGPoint, Radius:CGPoint, context:CGContext) {
        <#function body#>
    }
    
    func drawMouthBasedOnFaceCenterPoint(faceCenterPoint:CGPoint, Radius:CGPoint, context:CGContext) {
        <#function body#>
    }
    
    func drawEyebrowBasedOnFaceCenterPoint(faceCenterPoint:CGPoint, Radius:CGPoint, context:CGContext) {
        <#function body#>
    }
    
    func drawEyebrow2BasedOnFaceCenterPoint(faceCenterPoint:CGPoint, Radius:CGPoint, context:CGContext) {
        <#function body#>
    }
    
    
    @IBAction func pinchGestureRecognized(sender : UIPinchGestureRecognizer) {
        
    }
}
