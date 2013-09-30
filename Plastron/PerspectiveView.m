//
//  PerspectiveView.m
//  Plastron
//
//  Created by Joseph Landry on 9/28/13.
//  Copyright (c) 2013 Joseph Landry. All rights reserved.
//

#import "PerspectiveView.h"
#import "World.h"
#import "VanishingPoint.h"
#import "Renderer.h"

@implementation PerspectiveView

-(id)init{
    self = [super init];
    if(self){
        zoomLevel = 1.0f;
        cameraPosition = NSMakePoint(0, 0);
        mm_vanishingPoints = [[MouseMode_VanishingPoints alloc]init];
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
        mm_vanishingPoints = [[MouseMode_VanishingPoints alloc]init];
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
        mm_vanishingPoints = [[MouseMode_VanishingPoints alloc]init];
        world = [[World alloc]init];
        renderer = [[Renderer alloc]init];
    }
    return self;
}

- (BOOL)canBecomeKeyWindow
{
    return YES;
}

- (BOOL)canBecomeMainWindow
{
    return YES;
}


- (void)drawRect:(NSRect)dirtyRect {
    
	[[NSColor darkGrayColor] set];
	NSRectFill(self.bounds);
    
    
    NSAffineTransform *scale = [NSAffineTransform transform];
    NSAffineTransform *translate = [NSAffineTransform transform];
    
    [translate translateXBy:cameraPosition.x yBy:cameraPosition.y];
    [translate concat];

    [scale scaleBy:zoomLevel];
    [scale concat];
    
    
    [renderer renderWorld:world];
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
    NSLog(@"MouseDown: %@", theEvent);
    
    NSPoint p;
    int i;
    VanishingPoint *vp;
    
    p = [self convertPoint:theEvent.locationInWindow fromView:self.superview];
    p = [self pointToWorldCoordinates:p];
    
    
    // do this backwards becase the higher indexes get drawn last and look like they are on top of the smaller indexes
    for(i = 8; i > -1; i--){
        vp = [world vanishingPointAtIndex:i];
        if(vp != NULL){
            if(NSPointInRect(p, [self rectFromPoint:vp.point Radius:40.0f])){
                NSLog(@"FUCKING HERE %d", i);
                selection = i;
                [self updateSelection];
                [self setNeedsDisplay:YES];
                break;
            }
        }
    }

    [mm_vanishingPoints click:p Selection:selection];
    [self setNeedsDisplay:YES];
}

-(void)mouseDragged:(NSEvent *)theEvent{
        NSPoint p;
    p = [self convertPoint:theEvent.locationInWindow fromView:self.superview];
    p = [self pointToWorldCoordinates:p];

    [mm_vanishingPoints moved:p];
    [self setNeedsDisplay:YES];
}

-(void)rightMouseDown:(NSEvent *)theEvent{
    NSLog(@"Right mouse down: %@", theEvent);
}

-(void)otherMouseDown:(NSEvent *)theEvent{
    NSLog(@"Middle mouse down: %@", theEvent);
    oldCameraPosition = cameraPosition;
    otherMouseDown = theEvent.locationInWindow;
}

-(void)otherMouseDragged:(NSEvent *)theEvent{

    cameraPosition.x = oldCameraPosition.x + theEvent.locationInWindow.x - otherMouseDown.x;
    cameraPosition.y = oldCameraPosition.y + theEvent.locationInWindow.y - otherMouseDown.y;
    
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

@end
