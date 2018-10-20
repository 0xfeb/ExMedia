# ExMedia
### A part of ExtraSwift which apply some features for media. 

### Install

* Use source code, download source and drag into your project. 

* Use cocoapods, write a line into your Podfile. 
`pod 'ExMedia'`

### Color

* Extension -- UIColor

Create an instance from hex string

> `init(hex:String)`

Create an instance from red/green/blue/alpha parts, red/green/blue use the number between 0 to 255, and 0 to 100 for alpha. 

> `init(RGBA r:Int, _ g:Int, _ b:Int, _ a:Int = 100)`

Create an instanse from HSB/alpha. all the parts number between 0 to 100

> `init(HSBA h:Int, _ s:Int, _ b:Int, _ a:Int = 100)`

Get red/green/blue/alpha parts of the color, red/green/blue use the number between 0 to 255, and 0 to 100 for alpha. 

> `var RGBA:(Int, Int, Int, Int)`

Get hex string, include red/green/blue

> `var hex6:String`

Get hex string, include red/green/blue/alpha

> `var hex8:String`

Get HSB/alpha parts. all the parts number between 0 to 100

> `var HSBA:(Int, Int, Int, Int)`

Get middle color of current color and another one.

> `func combined(color:UIColor) -> UIColor`

Remove a color number from current color.

> `func divided(color:UIColor) -> UIColor`

Generate a color more lighter than current one.

> `func lighted(level:Int) -> UIColor`

Generate a color more darker than current one.

> `func darked(level:Int) -> UIColor`


### Filter

* Extension -- UIImage 

Get CIImage from UIImage

> `var ciImage:CIImage?`

Apply a filter and generate a new UIImage instance.

> `func applyFilter(_ action:(CIImage) -> CIImage?) -> UIImage?`

Generate an UIImage from a filter. 

> `static func generator(size:CGSize, _ action:() -> CIImage?) -> UIImage?`


* Extension -- CIImage

Get UIImage from CIImage

> `func uiImage(size:CGSize? = nil) -> UIImage?`


* Extension --- CIImage

Filters -- get reference from apple documents
> `func boxBlur(radius:CGFloat = 10.0) -> CIImage?`

> `func discBlur(radius:CGFloat = 8.0) -> CIImage?`

> `func gaussianBlur(radius:CGFloat = 8.0) -> CIImage?`

> `func medianFilter() -> CIImage?`

> `func motionBlur(radius:CGFloat = 20.0, angle:CGFloat = 0.0) -> CIImage?`

> `func noiseReduction(noiseLevel:CGFloat = 0.02, sharpness:CGFloat = 0.4) -> CIImage?`

> `func zoomBlur(center:CGPoint = CGPoint(x: 150.0, y: 150.0), amount:CGFloat = 20.0) -> CIImage?`

> `func colorClamp(minComponents:ColorComponents = (0, 0, 0, 0), maxComponents:ColorComponents = (0, 0, 0, 0)) -> CIImage?`

> `func colorControls(brightness:CGFloat, saturation:CGFloat = 1.0, contrast:CGFloat = 1.0) -> CIImage?`

> `func colorMatrix(redVector:ColorComponents = (1, 0, 0, 0), greenVector:ColorComponents = (0, 1, 0, 0), blueVector:ColorComponents = (0, 0, 1, 0), alpahVector:ColorComponents = (0, 0, 0, 1), biasVector:ColorComponents = (0, 0, 0, 0)) -> CIImage?`

> `func colorPolynomial(redVector:ColorComponents = (1, 0, 0, 0), greenVector:ColorComponents = (0, 1, 0, 0), blueVector:ColorComponents = (0, 0, 1, 0), alpahVector:ColorComponents = (0, 0, 0, 1), biasVector:ColorComponents = (0, 0, 0, 0)) -> CIImage?`

> `func exposureAdjust(ev:CGFloat = 0.5) -> CIImage?`

> `func gammaAdjust(ev:CGFloat = 0.75) -> CIImage?`

> `func hueAdjust(ev:CGFloat = 0.75) -> CIImage?`

> `func linearToSRGBToneCurve(ev:CGFloat = 0.75) -> CIImage?`

