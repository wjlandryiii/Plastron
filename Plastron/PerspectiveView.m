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
        zoomLevel = 1.0f;
        cameraPosition = NSMakePoint(0, 0);
        leftClickDrag = [[MouseDrag alloc]init];
        middleClickDrag = [[MouseDrag alloc]init];
        rightClickDrag = [[MouseDrag alloc]init];
        world = [[World alloc]init];
        renderer = [[Renderer alloc]init];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        zoomLevel = 1.0f;
        cameraPosition = NSMakePoint(0, 0);
        leftClickDrag = [[MouseDrag alloc]init];
        middleClickDrag = [[MouseDrag alloc]init];
        rightClickDrag = [[MouseDrag alloc]init];
        world = [[World alloc]init];
        renderer = [[Renderer alloc]init];
    }
    return self;
}

-(id)initWithFrame:(NSRect)frameRect{
    self = [super initWithFrame:frameRect];
    if(self){
        zoomLevel = 1.0f;
        cameraPosition = NSMakePoint(0, 0);
        leftClickDrag = [[MouseDrag alloc]init];
        middleClickDrag = [[MouseDrag alloc]init];
        rightClickDrag = [[MouseDrag alloc]init];
        world = [[World alloc]init];
        renderer = [[Renderer alloc]init];
    }
    return self;
}
/*
- (BOOL)canBecomeKeyWindow
{
    return YES;
}

- (BOOL)canBecomeMainWindow
{
    return YES;
}
 */


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
