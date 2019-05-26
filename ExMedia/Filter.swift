//
//  Image+Filter.swift
//  Coastline
//
//  Created by 王渊鸥 on 2017/3/31.
//  Copyright © 2017年 王渊鸥. All rights reserved.
//

import CoreImage
import UIKit

public extension UIImage {
    var ciImage:CIImage? {
        guard let cgImage = self.cgImage else { return nil }
        let ciImage = CIImage(cgImage: cgImage)
        return ciImage
    }
    
    func applyFilter(_ action:(CIImage) -> CIImage?) -> UIImage? {
        guard let ciimage = ciImage else { return nil }
        let size = self.size
        return action(ciimage)?.uiImage(size: size)
    }
    
    static func generator(size:CGSize, _ action:() -> CIImage?) -> UIImage? {
        return action()?.uiImage(size: size)
    }
}

public extension CIImage {
    func uiImage(size:CGSize? = nil) -> UIImage? {
        if let size = size {
            let ciContext = CIContext()
            guard let oCgImage = ciContext.createCGImage(self, from: CGRect(origin:CGPoint(), size: size)) else { return nil }
            return UIImage(cgImage: oCgImage, scale: UIScreen.main.scale, orientation: .up)
        } else {
            let ciContext = CIContext()
            guard let oCgImage = ciContext.createCGImage(self, from: self.extent) else { return nil }
            return UIImage(cgImage: oCgImage, scale: UIScreen.main.scale, orientation: .up)
        }
    }
}

public extension CIImage {
    typealias ColorComponents = (red:CGFloat, green:CGFloat, blue:CGFloat, alpha:CGFloat)
    
    func boxBlur(radius:CGFloat = 10.0) -> CIImage? {
        let filter = CIFilter(name: "CIBoxBlur", parameters: [
            "inputImage": self, "inputRadius": radius ])
        return filter?.outputImage
    }
    
    public func discBlur(radius:CGFloat = 8.0) -> CIImage? {
        let filter = CIFilter(name: "CIDiscBlur", parameters: [
            "inputImage": self, "inputRadius": radius ])
        return filter?.outputImage
    }
    
    public func gaussianBlur(radius:CGFloat = 8.0) -> CIImage? {
        let filter = CIFilter(name: "CIGaussianBlur", parameters: [
            "inputImage": self, "inputRadius": radius ])
        return filter?.outputImage
    }
    
    public func medianFilter() -> CIImage? {
        let filter = CIFilter(name: "CIMedianFilter", parameters: [
            "inputImage": self ])
        return filter?.outputImage
    }
    
    public func motionBlur(radius:CGFloat = 20.0, angle:CGFloat = 0.0) -> CIImage? {
        let filter = CIFilter(name: "CIMotionBlur", parameters: [
            "inputImage": self, "inputRadius": radius, "inputAngle": angle ])
        return filter?.outputImage
    }
    
    public func noiseReduction(noiseLevel:CGFloat = 0.02, sharpness:CGFloat = 0.4) -> CIImage? {
        let filter = CIFilter(name: "CINoiseReduction", parameters: [
            "inputImage": self, "inputNoiseLevel": noiseLevel, "inputSharpness": sharpness ])
        return filter?.outputImage
    }
    
    public func zoomBlur(center:CGPoint = CGPoint(x: 150.0, y: 150.0), amount:CGFloat = 20.0) -> CIImage? {
        let filter = CIFilter(name: "CIZoomBlur", parameters: [
            "inputImage": self, "inputCenter": CIVector(cgPoint: center), "inputAmount": amount ])
        return filter?.outputImage
    }
    
    public func colorClamp(minComponents:ColorComponents = (0, 0, 0, 0), maxComponents:ColorComponents = (0, 0, 0, 0)) -> CIImage? {
        let filter = CIFilter(name: "CIColorClamp", parameters: [
            "inputImage": self, "inputMinComponents": CIVector(componets: minComponents), "inputMaxComponents": CIVector(componets: maxComponents) ])
        return filter?.outputImage
    }
    
    public func colorControls(brightness:CGFloat, saturation:CGFloat = 1.0, contrast:CGFloat = 1.0) -> CIImage? {
        let filter = CIFilter(name: "CINoiseReduction", parameters: [
            "inputImage": self, "inputSaturation": saturation, "inputBrightness": brightness, "inputContrast": contrast ])
        return filter?.outputImage
    }
    
    public func colorMatrix(redVector:ColorComponents = (1, 0, 0, 0), greenVector:ColorComponents = (0, 1, 0, 0), blueVector:ColorComponents = (0, 0, 1, 0), alpahVector:ColorComponents = (0, 0, 0, 1), biasVector:ColorComponents = (0, 0, 0, 0)) -> CIImage? {
        let filter = CIFilter(name: "CIColorClamp", parameters: [
            "inputImage": self, "inputRVector": CIVector(componets: redVector), "inputGVector": CIVector(componets: greenVector), "inputBVector": CIVector(componets: blueVector), "inputAVector": CIVector(componets: alpahVector), "inputBiasVector": CIVector(componets: biasVector) ])
        return filter?.outputImage
    }
    
    public func colorPolynomial(redVector:ColorComponents = (1, 0, 0, 0), greenVector:ColorComponents = (0, 1, 0, 0), blueVector:ColorComponents = (0, 0, 1, 0), alpahVector:ColorComponents = (0, 0, 0, 1), biasVector:ColorComponents = (0, 0, 0, 0)) -> CIImage? {
        let filter = CIFilter(name: "CIColorPolynomial", parameters: [
            "inputImage": self, "inputRedCoefficients": CIVector(componets: redVector), "inputGreenCoefficients": CIVector(componets: greenVector), "inputBlueCoefficients": CIVector(componets: blueVector), "inputAlphaCoefficients": CIVector(componets: alpahVector) ])
        return filter?.outputImage
    }
    
    public func exposureAdjust(ev:CGFloat = 0.5) -> CIImage? {
        let filter = CIFilter(name: "CIExposureAdjust", parameters: [
            "inputImage": self, "inputEV": ev ])
        return filter?.outputImage
    }
    
    public func gammaAdjust(ev:CGFloat = 0.75) -> CIImage? {
        let filter = CIFilter(name: "CIGammaAdjust", parameters: [
            "inputImage": self, "inputPower": ev ])
        return filter?.outputImage
    }
    
    public func hueAdjust(ev:CGFloat = 0.75) -> CIImage? {
        let filter = CIFilter(name: "CIHueAdjust", parameters: [
            "inputImage": self, "inputAngle": ev ])
        return filter?.outputImage
    }
    
    public func linearToSRGBToneCurve(ev:CGFloat = 0.75) -> CIImage? {
        let filter = CIFilter(name: "CILinearToSRGBToneCurve", parameters: [
            "inputImage": self ])
        return filter?.outputImage
    }
    
    public func SRGBToneCurveToLinear(ev:CGFloat = 0.75) -> CIImage? {
        let filter = CIFilter(name: "CISRGBToneCurveToLinear", parameters: [
            "inputImage": self ])
        return filter?.outputImage
    }
    
    public func temperatureAndTint(neutral:(temp:CGFloat, tint:CGFloat) = (6500, 0), targetNeutral:(temp:CGFloat, tint:CGFloat) = (6500, 0)) -> CIImage? {
        let filter = CIFilter(name: "CITemperatureAndTint", parameters: [
            "inputImage": self, "inputNeutral": CIVector(x: neutral.temp, y: neutral.tint), "inputTargetNeutral": CIVector(x:targetNeutral.temp, y: targetNeutral.tint) ])
        return filter?.outputImage
    }
    
    public func toneCurve(point0:CGPoint = CGPoint(x: 0, y: 0), point1:CGPoint = CGPoint(x: 0.25, y: 0.25), point2:CGPoint = CGPoint(x: 0.5, y: 0.5), point3:CGPoint = CGPoint(x: 0.75, y: 0.75), point4:CGPoint = CGPoint(x: 1, y: 1)) -> CIImage? {
        let filter = CIFilter(name: "CIToneCurve", parameters: [
            "inputImage": self, "inputPoint0": CIVector(x: point0.x, y: point0.y), "inputPoint1": CIVector(x: point1.x, y: point1.y), "inputPoint2": CIVector(x: point2.x, y: point2.y), "inputPoint3": CIVector(x: point3.x, y: point3.y), "inputPoint4": CIVector(x: point4.x, y: point4.y) ])
        return filter?.outputImage
    }
    
    public func vibrance(amount:CGFloat) -> CIImage? {
        let filter = CIFilter(name: "CIVibrance", parameters: [
            "inputImage": self, "inputAmount" : amount ])
        return filter?.outputImage
    }
    
    public func whitePointAdjust(color:UIColor) -> CIImage? {
        let filter = CIFilter(name: "CIWhitePointAdjust", parameters: [
            "inputImage": self, "inputColor" : color.ciColor ])
        return filter?.outputImage
    }
    
    public func colorCrossPolynomial(red:ColorCoefficients = ColorCoefficients(r: 1, g: 0, b: 0, rr: 0, gg: 0, bb: 0, rg: 0, gb: 0, br: 0, add: 0), green:ColorCoefficients = ColorCoefficients(r: 0, g: 1, b: 0, rr: 0, gg: 0, bb: 0, rg: 0, gb: 0, br: 0, add: 0), blue:ColorCoefficients = ColorCoefficients(r: 0, g: 0, b: 1, rr: 0, gg: 0, bb: 0, rg: 0, gb: 0, br: 0, add: 0)) -> CIImage? {
        let filter = CIFilter(name: "CIColorCrossPolynomial", parameters: [
            "inputImage": self, "inputRedCoefficients" : red.vector, "inputGreenCoefficients" : green.vector, "inputBlueCoefficients" : blue.vector ])
        return filter?.outputImage
    }
    
    //....
    public func colorCube(data:Data, dimension:CGFloat = 2.0) -> CIImage? {
        let filter = CIFilter(name: "CIColorCube", parameters: [
            "inputImage": self, "inputCubeDimension" : dimension, "inputCubeData": data ])
        return filter?.outputImage
    }
    
    public func colorCubeWithColorSpace(data:Data, colorSpace:CGColorSpace, dimension:CGFloat = 2.0) -> CIImage? {
        let filter = CIFilter(name: "CIColorCubeWithColorSpace", parameters: [
            "inputImage": self, "inputCubeDimension" : dimension, "inputCubeData": data, "inputColorSpace": colorSpace ])
        return filter?.outputImage
    }
    
    public func colorInvert() -> CIImage? {
        let filter = CIFilter(name: "CIColorInvert", parameters: [
            "inputImage": self ])
        return filter?.outputImage
    }
    
    public func colorMap(gradientImage:CIImage) -> CIImage? {
        let filter = CIFilter(name: "CIColorMap", parameters: [
            "inputImage": self, "inputGradientImage": gradientImage ])
        return filter?.outputImage
    }
    
    public func colorMonochrome(color:UIColor, intensity:CGFloat = 1.0) -> CIImage? {
        let filter = CIFilter(name: "CIColorMonochrome", parameters: [
            "inputImage": self, "inputColor": color.ciColor, "inputIntensity": intensity ])
        return filter?.outputImage
    }
    
    public func colorPosterize(levels:CGFloat) -> CIImage? {
        let filter = CIFilter(name: "CIColorPosterize", parameters: [
            "inputImage": self, "inputLevels": levels ])
        return filter?.outputImage
    }
    
    public func flaseColor(color0:UIColor, color1:UIColor) -> CIImage? {
        let filter = CIFilter(name: "CIFalseColor", parameters: [
            "inputImage": self, "inputColor0": color0.ciColor, "inputColor1": color1.ciColor ])
        return filter?.outputImage
    }
    
    public func maskToAlpha() -> CIImage? {
        let filter = CIFilter(name: "CIMaskToAlpha", parameters: [
            "inputImage": self ])
        return filter?.outputImage
    }
    
    public func maximumComponent() -> CIImage? {
        let filter = CIFilter(name: "CIMaximumComponent", parameters: [
            "inputImage": self ])
        return filter?.outputImage
    }
    
    public func minimumComponent() -> CIImage? {
        let filter = CIFilter(name: "CIMinimumComponent", parameters: [
            "inputImage": self ])
        return filter?.outputImage
    }
    
    public func photoEffectChrome() -> CIImage? {
        let filter = CIFilter(name: "CIPhotoEffectChrome", parameters: [
            "inputImage": self ])
        return filter?.outputImage
    }
    
    public func photoEffectFade() -> CIImage? {
        let filter = CIFilter(name: "CIPhotoEffectFade", parameters: [
            "inputImage": self ])
        return filter?.outputImage
    }
    
    public func photoEffectInstant() -> CIImage? {
        let filter = CIFilter(name: "CIPhotoEffectInstant", parameters: [
            "inputImage": self ])
        return filter?.outputImage
    }
    
    public func photoEffectMono() -> CIImage? {
        let filter = CIFilter(name: "CIPhotoEffectMono", parameters: [
            "inputImage": self ])
        return filter?.outputImage
    }
    
    public func photoEffectNoir() -> CIImage? {
        let filter = CIFilter(name: "CIPhotoEffectNoir", parameters: [
            "inputImage": self ])
        return filter?.outputImage
    }
    
    public func photoEffectProcess() -> CIImage? {
        let filter = CIFilter(name: "CIPhotoEffectProcess", parameters: [
            "inputImage": self ])
        return filter?.outputImage
    }
    
    public func photoEffectTonal() -> CIImage? {
        let filter = CIFilter(name: "CIPhotoEffectTonal", parameters: [
            "inputImage": self ])
        return filter?.outputImage
    }
    
    public func photoEffectTransfer() -> CIImage? {
        let filter = CIFilter(name: "CIPhotoEffectTransfer", parameters: [
            "inputImage": self ])
        return filter?.outputImage
    }
    
    public func sepiaTone(intensity:CGFloat = 1.0) -> CIImage? {
        let filter = CIFilter(name: "CISepiaTone", parameters: [
            "inputImage": self, "inputIntensity": intensity ])
        return filter?.outputImage
    }
    
    public func vignette(radius:CGFloat = 1.0, intensity:CGFloat = 0.0) -> CIImage? {
        let filter = CIFilter(name: "CIVignette", parameters: [
            "inputImage": self, "inputIntensity": intensity, "inputRadius": radius ])
        return filter?.outputImage
    }
    
