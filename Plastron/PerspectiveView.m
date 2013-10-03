//
//  PerspectiveView.m
//  Plastron
//
//  Created by Joseph Landry on 9/28/13.
//  Copyright (c) 2013 Joseph Landry. All rights reserved.
//

#import "PerspectiveView.h"
#import "VanishingPoint.h"

@implementation PerspectiveView

-(id)init{
    self = [super init];
    if(self){
        [self reset];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        [self reset];
    }
    return self;
}

-(id)initWithFrame:(NSRect)frameRect{
    self = [super initWithFrame:frameRect];
    if(self){
        [self reset];
    }
    return self;
}


- (void)drawRect:(NSRect)dirtyRect {
    NSPoint n;
	[[NSColor darkGrayColor] set];
	NSRectFill(self.bounds);
    
    
    NSAffineTransform *scale = [NSAffineTransform transform];
    NSAffineTransform *translate = [NSAffineTransform transform];
    
    [translate translateXBy:cameraPosition.x yBy:cameraPosition.y];
    [translate concat];

    [scale scaleBy:zoomLevel];
    [scale concat];
    
    
    [renderer renderWorld:world];
    if(line1 != NULL){
        NSBezierPath* thePath = [NSBezierPath bezierPath];
        [[NSColor blueColor] setStroke];
        [thePath moveToPoint:line1.p1];
        [thePath lineToPoint:line1.p2];
        [thePath stroke];
    }
    if(line2 != NULL){
        NSBezierPath* thePath = [NSBezierPath bezierPath];
        [[NSColor redColor] setStroke];
        [thePath moveToPoint:line2.p1];
        [thePath lineToPoint:line2.p2];
        [thePath stroke];
    }
    if(line3 != NULL){
        NSBezierPath* thePath = [NSBezierPath bezierPath];
        [[NSColor redColor] setStroke];
        [thePath moveToPoint:line3.p1];
        [thePath lineToPoint:line3.p2];
        [thePath stroke];
    }
    
    if(line2 != NULL && line3 != NULL){
        if([line2 doesIntersectionExist:line3]){
            n = [line2 intersection:line3];
            [[NSColor greenColor] setFill];
            NSRectFill([self rectFromPoint:n Radius:10.0f]);
            NSLog(@"Intercept: X: %f Y: %f", n.x, n.y);
        }
    }
    
    [scale invert];
    [scale concat];
    [translate invert];
    [translate concat];
    [self drawHud];
}

-(void)drawHudHeader {
    NSBezierPath *path = [NSBezierPath bezierPathWithRect:NSMakeRect(0, self.bounds.size.height - 40.0f, self.bounds.size.width, 40.0f)];
    [[NSColor colorWithCalibratedRed:0.1f green:0.1f blue:0.1f alpha:0.75f] setFill];
    [path fill];
    [[NSColor blackColor] setStroke];
    [path stroke];
    
    NSString *zoomString = [NSString stringWithFormat:@"Zoom : %0.0f %%", zoomLevel * 100];
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [style setAlignment:kCTTextAlignmentRight];
    
    [zoomString drawInRect:NSMakeRect(0.0f, self.bounds.size.height - 40.0f, self.bounds.size.width, 40.0f) withAttributes:@{NSForegroundColorAttributeName: [NSColor whiteColor], NSFontAttributeName: [NSFont fontWithName:@"Helvetica" size:20.0f], NSParagraphStyleAttributeName: style}];
    
    NSString *dropIntersection = @"Press [CTRL]+[SHIFT]+(1-9) to drop a vanishing point at intersection";
    if(line2 != NULL && line3 != NULL){
        if([line2 doesIntersectionExist:line3]){
            [dropIntersection drawInRect:NSMakeRect(0.0f, self.bounds.size.height - 40.0f, self.bounds.size.width, 40.0f) withAttributes:@{NSForegroundColorAttributeName: [NSColor redColor], NSFontAttributeName: [NSFont fontWithName:@"Helvetica" size:20.0f]}];
        }
    }
}

