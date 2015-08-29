//
//  RegisterViewController.m
//  testing swiping
//
//  Created by Mattthew Bailey on 8/26/15.
//  Copyright (c) 2015 Richard Kim. All rights reserved.
//

#import "RegisterViewController.h"
#import "LoginViewController.h"
#import "VerifyRegistrationViewController.h"
#import "DraggableView.h"
#import "Summoner.h"
#import "SummonerController.h"
#import "FixedSummonerProfileView.h"
#import "LOLLabel.h"

//static const int MAX_BUFFER_SIZE = 2; //%%% max number of cards loaded at any given time, must be greater than 1
static const float CARD_HEIGHT = 386; //%%% height of the draggable card
static const float CARD_WIDTH = 290; //%%% width of the draggable card

@interface RegisterViewController () <UISearchBarDelegate>

@property (strong, nonatomic) UIButton *registerButton;
@property (strong, nonatomic) UISearchBar *searchBar;
@property (strong, nonatomic) Summoner *user;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Enter you LoL Summoner Name";
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 50)];
    self.searchBar.delegate = self;
    self.registerButton = [[UIButton alloc] initWithFrame:CGRectMake(150, 300, 50, 50)];
    LOLLabel *registerLabel = [[LOLLabel alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    
    registerLabel.text = @"Register";
    
    self.registerButton.titleLabel.text = @"Register";
    
    [self.registerButton addSubview:registerLabel];
    
    self.registerButton.backgroundColor = [UIColor blueColor];
    
    [self.registerButton addTarget:self action:@selector(registerButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    //  [self.view addSubview:self.registerButton];
    [self.view addSubview:self.searchBar];
    
    
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated {
    [self.searchBar becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)registerButtonPressed {
    
    VerifyRegistrationViewController *newViewController =  [VerifyRegistrationViewController new];
    newViewController.summoner = self.user;
    [self.navigationController pushViewController:newViewController animated:YES];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [searchBar resignFirstResponder];
    self.user = [[Summoner alloc] init];
    NSString *summonerName = searchBar.text;
    [self.user setSummonerWithName:summonerName completion:^{
        
        Summoner *weakSummoner;
        weakSummoner = self.user;
        FixedSummonerProfileView *summonerView = [[FixedSummonerProfileView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - CARD_WIDTH)/2, (self.view.frame.size.height - CARD_HEIGHT)/2 + 50, CARD_WIDTH, CARD_HEIGHT)];
        [summonerView fillCardWithSummonerInfo:weakSummoner];
        [summonerView addSubview:self.registerButton];
        [self.view addSubview:summonerView];
        [self.view setNeedsDisplay];
    
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
