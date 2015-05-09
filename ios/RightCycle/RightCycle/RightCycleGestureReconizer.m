//
//  RightCycleGestureReconizer.m
//  RightCycle
//
//  Created by Atomicflare on 2015-05-09.
//  Copyright (c) 2015 RightCycle. All rights reserved.
//

#import "RightCycleGestureReconizer.h"
#import <MyoKit/MyoKit.h>

#define LEFT_TURN_GESTURE   @"LEFT_TURN_GESTURE"
#define RIGHT_TURN_GESTURE  @"RIGHT_TURN_GESTURE"
#define STOP_GESTURE        @"STOP_GESTURE"


static RightCycleGestureReconizer * instance;


@implementation RightCycleGestureReconizer
{
    TLMHub * hub;
    NSDictionary * home;

}



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

        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didReceiveOrientationEvent:)
                                                     name:TLMMyoDidReceiveOrientationEventNotification
                                                   object:nil];
        // Posted when a new accelerometer event is available from a TLMMyo. Notifications are posted at a rate of 50 Hz.
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didReceiveAccelerometerEvent:)
                                                     name:TLMMyoDidReceiveAccelerometerEventNotification
                                                   object:nil];

        
        // set up observers to check
        
    }
    return self;
}


-(void)zeroOut
{
    home = nil;

}



- (void)didReceiveOrientationEvent:(NSNotification *)notification {
    

    
    // Retrieve the orientation from the NSNotification's userInfo with the kTLMKeyOrientationEvent key.
    TLMOrientationEvent *orientationEvent = notification.userInfo[kTLMKeyOrientationEvent];
//
//    // Create Euler angles from the quaternion of the orientation.
    TLMEulerAngles *angles = [TLMEulerAngles anglesWithQuaternion:orientationEvent.quaternion];
//
//    // Next, we want to apply a rotation and perspective transformation based on the pitch, yaw, and roll.
//    CATransform3D rotationAndPerspectiveTransform = CATransform3DConcat(CATransform3DConcat(CATransform3DRotate (CATransform3DIdentity, angles.pitch.radians, -1.0, 0.0, 0.0), CATransform3DRotate(CATransform3DIdentity, angles.yaw.radians, 0.0, 1.0, 0.0)), CATransform3DRotate(CATransform3DIdentity, angles.roll.radians, 0.0, 0.0, -1.0));
//    
    // Apply the rotation and perspective transform to helloLabel.
//    self.helloLabel.layer.transform = rotationAndPerspectiveTransform;
}

- (void)didReceiveAccelerometerEvent:(NSNotification *)notification {
    // Retrieve the accelerometer event from the NSNotification's userInfo with the kTLMKeyAccelerometerEvent.
//    TLMAccelerometerEvent *accelerometerEvent = notification.userInfo[kTLMKeyAccelerometerEvent];
    
    // Get the acceleration vector from the accelerometer event.
//    TLMVector3 accelerationVector = accelerometerEvent.vector;
    
    // Calculate the magnitude of the acceleration vector.
//    float magnitude = TLMVector3Length(accelerationVector);
    
    // Update the progress bar based on the magnitude of the acceleration vector.
//    self.accelerationProgressBar.progress = magnitude / 8;
    
    /* Note you can also access the x, y, z values of the acceleration (in G's) like below
     float x = accelerationVector.x;
     float y = accelerationVector.y;
     float z = accelerationVector.z;
     */
}





@end
