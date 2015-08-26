//
//  RegisterViewController.m
//  testing swiping
//
//  Created by Mattthew Bailey on 8/26/15.
//  Copyright (c) 2015 Richard Kim. All rights reserved.
//

#import "RegisterViewController.h"
#import "LoginViewController.h"

@interface RegisterViewController ()
    @property (strong, nonatomic) UIButton *registerButton;
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.registerButton = [[UIButton alloc] initWithFrame:CGRectMake(200, 400, 100, 100)];
    
    UILabel *registerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    
    registerLabel.text = @"Register";
    
    self.registerButton.titleLabel.text = @"Register";
    
    [self.registerButton addSubview:registerLabel];
    
    self.registerButton.backgroundColor = [UIColor blueColor];
    
    [self.registerButton addTarget:self action:@selector(registerButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.registerButton];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)registerButtonPressed {
    [self.navigationController popToRootViewControllerAnimated:YES];
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