> `func SRGBToneCurveToLinear(ev:CGFloat = 0.75) -> CIImage?`

> `func temperatureAndTint(neutral:(temp:CGFloat, tint:CGFloat) = (6500, 0), targetNeutral:(temp:CGFloat, tint:CGFloat) = (6500, 0)) -> CIImage?`

> `func toneCurve(point0:CGPoint = CGPoint(x: 0, y: 0), point1:CGPoint = CGPoint(x: 0.25, y: 0.25), point2:CGPoint = CGPoint(x: 0.5, y: 0.5), point3:CGPoint = CGPoint(x: 0.75, y: 0.75), point4:CGPoint = CGPoint(x: 1, y: 1)) -> CIImage?`

> `func vibrance(amount:CGFloat) -> CIImage?`

> `func whitePointAdjust(color:UIColor) -> CIImage?`

> `func colorCrossPolynomial(red:ColorCoefficients = ColorCoefficients(r: 1, g: 0, b: 0, rr: 0, gg: 0, bb: 0, rg: 0, gb: 0, br: 0, add: 0), green:ColorCoefficients = ColorCoefficients(r: 0, g: 1, b: 0, rr: 0, gg: 0, bb: 0, rg: 0, gb: 0, br: 0, add: 0), blue:ColorCoefficients = ColorCoefficients(r: 0, g: 0, b: 1, rr: 0, gg: 0, bb: 0, rg: 0, gb: 0, br: 0, add: 0)) -> CIImage?`

> `func colorCube(data:Data, dimension:CGFloat = 2.0) -> CIImage?`

> `func colorCubeWithColorSpace(data:Data, colorSpace:CGColorSpace, dimension:CGFloat = 2.0) -> CIImage?`

> `func colorInvert() -> CIImage?`

> `func colorMap(gradientImage:CIImage) -> CIImage?`

> `func colorMonochrome(color:UIColor, intensity:CGFloat = 1.0) -> CIImage?`

> `func colorPosterize(levels:CGFloat) -> CIImage?`

> `func flaseColor(color0:UIColor, color1:UIColor) -> CIImage?`

> `func maskToAlpha() -> CIImage?`

> `func maximumComponent() -> CIImage?`

> `func minimumComponent() -> CIImage?`

> `func photoEffectChrome() -> CIImage?`

> `func photoEffectFade() -> CIImage?`

> `func photoEffectInstant() -> CIImage?`

> `func photoEffectMono() -> CIImage?`

> `func photoEffectNoir() -> CIImage?`

> `func photoEffectProcess() -> CIImage?`

> `func photoEffectTonal() -> CIImage?`

> `func photoEffectTransfer() -> CIImage?`

> `func sepiaTone(intensity:CGFloat = 1.0) -> CIImage?`

> `func vignette(radius:CGFloat = 1.0, intensity:CGFloat = 0.0) -> CIImage?`

> `func vignetteEffect(center:CGPoint = CGPoint(x: 150, y: 150), radius:CGFloat = 0.0, intensity:CGFloat = 1.0) -> CIImage?`

> `func additionCompositing(backgroudImage:CIImage) -> CIImage?`

> `func colorBlendMode(backgroudImage:CIImage) -> CIImage?`

> `func colorBurnBlendMode(backgroudImage:CIImage) -> CIImage?`

> `func colorDodgeBlendMode(backgroudImage:CIImage) -> CIImage?`

> `func darkenBlendMode(backgroudImage:CIImage) -> CIImage?`

> `func differenceBlendMode(backgroudImage:CIImage) -> CIImage?`

> `func divideBlendMode(backgroudImage:CIImage) -> CIImage?`

> `func exclusionBlendMode(backgroudImage:CIImage) -> CIImage?`

> `func hardLightBlendMode(backgroudImage:CIImage) -> CIImage?`

> `func hueBlendMode(backgroudImage:CIImage) -> CIImage?`

> `func lightenBlendMode(backgroudImage:CIImage) -> CIImage?`

> `func linearBurnBlendMode(backgroudImage:CIImage) -> CIImage?`