-(void)drawHudFooter {
    NSBezierPath *path = [NSBezierPath bezierPathWithRect:NSMakeRect(0, 0, self.bounds.size.width, 40.0f)];
    [[NSColor colorWithCalibratedRed:0.1f green:0.1f blue:0.1f alpha:0.75f] setFill];
    [path fill];
    [[NSColor blackColor] setStroke];
    [path stroke];
    
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [style setAlignment:kCTTextAlignmentCenter];
    
    NSString *selectionString;
    VanishingPoint *vp = [world vanishingPointAtIndex:selection];
    
    if(selection != -1){
        selectionString = [NSString stringWithFormat:@"Vanishing Point %d >> Density : %ld", selection+1, (long)vp.density];
    } else {
        selectionString = @"No Selection";
    }
    
    [selectionString drawInRect:NSMakeRect(0, 0, self.bounds.size.width, 40.0f) withAttributes:@{NSForegroundColorAttributeName: [NSColor whiteColor], NSFontAttributeName: [NSFont fontWithName:@"Helvetica" size:20.0f], NSParagraphStyleAttributeName: style}];
}

-(void)drawHudHelp {
    NSBezierPath *path = [NSBezierPath bezierPathWithRect:NSMakeRect(0.0f, 40.0f, 350.0f, self.bounds.size.height - 80.0f)];
    [[NSColor colorWithCalibratedRed:0.1f green:0.1f blue:0.1f alpha:0.75f] setFill];
    [path fill];
    [[NSColor blackColor] setStroke];
    [path stroke];
    
    NSArray *help_strings = @[
                              @"Left_Click + Drag", @"Drag selection",
                              @"Middle_Click + Drag", @"Pan Camera",
                              @"Mouse_Wheel", @"--Zoom camera",
                              @"CTRL+ +/-", @"Zoom in/out",
                              @"",@"",
                              @"Escape", @"Unselect all",
                              @"Home", @"Reset camera",
                              @"", @"",
                              @"CTRL+R", @"Reset document",
                              @"CTRL+N", @"Resize document",
                              @"(1-9)", @"Drop vanishing point at mouse location",
                              @"CTRL + (1-9)", @"Select vanishing point",
                              @"ALT + (1-9)", @"Remove a vanishing point",
                              @"", @"",
                              @"Right_Click + Drag", @"Create a trace line (2 max)",
                              @"\t+ CTRL", @"--Snap to 5 degree increments",
                              @"\t+ SHIFT", @"--Snap to 15 degree increments",
                              @"Backspace", @"Delete last trace line",
                              @"Alt + Backspace", @"Delete all trace lines",
                              @"", @"",
                              @"CTRL + I", @"Load a background image",
                              @"I", @"Toggle background image",
                              @"ALT + I", @"Remove background image",
                              @"", @"",
                              @"CTRL + C", @"Copy grid to clipboard",
                              @"\t+ SHIFT", @"--Copy grid in grayscale",
                              @"CTRL + V", @"Paste background image from pasteboard",
                              @"", @"",
                              @"S", @"--Shuffle colors",
                              @"H", @"Align vanishing points 1 and 2 horizontally",
                              @"", @"",
                              @"CTRL + Cursor_Key", @"--Flip points to other side of axis",
                              @"Cursor Up/Down", @"Change line density (-- 0 = automatic)",
                              @"", @"",
                              @"G", @"Toggle grid",
                              @"CTRL + G", @"Cycle grid style",
                              @"+/-", @"Change grid size"
                              ];
    
    NSMutableParagraphStyle *rightStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [rightStyle setAlignment:kCTTextAlignmentRight];

    NSRect r = NSMakeRect(10.0f, self.bounds.size.height-80.0f, 300.0f, 15.0f);
    
    for(int i = 0; i < help_strings.count-1; i+=2){
        NSString *leftString = [help_strings objectAtIndex:i];
        NSString *rightString = [help_strings objectAtIndex:i+1];
        
        [leftString drawInRect:r withAttributes:@{NSForegroundColorAttributeName: [NSColor yellowColor]}];
        
        [rightString drawInRect:r withAttributes:@{NSForegroundColorAttributeName: [NSColor whiteColor], NSParagraphStyleAttributeName: rightStyle}];
        r.origin.y -= r.size.height;
    }
}

-(void)drawHud {
    [self drawHudFooter];
    [self drawHudHelp];
    [self drawHudHeader];
}

// TODO: set anchor points for zooming?
-(void) zoomIn{
    zoomLevel += 0.1f;
    [self setNeedsDisplay:YES];
}
-(void) zoomOut{
    zoomLevel -= 0.1;
    [self setNeedsDisplay:YES];
}

