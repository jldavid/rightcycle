//
//  RightCycleGestureReconizer.h
//  RightCycle
//
//  Created by Atomicflare on 2015-05-09.
//  Copyright (c) 2015 RightCycle. All rights reserved.
//

#import <Foundation/Foundation.h>
#define LEFT_TURN_GESTURE   @"LEFT_TURN_GESTURE"
#define RIGHT_TURN_GESTURE  @"RIGHT_TURN_GESTURE"
#define STOP_GESTURE        @"STOP_GESTURE"
#define LEFT_HAND   @"Left"
#define RIGHT_HAND  @"Right"



typedef NS_OPTIONS(NSInteger, RCGestureMask) {
    RCGestureMaskNone     =  0,
    RCGestureMaskLeft     =  1<<0,
    RCGestureMaskRight    =  1<<1,
    RCGestureMaskStop     =  1<<2
    
};


@interface RightCycleGestureReconizer : NSObject

@property (nonatomic,assign) int sensitivity;
@property (nonatomic,strong)     NSString * currentHand;

@property (nonatomic,strong) NSString * debugText;


+(RightCycleGestureReconizer*)getInstance;
-(void)zeroOut;
-(instancetype)init;

@end
