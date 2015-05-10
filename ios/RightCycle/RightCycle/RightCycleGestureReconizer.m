//
//  RightCycleGestureReconizer.m
//  RightCycle
//
//  Created by Atomicflare on 2015-05-09.
//  Copyright (c) 2015 RightCycle. All rights reserved.
//

#import "RightCycleGestureReconizer.h"
#import <MyoKit/MyoKit.h>



#define DEFAULT_SENSITIVITY 10


static RightCycleGestureReconizer * instance;


@implementation RightCycleGestureReconizer
{
    TLMHub * hub;
    TLMEulerAngles * home;
    TLMEulerAngles * current;
}

@synthesize debugText;
@synthesize currentHand;

+(RightCycleGestureReconizer*)getInstance
{
    
    if (!instance) {
        instance = [[RightCycleGestureReconizer alloc]init];
    
    }
    
    return instance;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        hub = [TLMHub sharedHub];

        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didReceiveOrientationEvent:)
                                                     name:TLMMyoDidReceiveOrientationEventNotification
                                                   object:nil];

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didSyncArm:)
                                                     name:TLMMyoDidReceiveArmSyncEventNotification
                                                   object:nil];

    }
    return self;
}



// this just sets the app to the right hand
- (void)didSyncArm:(NSNotification *)notification {
    TLMArmSyncEvent *armEvent = notification.userInfo[kTLMKeyArmSyncEvent];
    self.currentHand = armEvent.arm == TLMArmRight ? RIGHT_HAND : LEFT_HAND;
    NSLog(@"Your HAND is : %@",self.currentHand);
}




-(void)zeroOut
{
    home = nil;
    TLMMyo * myo = hub.myoDevices[0];
    [myo vibrateWithLength:10];
}



- (void)didReceiveOrientationEvent:(NSNotification *)notification
{
    TLMOrientationEvent *orientationEvent = notification.userInfo[kTLMKeyOrientationEvent];
    TLMEulerAngles *angles = [TLMEulerAngles anglesWithQuaternion:orientationEvent.quaternion];
    
    if (!home){
        home = angles;
        NSLog(@"Home - Pitch: %f   Yaw: %f   Roll: %f",[angles pitch].degrees,[angles yaw].degrees,[angles roll].degrees);
        
        self.debugText = [NSString stringWithFormat:@"Pitch: %.00f | Yaw: %.00f | Roll: %.00f",[angles pitch].degrees,[angles yaw].degrees,[angles roll].degrees ];
    }
    
    if (([angles pitch].degrees < (-60)) && [self.currentHand isEqualToString:LEFT_HAND]) {
        [[NSNotificationCenter defaultCenter]postNotificationName:RIGHT_TURN_GESTURE object:nil];
    } else if (([angles pitch].degrees < (-60)) && [self.currentHand isEqualToString:RIGHT_HAND]) {
        [[NSNotificationCenter defaultCenter]postNotificationName:LEFT_TURN_GESTURE object:nil];
    } else if ( [angles pitch].degrees > 60 ) {
        [[NSNotificationCenter defaultCenter]postNotificationName:STOP_GESTURE object:nil];
    }

}




@end
