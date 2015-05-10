//
//  FirstViewController.m
//  RightCycle
//
//  Created by Atomicflare on 2015-05-09.
//  Copyright (c) 2015 RightCycle. All rights reserved.
//

#import "FirstViewController.h"
#import <MyoKit/MyoKit.h>
#import "RightCycleGestureReconizer.h"

typedef NS_OPTIONS(NSInteger, RCGestureMask) {
    RCGestureMaskNone     =  0,
    RCGestureMaskLeft     =  1<<0,
    RCGestureMaskRight    =  1<<1,
    RCGestureMaskStop     =  1<<2

};



@interface FirstViewController ()
@property (strong, nonatomic) TLMPose *currentPose;
@end

@implementation FirstViewController
{
    UIButton * connectButton;
    UILabel  * statusLabel;
    UILabel  * debugLabel;
    UILabel  * accLabel;
    BOOL isFinishedDelay;
    RCGestureMask currentGesture;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    isFinishedDelay = YES;
    currentGesture = RCGestureMaskNone;
    // Do any additional setup after loading the view, typically from a nib.
    statusLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 100, 100, 30)];
    statusLabel.text    = @"Status";
    
    
    debugLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 180, 300, 30)];
    debugLabel.text     = @"Debug";
    
    accLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 230, 300, 30)];
    accLabel.text       = @"Acc";
    
    // Data notifications are received through NSNotificationCenter.
    // Posted whenever a TLMMyo connects
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didConnectDevice:)
                                                 name:TLMHubDidConnectDeviceNotification
                                               object:nil];
    // Posted whenever a TLMMyo disconnects.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didDisconnectDevice:)
                                                 name:TLMHubDidDisconnectDeviceNotification
                                               object:nil];
    // Posted whenever the user does a successful Sync Gesture.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didSyncArm:)
                                                 name:TLMMyoDidReceiveArmSyncEventNotification
                                               object:nil];
    // Posted whenever Myo loses sync with an arm (when Myo is taken off, or moved enough on the user's arm).
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didUnsyncArm:)
                                                 name:TLMMyoDidReceiveArmUnsyncEventNotification
                                               object:nil];
    // Posted whenever Myo is unlocked and the application uses TLMLockingPolicyStandard.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didUnlockDevice:)
                                                 name:TLMMyoDidReceiveUnlockEventNotification
                                               object:nil];
    // Posted whenever Myo is locked and the application uses TLMLockingPolicyStandard.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didLockDevice:)
                                                 name:TLMMyoDidReceiveLockEventNotification
                                               object:nil];

    // Posted when a new pose is available from a TLMMyo.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceivePoseChange:)
                                                 name:TLMMyoDidReceivePoseChangedNotification
                                               object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveAccelerometerEvent:)
                                                 name:TLMMyoDidReceiveAccelerometerEventNotification
                                               object:nil];

    
    // custom Gestures
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(signalLeft:)
                                                 name:LEFT_TURN_GESTURE
                                               object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(signalRight:)
                                                 name:RIGHT_TURN_GESTURE
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(signalStop:)
                                                 name:STOP_GESTURE
                                               object:nil];
    
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    connectButton = [[UIButton alloc]init];
    connectButton.layer.borderWidth =1;
    [connectButton setFrame:CGRectMake(50, 50, 100, 30)];
    [connectButton setTitle:@"Connect" forState:UIControlStateNormal];
    [connectButton setTitle:@"Connect" forState:UIControlStateSelected];
    [connectButton setTitle:@"Connect" forState:UIControlStateHighlighted];
    [connectButton addTarget:self action:@selector(didTapSettings:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:statusLabel];
    [self.view addSubview:debugLabel];
    [self.view addSubview:accLabel];
    [self.view addSubview:connectButton];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    UIImage *image = [UIImage imageNamed:@"titlelogo.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = CGRectMake(((320-130)/2), 10, 130, 20);
    [self.navigationController.navigationBar addSubview:imageView];

    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:(9.0f/255.f) green:(14.0f/255.f) blue:(23.0f/255.f) alpha:1.0f]];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleLightContent;
}

#pragma mark - NSNotificationCenter Methods
- (void)didConnectDevice:(NSNotification *)notification {

}
- (void)didDisconnectDevice:(NSNotification *)notification {

}
- (void)didUnlockDevice:(NSNotification *)notification {
    // Update the label to reflect Myo's lock state.

}
- (void)didLockDevice:(NSNotification *)notification {
    // Update the label to reflect Myo's lock state.

}
- (void)didSyncArm:(NSNotification *)notification {
//    TLMArmSyncEvent *armEvent = notification.userInfo[kTLMKeyArmSyncEvent];
    statusLabel.text = @"Synced";
}
- (void)didUnsyncArm:(NSNotification *)notification {
    // Reset the labels.
    statusLabel.text = @"not Synced";
}


