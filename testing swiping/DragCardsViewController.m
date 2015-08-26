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
#import "NetworkController.h"
#import "SummonerController.h"
#import "Summoner.h"
#import "MessagesViewController.h"
#import "MenuViewController.h"

@interface DragCardsViewController ()
@end

@implementation DragCardsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    DraggableViewBackground *draggableBackground = [[DraggableViewBackground alloc]initWithFrame:self.view.frame];

    [self.view addSubview:draggableBackground];
}

-(void)messageButtonPressed{
    [self.navigationController pushViewController:[MessagesViewController new] animated:YES];
}

-(void)menuButtonPressed{
    [self.navigationController pushViewController:[MenuViewController new] animated:YES];

}


@end
