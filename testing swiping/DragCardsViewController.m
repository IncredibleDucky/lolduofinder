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
#import "FirebaseNetworkController.h"
#import "SummonerController.h"
#import "Summoner.h"
#import "MessagesViewController.h"
#import "UserSettingsViewController.h"

@interface DragCardsViewController ()
@property (strong, nonatomic) IBOutlet DraggableViewBackground *draggableViewBackground;
@property (weak, nonatomic) IBOutlet DraggableView *draggableView;
@property (strong, nonatomic) IBOutlet UIPanGestureRecognizer *panGestureRecognizer;

@end

@implementation DragCardsViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];

    [self.navigationItem setHidesBackButton:YES animated:YES];
}

-(void)viewWillAppear:(BOOL)animated {

}

-(void)viewWillDisappear:(BOOL)animated {
    
}



-(void)messageButtonPressed{
    for (int i = 0; i < [SummonerController sharedInstance].matches.count; i++) {
            [FirebaseNetworkController loadMatchesSummonersWithUIDAtIndex:(NSInteger)i WithCompletion:^{
                [self.navigationController pushViewController:[MessagesViewController new] animated:YES];
        }];
    }
}

-(void)menuButtonPressed{
    
    UserSettingsViewController *menuViewController = [[UserSettingsViewController alloc] init];
    
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.25];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromLeft];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [self.navigationController.view.layer addAnimation:animation forKey:kCATransition];
    [self.navigationController pushViewController:menuViewController animated:NO];


}
- (IBAction)menuButtonPressed:(id)sender {
}

- (IBAction)messageButtonPressed:(id)sender {
}
- (IBAction)handlePanGestureRecognizer:(id)sender {
    [self.draggableView beingDragged:sender];
}

@end
