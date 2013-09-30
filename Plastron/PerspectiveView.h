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
#import "Line.h"

@interface PerspectiveView : NSView {
    World *world;
    Renderer *renderer;
    CGFloat zoomLevel;
    NSPoint cameraPosition;
    MouseDrag *leftClickDrag;
    MouseDrag *middleClickDrag;
    MouseDrag *rightClickDrag;
    int selection;
    Line *line1;
    Line *line2;
    Line *line3;
    
}

-(void) zoomIn;
-(void) zoomOut;

-(void) increaseDensity;
-(void) decreaseDensity;

-(NSPoint)pointToWorldCoordinates:(NSPoint) point;

-(NSRect) rectFromPoint:(NSPoint)point Radius:(CGFloat)radius;

-(void)clearSelection;

-(void)dropVanishingPoint:(int)index AtPoint:(NSPoint)point;
-(void)dropVanishingPointAtIntersection:(int)index;

-(int)vanishingPointHitTest:(NSPoint) worldPoint;
-(void)updateSelection;

@end
