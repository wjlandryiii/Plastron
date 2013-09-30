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
    NSSize size;
}

@property (nonatomic, assign) NSSize size;

-(void)reset;
-(int)maxVanishingPoints;
-(VanishingPoint *)vanishingPointAtIndex:(int)index;
-(void) setVanishingPoint:(VanishingPoint *)vp WithIndex:(int)index;


@end
