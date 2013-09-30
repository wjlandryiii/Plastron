//
//  World.h
//  Plastron
//
//  Created by Joseph Landry on 9/28/13.
//  Copyright (c) 2013 Joseph Landry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VanishingPoint.h"

@interface World : NSObject {
    VanishingPoint *vanishingPoints[9];
    int selection;
}


+(World *)getWorld;

-(void)reset;

-(int)selection;

-(VanishingPoint *)vanishingPointAtIndex:(int)index;
-(void) setVanishingPoint:(VanishingPoint *)vp WithIndex:(int)index;
-(void) setSelection:(int)newSelection;

-(void)Draw;
-(void) DrawCircleCenter:(NSPoint) center Radius:(CGFloat) radius Stroke:(NSColor *)stroke Fill:(NSColor *)fill;
-(void) DrawLineStart:(NSPoint) start Stop:(NSPoint) stop Stroke:(NSColor *)stroke;
-(void) DrawText:(NSString *)text inRect:(NSRect)rect;
-(void) DrawText:(NSString *)text AtPoint:(NSPoint)point;

@end