> `func linearDodgeBlendMode(backgroudImage:CIImage) -> CIImage?`

> `func luminosityBlendMode(backgroudImage:CIImage) -> CIImage?`

> `func maximumCompositing(backgroudImage:CIImage) -> CIImage?`

> `func minimumCompositing(backgroudImage:CIImage) -> CIImage?`

> `func multiplyBlendMode(backgroudImage:CIImage) -> CIImage?`

> `func multiplyCompositing(backgroudImage:CIImage) -> CIImage?`

> `func overlayBlendMode(backgroudImage:CIImage) -> CIImage?`

> `func pinLightBlendMode(backgroudImage:CIImage) -> CIImage?`

> `func saturationBlendMode(backgroudImage:CIImage) -> CIImage?`

> `func screenBlendMode(backgroudImage:CIImage) -> CIImage?`

> `func softLightBlendMode(backgroudImage:CIImage) -> CIImage?`

> `func sourceAtopCompositing(backgroudImage:CIImage) -> CIImage?`

> `func sourceInCompositing(backgroudImage:CIImage) -> CIImage?`

> `func sourceOutCompositing(backgroudImage:CIImage) -> CIImage?`

> `func sourceOverCompositing(backgroudImage:CIImage) -> CIImage?`

> `func subtractBlendMode(backgroudImage:CIImage) -> CIImage?`

> `func bumpDistortion(center:CGPoint = CGPoint(x: 150, y: 150), radius:CGFloat = 300.0, scale:CGFloat = 0.5) -> CIImage?`

> `func bumpDistortionLinear(center:CGPoint = CGPoint(x: 300, y: 300), radius:CGFloat = 300.0, angle:CGFloat = 0, scale:CGFloat = 0.5) -> CIImage?`

> `func circleSplashDistortion(center:CGPoint = CGPoint(x: 150, y: 150), radius:CGFloat = 150.0) -> CIImage?`

> `func circularWrap(center:CGPoint = CGPoint(x: 150, y: 150), radius:CGFloat = 150.0, angle:CGFloat = 0.0) -> CIImage?`

> `func droste(insetPoint0:CGPoint = CGPoint(x: 200, y: 200), insetPoint1:CGPoint = CGPoint(x: 400, y: 400), strand:CGFloat = 1.0, periodicity:CGFloat = 1.0, rotation:CGFloat = 0.0, zoom:CGFloat = 1.0) -> CIImage?`

> `func displacementDistortion(displacementImage:CIImage, scale:CGFloat = 50.0) -> CIImage?`

> `func glassDistortion(texture:CIImage, center:CGPoint = CGPoint(x: 150, y:150), scale:CGFloat = 200.0) -> CIImage?`

> `func glassLozenge(point0:CGPoint = CGPoint(x: 150, y: 150), point1:CGPoint = CGPoint(x: 150, y: 150), radius:CGFloat = 100.0, refraction:CGFloat = 1.7) -> CIImage?`

> `func holeDistortion(center:CGPoint = CGPoint(x: 150, y: 150), radius:CGFloat = 150.0) -> CIImage?`

> `func lightTunnel(center:CGPoint = CGPoint(x: 150, y: 150), radius:CGFloat = 0, rotation:CGFloat = 0) -> CIImage?`

> `func pinchDistortion(center:CGPoint = CGPoint(x: 150, y: 150), radius:CGFloat = 300.0, scale:CGFloat = 0.5) -> CIImage?`

> `func stretchCrop(size:CGSize, cropAmount:Bool, centerStretchAmount:Bool) -> CIImage?`

> `func torusLensDistortion(center:CGPoint = CGPoint(x: 150, y: 150), radius:CGFloat = 160.0, width:CGFloat = 80.0, refraction:CGFloat = 1.7) -> CIImage?`

> `func twirlDistortion(center:CGPoint = CGPoint(x: 150, y: 150), radius:CGFloat = 300.0, angle:CGFloat = 3.14) -> CIImage?`

> `func vortexDistortion(center:CGPoint = CGPoint(x: 150, y: 150), radius:CGFloat = 300.0, angle:CGFloat = 56.55) -> CIImage?`

Generators -- get reference from apple documents