-(void) increaseDensity{
    VanishingPoint *vp = [world vanishingPointAtIndex:selection];
    
    if(vp != NULL){
        vp.density += 1;
        [self setNeedsDisplay:YES];
    }
}

-(void) decreaseDensity{
    VanishingPoint *vp = [world vanishingPointAtIndex:selection];
    
    if(vp != NULL){
        if(vp.density > 1){
            vp.density -= 1;
            [self setNeedsDisplay:YES];
        }
    }
}

-(void) mouseDown:(NSEvent *)theEvent{
    NSPoint p;
    VanishingPoint *vp;
    int index;
    
    p = [self convertPoint:theEvent.locationInWindow fromView:self.superview];
    p = [self pointToWorldCoordinates:p];
    
    index = [self vanishingPointHitTest:p];
    if(index != selection && index != -1){
        selection = index;
        [self updateSelection];
        [self setNeedsDisplay:YES];
    }
    
    vp = [world vanishingPointAtIndex:selection];
    if(vp != NULL){
        [leftClickDrag startAtPoint:p WithOrigin:vp.point];
    }
}

-(void)mouseDragged:(NSEvent *)theEvent{
    VanishingPoint *vp;
    NSPoint p;
    p = [self convertPoint:theEvent.locationInWindow fromView:self.superview];
    p = [self pointToWorldCoordinates:p];
    
    [leftClickDrag update:p];
    
    vp = [world vanishingPointAtIndex:selection];
    if(vp != NULL){
        vp.point = leftClickDrag.resultantOrigin;
    }
    
    [self setNeedsDisplay:YES];
}


-(void)rightMouseDown:(NSEvent *)theEvent{
    NSPoint p;
    p = [self convertPoint:theEvent.locationInWindow fromView:self.superview];
    p = [self pointToWorldCoordinates:p];
    
    [rightClickDrag startAtPoint:p WithOrigin:NSMakePoint(0.0f, 0.0f)];
}

-(void)rightMouseDragged:(NSEvent *)theEvent{
    NSPoint p;
    p = [self convertPoint:theEvent.locationInWindow fromView:self.superview];
    p = [self pointToWorldCoordinates:p];
    
    [rightClickDrag update:p];
    
    if(line1 == NULL){
        line1 = [[Line alloc]init];
        line1.p1 = rightClickDrag.startPoint;
    }
    line1.p2 = rightClickDrag.stopPoint;
    [self setNeedsDisplay:YES];
}

-(void)rightMouseUp:(NSEvent *)theEvent{
    NSPoint p;
    p = [self convertPoint:theEvent.locationInWindow fromView:self.superview];
    p = [self pointToWorldCoordinates:p];
    
    [rightClickDrag update:p];
    
    if(line2 == NULL){
        line2 = line1;
    } else if(line3 == NULL){
        line3 = line1;
    } else {
        [line3 release];
        line3 = line1;
    }
    line1= NULL;
    [self setNeedsDisplay:YES];
}

-(void)otherMouseDown:(NSEvent *)theEvent{
    NSPoint p;
    p = [self convertPoint:theEvent.locationInWindow fromView:self.superview];
    
    [middleClickDrag startAtPoint:p WithOrigin:cameraPosition];
}

-(void)otherMouseDragged:(NSEvent *)theEvent{
    NSPoint p;
    p = [self convertPoint:theEvent.locationInWindow fromView:self.superview];

    [middleClickDrag update:p];
    
    cameraPosition = middleClickDrag.resultantOrigin;
    
    [self setNeedsDisplay:YES];
}

-(NSPoint)pointToWorldCoordinates:(NSPoint) point{
    return NSMakePoint((point.x - cameraPosition.x) / zoomLevel, (point.y - cameraPosition.y) / zoomLevel);
}

-(NSRect) rectFromPoint:(NSPoint)point Radius:(CGFloat)radius{
    return NSMakeRect(point.x-radius, point.y-radius, radius*2, radius*2);
}

-(void)clearSelection{
    VanishingPoint *vp = [world vanishingPointAtIndex:selection];
    
    if(vp == NULL)
        return;
    
    vp.selected = FALSE;
    selection = -1;

    [self setNeedsDisplay:YES];
}

