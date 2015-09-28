//
//  MenuViewController.m
//  testing swiping
//
//  Created by Mattthew Bailey on 8/26/15.
//  Copyright (c) 2015 Richard Kim. All rights reserved.
//

#import "MenuViewController.h"
#import "SummonerController.h"
#import "FirebaseNetworkController.h"
@interface MenuViewController ()

@property (nonatomic, strong, readwrite) UIBarButtonItem *logoutButton;
@property (nonatomic, strong, readwrite) UIBarButtonItem *backButton;


@end

@implementation MenuViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
    self.logoutButton = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(logoutButtonPressed)];
    self.backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back >" style:UIBarButtonItemStylePlain target:self action:@selector(backButtonPressed)];
    self.navigationItem.leftBarButtonItem = self.logoutButton;    // Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItem = self.backButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

 - (void)logoutButtonPressed{
     NSLog(@"Logout");
     [SummonerController sharedInstance].summoner = [Summoner new];
     [FirebaseNetworkController logout];
     [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)backButtonPressed{
    
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.25];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromRight];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [self.navigationController.view.layer addAnimation:animation forKey:kCATransition];

    [self.navigationController popViewControllerAnimated:NO];
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