> `static func aztecCodeGenerator(data:Data, correctionLevel:CGFloat = 23.0, layers:CGFloat = 0, compactStyle:CGFloat = 0) -> CIImage?`

> `static func checkerboardGenerato(color0:UIColor, color1:UIColor, center:CGPoint = CGPoint(x: 150, y: 150), width:CGFloat = 80.0, sharpness:CGFloat = 1.0) -> CIImage?`

> `static func code128BarcodeGenerator(asciiString:String, quietSpace:CGFloat = 7.0) -> CIImage?`

> `static func constantColorGenerator(color:UIColor) -> CIImage?`

> `static func lenticularHaloGenerator(color:UIColor, center:CGPoint = CGPoint(x: 150, y: 150), haloRadius:CGFloat = 70.0, haloWidth:CGFloat = 87.0, haloOverlap:CGFloat = 0.77, striationStrenght:CGFloat = 0.5, striationConstrast:CGFloat = 1.0, time:CGFloat = 0) -> CIImage?`

> `static func PDF417BarcodeGenerator(data:Data, minWidth:CGFloat = 0, maxWidth:CGFloat = 0, minHeight:CGFloat = 0, maxHeight:CGFloat = 0, dataColums:CGFloat = 0, rows:CGFloat = 0, preferredAspectRatio:CGFloat = 0, compactionMode:PDF417CompactionMode = .automatic, compactStyle:Bool = false, correctionLevel:CGFloat = 0, alwaysSpecifyCompaction:CGFloat = 0 ) -> CIImage?`

> `static func QRCodeGenerator(data:Data, correctionLevel:QRCodeCorrectionLevel = .Medium) -> CIImage?`

> `static func randomGenerator() -> CIImage?`

> `static func starShineGenerator(color:UIColor, center:CGPoint = CGPoint(x: 150, y: 150), radius:CGFloat = 50.0, crossScale:CGFloat = 15.0, crossAngle:CGFloat = 0.6, crossOpacity:CGFloat = -2.0, crossWidth:CGFloat = 2.5, epsilon:CGFloat = -2.0) -> CIImage?`

> `static func stripesGenerator(color0:UIColor, color1:UIColor, center:CGPoint = CGPoint(x: 150, y: 150), width:CGFloat = 80.0, sharpness:CGFloat = 1.0) -> CIImage?`

> `static func sunbeamsGenerator(color:UIColor, center:CGPoint = CGPoint(x: 150, y: 150), sunRadius:CGFloat = 40.0, maxStriationRadius:CGFloat = 2.58, striationStrength:CGFloat = 0.5, striationContrast:CGFloat = 1.38, time:CGFloat = 0.0) -> CIImage?`

Transformer -- get reference from apple documents

> `func affineTransform(transform:CGAffineTransform) -> CIImage?`

> `func crop(rect:CGRect) -> CIImage?`

> `func lanczosScaleTransform(scale:CGFloat = 1.0, aspectRatio:CGFloat = 1.0) -> CIImage?`

> `func perspectiveCorrection(topLeft:CGPoint, topRight:CGPoint, bottomLeft:CGPoint, bottomRight:CGPoint) -> CIImage?`

> `func perspectiveTransform(topLeft:CGPoint, topRight:CGPoint, bottomLeft:CGPoint, bottomRight:CGPoint) -> CIImage?`

> `func perspectiveTransformWithExtent(extent:CGAffineTransform, topLeft:CGPoint, topRight:CGPoint, bottomLeft:CGPoint, bottomRight:CGPoint) -> CIImage?`

> `func straightenFilter(angle:CGFloat) -> CIImage?`

Grandient -- get reference from apple documents

> `static func gaussianGradient(color0:UIColor, color1:UIColor, center:CGPoint = CGPoint(x:150, y:150), radius:CGFloat = 300.0) -> CIImage?`

> `static func linearGradient(color0:UIColor, color1:UIColor, center:CGPoint, radius0:CGFloat, radius1:CGFloat) -> CIImage?`

> `static func linearGradient(color0:UIColor, color1:UIColor, point0:CGPoint, point1:CGPoint) -> CIImage?`