    public func vignetteEffect(center:CGPoint = CGPoint(x: 150, y: 150), radius:CGFloat = 0.0, intensity:CGFloat = 1.0) -> CIImage? {
        let filter = CIFilter(name: "CIVignetteEffect", parameters: [
            "inputImage": self, "inputIntensity": intensity, "inputRadius": radius, "inputCenter": CIVector(cgPoint: center) ])
        return filter?.outputImage
    }
    
    public func additionCompositing(backgroudImage:CIImage) -> CIImage? {
        let filter = CIFilter(name: "CIAdditionCompositing", parameters: [
            "inputImage": self, "inputBackgroundImage": backgroudImage ])
        return filter?.outputImage
    }
    
    public func colorBlendMode(backgroudImage:CIImage) -> CIImage? {
        let filter = CIFilter(name: "CIColorBlendMode", parameters: [
            "inputImage": self, "inputBackgroundImage": backgroudImage ])
        return filter?.outputImage
    }
    
    public func colorBurnBlendMode(backgroudImage:CIImage) -> CIImage? {
        let filter = CIFilter(name: "CIColorBurnBlendMode", parameters: [
            "inputImage": self, "inputBackgroundImage": backgroudImage ])
        return filter?.outputImage
    }
    
    public func colorDodgeBlendMode(backgroudImage:CIImage) -> CIImage? {
        let filter = CIFilter(name: "CIColorDodgeBlendMode", parameters: [
            "inputImage": self, "inputBackgroundImage": backgroudImage ])
        return filter?.outputImage
    }
    
    public func darkenBlendMode(backgroudImage:CIImage) -> CIImage? {
        let filter = CIFilter(name: "CIDarkenBlendMode", parameters: [
            "inputImage": self, "inputBackgroundImage": backgroudImage ])
        return filter?.outputImage
    }
    
    public func differenceBlendMode(backgroudImage:CIImage) -> CIImage? {
        let filter = CIFilter(name: "CIDifferenceBlendMode", parameters: [
            "inputImage": self, "inputBackgroundImage": backgroudImage ])
        return filter?.outputImage
    }
    
    public func divideBlendMode(backgroudImage:CIImage) -> CIImage? {
        let filter = CIFilter(name: "CIDivideBlendMode", parameters: [
            "inputImage": self, "inputBackgroundImage": backgroudImage ])
        return filter?.outputImage
    }
    
    public func exclusionBlendMode(backgroudImage:CIImage) -> CIImage? {
        let filter = CIFilter(name: "CIExclusionBlendMode", parameters: [
            "inputImage": self, "inputBackgroundImage": backgroudImage ])
        return filter?.outputImage
    }
    
    public func hardLightBlendMode(backgroudImage:CIImage) -> CIImage? {
        let filter = CIFilter(name: "CIHardLightBlendMode", parameters: [
            "inputImage": self, "inputBackgroundImage": backgroudImage ])
        return filter?.outputImage
    }
    
    public func hueBlendMode(backgroudImage:CIImage) -> CIImage? {
        let filter = CIFilter(name: "CIHueBlendMode", parameters: [
            "inputImage": self, "inputBackgroundImage": backgroudImage ])
        return filter?.outputImage
    }
    
    public func lightenBlendMode(backgroudImage:CIImage) -> CIImage? {
        let filter = CIFilter(name: "CILightenBlendMode", parameters: [
            "inputImage": self, "inputBackgroundImage": backgroudImage ])
        return filter?.outputImage
    }
    
    public func linearBurnBlendMode(backgroudImage:CIImage) -> CIImage? {
        let filter = CIFilter(name: "CILinearBurnBlendMode", parameters: [
            "inputImage": self, "inputBackgroundImage": backgroudImage ])
        return filter?.outputImage
    }
    
    public func linearDodgeBlendMode(backgroudImage:CIImage) -> CIImage? {
        let filter = CIFilter(name: "CILinearDodgeBlendMode", parameters: [
            "inputImage": self, "inputBackgroundImage": backgroudImage ])
        return filter?.outputImage
    }
    
    public func luminosityBlendMode(backgroudImage:CIImage) -> CIImage? {
        let filter = CIFilter(name: "CILuminosityBlendMode", parameters: [
            "inputImage": self, "inputBackgroundImage": backgroudImage ])
        return filter?.outputImage
    }
    
    public func maximumCompositing(backgroudImage:CIImage) -> CIImage? {
        let filter = CIFilter(name: "CIMaximumCompositing", parameters: [
            "inputImage": self, "inputBackgroundImage": backgroudImage ])
        return filter?.outputImage
    }
    
    public func minimumCompositing(backgroudImage:CIImage) -> CIImage? {
        let filter = CIFilter(name: "CIMinimumCompositing", parameters: [
            "inputImage": self, "inputBackgroundImage": backgroudImage ])
        return filter?.outputImage
    }
    
    public func multiplyBlendMode(backgroudImage:CIImage) -> CIImage? {
        let filter = CIFilter(name: "CIMultiplyBlendMode", parameters: [
            "inputImage": self, "inputBackgroundImage": backgroudImage ])
        return filter?.outputImage
    }
    
    public func multiplyCompositing(backgroudImage:CIImage) -> CIImage? {
        let filter = CIFilter(name: "CIMultiplyCompositing", parameters: [
            "inputImage": self, "inputBackgroundImage": backgroudImage ])
        return filter?.outputImage
    }
    
    public func overlayBlendMode(backgroudImage:CIImage) -> CIImage? {
        let filter = CIFilter(name: "CIOverlayBlendMode", parameters: [
            "inputImage": self, "inputBackgroundImage": backgroudImage ])
        return filter?.outputImage
    }
    
    public func pinLightBlendMode(backgroudImage:CIImage) -> CIImage? {
        let filter = CIFilter(name: "CIPinLightBlendMode", parameters: [
            "inputImage": self, "inputBackgroundImage": backgroudImage ])
        return filter?.outputImage
    }
    
    public func saturationBlendMode(backgroudImage:CIImage) -> CIImage? {
        let filter = CIFilter(name: "CISaturationBlendMode", parameters: [
            "inputImage": self, "inputBackgroundImage": backgroudImage ])
        return filter?.outputImage
    }
    
    public func screenBlendMode(backgroudImage:CIImage) -> CIImage? {
        let filter = CIFilter(name: "CIScreenBlendMode", parameters: [
            "inputImage": self, "inputBackgroundImage": backgroudImage ])
        return filter?.outputImage
    }
    
    public func softLightBlendMode(backgroudImage:CIImage) -> CIImage? {
        let filter = CIFilter(name: "CISoftLightBlendMode", parameters: [
            "inputImage": self, "inputBackgroundImage": backgroudImage ])
        return filter?.outputImage
    }
    
    public func sourceAtopCompositing(backgroudImage:CIImage) -> CIImage? {
        let filter = CIFilter(name: "CISourceAtopCompositing", parameters: [
            "inputImage": self, "inputBackgroundImage": backgroudImage ])
        return filter?.outputImage
    }
    
    public func sourceInCompositing(backgroudImage:CIImage) -> CIImage? {
        let filter = CIFilter(name: "CISourceInCompositing", parameters: [
            "inputImage": self, "inputBackgroundImage": backgroudImage ])
        return filter?.outputImage
    }
    
    public func sourceOutCompositing(backgroudImage:CIImage) -> CIImage? {
        let filter = CIFilter(name: "CISourceOutCompositing", parameters: [
            "inputImage": self, "inputBackgroundImage": backgroudImage ])
        return filter?.outputImage
    }
    
    public func sourceOverCompositing(backgroudImage:CIImage) -> CIImage? {
        let filter = CIFilter(name: "CISourceOverCompositing", parameters: [
            "inputImage": self, "inputBackgroundImage": backgroudImage ])
        return filter?.outputImage
    }
    
    public func subtractBlendMode(backgroudImage:CIImage) -> CIImage? {
        let filter = CIFilter(name: "CISubtractBlendMode", parameters: [
            "inputImage": self, "inputBackgroundImage": backgroudImage ])
        return filter?.outputImage
    }
    
    public func bumpDistortion(center:CGPoint = CGPoint(x: 150, y: 150), radius:CGFloat = 300.0, scale:CGFloat = 0.5) -> CIImage? {
        let filter = CIFilter(name: "CIBumpDistortion", parameters: [
            "inputImage": self, "inputCenter": CIVector(cgPoint: center), "inputRadius": radius, "inputScale": scale ])
        return filter?.outputImage
    }
    
    public func bumpDistortionLinear(center:CGPoint = CGPoint(x: 300, y: 300), radius:CGFloat = 300.0, angle:CGFloat = 0, scale:CGFloat = 0.5) -> CIImage? {
        let filter = CIFilter(name: "CIBumpDistortionLinear", parameters: [
            "inputImage": self, "inputCenter": CIVector(cgPoint: center), "inputRadius": radius, "inputScale": scale, "inputAngle" : angle ])
        return filter?.outputImage
    }
    
    public func circleSplashDistortion(center:CGPoint = CGPoint(x: 150, y: 150), radius:CGFloat = 150.0) -> CIImage? {
        let filter = CIFilter(name: "CICircleSplashDistortion", parameters: [
            "inputImage": self, "inputCenter": CIVector(cgPoint: center), "inputRadius": radius ])
        return filter?.outputImage
    }
    
    public func circularWrap(center:CGPoint = CGPoint(x: 150, y: 150), radius:CGFloat = 150.0, angle:CGFloat = 0.0) -> CIImage? {
        let filter = CIFilter(name: "CICircularWrap", parameters: [
            "inputImage": self, "inputCenter": CIVector(cgPoint: center), "inputRadius": radius, "inputAngle": angle ])
        return filter?.outputImage
    }
    
    public func droste(insetPoint0:CGPoint = CGPoint(x: 200, y: 200), insetPoint1:CGPoint = CGPoint(x: 400, y: 400), strand:CGFloat = 1.0, periodicity:CGFloat = 1.0, rotation:CGFloat = 0.0, zoom:CGFloat = 1.0) -> CIImage? {
        let filter = CIFilter(name: "CIDroste", parameters: [
            "inputImage": self, "inputInsetPoint0": CIVector(cgPoint: insetPoint0), "inputInsetPoint1": CIVector(cgPoint: insetPoint1), "inputStrands": strand, "inputPeriodicity": periodicity, "inputRotation": rotation, "inputZoom": zoom ])
        return filter?.outputImage
    }
    
    public func displacementDistortion(displacementImage:CIImage, scale:CGFloat = 50.0) -> CIImage? {
        let filter = CIFilter(name: "CIDisplacementDistortion", parameters: [
            "inputImage": self, "inputDisplacementImage": displacementImage, "inputScale":scale ])
        return filter?.outputImage
    }
    
    public func glassDistortion(texture:CIImage, center:CGPoint = CGPoint(x: 150, y:150), scale:CGFloat = 200.0) -> CIImage? {
        let filter = CIFilter(name: "CIGlassDistortion", parameters: [
            "inputImage": self, "inputTexture": texture, "inputCenter":CIVector(cgPoint: center), "inputScale": scale ])
        return filter?.outputImage
    }
    
    public func glassLozenge(point0:CGPoint = CGPoint(x: 150, y: 150), point1:CGPoint = CGPoint(x: 150, y: 150), radius:CGFloat = 100.0, refraction:CGFloat = 1.7) -> CIImage? {
        let filter = CIFilter(name: "CIGlassLozenge", parameters: [
            "inputImage": self, "inputPoint0": CIVector(cgPoint:point0), "inputPoint1":CIVector(cgPoint: point1), "inputRadius": radius, "inputRefraction": refraction ])
        return filter?.outputImage
    }
    
    public func holeDistortion(center:CGPoint = CGPoint(x: 150, y: 150), radius:CGFloat = 150.0) -> CIImage? {
        let filter = CIFilter(name: "CIHoleDistortion", parameters: [
            "inputImage": self, "inputCenter": CIVector(cgPoint:center), "inputRadius": radius ])
        return filter?.outputImage
    }
    
    public func lightTunnel(center:CGPoint = CGPoint(x: 150, y: 150), radius:CGFloat = 0, rotation:CGFloat = 0) -> CIImage? {
        let filter = CIFilter(name: "CILightTunnel", parameters: [
            "inputImage": self, "inputCenter": CIVector(cgPoint:center), "inputRadius": radius, "inputRotation": rotation ])
        return filter?.outputImage
    }
    
    public func pinchDistortion(center:CGPoint = CGPoint(x: 150, y: 150), radius:CGFloat = 300.0, scale:CGFloat = 0.5) -> CIImage? {
        let filter = CIFilter(name: "CIPinchDistortion", parameters: [
            "inputImage": self, "inputCenter": CIVector(cgPoint:center), "inputRadius": radius, "inputScale": scale ])
        return filter?.outputImage
    }
    
    public func stretchCrop(size:CGSize, cropAmount:Bool, centerStretchAmount:Bool) -> CIImage? {
        let filter = CIFilter(name: "CIStretchCrop", parameters: [
            "inputImage": self, "inputSize": CIVector(x: size.width, y: size.height), "inputCropAmount": cropAmount ? 1 : 0, "inputCenterStretchAmount": centerStretchAmount ? 1 : 0 ])
        return filter?.outputImage
    }
    
    public func torusLensDistortion(center:CGPoint = CGPoint(x: 150, y: 150), radius:CGFloat = 160.0, width:CGFloat = 80.0, refraction:CGFloat = 1.7) -> CIImage? {
        let filter = CIFilter(name: "CITorusLensDistortion", parameters: [
            "inputImage": self, "inputCenter": CIVector(cgPoint:center), "inputRadius": radius, "inputRefraction": refraction, "inputWidth":width ])
        return filter?.outputImage
    }
    
    public func twirlDistortion(center:CGPoint = CGPoint(x: 150, y: 150), radius:CGFloat = 300.0, angle:CGFloat = 3.14) -> CIImage? {
        let filter = CIFilter(name: "CITwirlDistortion", parameters: [
            "inputImage": self, "inputCenter": CIVector(cgPoint:center), "inputRadius": radius, "inputAngle":angle ])
        return filter?.outputImage
    }
    
