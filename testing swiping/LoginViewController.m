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
#import "UserCreationViewController.h"
#import "LOLLabel.h"
#import "Firebase/Firebase.h"

static NSString *rootURL = @"https://intense-inferno-4374.firebaseio.com";

@interface LoginViewController ()

@property (strong, nonatomic) UIButton *loginButton;
@property (strong, nonatomic) UIButton *registerButton;
@property (nonatomic, strong) UITextField *emailTextField;
@property (nonatomic, strong) UITextField *passwordTextField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [AppearanceController initializeAppearanceDefaults];

    
    self.view.backgroundColor = [UIColor orangeColor];
    
    self.emailTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 79, self.view.frame.size.width - 20, 40)];
    self.passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 130, self.view.frame.size.width - 20, 40)];
    self.registerButton = [[UIButton alloc] initWithFrame:CGRectMake(20 + self.view.frame.size.width/2, 200, self.view.frame.size.width/2 - 20, 40)];
    self.loginButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 200, self.view.frame.size.width/2 - 20, 40)];
    
    self.emailTextField.placeholder = @"Email";
    self.passwordTextField.placeholder = @"Password";
    [self.registerButton setTitle:@"Register" forState:UIControlStateNormal];
    [self.loginButton setTitle:@"Login" forState:UIControlStateNormal];
    
    self.emailTextField.backgroundColor = [UIColor whiteColor];
    self.passwordTextField.backgroundColor = [UIColor whiteColor];
    self.passwordTextField.secureTextEntry = YES;
    self.registerButton.backgroundColor = [UIColor redColor];
    self.loginButton.backgroundColor = [UIColor redColor];

    
    [self.loginButton addTarget:self action:@selector(loginButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.registerButton addTarget:self action:@selector(registerButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.loginButton];
    [self.view addSubview:self.registerButton];
    [self.view addSubview:self.emailTextField];
    [self.view addSubview:self.passwordTextField];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)loginButtonPressed {
    Firebase *ref = [[Firebase alloc] initWithUrl:rootURL];
    
    [ref authUser:self.emailTextField.text password:self.passwordTextField.text withCompletionBlock:^(NSError *error, FAuthData *authData) {
        if(error ) {
            NSLog(@"%@", error);
        }else {
            NSLog(@"%@", authData);
        }
    }];
    
    [self.navigationController pushViewController:[DragCardsViewController new] animated:YES];
}

- (void)registerButtonPressed {
    [self.navigationController pushViewController:[UserCreationViewController new] animated:YES];
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