> `static func smoothLinearGradient(color0:UIColor, color1:UIColor, point0:CGPoint, point1:CGPoint) -> CIImage?`

Half tone -- get reference from apple documents

> `func circularScreen(center:CGPoint, width:CGFloat = 6.0, sharpness:CGFloat = 0.7) -> CIImage?`

> `func CMYKHalftone(center:CGPoint, width:CGFloat = 6.0, angle:CGFloat = 0.0, sharpness:CGFloat = 0.7, GCR:CGFloat = 1.0, UCR:CGFloat = 0.5) -> CIImage?`

> `func dotScreen(center:CGPoint, angle:CGFloat = 0.0, width:CGFloat = 6.0, sharpness:CGFloat = 0.7) -> CIImage?`

> `func hatchedScreen(center:CGPoint, angle:CGFloat = 0.0, width:CGFloat = 6.0, sharpness:CGFloat = 0.7) -> CIImage?`

> `func lineScreen(center:CGPoint, angle:CGFloat = 0.0, width:CGFloat = 6.0, sharpness:CGFloat = 0.7) -> CIImage?`

> `func areaAverage(extent:CGRect) -> CIImage?`

> `func areaHistogram(extent:CGRect, count:CGFloat, scale:CGFloat) -> CIImage?`

> `func rowAverage(extent:CGRect) -> CIImage?`

> `func columnAverage(extent:CGRect) -> CIImage?`

> `func histogramDisplayFilter(height:CGFloat = 100.0, highLimit:CGFloat = 1.0, lowLimit:CGFloat = 0.0) -> CIImage?`

> `func areaMaximum(extent:CGRect) -> CIImage?`

> `func areaMinimum(extent:CGRect) -> CIImage?`

> `func areaMaximumAlpha(extent:CGRect) -> CIImage?`

> `func areaMinimumAlpha(extent:CGRect) -> CIImage?`

> `func sharpenLuminance(sharpness:CGFloat = 0.4) -> CIImage?`

> `func unsharpMask(radius:CGFloat = 2.5, intensity:CGFloat = 0.5) -> CIImage?`

> `func blendWithAlphaMask(backgroud:CIImage, mask:CIImage) -> CIImage?`

> `func blendWithMask(backgroud:CIImage, mask:CIImage) -> CIImage?`

> `func bloom(radius:CGFloat = 10.0, intensity:CGFloat = 0.5) -> CIImage?`

> `func comicEffect() -> CIImage?`

> `func convolution3X3(matrix:Matrix3X3, bios:CGFloat = 0.0) -> CIImage?`

> `func convolution5X5(matrix:Matrix5X5, bios:CGFloat = 0.0) -> CIImage?`

> `func convolution7X7(matrix:Matrix7X7, bios:CGFloat = 0.0) -> CIImage?`

> `func convolution9Horizontal(matrix:Matrix3X3, bios:CGFloat = 0.0) -> CIImage?`

> `func convolution9Vertical(matrix:Matrix3X3, bios:CGFloat = 0.0) -> CIImage?`

> `func crystallize(center:CGPoint = CGPoint(x:150.0, y:150.0), radius:CGFloat = 20.0) -> CIImage?`

> `func depthOfField(point0:CGPoint, point1:CGPoint, saturation:CGFloat, unsharpMaskRadius:CGFloat, unsharpMaskIntensity:CGFloat, radius:CGFloat) -> CIImage?`

> `func edges(intensity:CGFloat = 1.0) -> CIImage?`

> `func edgeWork(intensity:CGFloat = 3.0) -> CIImage?`

> `func gloom(radius:CGFloat = 10.0, intensity:CGFloat = 0.5) -> CIImage?`

> `func heightFieldFromMask(radius:CGFloat = 10.0) -> CIImage?`

> `func hexagonalPixellate(center:CGPoint = CGPoint(x:150, y:150), scale:CGFloat = 8.0) -> CIImage?`

> `func highlightShadowAdjust(shadowAmount:CGFloat, highlightAmount:CGFloat = 1.0) -> CIImage?`

