//
//  PerspectiveView.h
//  Plastron
//
//  Created by Joseph Landry on 9/28/13.
//  Copyright (c) 2013 Joseph Landry. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "MouseMode_VanishingPoints.h"

@interface PerspectiveView : NSView {
    CGFloat zoomLevel;
    NSPoint otherMouseDown;
    NSPoint cameraPosition;
    NSPoint oldCameraPosition;
    MouseMode_VanishingPoints *mm_vanishingPoints;
}

-(void) zoomIn;
-(void) zoomOut;

-(void) increaseDensity;
-(void) decreaseDensity;

-(NSPoint)pointToWorldCoordinates:(NSPoint) point;

-(NSRect) rectFromPoint:(NSPoint)point Radius:(CGFloat)radius;

-(void)clearSelection;

-(void)dropVanishingPoint:(int)index AtPoint:(NSPoint)point;

@end
