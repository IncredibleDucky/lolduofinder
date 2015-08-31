//
//  WelcomeViewController.m
//  testing swiping
//
//  Created by Mattthew Bailey on 8/27/15.
//  Copyright (c) 2015 Richard Kim. All rights reserved.
//

#import "WelcomeViewController.h"

@interface WelcomeViewController ()

@property (strong, nonatomic) UITextView *instructions;
@property (strong, nonatomic) UIButton *getStartedButton;

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationItem  setHidesBackButton:YES animated:YES];
    self.instructions = [[UITextView alloc] init];
    self.getStartedButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 300, 50, 50)];
    
    self.view.backgroundColor = [UIColor redColor];
    
    [self.getStartedButton setTitle:@"GET STARTED" forState:UIControlStateNormal];
    [self.instructions setText: @"These are my instructions"];
    
    
    [self.view addSubview:self.instructions];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
