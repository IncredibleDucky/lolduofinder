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
#import "VerifyRegistrationViewController.h"
#import "AppearanceController.h"
#import "UserCreationViewController.h"
#import "LOLLabel.h"
#import "Firebase/Firebase.h"
#import "KeychainItemWrapper.h"
#import "SummonerController.h"
#import "FirebaseNetworkController.h"


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
    
    //Use keychain check if user has logged in before, if they have, auto log in.
    KeychainItemWrapper *keyChain = [[KeychainItemWrapper alloc] initWithIdentifier:@"emailLogin" accessGroup:nil];
    NSData *passwordData = [keyChain objectForKey:(__bridge id)(kSecValueData)];
    NSString *email = [keyChain objectForKey:(__bridge id)(kSecAttrAccount)];

    
    [self.loginButton addTarget:self action:@selector(loginButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.registerButton addTarget:self action:@selector(registerButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    
    //Auto Log in
    if (![email isEqualToString:@""]) {
        self.emailTextField.text = email;
        self.passwordTextField.text = [[NSString alloc] initWithBytes:[passwordData bytes] length:[passwordData length]
                                                                                  encoding:NSUTF8StringEncoding];
    }
    
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

    [FirebaseNetworkController loginWithUserName:self.emailTextField.text password:self.passwordTextField.text completion:^{
        if ([SummonerController sharedInstance].summoner) {
            if(![self.navigationController.topViewController isKindOfClass:[DragCardsViewController class]]) {
                [FirebaseNetworkController queryForMatchesWithCompletion:^{
                    DragCardsViewController *dragCardsViewController = [DragCardsViewController new];
                    [self.navigationController pushViewController:dragCardsViewController animated:YES];
                }];

            }
        }else {
            [self.navigationController pushViewController:[RegisterViewController new] animated:YES];
        }
    }];


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
