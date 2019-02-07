//
//  FaceView.swift
//  Happiness_Swift
//
//  Created by JihoonPark on 04/02/2019.
//  Copyright © 2019 JihoonPark. All rights reserved.
//

import UIKit

protocol FaceViewDelegate:class {
    func smilenessForFaceView(requestor:FaceView) -> CGFloat
}

class FaceView: UIView {
    
    let MIN_FACE_SCALE:CGFloat = 0.05
    let MAX_FACE_SCALE:CGFloat = 1.5
    let DEFAULT_FACE_SCALE:CGFloat = 0.9
    
    let MAX_SMILENESS:CGFloat = 1.0
    let MIN_SMILENESS:CGFloat = -1.0
    
    weak var delegate : FaceViewDelegate?
    var faceScale: CGFloat?
    //var smileness: CGFloat?
    
    func getSmileness() -> CGFloat{
        var _smileness:CGFloat = (delegate?.smilenessForFaceView(requestor: self))!
        
        if _smileness < MIN_SMILENESS {
            _smileness = MIN_SMILENESS
        } else if _smileness > MAX_SMILENESS {
            _smileness = MAX_SMILENESS
        }
        return _smileness
    }
    
    func reset() {
        faceScale = DEFAULT_FACE_SCALE
    }
    
    func setFaceScale(newScale:CGFloat) {
        if newScale < MIN_FACE_SCALE {
            faceScale = MIN_FACE_SCALE
        }
        else if newScale > MAX_FACE_SCALE {
            faceScale = MAX_FACE_SCALE
        }
        else {
            faceScale = newScale
        }
    }
    override func draw(_ rect: CGRect) {
        let faceCenterPoint:CGPoint = CGPoint.init(x: self.bounds.origin.x + self.bounds.size.width / 2, y: self.bounds.origin.y + self.bounds.size.height / 2)
        
        var faceRadius:CGFloat = self.bounds.size.width/2
        if self.bounds.size.width > self.bounds.size.height {
            faceRadius = self.bounds.size.height / 2
        }
        faceRadius *= self.faceScale!
        
        let context:CGContext = UIGraphicsGetCurrentContext()!
        
        self.drawCircleAtCenterPoint(centerPoint: faceCenterPoint, radius:faceRadius, context: context)
        self.drawEyesBasedOnFaceCenterPoint(faceCenterPoint: faceCenterPoint, faceRadius:faceRadius, context: context)
        self.drawMouthBasedOnFaceCenterPoint(faceCenterPoint: faceCenterPoint, faceRadius: faceRadius, context: context)
        self.drawNoseBasedOnFaceCenterPoint(faceCenterPoint: faceCenterPoint, faceRadius: faceRadius, context: context)
        self.drawEyesBasedOnFaceCenterPoint(faceCenterPoint: faceCenterPoint, faceRadius: faceRadius, context: context)
        //self.drawEyebrowBasedOnFaceCenterPoint(faceCenterPoint: faceCenterPoint, faceRadius: faceRadius, context: context)
        //self.drawEyebrow2BasedOnFaceCenterPoint(faceCenterPoint: faceCenterPoint, faceRadius: faceRadius, context: context)
    }
    
    func drawFaceAtCenterPoint(centerPoint:CGPoint, radius:CGFloat, context:CGContext) {
        UIColor.darkGray.setFill()
        self.drawCircleAtCenterPoint(centerPoint: centerPoint, radius: radius, context: context)
    }
    let CLOCKWISE = 1
    
