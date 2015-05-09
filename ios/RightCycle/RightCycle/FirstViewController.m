//
//  FirstViewController.m
//  RightCycle
//
//  Created by Atomicflare on 2015-05-09.
//  Copyright (c) 2015 RightCycle. All rights reserved.
//

#import "FirstViewController.h"
#import <MyoKit/MyoKit.h>


@interface FirstViewController ()
@property (strong, nonatomic) TLMPose *currentPose;
@end

@implementation FirstViewController
{
    UIButton * connectButton;
    UILabel  * statusLabel;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    statusLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 100, 100, 30)];
    statusLabel.text = @"Status";
    
    
    
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
    [self.view addSubview:connectButton];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    // Retrieve the arm event from the notification's userInfo with the kTLMKeyArmSyncEvent key.
    TLMArmSyncEvent *armEvent = notification.userInfo[kTLMKeyArmSyncEvent];
    // Update the armLabel with arm information.
//    NSString *armString = armEvent.arm == TLMArmRight ? @"Right" : @"Left";
//    NSString *directionString = armEvent.xDirection == TLMArmXDirectionTowardWrist ? @"Toward Wrist" : @"Toward Elbow";
   // self.armLabel.text = [NSString stringWithFormat:@"Arm: %@ X-Direction: %@", armString, directionString];
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
//    switch (pose.type) {
//        case TLMPoseTypeUnknown:
//        case TLMPoseTypeRest:
//        case TLMPoseTypeDoubleTap:
//            // Changes helloLabel's font to Helvetica Neue when the user is in a rest or unknown pose.
//            self.helloLabel.text = @"Hello Myo";
//            self.helloLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:50];
//            self.helloLabel.textColor = [UIColor blackColor];
//            break;
//        case TLMPoseTypeFist:
//            // Changes helloLabel's font to Noteworthy when the user is in a fist pose.
//            self.helloLabel.text = @"Fist";
//            self.helloLabel.font = [UIFont fontWithName:@"Noteworthy" size:50];
//            self.helloLabel.textColor = [UIColor greenColor];
//            break;
//        case TLMPoseTypeWaveIn:
//            // Changes helloLabel's font to Courier New when the user is in a wave in pose.
//            self.helloLabel.text = @"Wave In";
//            self.helloLabel.font = [UIFont fontWithName:@"Courier New" size:50];
//            self.helloLabel.textColor = [UIColor greenColor];
//            break;
//        case TLMPoseTypeWaveOut:
//            // Changes helloLabel's font to Snell Roundhand when the user is in a wave out pose.
//            self.helloLabel.text = @"Wave Out";
//            self.helloLabel.font = [UIFont fontWithName:@"Snell Roundhand" size:50];
//            self.helloLabel.textColor = [UIColor greenColor];
//            break;
//        case TLMPoseTypeFingersSpread:
//            // Changes helloLabel's font to Chalkduster when the user is in a fingers spread pose.
//            self.helloLabel.text = @"Fingers Spread";
//            self.helloLabel.font = [UIFont fontWithName:@"Chalkduster" size:50];
//            self.helloLabel.textColor = [UIColor greenColor];
//            break;
//    }
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




- (void)didTapSettings:(id)sender {
    // Note that when the settings view controller is presented to the user, it must be in a UINavigationController.
    UINavigationController *controller = [TLMSettingsViewController settingsInNavigationController];
    // Present the settings view controller modally.
    [self presentViewController:controller animated:YES completion:nil];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