    public func vortexDistortion(center:CGPoint = CGPoint(x: 150, y: 150), radius:CGFloat = 300.0, angle:CGFloat = 56.55) -> CIImage? {
        let filter = CIFilter(name: "CIVortexDistortion", parameters: [
            "inputImage": self, "inputCenter": CIVector(cgPoint:center), "inputRadius": radius, "inputAngle":angle ])
        return filter?.outputImage
    }
    
    
    //MARK: generator
    public static func aztecCodeGenerator(data:Data, correctionLevel:CGFloat = 23.0, layers:CGFloat = 0, compactStyle:CGFloat = 0) -> CIImage? {
        let filter = CIFilter(name: "CIAztecCodeGenerator", parameters: [
            "inputMessage": data, "inputCorrectionLevel": correctionLevel, "inputLayers": layers, "inputCompactStyle":compactStyle ])
        return filter?.outputImage
    }
    
    public static func checkerboardGenerato(color0:UIColor, color1:UIColor, center:CGPoint = CGPoint(x: 150, y: 150), width:CGFloat = 80.0, sharpness:CGFloat = 1.0) -> CIImage? {
        let filter = CIFilter(name: "CICheckerboardGenerator", parameters: [
            "inputCenter": CIVector(cgPoint: center), "inputColor0": color0.ciColor, "inputColor1": color1.ciColor, "inputWidth":width, "inputSharpness": sharpness ])
        return filter?.outputImage
    }
    
    public static func code128BarcodeGenerator(asciiString:String, quietSpace:CGFloat = 7.0) -> CIImage? {
        guard let data = asciiString.data(using: .ascii) else { return nil }
        let filter = CIFilter(name: "CICode128BarcodeGenerator", parameters: [
            "inputMessage": data, "inputQuietSpace": quietSpace ])
        return filter?.outputImage
    }
    
    public static func constantColorGenerator(color:UIColor) -> CIImage? {
        let filter = CIFilter(name: "CIConstantColorGenerator", parameters: [
            "inputColor": color.ciColor ])
        return filter?.outputImage
    }
    
    public static func lenticularHaloGenerator(color:UIColor, center:CGPoint = CGPoint(x: 150, y: 150), haloRadius:CGFloat = 70.0, haloWidth:CGFloat = 87.0, haloOverlap:CGFloat = 0.77, striationStrenght:CGFloat = 0.5, striationConstrast:CGFloat = 1.0, time:CGFloat = 0) -> CIImage? {
        let filter = CIFilter(name: "CILenticularHaloGenerator", parameters: [
            "inputColor": color.ciColor, "inputCenter":CIVector(cgPoint:center), "inputHaloRadius":haloRadius, "inputHaloWidth":haloWidth, "inputHaloOverlap":haloOverlap, "inputStriationStrength":striationStrenght, "inputStriationContrast":striationConstrast, "inputTime":time ])
        return filter?.outputImage
    }
    
    public enum PDF417CompactionMode:Int {
        case automatic = 0
        case numeric = 1
        case text = 2
        case byte = 3
    }
    
    public static func PDF417BarcodeGenerator(data:Data, minWidth:CGFloat = 0, maxWidth:CGFloat = 0, minHeight:CGFloat = 0, maxHeight:CGFloat = 0, dataColums:CGFloat = 0, rows:CGFloat = 0, preferredAspectRatio:CGFloat = 0, compactionMode:PDF417CompactionMode = .automatic, compactStyle:Bool = false, correctionLevel:CGFloat = 0, alwaysSpecifyCompaction:CGFloat = 0 ) -> CIImage? {
        let filter = CIFilter(name: "CIPDF417BarcodeGenerator", parameters: [
            "inputMessage": data, "inputMinWidth": minWidth, "inputMaxWidth": maxWidth, "inputMinHeight":minHeight, "inputMaxHeight":maxHeight, "inputDataColumns":dataColums, "inputRows":rows, "inputPreferredAspectRatio":preferredAspectRatio , "inputCompactionMode":CGFloat(compactionMode.rawValue), "inputCompactStyle":compactStyle ? 1: 0, "inputCorrectionLevel": correctionLevel, "inputAlwaysSpecifyCompaction":alwaysSpecifyCompaction ])
        return filter?.outputImage
    }
    
    public enum QRCodeCorrectionLevel:String {
        case Low = "L"
        case Medium = "M"
        case Quility = "Q"
        case High = "H"
    }
    
    public static func QRCodeGenerator(data:Data, correctionLevel:QRCodeCorrectionLevel = .Medium) -> CIImage? {
        let filter = CIFilter(name: "CIQRCodeGenerator", parameters: [
            "inputMessage": data, "inputCorrectionLevel": correctionLevel.rawValue ])
        return filter?.outputImage
    }
    
    public static func randomGenerator() -> CIImage? {
        let filter = CIFilter(name: "CIRandomGenerator")
        return filter?.outputImage
    }
    
    public static func starShineGenerator(color:UIColor, center:CGPoint = CGPoint(x: 150, y: 150), radius:CGFloat = 50.0, crossScale:CGFloat = 15.0, crossAngle:CGFloat = 0.6, crossOpacity:CGFloat = -2.0, crossWidth:CGFloat = 2.5, epsilon:CGFloat = -2.0) -> CIImage? {
        let filter = CIFilter(name: "CIStarShineGenerator", parameters: [
            "inputCenter": CIVector(cgPoint:center), "inputColor": color.ciColor, "inputRadius":radius, "inputCrossScale":crossScale, "inputCrossAngle":crossAngle, "inputCrossOpacity":crossOpacity, "inputCrossWidth":crossWidth, "inputEpsilon":epsilon ])
        return filter?.outputImage
    }
    
    public static func stripesGenerator(color0:UIColor, color1:UIColor, center:CGPoint = CGPoint(x: 150, y: 150), width:CGFloat = 80.0, sharpness:CGFloat = 1.0) -> CIImage? {
        let filter = CIFilter(name: "CIStripesGenerator", parameters: [
            "inputCenter": CIVector(cgPoint:center), "inputColor0": color0.ciColor, "inputColor1": color1.ciColor, "inputWidth":width, "inputSharpness":sharpness ])
        return filter?.outputImage
    }
    
    public static func sunbeamsGenerator(color:UIColor, center:CGPoint = CGPoint(x: 150, y: 150), sunRadius:CGFloat = 40.0, maxStriationRadius:CGFloat = 2.58, striationStrength:CGFloat = 0.5, striationContrast:CGFloat = 1.38, time:CGFloat = 0.0) -> CIImage? {
        let filter = CIFilter(name: "CISunbeamsGenerator", parameters: [
            "inputCenter": CIVector(cgPoint:center), "inputColor": color.ciColor, "inputSunRadius":sunRadius, "inputMaxStriationRadius":maxStriationRadius, "inputStriationStrength":striationStrength, "inputStriationContrast":striationContrast, "inputTime":time ])
        return filter?.outputImage
    }
    
    //MARK: transform
    public func affineTransform(transform:CGAffineTransform) -> CIImage? {
        let filter = CIFilter(name: "CIAffineTransform", parameters: [
            "inputImage": self, "inputTransform": NSValue(cgAffineTransform:transform) ])
        return filter?.outputImage
    }
    
    public func crop(rect:CGRect) -> CIImage? {
        let filter = CIFilter(name: "CICrop", parameters: [
            "inputImage": self, "inputRectangle": CIVector(cgRect:rect) ])
        return filter?.outputImage
    }
    
    public func lanczosScaleTransform(scale:CGFloat = 1.0, aspectRatio:CGFloat = 1.0) -> CIImage? {
        let filter = CIFilter(name: "CILanczosScaleTransform", parameters: [
            "inputImage": self, "inputScale": scale, "inputAspectRatio": aspectRatio ])
        return filter?.outputImage
    }
    
    public func perspectiveCorrection(topLeft:CGPoint, topRight:CGPoint, bottomLeft:CGPoint, bottomRight:CGPoint) -> CIImage? {
        let filter = CIFilter(name: "CIPerspectiveCorrection", parameters: [
            "inputImage": self, "inputTopLeft": CIVector(x:topLeft.x, y:topLeft.y), "inputTopRight": CIVector(x:topRight.x, y:topRight.y), "inputBottomRight": CIVector(x:bottomRight.x, y:bottomRight.y), "inputBottomLeft": CIVector(x:bottomLeft.x, y:bottomLeft.y) ])
        return filter?.outputImage
    }
    
    public func perspectiveTransform(topLeft:CGPoint, topRight:CGPoint, bottomLeft:CGPoint, bottomRight:CGPoint) -> CIImage? {
        let filter = CIFilter(name: "CIPerspectiveTransform", parameters: [
            "inputImage": self, "inputTopLeft": CIVector(x:topLeft.x, y:topLeft.y), "inputTopRight": CIVector(x:topRight.x, y:topRight.y), "inputBottomRight": CIVector(x:bottomRight.x, y:bottomRight.y), "inputBottomLeft": CIVector(x:bottomLeft.x, y:bottomLeft.y) ])
        return filter?.outputImage
    }
    
    public func perspectiveTransformWithExtent(extent:CGAffineTransform, topLeft:CGPoint, topRight:CGPoint, bottomLeft:CGPoint, bottomRight:CGPoint) -> CIImage? {
        let filter = CIFilter(name: "CIPerspectiveTransformWithExtent", parameters: [
            "inputImage": self, "inputTopLeft": CIVector(x:topLeft.x, y:topLeft.y), "inputTopRight": CIVector(x:topRight.x, y:topRight.y), "inputBottomRight": CIVector(x:bottomRight.x, y:bottomRight.y), "inputBottomLeft": CIVector(x:bottomLeft.x, y:bottomLeft.y), "inputExtent":NSValue(cgAffineTransform:extent) ])
        return filter?.outputImage
    }
    
    public func straightenFilter(angle:CGFloat) -> CIImage? {
        let filter = CIFilter(name: "CIStraightenFilter", parameters: [
            "inputImage": self, "inputAngle": angle ])
        return filter?.outputImage
    }
    
    //MARK:Grandient
    public static func gaussianGradient(color0:UIColor, color1:UIColor, center:CGPoint = CGPoint(x:150, y:150), radius:CGFloat = 300.0) -> CIImage? {
        let filter = CIFilter(name: "CIGaussianGradient", parameters: [
            "inputCenter": CIVector(x: center.x, y: center.y), "inputColor0": color0.ciColor, "inputColor1": color1.ciColor, "inputRadius": radius ])
        return filter?.outputImage
    }
    
    public static func linearGradient(color0:UIColor, color1:UIColor, center:CGPoint, radius0:CGFloat, radius1:CGFloat) -> CIImage? {
        let filter = CIFilter(name: "CILinearGradient", parameters: [
            "inputCenter": CIVector(x: center.x, y: center.y), "inputRadius0": radius0, "inputRadius1": radius1, "inputColor0": color0.ciColor, "inputColor1": color1.ciColor ])
        return filter?.outputImage
    }
    
    public static func linearGradient(color0:UIColor, color1:UIColor, point0:CGPoint, point1:CGPoint) -> CIImage? {
        let filter = CIFilter(name: "CILinearGradient", parameters: [
            "inputPoint0": CIVector(x: point0.x, y: point0.y), "inputPoint1": CIVector(x: point1.x, y: point1.y), "inputColor0": color0.ciColor, "inputColor1": color1.ciColor ])
        return filter?.outputImage
    }
    
    public static func smoothLinearGradient(color0:UIColor, color1:UIColor, point0:CGPoint, point1:CGPoint) -> CIImage? {
        let filter = CIFilter(name: "CISmoothLinearGradient", parameters: [
            "inputPoint0": CIVector(x: point0.x, y: point0.y), "inputPoint1": CIVector(x: point1.x, y: point1.y), "inputColor0": color0.ciColor, "inputColor1": color1.ciColor ])
        return filter?.outputImage
    }
    
    //MARK:Half tone
    public func circularScreen(center:CGPoint, width:CGFloat = 6.0, sharpness:CGFloat = 0.7) -> CIImage? {
        let filter = CIFilter(name: "CICircularScreen", parameters: [
            "inputImage": self, "inputCenter": CIVector(x:center.x, y:center.y), "inputWidth": width, "inputSharpness": sharpness ])
        return filter?.outputImage
    }
    
    public func CMYKHalftone(center:CGPoint, width:CGFloat = 6.0, angle:CGFloat = 0.0, sharpness:CGFloat = 0.7, GCR:CGFloat = 1.0, UCR:CGFloat = 0.5) -> CIImage? {
        let filter = CIFilter(name: "CICMYKHalftone", parameters: [
            "inputImage": self, "inputCenter": CIVector(x:center.x, y:center.y), "inputWidth": width, "inputWidth": angle, "inputSharpness": sharpness, "inputGCR":GCR, "inputUCR":UCR ])
        return filter?.outputImage
    }
    
    public func dotScreen(center:CGPoint, angle:CGFloat = 0.0, width:CGFloat = 6.0, sharpness:CGFloat = 0.7) -> CIImage? {
        let filter = CIFilter(name: "CIDotScreen", parameters: [
            "inputImage": self, "inputCenter": CIVector(x:center.x, y:center.y), "inputAngle": angle, "inputWidth": width, "inputSharpness": sharpness ])
        return filter?.outputImage
    }
    
    public func hatchedScreen(center:CGPoint, angle:CGFloat = 0.0, width:CGFloat = 6.0, sharpness:CGFloat = 0.7) -> CIImage? {
        let filter = CIFilter(name: "CIHatchedScreen", parameters: [
            "inputImage": self, "inputCenter": CIVector(x:center.x, y:center.y), "inputAngle": angle, "inputWidth": width, "inputSharpness": sharpness ])
        return filter?.outputImage
    }
    
    public func lineScreen(center:CGPoint, angle:CGFloat = 0.0, width:CGFloat = 6.0, sharpness:CGFloat = 0.7) -> CIImage? {
        let filter = CIFilter(name: "CILineScreen", parameters: [
            "inputImage": self, "inputCenter": CIVector(x:center.x, y:center.y), "inputAngle": angle, "inputWidth": width, "inputSharpness": sharpness ])
        return filter?.outputImage
    }
    
    
    public func areaAverage(extent:CGRect) -> CIImage? {
        let filter = CIFilter(name: "CIAreaAverage", parameters: [
            "inputImage": self, "inputExtent": CIVector(cgRect: extent) ])
        return filter?.outputImage
    }
    
    public func areaHistogram(extent:CGRect, count:CGFloat, scale:CGFloat) -> CIImage? {
        let filter = CIFilter(name: "CIAreaHistogram", parameters: [
            "inputImage": self, "inputExtent": CIVector(cgRect: extent), "inputCount":count, "inputScale":scale ])
        return filter?.outputImage
    }
    
