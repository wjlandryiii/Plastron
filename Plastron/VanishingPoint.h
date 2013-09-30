//
//  VanishingPoint.h
//  Plastron
//
//  Created by Joseph Landry on 9/28/13.
//  Copyright (c) 2013 Joseph Landry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VanishingPoint : NSObject {
    NSPoint point;
    NSInteger density;
}

@property (nonatomic, assign) NSPoint point;
@property (nonatomic, assign) NSInteger density;

-(void) Draw:(NSInteger) index Selected:(BOOL) selected;

@end
