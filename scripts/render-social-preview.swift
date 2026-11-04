// Usage: swift render-social-preview.swift FRAUNCES_TTF_FOLDER BRAND_MARK_SVG OUTPUT_PNG
import AppKit
import CoreText
let args = CommandLine.arguments
precondition(args.count == 4)
for name in ["Fraunces-Regular", "Fraunces-Italic", "Fraunces-SemiBold"] {
    precondition(CTFontManagerRegisterFontsForURL(URL(fileURLWithPath: args[1]).appendingPathComponent(name + ".ttf") as CFURL, .process, nil))
}
let width: CGFloat = 1200, height: CGFloat = 630
let rep = NSBitmapImageRep(bitmapDataPlanes: nil, pixelsWide: 1200, pixelsHigh: 630, bitsPerSample: 8, samplesPerPixel: 4, hasAlpha: true, isPlanar: false, colorSpaceName: .deviceRGB, bytesPerRow: 0, bitsPerPixel: 0)!
NSGraphicsContext.saveGraphicsState(); NSGraphicsContext.current = NSGraphicsContext(bitmapImageRep: rep)
func color(_ value: UInt32) -> NSColor { NSColor(srgbRed: CGFloat(value >> 16 & 255)/255, green: CGFloat(value >> 8 & 255)/255, blue: CGFloat(value & 255)/255, alpha: 1) }
func rect(_ x: CGFloat,_ y: CGFloat,_ w: CGFloat,_ h: CGFloat) -> NSRect { NSRect(x:x,y:height-y-h,width:w,height:h) }
func text(_ value: String,_ x: CGFloat,_ y: CGFloat,_ font: NSFont,_ hex: UInt32) {
    (value as NSString).draw(in: rect(x,y,1000,font.pointSize*1.4),withAttributes:[.font:font,.foregroundColor:color(hex)])
}
color(0xFBF9F3).setFill(); NSBezierPath(rect:rect(0,0,width,height)).fill()
color(0xE8EDDF).setFill(); NSBezierPath(roundedRect:rect(732,56,420,478),xRadius:210,yRadius:210).fill()
NSBezierPath(roundedRect:rect(732,295,420,239),xRadius:18,yRadius:18).fill()
color(0xEFD7C6).setFill(); NSBezierPath(ovalIn:rect(998,126,96,96)).fill()
let mark = NSImage(contentsOfFile: args[2])!
let aspect = mark.size.width / mark.size.height
mark.draw(in:rect(77,66,44*aspect,44))
mark.draw(in:rect(829,153,316*aspect,316))
text("Little Boundaries",118,70,NSFont(name:"Fraunces-SemiBold",size:29)!,0x223D33)
text("Small boundaries.",67,147,NSFont(name:"Fraunces-Regular",size:72)!,0x223D33)
let normal = NSFont(name:"Fraunces-Regular",size:72)!
text("Room to ",67,229,normal,0x223D33)
let offset = ("Room to " as NSString).size(withAttributes:[.font:normal]).width
text("grow.",67+offset,229,NSFont(name:"Fraunces-Italic",size:72)!,0xA45739)
text("Thoughtful iPhone & iPad boundaries.",70,352,NSFont.systemFont(ofSize:25),0x526158)
text("Parent-friendly setup on your Mac.",70,391,NSFont.systemFont(ofSize:25),0x526158)
color(0xD9DED1).setFill(); NSBezierPath(rect:rect(70,478,576,1)).fill()
text("littleboundaries.app",70,502,NSFont.systemFont(ofSize:22),0x285844)
NSGraphicsContext.restoreGraphicsState()
try rep.representation(using:.png,properties:[:])!.write(to:URL(fileURLWithPath:args[3]))