-(void)dropVanishingPoint:(int)index AtPoint:(NSPoint)point{
    VanishingPoint *vp = [world vanishingPointAtIndex:index];
    NSPoint p;
    p = [self convertPoint:point fromView:self.superview];
    p = [self pointToWorldCoordinates:p];
    
    if(vp == NULL){
        vp = [[VanishingPoint alloc]init];
        vp.label = [NSString stringWithFormat:@"%d", index+1];
        vp.density = 4;
        [world setVanishingPoint:vp WithIndex:index];
    }

    selection = index;
    [self updateSelection];
    vp.point = p;
    [self setNeedsDisplay:YES];
}

-(void)dropVanishingPointAtIntersection:(int)index{
    NSPoint intersection;
    VanishingPoint *vp = [world vanishingPointAtIndex:index];
    
    if(line2 != NULL && line3 != NULL){
        if([line2 doesIntersectionExist:line3]){
            intersection = [line2 intersection:line3];
            if(fabs(intersection.x) < 50000.0f && fabs(intersection.y) < 50000.0f){
                if(vp == NULL){
                    vp = [[VanishingPoint alloc]init];
                    vp.label = [NSString stringWithFormat:@"%d", index+1];
                    vp.density = 4;
                    [world setVanishingPoint:vp WithIndex:index];
                }
                selection = index;
                [self updateSelection];
                vp.point = intersection;
                [line2 release];
                [line3 release];
                line2 = NULL;
                line3 = NULL;
                [self setNeedsDisplay:YES];
            }
        }
    }
}

-(void)selectVanishingPoint:(int)index {
    selection = index;
    [self updateSelection];
    [self setNeedsDisplay:TRUE];
}

-(void)removeVanishingPoint:(int)index{
    [world setVanishingPoint:NULL WithIndex:index];
    [self setNeedsDisplay:TRUE];
}

-(void)removeLastTraceLine{
    if(line3 != NULL){
        [line3 release];
        line3 = NULL;
        [self setNeedsDisplay:YES];
        return;
    }
    if(line2 != NULL){
        [line2 release];
        line2 = NULL;
        [self setNeedsDisplay:YES];
        return;
    }
}

-(void)removeAllTraceLines{
    [self removeLastTraceLine];
    [self removeLastTraceLine];
}

-(void)alignVanishingPoints1_2_HorizontallyAtPoint:(NSPoint)point{
    NSPoint p;
    VanishingPoint *vp1 = [world vanishingPointAtIndex:0];
    VanishingPoint *vp2 = [world vanishingPointAtIndex:1];
    
    p = [self convertPoint:point fromView:self.superview];
    p = [self pointToWorldCoordinates:p];
    
    if(vp1 != NULL){
        vp1.point = NSMakePoint(vp1.point.x, p.y);
        [self setNeedsDisplay:YES];
    }
    if(vp2 != NULL){
        vp2.point = NSMakePoint(vp2.point.x, p.y);
        [self setNeedsDisplay:YES];
    }
}

-(void)updateSelection{
    int i;
    VanishingPoint *vp;
    
    for(i = 0; i < world.maxVanishingPoints; i++){
        vp = [world vanishingPointAtIndex:i];
        if(vp != NULL){
            vp.selected = i == selection ? YES : NO;
        }
    }
}

-(void)copyToPasteboard{
    //TODO review this code
    NSPasteboard *pb = [NSPasteboard generalPasteboard];
    NSBitmapImageRep *rep;
    
    [pb declareTypes:[NSArray arrayWithObjects:NSPasteboardTypePNG,nil] owner:self];
    
    rep = [[[NSBitmapImageRep alloc]
                                       initWithBitmapDataPlanes:NULL
                                       pixelsWide:world.size.width
                                       pixelsHigh:world.size.height
                                       bitsPerSample:8
                                       samplesPerPixel:4
                                       hasAlpha:YES
                                       isPlanar:NO
                                       colorSpaceName:NSDeviceRGBColorSpace
                                       bitmapFormat:NSAlphaFirstBitmapFormat
                                       bytesPerRow:0
                                       bitsPerPixel:0] autorelease];
    [NSGraphicsContext saveGraphicsState];
    [NSGraphicsContext setCurrentContext:[NSGraphicsContext graphicsContextWithBitmapImageRep:rep]];

    [renderer renderWorld:world];
    [NSGraphicsContext restoreGraphicsState];
    [pb setData:[rep representationUsingType:NSPNGFileType properties:nil] forType:NSPasteboardTypePNG];
}