    public func rowAverage(extent:CGRect) -> CIImage? {
        let filter = CIFilter(name: "CIRowAverage", parameters: [
            "inputImage": self, "inputExtent": CIVector(cgRect: extent) ])
        return filter?.outputImage
    }
    
    public func columnAverage(extent:CGRect) -> CIImage? {
        let filter = CIFilter(name: "CIColumnAverage", parameters: [
            "inputImage": self, "inputExtent": CIVector(cgRect: extent) ])
        return filter?.outputImage
    }
    
    public func histogramDisplayFilter(height:CGFloat = 100.0, highLimit:CGFloat = 1.0, lowLimit:CGFloat = 0.0) -> CIImage? {
        let filter = CIFilter(name: "CIHistogramDisplayFilter", parameters: [
            "inputImage": self, "inputHeight": height, "inputHighLimit":highLimit, "inputLowLimit":lowLimit ])
        return filter?.outputImage
    }
    
    public func areaMaximum(extent:CGRect) -> CIImage? {
        let filter = CIFilter(name: "CIAreaMaximum", parameters: [
            "inputImage": self, "inputExtent": CIVector(cgRect: extent) ])
        return filter?.outputImage
    }
    
    public func areaMinimum(extent:CGRect) -> CIImage? {
        let filter = CIFilter(name: "CIAreaMinimum", parameters: [
            "inputImage": self, "inputExtent": CIVector(cgRect: extent) ])
        return filter?.outputImage
    }
    
    public func areaMaximumAlpha(extent:CGRect) -> CIImage? {
        let filter = CIFilter(name: "CIAreaMaximumAlpha", parameters: [
            "inputImage": self, "inputExtent": CIVector(cgRect: extent) ])
        return filter?.outputImage
    }
    
    public func areaMinimumAlpha(extent:CGRect) -> CIImage? {
        let filter = CIFilter(name: "CIAreaMinimumAlpha", parameters: [
            "inputImage": self, "inputExtent": CIVector(cgRect: extent) ])
        return filter?.outputImage
    }
    
    public func sharpenLuminance(sharpness:CGFloat = 0.4) -> CIImage? {
        let filter = CIFilter(name: "CISharpenLuminance", parameters: [
            "inputImage": self, "inputSharpness": sharpness ])
        return filter?.outputImage
    }
    
    public func unsharpMask(radius:CGFloat = 2.5, intensity:CGFloat = 0.5) -> CIImage? {
        let filter = CIFilter(name: "CIUnsharpMask", parameters: [
            "inputImage": self, "inputRadius": radius, "inputIntensity": intensity ])
        return filter?.outputImage
    }
    
    public func blendWithAlphaMask(backgroud:CIImage, mask:CIImage) -> CIImage? {
        let filter = CIFilter(name: "CIBlendWithAlphaMask", parameters: [
            "inputImage": self, "inputBackgroundImage": backgroud, "inputMaskImage": mask ])
        return filter?.outputImage
    }
    
    public func blendWithMask(backgroud:CIImage, mask:CIImage) -> CIImage? {
        let filter = CIFilter(name: "CIBlendWithMask", parameters: [
            "inputImage": self, "inputBackgroundImage": backgroud, "inputMaskImage": mask ])
        return filter?.outputImage
    }
    
    public func bloom(radius:CGFloat = 10.0, intensity:CGFloat = 0.5) -> CIImage? {
        let filter = CIFilter(name: "CIBloom", parameters: [
            "inputImage": self, "inputRadius": radius, "inputIntensity": intensity ])
        return filter?.outputImage
    }
    
    public func comicEffect() -> CIImage? {
        let filter = CIFilter(name: "CIComicEffect", parameters: [
            "inputImage": self ])
        return filter?.outputImage
    }
    
    public func convolution3X3(matrix:Matrix3X3, bios:CGFloat = 0.0) -> CIImage? {
        let filter = CIFilter(name: "CIConvolution3X3", parameters: [
            "inputImage": self, "inputWeights":matrix.vector, "inputBias":bios ])
        return filter?.outputImage
    }
    
    public func convolution5X5(matrix:Matrix5X5, bios:CGFloat = 0.0) -> CIImage? {
        let filter = CIFilter(name: "CIConvolution5X5", parameters: [
            "inputImage": self, "inputWeights":matrix.vector, "inputBias":bios ])
        return filter?.outputImage
    }
    
    public func convolution7X7(matrix:Matrix7X7, bios:CGFloat = 0.0) -> CIImage? {
        let filter = CIFilter(name: "CIConvolution7X7", parameters: [
            "inputImage": self, "inputWeights":matrix.vector, "inputBias":bios ])
        return filter?.outputImage
    }
    
    public func convolution9Horizontal(matrix:Matrix3X3, bios:CGFloat = 0.0) -> CIImage? {
        let filter = CIFilter(name: "CIConvolution9Horizontal", parameters: [
            "inputImage": self, "inputWeights":matrix.vector, "inputBias":bios ])
        return filter?.outputImage
    }
    
    public func convolution9Vertical(matrix:Matrix3X3, bios:CGFloat = 0.0) -> CIImage? {
        let filter = CIFilter(name: "CIConvolution9Vertical", parameters: [
            "inputImage": self, "inputWeights":matrix.vector, "inputBias":bios ])
        return filter?.outputImage
    }
    
    public func crystallize(center:CGPoint = CGPoint(x:150.0, y:150.0), radius:CGFloat = 20.0) -> CIImage? {
        let filter = CIFilter(name: "CICrystallize", parameters: [
            "inputImage": self, "inputCenter":CIVector(x:center.x, y:center.y), "inputRadius":radius ])
        return filter?.outputImage
    }
    
    public func depthOfField(point0:CGPoint, point1:CGPoint, saturation:CGFloat, unsharpMaskRadius:CGFloat, unsharpMaskIntensity:CGFloat, radius:CGFloat) -> CIImage? {
        let filter = CIFilter(name: "CIDepthOfField", parameters: [
            "inputImage": self, "inputPoint0":CIVector(x:point0.x, y:point0.y), "inputPoint1":CIVector(x:point1.x, y:point1.y), "inputRadius":radius, "inputSaturation":saturation, "inputUnsharpMaskRadius":unsharpMaskRadius, "inputUnsharpMaskIntensity":unsharpMaskIntensity ])
        return filter?.outputImage
    }
    
    public func edges(intensity:CGFloat = 1.0) -> CIImage? {
        let filter = CIFilter(name: "CIEdges", parameters: [
            "inputImage": self, "inputIntensity":intensity ])
        return filter?.outputImage
    }
    
    public func edgeWork(intensity:CGFloat = 3.0) -> CIImage? {
        let filter = CIFilter(name: "CIEdgeWork", parameters: [
            "inputImage": self, "inputIntensity":intensity ])
        return filter?.outputImage
    }
    
    public func gloom(radius:CGFloat = 10.0, intensity:CGFloat = 0.5) -> CIImage? {
        let filter = CIFilter(name: "CIGloom", parameters: [
            "inputImage": self, "inputRadius":radius, "inputIntensity":intensity ])
        return filter?.outputImage
    }
    
    public func heightFieldFromMask(radius:CGFloat = 10.0) -> CIImage? {
        let filter = CIFilter(name: "CIHeightFieldFromMask", parameters: [
            "inputImage": self, "inputRadius":radius ])
        return filter?.outputImage
    }
    
    public func hexagonalPixellate(center:CGPoint = CGPoint(x:150, y:150), scale:CGFloat = 8.0) -> CIImage? {
        let filter = CIFilter(name: "CIHexagonalPixellate", parameters: [
            "inputImage": self, "inputCenter":CIVector(x:center.x, y:center.y), "inputScale":scale ])
        return filter?.outputImage
    }
    
    public func highlightShadowAdjust(shadowAmount:CGFloat, highlightAmount:CGFloat = 1.0) -> CIImage? {
        let filter = CIFilter(name: "CIHighlightShadowAdjust", parameters: [
            "inputImage": self, "inputHighlightAmount":highlightAmount, "inputShadowAmount":shadowAmount ])
        return filter?.outputImage
    }
    
    public func lineOverlay(NRNoiseLeve:CGFloat = 0.07, NRSharpness:CGFloat = 0.71, edgeIntensity:CGFloat = 1.0, threshold:CGFloat = 0.1, contrast:CGFloat = 50.0) -> CIImage? {
        let filter = CIFilter(name: "CILineOverlay", parameters: [
            "inputImage": self, "inputNRNoiseLevel":NRNoiseLeve, "inputNRSharpness":NRSharpness, "inputEdgeIntensity":edgeIntensity, "inputThreshold":threshold, "inputContrast":contrast ])
        return filter?.outputImage
    }
    
    public func pixellate(center:CGPoint = CGPoint(x:150, y:150), scale:CGFloat = 8.0) -> CIImage? {
        let filter = CIFilter(name: "CIPixellate", parameters: [
            "inputImage": self, "inputCenter":CIVector(x:center.x, y:center.y), "inputScale":scale ])
        return filter?.outputImage
    }
    
    public func pointillize(center:CGPoint = CGPoint(x:150, y:150), radius:CGFloat = 20.0) -> CIImage? {
        let filter = CIFilter(name: "CIPointillize", parameters: [
            "inputImage": self, "inputCenter":CIVector(x:center.x, y:center.y), "inputRadius":radius ])
        return filter?.outputImage
    }
    
    public func shadedMaterial(shadingImage:CIImage, scale:CGFloat = 10.0) -> CIImage? {
        let filter = CIFilter(name: "CIShadedMaterial", parameters: [
            "inputImage": self, "inputShadingImage":shadingImage, "inputScale":scale ])
        return filter?.outputImage
    }
    
    public func spotColor(spot0:SpotColor, spot1:SpotColor, spot2:SpotColor) -> CIImage? {
        let filter = CIFilter(name: "CISpotColor", parameters: [
            "inputImage": self, "inputCenterColor1":spot0.centerColor.ciColor, "inputReplacementColor1":spot0.centerColor.ciColor,
            "inputCloseness1":spot0.closeness, "inputContrast1":spot0.contrast,
            "inputCenterColor2":spot1.centerColor.ciColor, "inputReplacementColor2":spot1.centerColor.ciColor,
            "inputCloseness2":spot1.closeness, "inputContrast2":spot1.contrast,
            "inputCenterColor3":spot2.centerColor.ciColor, "inputReplacementColor3":spot2.centerColor.ciColor,
            "inputCloseness3":spot2.closeness, "inputContrast3":spot2.contrast])
        return filter?.outputImage
    }
    
    public func spotLight(color:UIColor, lightPosition:Dim3, lightPointsAt:Dim3, brightness:CGFloat = 3.0, concentration:CGFloat = 0.1) -> CIImage? {
        let filter = CIFilter(name: "CISpotLight", parameters: [
            "inputImage": self, "inputLightPosition":lightPosition.vector, "inputLightPointsAt":lightPointsAt.vector, "inputBrightness":brightness, "inputConcentration": concentration, "inputColor":color.ciColor ])
        return filter?.outputImage
    }
    
    public func affineClamp(transform:CGAffineTransform) -> CIImage? {
        let filter = CIFilter(name: "CIAffineClamp", parameters: [
            "inputImage": self, "inputTransform":NSValue(cgAffineTransform:transform) ])
        return filter?.outputImage
    }
    
    public func affineTile(transform:CGAffineTransform) -> CIImage? {
        let filter = CIFilter(name: "CIAffineTile", parameters: [
            "inputImage": self, "inputTransform":NSValue(cgAffineTransform:transform) ])
        return filter?.outputImage
    }
    
    public func eightfoldReflectedTile(center:CGPoint = CGPoint(x:150, y:150), angle:CGFloat = 0, width:CGFloat = 100.0) -> CIImage? {
        let filter = CIFilter(name: "CIEightfoldReflectedTile", parameters: [
            "inputImage": self, "inputCenter":CIVector(x:center.x, y:center.y), "inputAngle":angle, "inputWidth":width ])
        return filter?.outputImage
    }
    
    public func fourfoldReflectedTile(center:CGPoint = CGPoint(x:150, y:150), angle:CGFloat = 0, acuteAngle:CGFloat = 1.57, width:CGFloat = 100.0) -> CIImage? {
        let filter = CIFilter(name: "CIFourfoldReflectedTile", parameters: [
            "inputImage": self, "inputCenter":CIVector(x:center.x, y:center.y), "inputAngle":angle, "inputAcuteAngle":acuteAngle, "inputWidth":width ])
        return filter?.outputImage
    }
    
    public func fourfoldRotatedTile(center:CGPoint = CGPoint(x:150, y:150), angle:CGFloat = 0, width:CGFloat = 100.0) -> CIImage? {
        let filter = CIFilter(name: "CIFourfoldRotatedTile", parameters: [
            "inputImage": self, "inputCenter":CIVector(x:center.x, y:center.y), "inputAngle":angle, "inputWidth":width ])
        return filter?.outputImage
    }
    
    public func fourfoldTranslatedTile(center:CGPoint = CGPoint(x:150, y:150), angle:CGFloat = 0, acuteAngle:CGFloat = 1.57, width:CGFloat = 100.0) -> CIImage? {
        let filter = CIFilter(name: "CIFourfoldTranslatedTile", parameters: [
            "inputImage": self, "inputCenter":CIVector(x:center.x, y:center.y), "inputAngle":angle, "inputAcuteAngle":acuteAngle, "inputWidth":width ])
        return filter?.outputImage
    }
    
    public func glideReflectedTile(center:CGPoint = CGPoint(x:150, y:150), angle:CGFloat = 0, width:CGFloat = 100.0) -> CIImage? {
        let filter = CIFilter(name: "CIGlideReflectedTile", parameters: [
            "inputImage": self, "inputCenter":CIVector(x:center.x, y:center.y), "inputAngle":angle, "inputWidth":width ])
        return filter?.outputImage
    }
    
    public func kaleidoscope(center:CGPoint = CGPoint(x:150, y:150), count:CGFloat = 6, angle:CGFloat = 0) -> CIImage? {
        let filter = CIFilter(name: "CIKaleidoscope", parameters: [
            "inputImage": self, "inputCenter":CIVector(x:center.x, y:center.y), "inputAngle":angle, "inputCount":count ])
        return filter?.outputImage
    }
    
