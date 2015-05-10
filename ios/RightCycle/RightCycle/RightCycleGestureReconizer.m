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

    
    NSDictionary * leftAngle;
    NSDictionary * rightAngle;
    NSDictionary * stopAngle;
    
    
}

@synthesize debugText;


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
        hub = [TLMHub sharedHub] ;

        
        // Should Roll be ignored?!?
        //NSDictionary * zeroAngle   =    @{@"pitch":@0,@"yaw":@85,@"roll":@145};
        leftAngle   =                   @{@"pitch":@-10,@"yaw":@5,@"roll":@145};
        rightAngle  =                   @{@"pitch":@-70,@"yaw":@45,@"roll":@115};
        stopAngle   =                   @{@"pitch":@70,@"yaw":@72,@"roll":@58};
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didReceiveOrientationEvent:)
                                                     name:TLMMyoDidReceiveOrientationEventNotification
                                                   object:nil];

        
        
    }
    return self;
}


-(void)zeroOut
{
    home = nil;
    TLMMyo * myo = hub.myoDevices[0];
    [myo vibrateWithLength:10];
   
    
}



- (void)didReceiveOrientationEvent:(NSNotification *)notification {
    

    
    // Retrieve the orientation from the NSNotification's userInfo with the kTLMKeyOrientationEvent key.
    TLMOrientationEvent *orientationEvent = notification.userInfo[kTLMKeyOrientationEvent];
//
//    // Create Euler angles from the quaternion of the orientation.
    TLMEulerAngles *angles = [TLMEulerAngles anglesWithQuaternion:orientationEvent.quaternion];

    
    if (!home){
        home = angles;
        NSLog(@"Home - Pitch: %f   Yaw: %f   Roll: %f",[angles pitch].degrees,[angles yaw].degrees,[angles roll].degrees);
        
        self.debugText = [NSString stringWithFormat:@"Pitch: %.00f | Yaw: %.00f | Roll: %.00f",[angles pitch].degrees,[angles yaw].degrees,[angles roll].degrees ];
    }
    
    if ([angles pitch].degrees < (-70) ) {
        [[NSNotificationCenter defaultCenter]postNotificationName:LEFT_TURN_GESTURE object:nil];
    } else if ( [angles pitch].degrees > 70 ) {
        [[NSNotificationCenter defaultCenter]postNotificationName:STOP_GESTURE object:nil];
    }
    
//    if ( [self isDifference:leftAngle current:angles]) {
//        [[NSNotificationCenter defaultCenter]postNotificationName:LEFT_TURN_GESTURE object:nil];
//    } else if ( [self isDifference:rightAngle current:angles] ){
//
//    } else if ( [self isDifference:stopAngle current:angles] ) {
//        [[NSNotificationCenter defaultCenter]postNotificationName:STOP_GESTURE object:nil];
//    }
    
    
    //
//    // Next, we want to apply a rotation and perspective transformation based on the pitch, yaw, and roll.
//    CATransform3D rotationAndPerspectiveTransform = CATransform3DConcat(CATransform3DConcat(CATransform3DRotate (CATransform3DIdentity, angles.pitch.radians, -1.0, 0.0, 0.0), CATransform3DRotate(CATransform3DIdentity, angles.yaw.radians, 0.0, 1.0, 0.0)), CATransform3DRotate(CATransform3DIdentity, angles.roll.radians, 0.0, 0.0, -1.0));
//    
    // Apply the rotation and perspective transform to helloLabel.
//    self.helloLabel.layer.transform = rotationAndPerspectiveTransform;
}



-(BOOL)isDifference:(NSDictionary*)aAngle current:(TLMEulerAngles*)current
{
    
    // if pitch is in range of aAngle pitch
    // if yaw is in range of aAngle yaw
    
    //double aYaw =
    
    
    
    if (YES) {
        return YES;
    } else {
        return NO;
    }
    
    

    
}




@end
