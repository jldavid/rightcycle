//
//  TrafficLights.m
//  RightCycle
//
//  Created by Jean-Luc David on 2015-05-09.
//  Copyright (c) 2015 RightCycle. All rights reserved.
//

#import "TrafficLights.h"
#import "RightCycleGestureReconizer.h"

@interface TrafficLights ()

@property (nonatomic,strong) IBOutlet UIImageView * stopLight;
@property (nonatomic,strong) IBOutlet UIImageView * leftLight;
@property (nonatomic,strong) IBOutlet UIImageView * rightLight;

@end

@implementation TrafficLights
{
    RCGestureMask currentGesture;
    
    UIImage * imgLeftOn;
    UIImage * imgRightOn;
    UIImage * imgStopOn;

    UIImage * imgLeftOff;
    UIImage * imgRightOff;
    UIImage * imgStopOff;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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





- (void)signalLeft:(NSNotification *)notification {

    if ((currentGesture & RCGestureMaskLeft) == 0){
        currentGesture = RCGestureMaskLeft;
        [self performSelector:@selector(blank) withObject:self afterDelay:2];
    }
}

- (void)signalRight:(NSNotification *)notification {

    if ((currentGesture & RCGestureMaskRight) == 0){
        currentGesture = RCGestureMaskRight;
        [self performSelector:@selector(blank) withObject:self afterDelay:2];
    }
}

- (void)signalStop:(NSNotification *)notification {

    if ((currentGesture & RCGestureMaskStop) == 0){
        currentGesture = RCGestureMaskStop;
        self.stopLight.image = [UIImage imageNamed:@"signal_stop_on.png"];
        [self performSelector:@selector(blank) withObject:self afterDelay:2];
    }
}


-(void)blank
{
    currentGesture = RCGestureMaskNone;

}




@end