    public func opTile(center:CGPoint = CGPoint(x:150, y:150), angle:CGFloat = 0, scale:CGFloat = 2.8, width:CGFloat = 65.0) -> CIImage? {
        let filter = CIFilter(name: "CIOpTile", parameters: [
            "inputImage": self, "inputCenter":CIVector(x:center.x, y:center.y), "inputAngle":angle, "inputScale":scale, "inputWidth":width ])
        return filter?.outputImage
    }
    
    public func parallelogramTile(center:CGPoint = CGPoint(x:150, y:150), angle:CGFloat = 0, acuteAngle:CGFloat = 1.57, width:CGFloat = 100.0) -> CIImage? {
        let filter = CIFilter(name: "CIParallelogramTile", parameters: [
            "inputImage": self, "inputCenter":CIVector(x:center.x, y:center.y), "inputAngle":angle, "inputAcuteAngle":acuteAngle, "inputWidth":width ])
        return filter?.outputImage
    }
    
    public func perspectiveTile(topLeft:CGPoint, topRight:CGPoint, bottomLeft:CGPoint, bottomRight:CGPoint) -> CIImage? {
        let filter = CIFilter(name: "CIPerspectiveTile", parameters: [
            "inputImage": self, "inputTopLeft":CIVector(x:topLeft.x, y:topLeft.y), "inputTopRight":CIVector(x:topRight.x, y:topRight.y), "inputBottomLeft":CIVector(x:bottomLeft.x, y:bottomLeft.y), "inputBottomRight":CIVector(x:bottomRight.x, y:bottomRight.y) ])
        return filter?.outputImage
    }
    
    public func sixfoldReflectedTile(center:CGPoint = CGPoint(x:150, y:150), angle:CGFloat = 0, width:CGFloat = 100.0) -> CIImage? {
        let filter = CIFilter(name: "CISixfoldReflectedTile", parameters: [
            "inputImage": self, "inputCenter":CIVector(x:center.x, y:center.y), "inputAngle":angle, "inputWidth":width ])
        return filter?.outputImage
    }
    
    public func sixfoldRotatedTile(center:CGPoint = CGPoint(x:150, y:150), angle:CGFloat = 0, width:CGFloat = 100.0) -> CIImage? {
        let filter = CIFilter(name: "CISixfoldRotatedTile", parameters: [
            "inputImage": self, "inputCenter":CIVector(x:center.x, y:center.y), "inputAngle":angle, "inputWidth":width ])
        return filter?.outputImage
    }
    
    public func triangleKaleidoscope(point:CGPoint = CGPoint(x:150, y:150), size:CGFloat = 700, rotation:CGFloat = -0.36, decay:CGFloat = 0.85) -> CIImage? {
        let filter = CIFilter(name: "CITriangleKaleidoscope", parameters: [
            "inputImage": self, "inputPoint":CIVector(x:point.x, y:point.y), "inputSize":size, "inputRotation":rotation, "inputDecay":decay ])
        return filter?.outputImage
    }
    
    public func triangleTile(center:CGPoint = CGPoint(x:150, y:150), angle:CGFloat = 0, width:CGFloat = 100.0) -> CIImage? {
        let filter = CIFilter(name: "CITriangleTile", parameters: [
            "inputImage": self, "inputCenter":CIVector(x:center.x, y:center.y), "inputAngle":angle, "inputWidth":width ])
        return filter?.outputImage
    }
    
    public func twelvefoldReflectedTile(center:CGPoint = CGPoint(x:150, y:150), angle:CGFloat = 0, width:CGFloat = 100.0) -> CIImage? {
        let filter = CIFilter(name: "CITwelvefoldReflectedTile", parameters: [
            "inputImage": self, "inputCenter":CIVector(x:center.x, y:center.y), "inputAngle":angle, "inputWidth":width ])
        return filter?.outputImage
    }
    
    public func accordionFoldTransition(target:CIImage, time:CGFloat = 0, bottomHeight:CGFloat = 0, numberOfFolds:CGFloat = 3.0, foldShadowAmount:CGFloat = 0.1) -> CIImage? {
        let filter = CIFilter(name: "CIAccordionFoldTransition", parameters: [
            "inputImage": self, "inputTargetImage":target, "inputBottomHeight":bottomHeight, "inputNumberOfFolds":numberOfFolds, "inputFoldShadowAmount":foldShadowAmount, "inputTime":time ])
        return filter?.outputImage
    }
    
    public func barsSwipeTransition(target:CIImage, time:CGFloat = 0, angle:CGFloat = 3.14, width:CGFloat = 30.0, barOffset:CGFloat = 10.0) -> CIImage? {
        let filter = CIFilter(name: "CIBarsSwipeTransition", parameters: [
            "inputImage": self, "inputTargetImage":target, "inputAngle":angle, "inputWidth":width, "inputBarOffset":barOffset, "inputTime":time ])
        return filter?.outputImage
    }
    
    public func copyMachineTransition(target:CIImage, time:CGFloat = 0, color:UIColor = UIColor.gray, extent:CGRect = CGRect(x:0, y:0, width:300, height:300), angle:CGFloat = 0.0, width:CGFloat = 30.0, opacity:CGFloat = 1.3) -> CIImage? {
        let filter = CIFilter(name: "CICopyMachineTransition", parameters: [
            "inputImage": self, "inputTargetImage":target, "inputExtent":CIVector(cgRect:extent), "inputColor":color.ciColor, "inputAngle":angle, "inputWidth":width, "inputOpacity":opacity, "inputTime":time ])
        return filter?.outputImage
    }
    
    public func disintegrateWithMaskTransition(target:CIImage, mask:CIImage, time:CGFloat = 0, shadowRadius:CGFloat = 8.0, shadowDesity:CGFloat = 0.65, shadowOffset:CGSize = CGSize(width:0, height:-10)) -> CIImage? {
        let filter = CIFilter(name: "CIDisintegrateWithMaskTransition", parameters: [
            "inputImage": self, "inputTargetImage":target, "inputMaskImage":mask, "inputShadowRadius":shadowRadius, "inputShadowDensity":shadowDesity, "inputShadowOffset":CIVector(x:shadowOffset.width, y:shadowOffset.height) , "inputTime":time ])
        return filter?.outputImage
    }
    
    public func dissolveTransition(target:CIImage, time:CGFloat = 0) -> CIImage? {
        let filter = CIFilter(name: "CIDissolveTransition", parameters: [
            "inputImage": self, "inputTargetImage":target, "inputTime":time ])
        return filter?.outputImage
    }
    
    public func flashTransition(target:CIImage, time:CGFloat = 0, color:UIColor, center:CGPoint = CGPoint(x:150, y:150), extent:CGRect = CGRect(x:0, y:0, width:300, height:300), maxStriationRadius:CGFloat = 2.58, striationStrength:CGFloat = 0.5, striationContrast:CGFloat = 1.38, fadeThreshold:CGFloat = 0.85) -> CIImage? {
        let filter = CIFilter(name: "CIFlashTransition", parameters: [
            "inputImage": self, "inputTargetImage":target, "inputTime":time, "inputCenter":CIVector(x:center.x, y:center.y), "inputExtent":CIVector(cgRect:extent), "inputColor":color.ciColor, "inputMaxStriationRadius":maxStriationRadius, "inputStriationStrength":striationStrength, "inputStriationContrast":striationContrast, "inputFadeThreshold":fadeThreshold ])
        return filter?.outputImage
    }
    
    public func modTransition(target:CIImage, time:CGFloat = 0, center:CGPoint = CGPoint(x:150, y:150), angle:CGFloat = 2.0, radius:CGFloat = 150.0, compression:CGFloat = 300.0) -> CIImage? {
        let filter = CIFilter(name: "CIModTransition", parameters: [
            "inputImage": self, "inputTargetImage":target, "inputTime":time, "inputCenter":CIVector(x:center.x, y:center.y), "inputAngle":angle, "inputRadius":radius, "inputCompression":compression ])
        return filter?.outputImage
    }
    
    public func pageCurlTransition(target:CIImage, backside:CIImage, shading:CIImage, time:CGFloat = 0, extent:CGRect = CGRect(x:0, y:0, width:300, height:300), angle:CGFloat = 0, radius:CGFloat = 100.0) -> CIImage? {
        let filter = CIFilter(name: "CIPageCurlTransition", parameters: [
            "inputImage": self, "inputTargetImage":target, "inputTime":time, "inputBacksideImage":backside, "inputShadingImage":shading, "inputExtent":CIVector(cgRect:extent), "inputAngle":angle, "inputRadius":radius ])
        return filter?.outputImage
    }
    
    public func pageCurlWithShadowTransition(target:CIImage, backside:CIImage, time:CGFloat = 0, extent:CGRect = CGRect(x:0, y:0, width:0, height:0), angle:CGFloat = 0.0, radius:CGFloat = 100.0, shadowSize:CGFloat = 0.5, shadowAmount:CGFloat = 0.7, shadowExtent:CGRect = CGRect(x:0, y:0, width:0, height:0)) -> CIImage? {
        let filter = CIFilter(name: "CIPageCurlWithShadowTransition", parameters: [
            "inputImage": self, "inputTargetImage":target, "inputBacksideImage":backside, "inputTime":time, "inputExtent":CIVector(cgRect:extent), "inputAngle":angle, "inputRadius":radius, "inputShadowSize":shadowSize, "inputShadowAmount":shadowAmount, "inputShadowExtent":CIVector(cgRect:shadowExtent) ])
        return filter?.outputImage
    }
    
    public func rippleTransition(target:CIImage, shading:CIImage, time:CGFloat = 0, center:CGPoint = CGPoint(x:150, y:150), extent:CGRect = CGRect(x:0, y:0, width:300, height:300), width:CGFloat = 100.0, scale:CGFloat = 50.0) -> CIImage? {
        let filter = CIFilter(name: "CIRippleTransition", parameters: [
            "inputImage": self, "inputTargetImage":target, "inputTime":time, "inputShadingImage":shading, "inputCenter":CIVector(x:center.x, y:center.y), "inputExtent":CIVector(cgRect:extent), "inputWidth":width, "inputScale":scale ])
        return filter?.outputImage
    }
    
    public func swipeTransition(target:CIImage, color:UIColor, time:CGFloat = 0, extent:CGRect = CGRect(x:0, y:0, width:300, height:300), angle:CGFloat = 0.0, width:CGFloat = 300.0, opacity:CGFloat = 0) -> CIImage? {
        let filter = CIFilter(name: "CISwipeTransition", parameters: [
            "inputImage": self, "inputTargetImage":target, "inputTime":time, "inputExtent":CIVector(cgRect:extent), "inputColor":color.ciColor, "inputAngle":angle, "inputWidth":width, "inputOpacity":opacity ])
        return filter?.outputImage
    }
}

public struct SpotColor {
    var centerColor:UIColor
    var replacementColor:UIColor
    var closeness:CGFloat = 0.22
    var contrast:CGFloat = 0.98
}

public struct ColorCoefficients {
    var c:[CGFloat]
    
    public init(r:CGFloat, g:CGFloat, b:CGFloat, rr:CGFloat, gg:CGFloat, bb:CGFloat, rg:CGFloat, gb:CGFloat, br:CGFloat, add:CGFloat) {
        c = [r, g, b, rr, gg, bb, rg, gb, br, add]
    }
    
    var vector:CIVector {
        return CIVector(values: c, count: 10)
    }
}

public struct Matrix3X3 {
    var c:[CGFloat]
    
    init(n00:CGFloat, n01:CGFloat, n02:CGFloat, n10:CGFloat, n11:CGFloat, n12:CGFloat, n20:CGFloat, n21:CGFloat, n22:CGFloat) {
        c = [n00, n01, n02, n10, n11, n12, n20, n21, n22]
    }
    
    var vector:CIVector {
        return CIVector(values: c, count: 9)
    }
}

public struct Matrix5X5 {
    var c:[CGFloat]
    
    init(n00:CGFloat, n01:CGFloat, n02:CGFloat, n03:CGFloat, n04:CGFloat,
         n10:CGFloat, n11:CGFloat, n12:CGFloat, n13:CGFloat, n14:CGFloat,
         n20:CGFloat, n21:CGFloat, n22:CGFloat, n23:CGFloat, n24:CGFloat,
         n30:CGFloat, n31:CGFloat, n32:CGFloat, n33:CGFloat, n34:CGFloat,
         n40:CGFloat, n41:CGFloat, n42:CGFloat, n43:CGFloat, n44:CGFloat) {
        c = [n00, n01, n02, n03, n04, n10, n11, n12, n13, n14, n20, n21, n22, n23, n24,
             n30, n31, n32, n33, n34, n40, n41, n42, n43, n44]
    }
    
    var vector:CIVector {
        return CIVector(values: c, count: 25)
    }
}

public struct Matrix7X7 {
    var c:[CGFloat]
    
    init(n00:CGFloat, n01:CGFloat, n02:CGFloat, n03:CGFloat, n04:CGFloat, n05:CGFloat, n06:CGFloat,
         n10:CGFloat, n11:CGFloat, n12:CGFloat, n13:CGFloat, n14:CGFloat, n15:CGFloat, n16:CGFloat,
         n20:CGFloat, n21:CGFloat, n22:CGFloat, n23:CGFloat, n24:CGFloat, n25:CGFloat, n26:CGFloat,
         n30:CGFloat, n31:CGFloat, n32:CGFloat, n33:CGFloat, n34:CGFloat, n35:CGFloat, n36:CGFloat,
         n40:CGFloat, n41:CGFloat, n42:CGFloat, n43:CGFloat, n44:CGFloat, n45:CGFloat, n46:CGFloat,
         n50:CGFloat, n51:CGFloat, n52:CGFloat, n53:CGFloat, n54:CGFloat, n55:CGFloat, n56:CGFloat,
         n60:CGFloat, n61:CGFloat, n62:CGFloat, n63:CGFloat, n64:CGFloat, n65:CGFloat, n66:CGFloat) {
        c = [n00, n01, n02, n03, n04, n05, n06,
             n10, n11, n12, n13, n14, n15, n16,
             n20, n21, n22, n23, n24, n25, n26,
             n30, n31, n32, n33, n34, n35, n36,
             n40, n41, n42, n43, n44, n45, n46,
             n50, n51, n52, n53, n54, n55, n56,
             n60, n61, n62, n63, n64, n65, n66]
    }
    
    var vector:CIVector {
        return CIVector(values: c, count: 49)
    }
}

public struct Dim3 {
    var dx:CGFloat, dy:CGFloat, dz:CGFloat
    
    init(x:CGFloat, y:CGFloat, z:CGFloat) {
        dx = x
        dy = y
        dz = z
    }
    
