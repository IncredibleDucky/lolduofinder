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

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@property (weak, nonatomic) IBOutlet UIButton *forgotPasswordButton;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Use keychain check if user has logged in before, if they have, auto log in.
    KeychainItemWrapper *keyChain = [[KeychainItemWrapper alloc] initWithIdentifier:@"emailLogin" accessGroup:nil];
    NSData *passwordData = [keyChain objectForKey:(__bridge id)(kSecValueData)];
    NSString *email = [keyChain objectForKey:(__bridge id)(kSecAttrAccount)];
    
    //Auto Log in
    if (![email isEqualToString:@""]) {
        self.emailTextField.text = email;
        self.passwordTextField.text = [[NSString alloc] initWithBytes:[passwordData bytes] length:[passwordData length]
                                                             encoding:NSUTF8StringEncoding];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginButtonPresed:(id)sender {

    
    
    [FirebaseNetworkController loginWithUserName:self.emailTextField.text password:self.passwordTextField.text completion:^{
        if ([SummonerController sharedInstance].isLoggedIn == NO) {
            
            if ([SummonerController sharedInstance].summoner) {
                if(![self.navigationController.topViewController isKindOfClass:[DragCardsViewController class]]) {
                    [FirebaseNetworkController queryForMatchesWithCompletion:^{
                       
                        [SummonerController sharedInstance].isLoggedIn = YES;
                        
                        [self performSegueWithIdentifier:@"loginWithVerifiedSummoner" sender:sender];
                    }];
                    
                }
            }else {
                [SummonerController sharedInstance].isLoggedIn = YES;
                
                [self.navigationController pushViewController:[RegisterViewController new] animated:YES];
            }
        }
    }];
    
    
}

- (IBAction)registerButtonPressed:(id)sender {

    [self.navigationController pushViewController:[UserCreationViewController new] animated:YES];
    
}

- (IBAction)forgotPasswordButtonPressed:(id)sender {
}


 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

 }
 

@end
