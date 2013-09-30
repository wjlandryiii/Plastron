//
//  PerspectiveView.h
//  Plastron
//
//  Created by Joseph Landry on 9/28/13.
//  Copyright (c) 2013 Joseph Landry. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "MouseDrag.h"
#import "World.h"
#import "Renderer.h"

@interface PerspectiveView : NSView {
    World *world;
    Renderer *renderer;
    CGFloat zoomLevel;
    NSPoint otherMouseDown;
    NSPoint cameraPosition;
    NSPoint oldCameraPosition;
    MouseDrag *leftClickDrag;
    int selection;
}

-(void) zoomIn;
-(void) zoomOut;

-(void) increaseDensity;
-(void) decreaseDensity;

-(NSPoint)pointToWorldCoordinates:(NSPoint) point;

-(NSRect) rectFromPoint:(NSPoint)point Radius:(CGFloat)radius;

-(void)clearSelection;

-(void)dropVanishingPoint:(int)index AtPoint:(NSPoint)point;

-(int)vanishingPointHitTest:(NSPoint) worldPoint;
-(void)updateSelection;

@end
