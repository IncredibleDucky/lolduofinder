//
//  UserCreationViewController.m
//  testing swiping
//
//  Created by Mattthew Bailey on 8/31/15.
//  Copyright (c) 2015 Richard Kim. All rights reserved.
//

#import "UserCreationViewController.h"
#import "RegisterViewController.h"
#import "Firebase/Firebase.h"
#import "FirebaseNetworkController.h"


@interface UserCreationViewController ()

@property (nonatomic, strong) UITextField *emailTextField;
@property (nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, strong) UIButton *registerButton;

@end

@implementation UserCreationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    self.emailTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 79, self.view.frame.size.width - 20, 40)];
    self.passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 130, self.view.frame.size.width - 20, 40)];
    self.registerButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 200, self.view.frame.size.width - 20, 40)];
    
    self.emailTextField.placeholder = @"Email";
    self.passwordTextField.placeholder = @"Password";
    
    self.emailTextField.backgroundColor = [UIColor whiteColor];
    self.passwordTextField.backgroundColor = [UIColor whiteColor];
    self.passwordTextField.secureTextEntry = YES;
    self.registerButton.backgroundColor = [UIColor redColor];
    [self.registerButton setTitle:@"Register" forState:UIControlStateNormal];
    
    [self.registerButton addTarget:self action:@selector(registrationButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.emailTextField];

    [self.view addSubview:self.passwordTextField];

    [self.view addSubview:self.registerButton];
// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)registrationButtonClicked {
    
    [FirebaseNetworkController createUserWithEmail:self.emailTextField.text andPassword:self.passwordTextField.text completion:^{
            [self.navigationController pushViewController:[RegisterViewController new] animated:YES];
    }];

    
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
