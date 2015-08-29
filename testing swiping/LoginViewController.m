//
//  LoginViewController.m
//  testing swiping
//
//  Created by Mattthew Bailey on 8/26/15.
//  Copyright (c) 2015 Richard Kim. All rights reserved.
//

#import "LoginViewController.h"
#import "DragCardsViewController.h"
#import "RegisterViewController.h"
#import "AppearanceController.h"
#import "LOLLabel.h"

@interface LoginViewController ()

@property (strong, nonatomic) UIButton *loginButton;
@property (strong, nonatomic) UIButton *registerButton;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [AppearanceController initializeAppearanceDefaults];

    
    self.loginButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 64, 100, 100)];
    self.registerButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 64, 100, 100)];
    
    LOLLabel *loginLabel = [[LOLLabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    LOLLabel *registerLabel = [[LOLLabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    
    loginLabel.text = @"Login";
    loginLabel.font = [UIFont fontWithName:@"FrizQuadrataFont" size:20];
    registerLabel.text = @"Register";
    
//    self.loginButton.titleLabel.text = @"Login";
//    self.registerButton.titleLabel.text = @"Register";

    self.loginButton.titleLabel.textColor = [UIColor blackColor];

    [self.loginButton addSubview:loginLabel];
    [self.registerButton addSubview:registerLabel];
    
    self.loginButton.backgroundColor = [UIColor redColor];
    self.registerButton.backgroundColor = [UIColor blueColor];
    
    [self.loginButton addTarget:self action:@selector(loginButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.registerButton addTarget:self action:@selector(registerButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.loginButton];
    [self.view addSubview:self.registerButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)loginButtonPressed {
    [self.navigationController pushViewController:[DragCardsViewController new] animated:YES];
}

- (void)registerButtonPressed {
    [self.navigationController pushViewController:[RegisterViewController new] animated:YES];
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
