//
//  TrafficLights.m
//  RightCycle
//
//  Created by Jean-Luc David on 2015-05-09.
//  Copyright (c) 2015 RightCycle. All rights reserved.
//

#import "TrafficLights.h"

@interface TrafficLights ()

@end

@implementation TrafficLights

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