> `func lineOverlay(NRNoiseLeve:CGFloat = 0.07, NRSharpness:CGFloat = 0.71, edgeIntensity:CGFloat = 1.0, threshold:CGFloat = 0.1, contrast:CGFloat = 50.0) -> CIImage?`

> `func pixellate(center:CGPoint = CGPoint(x:150, y:150), scale:CGFloat = 8.0) -> CIImage?`

> `func pointillize(center:CGPoint = CGPoint(x:150, y:150), radius:CGFloat = 20.0) -> CIImage?`

> `func shadedMaterial(shadingImage:CIImage, scale:CGFloat = 10.0) -> CIImage?`

> `func spotColor(spot0:SpotColor, spot1:SpotColor, spot2:SpotColor) -> CIImage?`

> `func spotLight(color:UIColor, lightPosition:Dim3, lightPointsAt:Dim3, brightness:CGFloat = 3.0, concentration:CGFloat = 0.1) -> CIImage?`

> `func affineClamp(transform:CGAffineTransform) -> CIImage?`

> `func affineTile(transform:CGAffineTransform) -> CIImage?`

> `func eightfoldReflectedTile(center:CGPoint = CGPoint(x:150, y:150), angle:CGFloat = 0, width:CGFloat = 100.0) -> CIImage?`

> `func fourfoldReflectedTile(center:CGPoint = CGPoint(x:150, y:150), angle:CGFloat = 0, acuteAngle:CGFloat = 1.57, width:CGFloat = 100.0) -> CIImage?`

> `func fourfoldRotatedTile(center:CGPoint = CGPoint(x:150, y:150), angle:CGFloat = 0, width:CGFloat = 100.0) -> CIImage?`

> `func fourfoldTranslatedTile(center:CGPoint = CGPoint(x:150, y:150), angle:CGFloat = 0, acuteAngle:CGFloat = 1.57, width:CGFloat = 100.0) -> CIImage?`

> `func glideReflectedTile(center:CGPoint = CGPoint(x:150, y:150), angle:CGFloat = 0, width:CGFloat = 100.0) -> CIImage?`

> `func kaleidoscope(center:CGPoint = CGPoint(x:150, y:150), count:CGFloat = 6, angle:CGFloat = 0) -> CIImage?`

> `func opTile(center:CGPoint = CGPoint(x:150, y:150), angle:CGFloat = 0, scale:CGFloat = 2.8, width:CGFloat = 65.0) -> CIImage?`

> `func parallelogramTile(center:CGPoint = CGPoint(x:150, y:150), angle:CGFloat = 0, acuteAngle:CGFloat = 1.57, width:CGFloat = 100.0) -> CIImage?`

> `func perspectiveTile(topLeft:CGPoint, topRight:CGPoint, bottomLeft:CGPoint, bottomRight:CGPoint) -> CIImage?`

> `func sixfoldReflectedTile(center:CGPoint = CGPoint(x:150, y:150), angle:CGFloat = 0, width:CGFloat = 100.0) -> CIImage?`

> `func sixfoldRotatedTile(center:CGPoint = CGPoint(x:150, y:150), angle:CGFloat = 0, width:CGFloat = 100.0) -> CIImage?`

> `func triangleKaleidoscope(point:CGPoint = CGPoint(x:150, y:150), size:CGFloat = 700, rotation:CGFloat = -0.36, decay:CGFloat = 0.85) -> CIImage?`

> `func triangleTile(center:CGPoint = CGPoint(x:150, y:150), angle:CGFloat = 0, width:CGFloat = 100.0) -> CIImage?`

> `func twelvefoldReflectedTile(center:CGPoint = CGPoint(x:150, y:150), angle:CGFloat = 0, width:CGFloat = 100.0) -> CIImage?`

> `func accordionFoldTransition(target:CIImage, time:CGFloat = 0, bottomHeight:CGFloat = 0, numberOfFolds:CGFloat = 3.0, foldShadowAmount:CGFloat = 0.1) -> CIImage?`

> `func barsSwipeTransition(target:CIImage, time:CGFloat = 0, angle:CGFloat = 3.14, width:CGFloat = 30.0, barOffset:CGFloat = 10.0) -> CIImage?`