- (void)didReceivePoseChange:(NSNotification *)notification {
    // Retrieve the pose from the NSNotification's userInfo with the kTLMKeyPose key.
    TLMPose *pose = notification.userInfo[kTLMKeyPose];
    self.currentPose = pose;
//    // Handle the cases of the TLMPoseType enumeration, and change the color of helloLabel based on the pose we receive.
    switch (pose.type) {
        case TLMPoseTypeUnknown:
            break;
        case TLMPoseTypeRest:
            break;
        case TLMPoseTypeDoubleTap:
            break;
        case TLMPoseTypeFist:
            break;
        case TLMPoseTypeWaveIn:

            if ([[RightCycleGestureReconizer getInstance].currentHand isEqualToString:RIGHT_HAND]) {
                [[NSNotificationCenter defaultCenter]postNotificationName:LEFT_TURN_GESTURE object:nil];
            } else {
                [[NSNotificationCenter defaultCenter]postNotificationName:RIGHT_TURN_GESTURE object:nil];
            }
            
            break;
        case TLMPoseTypeWaveOut:
            if ([[RightCycleGestureReconizer getInstance].currentHand isEqualToString:LEFT_HAND]) {
                [[NSNotificationCenter defaultCenter]postNotificationName:LEFT_TURN_GESTURE object:nil];
            } else {
                [[NSNotificationCenter defaultCenter]postNotificationName:RIGHT_TURN_GESTURE object:nil];
            }
            break;
        case TLMPoseTypeFingersSpread:
            [[RightCycleGestureReconizer getInstance] zeroOut];
            debugLabel.text = [RightCycleGestureReconizer getInstance].debugText;
            break;
    }
    // Unlock the Myo whenever we receive a pose
    if (pose.type == TLMPoseTypeUnknown || pose.type == TLMPoseTypeRest) {
        // Causes the Myo to lock after a short period.
        [pose.myo unlockWithType:TLMUnlockTypeTimed];
    } else {
        // Keeps the Myo unlocked until specified.
        // This is required to keep Myo unlocked while holding a pose, but if a pose is not being held, use
        // TLMUnlockTypeTimed to restart the timer.
        [pose.myo unlockWithType:TLMUnlockTypeHold];
        // Indicates that a user action has been performed.
        [pose.myo indicateUserAction];
    }
}



- (void)signalLeft:(NSNotification *)notification {
    statusLabel.text = @"LEFT";
    if ((currentGesture & RCGestureMaskLeft) == 0){
        currentGesture = RCGestureMaskLeft;
        [self performSelector:@selector(blank) withObject:self afterDelay:2];
    }
}

- (void)signalRight:(NSNotification *)notification {
    statusLabel.text = @"RIGHT";
        if ((currentGesture & RCGestureMaskRight) == 0){
            currentGesture = RCGestureMaskRight;
            [self performSelector:@selector(blank) withObject:self afterDelay:2];
        }
}

- (void)signalStop:(NSNotification *)notification {
    statusLabel.text = @"STOP";
    if ((currentGesture & RCGestureMaskStop) == 0){
        currentGesture = RCGestureMaskStop;
        [self performSelector:@selector(blank) withObject:self afterDelay:2];
    }
}


-(void)blank
{
        currentGesture = 0;
        statusLabel.text = @"";
}


- (void)didReceiveAccelerometerEvent:(NSNotification *)notification {
    // Retrieve the accelerometer event from the NSNotification's userInfo with the kTLMKeyAccelerometerEvent.
    TLMAccelerometerEvent *accelerometerEvent = notification.userInfo[kTLMKeyAccelerometerEvent];
    
    // Get the acceleration vector from the accelerometer event.
    TLMVector3 accelerationVector = accelerometerEvent.vector;

    accLabel.text = [NSString stringWithFormat:@"x: %.00f  y: %.00f  Z: %.00f",accelerationVector.x,accelerationVector.y,accelerationVector.z];
}


- (void)didTapSettings:(id)sender {
    // Note that when the settings view controller is presented to the user, it must be in a UINavigationController.
    UINavigationController *controller = [TLMSettingsViewController settingsInNavigationController];
    // Present the settings view controller modally.
    [self presentViewController:controller animated:YES completion:nil];
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

@end
