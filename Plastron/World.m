//
//  World.m
//  Plastron
//
//  Created by Joseph Landry on 9/28/13.
//  Copyright (c) 2013 Joseph Landry. All rights reserved.
//

#import "World.h"

@implementation World

@synthesize size = size;

-(id) init{
    self = [super init];
    if(self){
        self.size = NSMakeSize(640.0f, 480.0f);
    }
    return self;
}

-(int)maxVanishingPoints{
    return 9;
}

-(void)reset{
    int i;
    for(i = 0; i < 9; i++){
        vanishingPoints[i] = NULL;
    }
}

-(VanishingPoint *)vanishingPointAtIndex:(int)index{
    if(!(0 <= index && index < 9))
        return NULL;
    return vanishingPoints[index];
}

-(void) setVanishingPoint:(VanishingPoint *)vp WithIndex:(int)index{
    if(!(0 <= index && index < 9))
        return;
    vanishingPoints[index] = vp;
}



@end
