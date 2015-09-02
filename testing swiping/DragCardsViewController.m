//
//  ViewController.m
//  testing swiping
//
//  Created by Richard Kim on 5/21/14.
//  Copyright (c) 2014 Richard Kim. All rights reserved.
//
//  @cwRichardKim for updates and requests

#import "DragCardsViewController.h"
#import "DraggableViewBackground.h"
#import "LeagueNetworkController.h"
#import "SummonerController.h"
#import "Summoner.h"
#import "MessagesViewController.h"
#import "MenuViewController.h"

@interface DragCardsViewController ()

@property (strong, nonatomic) UIButton *menuButton;
@property (strong, nonatomic) UIButton *messageButton;


@end

@implementation DragCardsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    DraggableViewBackground *draggableBackground = [[DraggableViewBackground alloc]initWithFrame:self.view.frame];

    [self.view addSubview:draggableBackground];
    [self.navigationItem setHidesBackButton:YES animated:YES];
    
    self.menuButton = [[UIButton alloc]initWithFrame:CGRectMake(17, 18, 22, 15)];
    [self.menuButton setImage:[UIImage imageNamed:@"menuButton"] forState:UIControlStateNormal];
    
    self.messageButton = [[UIButton alloc]initWithFrame:CGRectMake(284, 18, 18, 18)];
    [self.messageButton setImage:[UIImage imageNamed:@"messageButton"] forState:UIControlStateNormal];
    
    [self.messageButton addTarget:self action:@selector(messageButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.menuButton addTarget:self action:@selector(menuButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [self.navigationController.navigationBar addSubview:self.menuButton];
    [self.navigationController.navigationBar addSubview:self.messageButton];
    
    self.view.backgroundColor = [UIColor grayColor];

}

-(void)viewWillAppear:(BOOL)animated {
    [self.navigationController.navigationBar addSubview:self.menuButton];
    [self.navigationController.navigationBar addSubview:self.messageButton];
}

-(void)viewWillDisappear:(BOOL)animated {
    [self.menuButton removeFromSuperview];
    [self.messageButton removeFromSuperview];
    
}



-(void)messageButtonPressed{
    [self.navigationController pushViewController:[MessagesViewController new] animated:YES];
}

-(void)menuButtonPressed{
    [self.navigationController pushViewController:[MenuViewController new] animated:YES];

}


@end
