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
-(void)selectVanishingPoint:(int)index;
-(void)removeVanishingPoint:(int)index;

-(void)removeLastTraceLine;
-(void)removeAllTraceLines;

-(void)alignVanishingPoints1_2_HorizontallyAtPoint:(NSPoint)point;

-(void)copyToPasteboard;

-(void)showGrid;
-(void)hideGrid;
-(void)toggleGrid;
-(void)cycleGridType;

-(void)increaseGridSize;
-(void)decreaseGridSize;

-(void)resizeWorld:(NSSize) size;
-(NSSize)currentWorldSize;

-(void)setBackgroundImage:(NSImage *)image;

-(void)toggleBackground;
-(void)showBackground;
-(void)hideBackground;

-(void)resetCamera;
-(void)reset;

-(int)vanishingPointHitTest:(NSPoint) worldPoint;
-(void)updateSelection;

@end