    var vector:CIVector {
        return CIVector(x: dx, y: dy, z: dz)
    }
}

extension CIVector {
    convenience init(componets:CIImage.ColorComponents) {
        self.init(x: componets.red, y: componets.green, z: componets.blue, w: componets.alpha)
    }
}

public enum ExFilter {
    case boxBlur(radius:CGFloat)
    case discBlur(radius:CGFloat)
    case gaussianBlur(radius:CGFloat)
    case median
    case motionBlur(radius:CGFloat, angle:CGFloat)
    case noiseReduction(noiseLevel:CGFloat, sharpness:CGFloat)
    case zoomBlur(center:CGPoint, amount:CGFloat)
    case colorClamp(minComponents:CIImage.ColorComponents, maxComponents:CIImage.ColorComponents)
    case colorControls(brightness:CGFloat, saturation:CGFloat, contrast:CGFloat)
    case colorMatrix(redVector:CIImage.ColorComponents, greenVector:CIImage.ColorComponents, blueVector:CIImage.ColorComponents, alpahVector:CIImage.ColorComponents, biasVector:CIImage.ColorComponents)
    case colorPolynomial(redVector:CIImage.ColorComponents, greenVector:CIImage.ColorComponents, blueVector:CIImage.ColorComponents, alpahVector:CIImage.ColorComponents, biasVector:CIImage.ColorComponents)
    case exposureAdjust(ev:CGFloat)
    case gammaAdjust(ev:CGFloat)
    case hueAdjust(ev:CGFloat)
    case linearToSRGBToneCurve(ev:CGFloat)
    case SRGBToneCurveToLinear(ev:CGFloat)
    case temperatureAndTint(neutral:(temp:CGFloat, tint:CGFloat), targetNeutral:(temp:CGFloat, tint:CGFloat))
    case toneCurve(point0:CGPoint, point1:CGPoint, point2:CGPoint, point3:CGPoint, point4:CGPoint)
    case vibrance(amount:CGFloat)
    case whitePointAdjust(color:UIColor)
    case colorCrossPolynomial(red:ColorCoefficients, green:ColorCoefficients, blue:ColorCoefficients)
    case colorCube(data:Data, dimension:CGFloat)
    case colorCubeWithColorSpace(data:Data, colorSpace:CGColorSpace, dimension:CGFloat)
    case colorInvert
    case colorMap(gradient:CIImage)
    case colorMonochrome(color:UIColor, intensity:CGFloat)
    case colorPosterize(levels:CGFloat)
    case flaseColor(color0:UIColor, color1:UIColor)
    case maskToAlpha
    case maximumComponent
    case minimumComponent
    case photoEffectChrome
    case photoEffectFade
    case photoEffectInstant
    case photoEffectNoir
    case photoEffectProcess
    case photoEffectTonal
    case photoEffectTransfer
    case sepiaTone(intensity:CGFloat)
    case vignette(radius:CGFloat, intensity:CGFloat)
    case vignetteEffect(center:CGPoint, radius:CGFloat, intensity:CGFloat)
    case additionCompositing(backgroudImage:CIImage)
    case colorBlendMode(backgroudImage:CIImage)
    case colorBurnBlendMode(backgroudImage:CIImage)
    case colorDodgeBlendMode(backgroudImage:CIImage)
    case darkenBlendMode(backgroudImage:CIImage)
    case differenceBlendMode(backgroudImage:CIImage)
    case divideBlendMode(backgroudImage:CIImage)
    case exclusionBlendMode(backgroudImage:CIImage)
    case hardLightBlendMode(backgroudImage:CIImage)
    case hueBlendMode(backgroudImage:CIImage)
    case lightenBlendMode(backgroudImage:CIImage)
    case linearBurnBlendMode(backgroudImage:CIImage)
    case linearDodgeBlendMode(backgroudImage:CIImage)
    case luminosityBlendMode(backgroudImage:CIImage)
    case maximumCompositing(backgroudImage:CIImage)
    case minimumCompositing(backgroudImage:CIImage)
    case multiplyBlendMode(backgroudImage:CIImage)
    case multiplyCompositing(backgroudImage:CIImage)
    case overlayBlendMode(backgroudImage:CIImage)
    case pinLightBlendMode(backgroudImage:CIImage)
    case saturationBlendMode(backgroudImage:CIImage)
    case screenBlendMode(backgroudImage:CIImage)
    case softLightBlendMode(backgroudImage:CIImage)
    case sourceAtopCompositing(backgroudImage:CIImage)
    case sourceInCompositing(backgroudImage:CIImage)
    case sourceOutCompositing(backgroudImage:CIImage)
    case sourceOverCompositing(backgroudImage:CIImage)
    case subtractBlendMode(backgroudImage:CIImage)
    case bumpDistortion(center:CGPoint, radius:CGFloat, scale:CGFloat)
    case bumpDistortionLinear(center:CGPoint, radius:CGFloat, angle:CGFloat, scale:CGFloat)
    case circleSplashDistortion(center:CGPoint, radius:CGFloat)
    case circularWrap(center:CGPoint, radius:CGFloat, angle:CGFloat)
    case droste(insetPoint0:CGPoint, insetPoint1:CGPoint, strand:CGFloat, periodicity:CGFloat, rotation:CGFloat, zoom:CGFloat)
    case displacementDistortion(displacementImage:CIImage, scale:CGFloat)
    case glassDistortion(texture:CIImage, center:CGPoint, scale:CGFloat)
    case glassLozenge(point0:CGPoint, point1:CGPoint, radius:CGFloat, refraction:CGFloat)
    case holeDistortion(center:CGPoint, radius:CGFloat)
    case lightTunnel(center:CGPoint, radius:CGFloat, rotation:CGFloat)
    case pinchDistortion(center:CGPoint, radius:CGFloat, scale:CGFloat)
    case stretchCrop(size:CGSize, cropAmount:Bool, centerStretchAmount:Bool)
    case torusLensDistortion(center:CGPoint, radius:CGFloat, width:CGFloat, refraction:CGFloat)
    case twirlDistortion(center:CGPoint, radius:CGFloat, angle:CGFloat)
    case vortexDistortion(center:CGPoint, radius:CGFloat, angle:CGFloat)
    case affineTransform(transform:CGAffineTransform)
    case crop(rect:CGRect)
    case lanczosScaleTransform(scale:CGFloat, aspectRatio:CGFloat)
    case perspectiveCorrection(topLeft:CGPoint, topRight:CGPoint, bottomLeft:CGPoint, bottomRight:CGPoint)
    case perspectiveTransform(topLeft:CGPoint, topRight:CGPoint, bottomLeft:CGPoint, bottomRight:CGPoint)
    case perspectiveTransformWithExtent(extent:CGAffineTransform, topLeft:CGPoint, topRight:CGPoint, bottomLeft:CGPoint, bottomRight:CGPoint)
    case straightenFilter(angle:CGFloat)
    case circularScreen(center:CGPoint, width:CGFloat, sharpness:CGFloat)
    case CMYKHalftone(center:CGPoint, width:CGFloat, angle:CGFloat, sharpness:CGFloat, GCR:CGFloat, UCR:CGFloat)
    case dotScreen(center:CGPoint, angle:CGFloat, width:CGFloat, sharpness:CGFloat)
    case hatchedScreen(center:CGPoint, angle:CGFloat, width:CGFloat, sharpness:CGFloat)
    case lineScreen(center:CGPoint, angle:CGFloat, width:CGFloat, sharpness:CGFloat)
    case areaAverage(extent:CGRect)
    case areaHistogram(extent:CGRect, count:CGFloat, scale:CGFloat)
    case rowAverage(extent:CGRect)
    case columnAverage(extent:CGRect)
    case histogramDisplayFilter(height:CGFloat, highLimit:CGFloat, lowLimit:CGFloat)
    case areaMaximum(extent:CGRect)
    case areaMinimum(extent:CGRect)
    case areaMaximumAlpha(extent:CGRect)
    case areaMinimumAlpha(extent:CGRect)
    case sharpenLuminance(sharpness:CGFloat)
    case unsharpMask(radius:CGFloat, intensity:CGFloat)
    case blendWithAlphaMask(backgroud:CIImage, mask:CIImage)
    case blendWithMask(backgroud:CIImage, mask:CIImage)
    case bloom(radius:CGFloat, intensity:CGFloat)
    case comicEffect
    case convolution3X3(matrix:Matrix3X3, bios:CGFloat)
    case convolution5X5(matrix:Matrix5X5, bios:CGFloat)
    case convolution7X7(matrix:Matrix7X7, bios:CGFloat)
    case convolution9Horizontal(matrix:Matrix3X3, bios:CGFloat)
    case convolution9Vertical(matrix:Matrix3X3, bios:CGFloat)
    case crystallize(center:CGPoint, radius:CGFloat)
    case depthOfField(point0:CGPoint, point1:CGPoint, saturation:CGFloat, unsharpMaskRadius:CGFloat, unsharpMaskIntensity:CGFloat, radius:CGFloat)
    case edges(intensity:CGFloat)
    case edgeWork(intensity:CGFloat)
    case gloom(radius:CGFloat, intensity:CGFloat)
    case heightFieldFromMask(radius:CGFloat)
    case hexagonalPixellate(center:CGPoint, scale:CGFloat)
    case highlightShadowAdjust(shadowAmount:CGFloat, highlightAmount:CGFloat)
    case lineOverlay(NRNoiseLeve:CGFloat, NRSharpness:CGFloat, edgeIntensity:CGFloat, threshold:CGFloat, contrast:CGFloat)
    case pixellate(center:CGPoint, scale:CGFloat)
    case pointillize(center:CGPoint, radius:CGFloat)
    case shadedMaterial(shadingImage:CIImage, scale:CGFloat)
    case spotColor(spot0:SpotColor, spot1:SpotColor, spot2:SpotColor)
    case spotLight(color:UIColor, lightPosition:Dim3, lightPointsAt:Dim3, brightness:CGFloat, concentration:CGFloat)
    case affineClamp(transform:CGAffineTransform)
    case affineTile(transform:CGAffineTransform)
    case eightfoldReflectedTile(center:CGPoint, angle:CGFloat, width:CGFloat)
    case fourfoldReflectedTile(center:CGPoint, angle:CGFloat, acuteAngle:CGFloat, width:CGFloat)
    case fourfoldRotatedTile(center:CGPoint, angle:CGFloat, width:CGFloat)
    case fourfoldTranslatedTile(center:CGPoint, angle:CGFloat, acuteAngle:CGFloat, width:CGFloat)
    case glideReflectedTile(center:CGPoint, angle:CGFloat, width:CGFloat)
    case kaleidoscope(center:CGPoint, count:CGFloat, angle:CGFloat)
    case opTile(center:CGPoint, angle:CGFloat, scale:CGFloat, width:CGFloat)
    case parallelogramTile(center:CGPoint, angle:CGFloat, acuteAngle:CGFloat, width:CGFloat)
    case perspectiveTile(topLeft:CGPoint, topRight:CGPoint, bottomLeft:CGPoint, bottomRight:CGPoint)
    case sixfoldReflectedTile(center:CGPoint, angle:CGFloat, width:CGFloat)
    case sixfoldRotatedTile(center:CGPoint, angle:CGFloat, width:CGFloat)
    case triangleKaleidoscope(point:CGPoint, size:CGFloat, rotation:CGFloat, decay:CGFloat)
    case triangleTile(center:CGPoint, angle:CGFloat, width:CGFloat)
    case twelvefoldReflectedTile(center:CGPoint, angle:CGFloat, width:CGFloat)
    case accordionFoldTransition(target:CIImage, time:CGFloat, bottomHeight:CGFloat, numberOfFolds:CGFloat, foldShadowAmount:CGFloat)
    case barsSwipeTransition(target:CIImage, time:CGFloat, angle:CGFloat, width:CGFloat, barOffset:CGFloat)
    case copyMachineTransition(target:CIImage, time:CGFloat, color:UIColor, extent:CGRect, angle:CGFloat, width:CGFloat, opacity:CGFloat)
    case disintegrateWithMaskTransition(target:CIImage, mask:CIImage, time:CGFloat, shadowRadius:CGFloat, shadowDesity:CGFloat, shadowOffset:CGSize)
    case dissolveTransition(target:CIImage, time:CGFloat)
    case flashTransition(target:CIImage, time:CGFloat, color:UIColor, center:CGPoint, extent:CGRect, maxStriationRadius:CGFloat, striationStrength:CGFloat, striationContrast:CGFloat, fadeThreshold:CGFloat)
    case modTransition(target:CIImage, time:CGFloat, center:CGPoint, angle:CGFloat, radius:CGFloat, compression:CGFloat)
    case pageCurlTransition(target:CIImage, backside:CIImage, shading:CIImage, time:CGFloat, extent:CGRect, angle:CGFloat, radius:CGFloat)
    case pageCurlWithShadowTransition(target:CIImage, backside:CIImage, time:CGFloat, extent:CGRect, angle:CGFloat, radius:CGFloat, shadowSize:CGFloat, shadowAmount:CGFloat, shadowExtent:CGRect)
    case rippleTransition(target:CIImage, shading:CIImage, time:CGFloat, center:CGPoint, extent:CGRect, width:CGFloat, scale:CGFloat)
    case swipeTransition(target:CIImage, color:UIColor, time:CGFloat, extent:CGRect, angle:CGFloat, width:CGFloat, opacity:CGFloat)
}