> `func copyMachineTransition(target:CIImage, time:CGFloat = 0, color:UIColor = UIColor.gray, extent:CGRect = CGRect(x:0, y:0, width:300, height:300), angle:CGFloat = 0.0, width:CGFloat = 30.0, opacity:CGFloat = 1.3) -> CIImage?`

> `func disintegrateWithMaskTransition(target:CIImage, mask:CIImage, time:CGFloat = 0, shadowRadius:CGFloat = 8.0, shadowDesity:CGFloat = 0.65, shadowOffset:CGSize = CGSize(width:0, height:-10)) -> CIImage?`

> `func dissolveTransition(target:CIImage, time:CGFloat = 0) -> CIImage?`

> `func flashTransition(target:CIImage, time:CGFloat = 0, color:UIColor, center:CGPoint = CGPoint(x:150, y:150), extent:CGRect = CGRect(x:0, y:0, width:300, height:300), maxStriationRadius:CGFloat = 2.58, striationStrength:CGFloat = 0.5, striationContrast:CGFloat = 1.38, fadeThreshold:CGFloat = 0.85) -> CIImage?`

> `func modTransition(target:CIImage, time:CGFloat = 0, center:CGPoint = CGPoint(x:150, y:150), angle:CGFloat = 2.0, radius:CGFloat = 150.0, compression:CGFloat = 300.0) -> CIImage?`

> `func pageCurlTransition(target:CIImage, backside:CIImage, shading:CIImage, time:CGFloat = 0, extent:CGRect = CGRect(x:0, y:0, width:300, height:300), angle:CGFloat = 0, radius:CGFloat = 100.0) -> CIImage?`

> `func pageCurlWithShadowTransition(target:CIImage, backside:CIImage, time:CGFloat = 0, extent:CGRect = CGRect(x:0, y:0, width:0, height:0), angle:CGFloat = 0.0, radius:CGFloat = 100.0, shadowSize:CGFloat = 0.5, shadowAmount:CGFloat = 0.7, shadowExtent:CGRect = CGRect(x:0, y:0, width:0, height:0)) -> CIImage?`

> `func rippleTransition(target:CIImage, shading:CIImage, time:CGFloat = 0, center:CGPoint = CGPoint(x:150, y:150), extent:CGRect = CGRect(x:0, y:0, width:300, height:300), width:CGFloat = 100.0, scale:CGFloat = 50.0) -> CIImage?`

> `func swipeTransition(target:CIImage, color:UIColor, time:CGFloat = 0, extent:CGRect = CGRect(x:0, y:0, width:300, height:300), angle:CGFloat = 0.0, width:CGFloat = 300.0, opacity:CGFloat = 0) -> CIImage?`

* Enum -- ExFilter

```
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
```

* Extension -- CIImage

Apply filter to an image instance. 

> `func apply(filter: ExFilter) -> CIImage?`

Generater an image by filter.

> `static func generate(generator: ExGenerator) -> CIImage?`


### Image

* Extension -- UIImage

Add color mask to an image

> `func mask(color:UIColor) -> UIImage?`

Use blur filter to an image

> `func blur(radius:CGFloat) -> UIImage?`

Save image to photos

> `func saveToPhotos()`

Save image to file storage

> `func savePngFile(_ filename:String) -> Bool`

> `func saveJpegFile(_ filename:String, quality:CGFloat = 0.75) -> Bool`


### Sound

* Functions

Vibrate

> `func ex_vibrate()`

Register sound and play sound.

> `func ex_registerSound(resFile:String) -> SystemSoundID`

> `func ex_playSound(soundId:SystemSoundID)`


### Photos

* Extension -- PHAsset

Get image of asset

> `func image(bySize size:CGSize? = nil) -> UIImage?`


* Extension -- PHAssetCollection

Get albumns list

> `static func albums(_ skipNames:[String] = ["Slo-mo", "Videos", "Recently Deleted"]) -> [PHAssetCollection]`

Get asset from albumn

> `func assets(_ ascending:Bool = false) -> [PHAsset]`


### BarCodeScanner

* Class -- ExBarcodeScannerView

Start scan

> `public func start()`


### Author

WangYuanOu

2018-10-20