    func drawCircleAtCenterPoint(centerPoint:CGPoint, radius:CGFloat, context:CGContext) {
        let startAngle:CGFloat = 0.0
        let endAngle:CGFloat = CGFloat(2.0 * .pi)
        
        UIGraphicsPushContext(context)
        
        context.beginPath()
        context.addArc(center: centerPoint, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        context.fillPath()
        context.strokePath()
        UIGraphicsPopContext()
    }
    
    let EYE_HorizontalOffsetRatio : CGFloat = 0.35
    let EYE_VerticalOffsetRatio : CGFloat = 0.30
    let EYE_RadiusRatio = 0.15
    
    func drawEyesBasedOnFaceCenterPoint(faceCenterPoint:CGPoint, faceRadius:CGFloat, context:CGContext) {
        
        let eyeHorizontalOffset:CGFloat = faceRadius * EYE_HorizontalOffsetRatio
        let eyeVerticalOffset : CGFloat = faceRadius * EYE_VerticalOffsetRatio
        let eyeRadius:CGFloat = faceRadius * CGFloat(EYE_RadiusRatio)
        
        var eyePoint:CGPoint = CGPoint.init()
        eyePoint.x = faceCenterPoint.x - eyeHorizontalOffset
        eyePoint.y = faceCenterPoint.y - eyeVerticalOffset
        
        UIColor.cyan.setFill()
        
        self.drawCircleAtCenterPoint(centerPoint: eyePoint, radius: eyeRadius, context: context)
        eyePoint.x = faceCenterPoint.x + eyeHorizontalOffset
        self.drawCircleAtCenterPoint(centerPoint: eyePoint, radius: eyeRadius, context: context)
    }
    
    let NOSE_HorizontalOffsetRatio:CGFloat = 0.0
    let NOSE_VerticalOffsetRatio:CGFloat = 0.1
    let NOSE_RadiusRatio:CGFloat = 0.09
    
    func drawNoseBasedOnFaceCenterPoint(faceCenterPoint:CGPoint, faceRadius:CGFloat, context:CGContext) {
        var noseCenterPoint:CGPoint = faceCenterPoint
        noseCenterPoint.y = faceCenterPoint.y + faceRadius * NOSE_VerticalOffsetRatio
        UIColor.orange.setFill()
        self.drawCircleAtCenterPoint(centerPoint: noseCenterPoint, radius: faceRadius*NOSE_RadiusRatio, context: context)
    }
    
    let MOUTH_HorizontalOffsetRatio:CGFloat = 0.45
    let MOUTH_VerticalOffsetRatio:CGFloat = 0.5
    let MOUTH_RadiusRatio:CGFloat = 0.3
    
    func drawMouthBasedOnFaceCenterPoint(faceCenterPoint:CGPoint, faceRadius:CGFloat, context:CGContext) {
        
        
        let mouthHorizontalOffset = faceRadius * MOUTH_HorizontalOffsetRatio
        let mouthVerticalOffset = faceRadius * MOUTH_VerticalOffsetRatio
        var mouthLeftPoint:CGPoint = CGPoint.init()
        mouthLeftPoint.x = faceCenterPoint.x - mouthHorizontalOffset
        mouthLeftPoint.y = faceCenterPoint.y + mouthVerticalOffset
        
        var mouthRightPoint:CGPoint = CGPoint.init()
        mouthRightPoint.x = faceCenterPoint.x + mouthHorizontalOffset
        mouthRightPoint.y = faceCenterPoint.y + mouthVerticalOffset
        
        var mouthLeftControlPoint = mouthLeftPoint
        mouthLeftControlPoint.x += mouthHorizontalOffset * (2.0/3.0)
        var mouthRightControlPoint = mouthRightPoint
        mouthRightControlPoint.x -= mouthHorizontalOffset * (2.0/3.0)
        
        let smileOffset:CGFloat = (faceRadius * MOUTH_RadiusRatio) * self.getSmileness()
        mouthLeftControlPoint.y += smileOffset
        mouthRightControlPoint.y += smileOffset
        
        context.setLineWidth(0.5)
        UIColor.green.setStroke()
        UIColor.green.setFill()
        
        UIGraphicsPushContext(context)
        context.beginPath()
        context.move(to: mouthLeftPoint)
        if abs(smileOffset) < 1 {
            context.addLine(to: mouthRightPoint)
            context.strokePath()
        }
        else{
            context.addCurve(to: mouthRightPoint, control1:mouthLeftControlPoint , control2: mouthRightControlPoint)
            context.move(to: mouthRightPoint)
            context.addCurve(to: mouthLeftPoint, control1:CGPoint.init(x:mouthRightControlPoint.x, y:mouthRightControlPoint.y-smileOffset/2)  ,control2: CGPoint.init(x:mouthLeftControlPoint.x , y: mouthLeftControlPoint.y-smileOffset/2))
            context.fillPath()
        }
        UIGraphicsPopContext()
    }
    
    let EYEBROW_HorizontalOffsetRatio:CGFloat = 0.6
    let EYEBROW_VerticalOffsetRatio:CGFloat = 0.5
    let EYEBROW_RadiusRatio:CGFloat = 0.02
    
    func drawEyebrowBasedOnFaceCenterPoint(faceCenterPoint:CGPoint, faceRadius:CGFloat, context:CGContext) {
        
        let eyebrowHorizontalOffset:CGFloat = faceRadius * EYEBROW_HorizontalOffsetRatio
        let eyebrowVerticalOffset:CGFloat = faceRadius * EYEBROW_VerticalOffsetRatio
        var eyebrowLeftPoint:CGPoint = CGPoint.init()
        eyebrowLeftPoint.x = faceCenterPoint.x - eyebrowHorizontalOffset
        eyebrowLeftPoint.y = faceCenterPoint.y - eyebrowVerticalOffset
        
        var eyebrowRightPoint:CGPoint = CGPoint.init()
        eyebrowRightPoint.x = faceCenterPoint.x - eyebrowHorizontalOffset/5
        eyebrowRightPoint.y = faceCenterPoint.y - eyebrowVerticalOffset
        
        var eyebrowLeftControlPoint = eyebrowLeftPoint
        var eyebrowRightControlPoint = eyebrowRightPoint
        
        let smileOffset = (faceRadius * EYEBROW_RadiusRatio) * self.getSmileness()
        eyebrowLeftControlPoint.y -= smileOffset
        eyebrowRightControlPoint.y -= smileOffset
        
        context.setLineWidth(0.5)
        UIColor.red.setStroke()
        UIColor.red.setFill()
        
        UIGraphicsPushContext(context)
        
        context.beginPath()
        context.move(to: eyebrowLeftPoint)
        if(abs(smileOffset) < 1){
            context.addLine(to: eyebrowRightPoint)
            context.strokePath()
        }
        else{
            context.addCurve(to: eyebrowRightPoint, control1: eyebrowLeftControlPoint, control2: eyebrowRightControlPoint)
            context.move(to: eyebrowRightPoint)
            context.addCurve(to: eyebrowLeftPoint, control1: eyebrowRightControlPoint, control2: eyebrowLeftControlPoint)
            context.fillPath()
        }
        UIGraphicsPopContext()
    }
    
    func drawEyebrow2BasedOnFaceCenterPoint(faceCenterPoint:CGPoint, faceRadius:CGFloat, context:CGContext) {
        
        let eyebrowHorizontalOffset:CGFloat = faceRadius * EYEBROW_HorizontalOffsetRatio
        let eyebrowVerticalOffset:CGFloat = faceRadius * EYEBROW_VerticalOffsetRatio
        
        var eyebrowLeftPoint:CGPoint = CGPoint.init()
        eyebrowLeftPoint.x = faceCenterPoint.x - eyebrowHorizontalOffset/5
        eyebrowLeftPoint.y = faceCenterPoint.y - eyebrowVerticalOffset
        
        var eyebrowRightPoint:CGPoint = CGPoint.init()
        eyebrowRightPoint.x = faceCenterPoint.x - eyebrowHorizontalOffset
        eyebrowRightPoint.y = faceCenterPoint.y - eyebrowVerticalOffset
        
        var eyebrowLeftControlPoint = eyebrowLeftPoint
        var eyebrowRightControlPoint = eyebrowRightPoint
        
        let smileOffset = (faceRadius * EYEBROW_RadiusRatio) * self.getSmileness()
        eyebrowLeftControlPoint.y -= smileOffset
        eyebrowRightControlPoint.y -= smileOffset
        
        context.setLineWidth(0.5)
        UIColor.red.setStroke()
        UIColor.red.setFill()
        
        UIGraphicsPushContext(context)
        
        context.beginPath()
        context.move(to: eyebrowLeftPoint)
        if(abs(smileOffset) < 1){
            context.addLine(to: eyebrowRightPoint)
            context.strokePath()
        }
        else{
            context.addCurve(to: eyebrowRightPoint, control1: eyebrowLeftControlPoint, control2: eyebrowRightControlPoint)
            context.move(to: eyebrowRightPoint)
            context.addCurve(to: eyebrowLeftPoint, control1: eyebrowRightControlPoint, control2: eyebrowLeftControlPoint)
            context.fillPath()
        }
        UIGraphicsPopContext()
    }
    
    
    @IBAction func pinchGestureRecognized(sender : UIPinchGestureRecognizer) {
        if sender.state == UIGestureRecognizer.State.changed || sender.state == UIGestureRecognizer.State.ended {
            self.faceScale? *= sender.scale
            sender.scale = 1.0
            self.setNeedsDisplay()
        }
    }
}