public enum ExGenerator {
    case aztecCode(data:Data, correctionLevel:CGFloat, layers:CGFloat, compactStyle:CGFloat)
    case checkerboard(color0:UIColor, color1:UIColor, center:CGPoint, width:CGFloat, sharpness:CGFloat)
    case code128Barcode(asciiString:String, quietSpace:CGFloat)
    case constantColor(color:UIColor)
    case lenticularHalo(color:UIColor, center:CGPoint, haloRadius:CGFloat, haloWidth:CGFloat, haloOverlap:CGFloat, striationStrenght:CGFloat, striationConstrast:CGFloat, time:CGFloat)
    case PDF417Barcode(data:Data, minWidth:CGFloat, maxWidth:CGFloat, minHeight:CGFloat, maxHeight:CGFloat, dataColums:CGFloat, rows:CGFloat, preferredAspectRatio:CGFloat, compactionMode:CIImage.PDF417CompactionMode, compactStyle:Bool, correctionLevel:CGFloat, alwaysSpecifyCompaction:CGFloat)
    case QRCode(data:Data, correctionLevel:CIImage.QRCodeCorrectionLevel)
    case random
    case starShine(color:UIColor, center:CGPoint, radius:CGFloat, crossScale:CGFloat, crossAngle:CGFloat, crossOpacity:CGFloat, crossWidth:CGFloat, epsilon:CGFloat)
    case stripes(color0:UIColor, color1:UIColor, center:CGPoint, width:CGFloat, sharpness:CGFloat)
    case sunbeams(color:UIColor, center:CGPoint, sunRadius:CGFloat, maxStriationRadius:CGFloat, striationStrength:CGFloat, striationContrast:CGFloat, time:CGFloat)
    case gaussianGradient(color0:UIColor, color1:UIColor, center:CGPoint, radius:CGFloat)
    case linearGradientRadius(color0:UIColor, color1:UIColor, center:CGPoint, radius0:CGFloat, radius1:CGFloat)
    case linearGradientPoint(color0:UIColor, color1:UIColor, point0:CGPoint, point1:CGPoint)
    case smoothLinearGradient(color0:UIColor, color1:UIColor, point0:CGPoint, point1:CGPoint)
}

public extension CIImage {
    public func apply(filter: ExFilter) -> CIImage? {
        switch filter {
        case .boxBlur(radius:let radius):
            return boxBlur(radius: radius)
        case .discBlur(radius:let radius):
            return discBlur(radius: radius)
        case .gaussianBlur(radius:let radius):
            return gaussianBlur(radius: radius)
        case .median:
            return medianFilter()
        case .motionBlur(radius:let radius, angle:let angle):
            return motionBlur(radius: radius, angle: angle)
        case .noiseReduction(noiseLevel:let noiseLevel, sharpness:let sharpness):
            return noiseReduction(noiseLevel: noiseLevel, sharpness: sharpness)
        case .zoomBlur(center:let center, amount:let amount):
            return zoomBlur(center: center, amount: amount)
        case .colorClamp(minComponents:let minComponents, maxComponents:let maxComponents):
            return colorClamp(minComponents: minComponents, maxComponents: maxComponents)
        case .colorControls(brightness:let brightness, saturation:let saturation, contrast:let contrast):
            return colorControls(brightness: brightness, saturation: saturation, contrast: contrast)
        case .colorMatrix(redVector:let redVector, greenVector:let greenVector, blueVector:let blueVector, alpahVector:let alpahVector, biasVector:let biasVector):
            return colorMatrix(redVector: redVector, greenVector: greenVector, blueVector: blueVector, alpahVector: alpahVector, biasVector: biasVector)
        case .colorPolynomial(redVector:let redVector, greenVector:let greenVector, blueVector:let blueVector, alpahVector:let alpahVector, biasVector:let biasVector):
            return colorPolynomial(redVector: redVector, greenVector: greenVector, blueVector: blueVector, alpahVector: alpahVector, biasVector: biasVector)
        case .exposureAdjust(ev:let ev):
            return exposureAdjust(ev: ev)
        case .gammaAdjust(ev:let ev):
            return gammaAdjust(ev: ev)
        case .hueAdjust(ev:let ev):
            return hueAdjust(ev: ev)
        case .linearToSRGBToneCurve(ev:let ev):
            return linearToSRGBToneCurve(ev: ev)
        case .SRGBToneCurveToLinear(ev:let ev):
            return SRGBToneCurveToLinear(ev: ev)
        case .temperatureAndTint(neutral:let neutral, targetNeutral:let targetNeutral):
            return temperatureAndTint(neutral: neutral, targetNeutral: targetNeutral)
        case .toneCurve(point0:let point0, point1:let point1, point2:let point2, point3:let point3, point4:let point4):
            return toneCurve(point0: point0, point1: point1, point2: point2, point3: point3, point4: point4)
        case .vibrance(amount:let amount):
            return vibrance(amount: amount)
        case .whitePointAdjust(color:let color):
            return whitePointAdjust(color: color)
        case .colorCrossPolynomial(red:let red, green:let green, blue:let blue):
            return colorCrossPolynomial(red: red, green: green, blue: blue)
        case .colorCube(data:let data, dimension:let dimension):
            return colorCube(data: data, dimension: dimension)
        case .colorCubeWithColorSpace(data:let data, colorSpace:let colorSpace, dimension:let dimension):
            return colorCubeWithColorSpace(data: data, colorSpace: colorSpace, dimension: dimension)
        case .colorInvert:
            return colorInvert()
        case .colorMap(gradient:let gradient):
            return colorMap(gradientImage: gradient)
        case .colorMonochrome(color:let color, intensity:let intensity):
            return colorMonochrome(color: color, intensity: intensity)
        case .colorPosterize(levels:let levels):
            return colorPosterize(levels: levels)
        case .flaseColor(color0:let color0, color1:let color1):
            return flaseColor(color0: color0, color1: color1)
        case .maskToAlpha:
            return maskToAlpha()
        case .maximumComponent:
            return maximumComponent()
        case .minimumComponent:
            return minimumComponent()
        case .photoEffectChrome:
            return photoEffectChrome()
        case .photoEffectFade:
            return photoEffectFade()
        case .photoEffectInstant:
            return photoEffectInstant()
        case .photoEffectNoir:
            return photoEffectNoir()
        case .photoEffectProcess:
            return photoEffectProcess()
        case .photoEffectTonal:
            return photoEffectTonal()
        case .photoEffectTransfer:
            return photoEffectTransfer()
        case .sepiaTone(intensity:let intensity):
            return sepiaTone(intensity: intensity)
        case .vignette(radius:let radius, intensity:let intensity):
            return vignette(radius: radius, intensity: intensity)
        case .vignetteEffect(center:let center, radius:let radius, intensity:let intensity):
            return vignetteEffect(center: center, radius: radius, intensity: intensity)
        case .additionCompositing(backgroudImage:let backgroudImage):
            return additionCompositing(backgroudImage: backgroudImage)
        case .colorBlendMode(backgroudImage:let backgroudImage):
            return colorBlendMode(backgroudImage: backgroudImage)
        case .colorBurnBlendMode(backgroudImage:let backgroudImage):
            return colorBurnBlendMode(backgroudImage: backgroudImage)
        case .colorDodgeBlendMode(backgroudImage:let backgroudImage):
            return colorDodgeBlendMode(backgroudImage: backgroudImage)
        case .darkenBlendMode(backgroudImage:let backgroudImage):
            return darkenBlendMode(backgroudImage: backgroudImage)
        case .differenceBlendMode(backgroudImage:let backgroudImage):
            return differenceBlendMode(backgroudImage: backgroudImage)
        case .divideBlendMode(backgroudImage:let backgroudImage):
            return divideBlendMode(backgroudImage: backgroudImage)
        case .exclusionBlendMode(backgroudImage:let backgroudImage):
            return exclusionBlendMode(backgroudImage: backgroudImage)
        case .hardLightBlendMode(backgroudImage:let backgroudImage):
            return hardLightBlendMode(backgroudImage: backgroudImage)
        case .hueBlendMode(backgroudImage:let backgroudImage):
            return hueBlendMode(backgroudImage: backgroudImage)
        case .lightenBlendMode(backgroudImage:let backgroudImage):
            return lightenBlendMode(backgroudImage: backgroudImage)
        case .linearBurnBlendMode(backgroudImage:let backgroudImage):
            return linearBurnBlendMode(backgroudImage: backgroudImage)
        case .linearDodgeBlendMode(backgroudImage:let backgroudImage):
            return linearDodgeBlendMode(backgroudImage: backgroudImage)
        case .luminosityBlendMode(backgroudImage:let backgroudImage):
            return luminosityBlendMode(backgroudImage: backgroudImage)
        case .maximumCompositing(backgroudImage:let backgroudImage):
            return maximumCompositing(backgroudImage: backgroudImage)
        case .minimumCompositing(backgroudImage:let backgroudImage):
            return minimumCompositing(backgroudImage: backgroudImage)
        case .multiplyBlendMode(backgroudImage:let backgroudImage):
            return multiplyBlendMode(backgroudImage: backgroudImage)
        case .multiplyCompositing(backgroudImage:let backgroudImage):
            return multiplyCompositing(backgroudImage: backgroudImage)
        case .overlayBlendMode(backgroudImage:let backgroudImage):
            return overlayBlendMode(backgroudImage: backgroudImage)
        case .pinLightBlendMode(backgroudImage:let backgroudImage):
            return pinLightBlendMode(backgroudImage: backgroudImage)
        case .saturationBlendMode(backgroudImage:let backgroudImage):
            return saturationBlendMode(backgroudImage: backgroudImage)
        case .screenBlendMode(backgroudImage:let backgroudImage):
            return screenBlendMode(backgroudImage: backgroudImage)
        case .softLightBlendMode(backgroudImage:let backgroudImage):
            return softLightBlendMode(backgroudImage: backgroudImage)
        case .sourceAtopCompositing(backgroudImage:let backgroudImage):
            return sourceAtopCompositing(backgroudImage: backgroudImage)
        case .sourceInCompositing(backgroudImage:let backgroudImage):
            return sourceInCompositing(backgroudImage: backgroudImage)
        case .sourceOutCompositing(backgroudImage:let backgroudImage):
            return sourceOutCompositing(backgroudImage: backgroudImage)
        case .sourceOverCompositing(backgroudImage:let backgroudImage):
            return sourceOverCompositing(backgroudImage: backgroudImage)
        case .subtractBlendMode(backgroudImage:let backgroudImage):
            return subtractBlendMode(backgroudImage: backgroudImage)
        case .bumpDistortion(center:let center, radius:let radius, scale:let scale):
            return bumpDistortion(center: center, radius: radius, scale: scale)
        case .bumpDistortionLinear(center:let center, radius:let radius, angle:let angle, scale:let scale):
            return bumpDistortionLinear(center: center, radius: radius, angle: angle, scale: scale)
        case .circleSplashDistortion(center:let center, radius:let radius):
            return circleSplashDistortion(center: center, radius: radius)
        case .circularWrap(center:let center, radius:let radius, angle:let angle):
            return circularWrap(center: center, radius: radius, angle: angle)
        case .droste(insetPoint0:let insetPoint0, insetPoint1:let insetPoint1, strand:let strand, periodicity:let periodicity, rotation:let rotation, zoom:let zoom):
            return droste(insetPoint0: insetPoint0, insetPoint1: insetPoint1, strand: strand, periodicity: periodicity, rotation: rotation, zoom: zoom)
        case .displacementDistortion(displacementImage:let displacementImage, scale:let scale):
            return displacementDistortion(displacementImage: displacementImage, scale: scale)
        case .glassDistortion(texture:let texture, center:let center, scale:let scale):
            return glassDistortion(texture: texture, center: center, scale: scale)
        case .glassLozenge(point0:let point0, point1:let point1, radius:let radius, refraction:let refraction):
            return glassLozenge(point0: point0, point1: point1, radius: radius, refraction: refraction)
        case .holeDistortion(center:let center, radius:let radius):
            return holeDistortion(center: center, radius: radius)
        case .lightTunnel(center:let center, radius:let radius, rotation:let rotation):
            return lightTunnel(center: center, radius: radius, rotation: rotation)
        case .pinchDistortion(center:let center, radius:let radius, scale:let scale):
            return pinchDistortion(center: center, radius: radius, scale: scale)
        case .stretchCrop(size:let size, cropAmount:let cropAmount, centerStretchAmount:let centerStretchAmount):
            return stretchCrop(size: size, cropAmount: cropAmount, centerStretchAmount: centerStretchAmount)
        case .torusLensDistortion(center:let center, radius:let radius, width:let width, refraction:let refraction):
            return torusLensDistortion(center: center, radius: radius, width: width, refraction: refraction)
        case .twirlDistortion(center:let center, radius:let radius, angle:let angle):
            return twirlDistortion(center: center, radius: radius, angle: angle)
        case .vortexDistortion(center:let center, radius:let radius, angle:let angle):
            return vortexDistortion(center: center, radius: radius, angle: angle)
        case .affineTransform(transform:let transform):
            return affineTransform(transform: transform)
        case .crop(rect:let rect):
            return crop(rect: rect)
        case .lanczosScaleTransform(scale:let scale, aspectRatio:let aspectRatio):
            return lanczosScaleTransform(scale: scale, aspectRatio: aspectRatio)
        case .perspectiveCorrection(topLeft:let topLeft, topRight:let topRight, bottomLeft:let bottomLeft, bottomRight:let bottomRight):
            return perspectiveCorrection(topLeft: topLeft, topRight: topRight, bottomLeft: bottomLeft, bottomRight: bottomRight)
        case .perspectiveTransform(topLeft:let topLeft, topRight:let topRight, bottomLeft:let bottomLeft, bottomRight:let bottomRight):
            return perspectiveTransform(topLeft: topLeft, topRight: topRight, bottomLeft: bottomLeft, bottomRight: bottomRight)
        case .perspectiveTransformWithExtent(extent:let extent, topLeft:let topLeft, topRight:let topRight, bottomLeft:let bottomLeft, bottomRight:let bottomRight):
            return perspectiveTransformWithExtent(extent: extent, topLeft: topLeft, topRight: topRight, bottomLeft: bottomLeft, bottomRight: bottomRight)
        case .straightenFilter(angle:let angle):
            return straightenFilter(angle: angle)
        case .circularScreen(center:let center, width:let width, sharpness:let sharpness):
            return circularScreen(center: center, width: width, sharpness: sharpness)
        case .CMYKHalftone(center:let center, width:let width, angle:let angle, sharpness:let sharpness, GCR:let GCR, UCR:let UCR):
            return CMYKHalftone(center: center, width: width, angle: angle, sharpness: sharpness, GCR: GCR, UCR: UCR)
        case .dotScreen(center:let center, angle:let angle, width:let width, sharpness:let sharpness):
            return dotScreen(center: center, angle: angle, width: width, sharpness: sharpness)
        case .hatchedScreen(center:let center, angle:let angle, width:let width, sharpness:let sharpness):
            return hatchedScreen(center: center, angle: angle, width: width, sharpness: sharpness)
        case .lineScreen(center:let center, angle:let angle, width:let width, sharpness:let sharpness):
            return lineScreen(center: center, angle: angle, width: width, sharpness: sharpness)
        case .areaAverage(extent:let extent):
            return areaAverage(extent: extent)
        case .areaHistogram(extent:let extent, count:let count, scale:let scale):
            return areaHistogram(extent: extent, count: count, scale: scale)
        case .rowAverage(extent:let extent):
            return rowAverage(extent: extent)
        case .columnAverage(extent:let extent):
            return columnAverage(extent: extent)
        case .histogramDisplayFilter(height:let height, highLimit:let highLimit, lowLimit:let lowLimit):
            return histogramDisplayFilter(height: height, highLimit: highLimit, lowLimit: lowLimit)
        case .areaMaximum(extent:let extent):
            return areaMaximum(extent: extent)
        case .areaMinimum(extent:let extent):
            return areaMinimum(extent: extent)
        case .areaMaximumAlpha(extent:let extent):
            return areaMaximumAlpha(extent: extent)
        case .areaMinimumAlpha(extent:let extent):
            return areaMinimumAlpha(extent: extent)
        case .sharpenLuminance(sharpness:let sharpness):
            return sharpenLuminance(sharpness: sharpness)
        case .unsharpMask(radius:let radius, intensity:let intensity):
            return unsharpMask(radius: radius, intensity: intensity)
        case .blendWithAlphaMask(backgroud:let backgroud, mask:let mask):
            return blendWithAlphaMask(backgroud: backgroud, mask: mask)
        case .blendWithMask(backgroud:let backgroud, mask:let mask):
            return blendWithMask(backgroud: backgroud, mask: mask)
        case .bloom(radius:let radius, intensity:let intensity):
            return bloom(radius: radius, intensity: intensity)
        case .comicEffect:
            return comicEffect()
        case .convolution3X3(matrix:let matrix, bios:let bios):
            return convolution3X3(matrix: matrix, bios: bios)
        case .convolution5X5(matrix:let matrix, bios:let bios):
            return convolution5X5(matrix: matrix, bios: bios)
        case .convolution7X7(matrix:let matrix, bios:let bios):
            return convolution7X7(matrix: matrix, bios: bios)
        case .convolution9Horizontal(matrix:let matrix, bios:let bios):
            return convolution9Horizontal(matrix: matrix, bios: bios)
        case .convolution9Vertical(matrix:let matrix, bios:let bios):
            return convolution9Vertical(matrix: matrix, bios: bios)
        case .crystallize(center:let center, radius:let radius):
            return crystallize(center: center, radius: radius)
        case .depthOfField(point0:let point0, point1:let point1, saturation:let saturation, unsharpMaskRadius:let unsharpMaskRadius, unsharpMaskIntensity:let unsharpMaskIntensity, radius:let radius):
            return depthOfField(point0: point0, point1: point1, saturation: saturation, unsharpMaskRadius: unsharpMaskRadius, unsharpMaskIntensity: unsharpMaskIntensity, radius: radius)
        case .edges(intensity:let intensity):
            return edges(intensity: intensity)
        case .edgeWork(intensity:let intensity):
            return edgeWork(intensity: intensity)
        case .gloom(radius:let radius, intensity:let intensity):
            return gloom(radius: radius, intensity: intensity)
        case .heightFieldFromMask(radius:let radius):
            return heightFieldFromMask(radius: radius)
        case .hexagonalPixellate(center:let center, scale:let scale):
            return hexagonalPixellate(center: center, scale: scale)
        case .highlightShadowAdjust(shadowAmount:let shadowAmount, highlightAmount:let highlightAmount):
            return highlightShadowAdjust(shadowAmount: shadowAmount, highlightAmount: highlightAmount)
        case .lineOverlay(NRNoiseLeve:let NRNoiseLeve, NRSharpness:let NRSharpness, edgeIntensity:let edgeIntensity, threshold:let threshold, contrast:let contrast):
            return lineOverlay(NRNoiseLeve: NRNoiseLeve, NRSharpness: NRSharpness, edgeIntensity: edgeIntensity, threshold: threshold, contrast: contrast)
        case .pixellate(center:let center, scale:let scale):
            return pixellate(center: center, scale: scale)
        case .pointillize(center:let center, radius:let radius):
            return pointillize(center: center, radius: radius)
        case .shadedMaterial(shadingImage:let shadingImage, scale:let scale):
            return shadedMaterial(shadingImage: shadingImage, scale: scale)
        case .spotColor(spot0:let spot0, spot1:let spot1, spot2:let spot2):
            return spotColor(spot0: spot0, spot1: spot1, spot2: spot2)
        case .spotLight(color:let color, lightPosition:let lightPosition, lightPointsAt:let lightPointsAt, brightness:let brightness, concentration:let concentration):
            return spotLight(color: color, lightPosition: lightPosition, lightPointsAt: lightPointsAt, brightness: brightness, concentration: concentration)
        case .affineClamp(transform:let transform):
            return affineClamp(transform: transform)
        case .affineTile(transform:let transform):
            return affineTile(transform: transform)
        case .eightfoldReflectedTile(center:let center, angle:let angle, width:let width):
            return eightfoldReflectedTile(center: center, angle: angle, width: width)
        case .fourfoldReflectedTile(center:let center, angle:let angle, acuteAngle:let acuteAngle, width:let width):
            return fourfoldReflectedTile(center: center, angle: angle, acuteAngle: acuteAngle, width: width)
        case .fourfoldRotatedTile(center:let center, angle:let angle, width:let width):
            return fourfoldRotatedTile(center: center, angle: angle, width: width)
        case .fourfoldTranslatedTile(center:let center, angle:let angle, acuteAngle:let acuteAngle, width:let width):
            return fourfoldTranslatedTile(center: center, angle: angle, acuteAngle: acuteAngle, width: width)
        case .glideReflectedTile(center:let center, angle:let angle, width:let width):
            return glideReflectedTile(center: center, angle: angle, width: width)
        case .kaleidoscope(center:let center, count:let count, angle:let angle):
            return kaleidoscope(center: center, count: count, angle: angle)
        case .opTile(center:let center, angle:let angle, scale:let scale, width:let width):
            return opTile(center: center, angle: angle, scale: scale, width: width)
        case .parallelogramTile(center:let center, angle:let angle, acuteAngle:let acuteAngle, width:let width):
            return parallelogramTile(center: center, angle: angle, acuteAngle: acuteAngle, width: width)
        case .perspectiveTile(topLeft:let topLeft, topRight:let topRight, bottomLeft:let bottomLeft, bottomRight:let bottomRight):
            return perspectiveTile(topLeft: topLeft, topRight: topRight, bottomLeft: bottomLeft, bottomRight: bottomRight)
        case .sixfoldReflectedTile(center:let center, angle:let angle, width:let width):
            return sixfoldReflectedTile(center: center, angle: angle, width: width)
        case .sixfoldRotatedTile(center:let center, angle:let angle, width:let width):
            return sixfoldRotatedTile(center: center, angle: angle, width: width)
        case .triangleKaleidoscope(point:let point, size:let size, rotation:let rotation, decay:let decay):
            return triangleKaleidoscope(point: point, size: size, rotation: rotation, decay: decay)
        case .triangleTile(center:let center, angle:let angle, width:let width):
            return triangleTile(center: center, angle: angle, width: width)
        case .twelvefoldReflectedTile(center:let center, angle:let angle, width:let width):
            return twelvefoldReflectedTile(center: center, angle: angle, width: width)
        case .accordionFoldTransition(target:let target, time:let time, bottomHeight:let bottomHeight, numberOfFolds:let numberOfFolds, foldShadowAmount:let foldShadowAmount):
            return accordionFoldTransition(target: target, time: time, bottomHeight: bottomHeight, numberOfFolds: numberOfFolds, foldShadowAmount: foldShadowAmount)
        case .barsSwipeTransition(target:let target, time:let time, angle:let angle, width:let width, barOffset:let barOffset):
            return barsSwipeTransition(target: target, time: time, angle: angle, width: width, barOffset: barOffset)
        case .copyMachineTransition(target:let target, time:let time, color:let color, extent:let extent, angle:let angle, width:let width, opacity:let opacity):
            return copyMachineTransition(target: target, time: time, color: color, extent: extent, angle: angle, width: width, opacity: opacity)
        case .disintegrateWithMaskTransition(target:let target, mask:let mask, time:let time, shadowRadius:let shadowRadius, shadowDesity:let shadowDesity, shadowOffset:let shadowOffset):
            return disintegrateWithMaskTransition(target: target, mask: mask, time: time, shadowRadius: shadowRadius, shadowDesity: shadowDesity, shadowOffset: shadowOffset)
        case .dissolveTransition(target:let target, time:let time):
            return dissolveTransition(target: target, time: time)
        case .flashTransition(target:let target, time:let time, color:let color, center:let center, extent:let extent, maxStriationRadius:let maxStriationRadius, striationStrength:let striationStrength, striationContrast:let striationContrast, fadeThreshold:let fadeThreshold):
            return flashTransition(target: target, time: time, color: color, center: center, extent: extent, maxStriationRadius: maxStriationRadius, striationStrength: striationStrength, striationContrast: striationContrast, fadeThreshold: fadeThreshold)
        case .modTransition(target:let target, time:let time, center:let center, angle:let angle, radius:let radius, compression:let compression):
            return modTransition(target: target, time: time, center: center, angle: angle, radius: radius, compression: compression)
        case .pageCurlTransition(target:let target, backside:let backside, shading:let shading, time:let time, extent:let extent, angle:let angle, radius:let radius):
            return pageCurlTransition(target: target, backside: backside, shading: shading, time: time, extent: extent, angle: angle, radius: radius)
        case .pageCurlWithShadowTransition(target:let target, backside:let backside, time:let time, extent:let extent, angle:let angle, radius:let radius, shadowSize:let shadowSize, shadowAmount:let shadowAmount, shadowExtent:let shadowExtent):
            return pageCurlWithShadowTransition(target: target, backside: backside, time: time, extent: extent, angle: angle, radius: radius, shadowSize: shadowSize, shadowAmount: shadowAmount, shadowExtent: shadowExtent)
        case .rippleTransition(target:let target, shading:let shading, time:let time, center:let center, extent:let extent, width:let width, scale:let scale):
            return rippleTransition(target: target, shading: shading, time: time, center: center, extent: extent, width: width, scale: scale)
        case .swipeTransition(target:let target, color:let color, time:let time, extent:let extent, angle:let angle, width:let width, opacity:let opacity):
            return swipeTransition(target: target, color: color, time: time, extent: extent, angle: angle, width: width, opacity: opacity)
        }
    }
    
