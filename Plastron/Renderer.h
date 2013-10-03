//
//  Renderer.h
//  Plastron
//
//  Created by Joseph Landry on 9/29/13.
//  Copyright (c) 2013 Joseph Landry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "World.h"
#import "VanishingPoint.h"

@interface Renderer : NSObject {
    BOOL renderBackground;
}

@property (nonatomic, assign) BOOL renderBackground;

-(void)renderWorld:(World *)world;
-(void)renderVanishingPoint:(VanishingPoint *)vanishingPoint;

@end