-(void)showGrid{
    world.showHorizontalGrid = YES;
    world.showVerticalGrid = YES;
    [self setNeedsDisplay:YES];
}

-(void)hideGrid{
    world.showHorizontalGrid = NO;
    world.showVerticalGrid = NO;
    [self setNeedsDisplay:YES];
}

-(void)toggleGrid{
    if(world.showVerticalGrid || world.showHorizontalGrid)
        [self hideGrid];
    else
        [self showGrid];
}

-(void)increaseGridSize{
    world.gridSpacing += 5;
    [self setNeedsDisplay:YES];
}

-(void)decreaseGridSize{
    world.gridSpacing -= 5;
    if(world.gridSpacing <= 0)
        world.gridSpacing = 5;
    [self setNeedsDisplay:YES];
}

-(NSSize)currentWorldSize{
    return world.size;
}

-(void)resizeWorld:(NSSize) size{
    world.size = size;
    [self setNeedsDisplay:YES];
}

-(void)setBackgroundImage:(NSImage *)image{
    world.backgroundImage = image;
    if(image == nil){
        world.size = NSMakeSize(640.0f, 480.0f);
        [self hideBackground];
    } else {
        world.size = image.size;
        [self showBackground];
    }
    [self setNeedsDisplay:YES];
}

-(void)toggleBackground{
    if(renderer.renderBackground){
        [self hideBackground];
    } else {
        [self showBackground];
    }
}

-(void)showBackground{
    if(!renderer.renderBackground){
        renderer.renderBackground = YES;
        [self setNeedsDisplay:YES];
    }
}

-(void)hideBackground{
    if(renderer.renderBackground){
        renderer.renderBackground = NO;
        [self setNeedsDisplay:YES];
    }
}

-(void)resetCamera{
    cameraPosition = NSMakePoint(0.0f, 0.0f);
    zoomLevel = 1.0f;
    [self setNeedsDisplay:YES];
}

-(void)reset{
    [world release];
    [renderer release];
    [leftClickDrag release];
    [middleClickDrag release];
    [rightClickDrag release];
    
    leftClickDrag = [[MouseDrag alloc]init];
    middleClickDrag = [[MouseDrag alloc]init];
    rightClickDrag = [[MouseDrag alloc]init];
    world = [[World alloc]init];
    renderer = [[Renderer alloc]init];
    
    selection = -1;

    if(line1 != NULL){
        [line1 release];
        line1 = NULL;
    }
    if(line2 != NULL){
        [line2 release];
        line2 = NULL;
    }
    if(line3 != NULL){
        [line3 release];
        line3 = NULL;
    }
    
    [self resetCamera];
    [self setNeedsDisplay:YES];
}

-(void)cycleGridType{
    if(world.showVerticalGrid && world.showHorizontalGrid){
        world.showVerticalGrid = YES;
        world.showHorizontalGrid = NO;
    } else if(world.showVerticalGrid && !world.showHorizontalGrid){
        world.showVerticalGrid = NO;
        world.showHorizontalGrid = YES;
    } else if(!world.showVerticalGrid && world.showHorizontalGrid){
        world.showVerticalGrid = NO;
        world.showHorizontalGrid = NO;
    } else if(!world.showVerticalGrid && !world.showHorizontalGrid){
        world.showVerticalGrid = YES;
        world.showHorizontalGrid = YES;
    }
    [self setNeedsDisplay:YES];
}

-(int)vanishingPointHitTest:(NSPoint) worldPoint{
    VanishingPoint *vp;
    NSRect vpHitRect;
    int i;
    
    // do this backwards becase the higher indexes get drawn last and look like they are on top of the smaller indexes
    for(i = world.maxVanishingPoints-1; i >= 0; i--){
        vp = [world vanishingPointAtIndex:i];
        if(vp != NULL){
            vpHitRect = [self rectFromPoint:vp.point Radius:20.0f];
            if(NSPointInRect(worldPoint, vpHitRect)){
                return i;
            }
        }
    }
    return -1; // did not click a vanishing point
}


@end