    public static func generate(generator: ExGenerator) -> CIImage? {
        switch generator {
        case .aztecCode(data: let data, correctionLevel: let correctionLevel, layers: let layers, compactStyle: let compactStyle):
            return aztecCodeGenerator(data: data, correctionLevel: correctionLevel, layers: layers, compactStyle: compactStyle)
        case .checkerboard(color0: let color0, color1: let color1, center: let center, width: let width, sharpness: let sharpness):
            return checkerboardGenerato(color0: color0, color1: color1, center: center, width: width, sharpness: sharpness)
        case .code128Barcode(asciiString: let asciiString, quietSpace: let quietSpace):
            return code128BarcodeGenerator(asciiString: asciiString, quietSpace: quietSpace)
        case .constantColor(color: let color):
            return constantColorGenerator(color: color)
        case .lenticularHalo(color: let color, center: let center, haloRadius: let haloRadius, haloWidth: let haloWidth, haloOverlap: let haloOverlap, striationStrenght: let striationStrenght, striationConstrast: let striationConstrast, time: let time):
            return lenticularHaloGenerator(color: color, center: center, haloRadius: haloRadius, haloWidth: haloWidth, haloOverlap: haloOverlap, striationStrenght: striationStrenght, striationConstrast: striationConstrast, time: time)
        case .PDF417Barcode(data:let data, minWidth:let minWidth, maxWidth:let maxWidth, minHeight:let minHeight, maxHeight:let maxHeight, dataColums:let dataColums, rows:let rows, preferredAspectRatio:let preferredAspectRatio, compactionMode:let compactionMode, compactStyle:let compactStyle, correctionLevel:let correctionLevel, alwaysSpecifyCompaction:let alwaysSpecifyCompaction):
            return PDF417BarcodeGenerator(data: data, minWidth: minWidth, maxWidth: maxWidth, minHeight: minHeight, maxHeight: maxHeight, dataColums: dataColums, rows: rows, preferredAspectRatio: preferredAspectRatio, compactionMode: compactionMode, compactStyle: compactStyle, correctionLevel: correctionLevel, alwaysSpecifyCompaction: alwaysSpecifyCompaction)
        case .QRCode(data:let data, correctionLevel:let correctionLevel):
            return QRCodeGenerator(data: data, correctionLevel: correctionLevel)
        case .random:
            return randomGenerator()
        case .starShine(color:let color, center:let center, radius:let radius, crossScale:let crossScale, crossAngle:let crossAngle, crossOpacity:let crossOpacity, crossWidth:let crossWidth, epsilon:let epsilon):
            return starShineGenerator(color: color, center: center, radius: radius, crossScale: crossScale, crossAngle: crossAngle, crossOpacity: crossOpacity, crossWidth: crossWidth, epsilon: epsilon)
        case .stripes(color0:let color0, color1:let color1, center:let center, width:let width, sharpness:let sharpness):
            return stripesGenerator(color0: color0, color1: color1, center: center, width: width, sharpness: sharpness)
        case .sunbeams(color:let color, center:let center, sunRadius:let sunRadius, maxStriationRadius:let maxStriationRadius, striationStrength:let striationStrength, striationContrast:let striationContrast, time:let time):
            return sunbeamsGenerator(color: color, center: center, sunRadius: sunRadius, maxStriationRadius: maxStriationRadius, striationStrength: striationStrength, striationContrast: striationContrast, time: time)
        case .gaussianGradient(color0:let color0, color1:let color1, center:let center, radius:let radius):
            return gaussianGradient(color0: color0, color1: color1, center: center, radius: radius)
        case .linearGradientRadius(color0:let color0, color1:let color1, center:let center, radius0:let radius0, radius1:let radius1):
            return linearGradient(color0: color0, color1: color1, center: center, radius0: radius0, radius1: radius1)
        case .linearGradientPoint(color0:let color0, color1:let color1, point0:let point0, point1:let point1):
            return linearGradient(color0: color0, color1: color1, point0: point0, point1: point1)
        case .smoothLinearGradient(color0:let color0, color1:let color1, point0:let point0, point1:let point1):
            return smoothLinearGradient(color0: color0, color1: color1, point0: point0, point1: point1)
        }
    }
}
