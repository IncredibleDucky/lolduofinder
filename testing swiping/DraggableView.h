//
//  DraggableView.h
//  testing swiping
//
//  Created by Richard Kim on 5/21/14.
//  Copyright (c) 2014 Richard Kim. All rights reserved.
//
//  @cwRichardKim for updates and requests

/*
 
 Copyright (c) 2014 Choong-Won Richard Kim <cwrichardkim@gmail.com>
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is furnished
 to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 
 */

#import <UIKit/UIKit.h>
#import "OverlayView.h"
#import "Summoner.h"
#import "AppearanceController.h"
#import "LOLLabel.h"

@protocol DraggableViewDelegate <NSObject>

-(void)cardSwipedLeft:(UIView *)card;
-(void)cardSwipedRight:(UIView *)card;

@end

@interface DraggableView : UIView

@property (nonatomic, weak) IBOutlet UILabel *rankLabel;
@property (nonatomic, weak) IBOutlet UILabel *winLossLabel;
@property (nonatomic, weak) IBOutlet UILabel *leaguePointsLabel;
@property (nonatomic, weak) IBOutlet UILabel *preferredRoleLabel;
@property (nonatomic, weak) IBOutlet UILabel *useVoiceCommsLabel;
@property (nonatomic, weak) IBOutlet UILabel *hotStreakLabel;
@property (nonatomic, weak) IBOutlet UILabel *summonerNameLabel;
@property (nonatomic, weak) IBOutlet UIImageView *splashArtImageView;
@property (nonatomic, weak) IBOutlet UIImageView *profileIconImageView;
@property (nonatomic, weak) IBOutlet UIImageView *rolePreferredImageView;
@property (nonatomic, weak) IBOutlet UIImageView *hotStreakCheckBoxImageView;
@property (nonatomic, weak) IBOutlet UIImageView *commsCheckBoxImageView;
@property (nonatomic, weak) IBOutlet UIImageView *rankIconImageView;


@property (weak) id <DraggableViewDelegate> delegate;

@property (nonatomic, strong)UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic)CGPoint originalPoint;
@property (nonatomic,strong)OverlayView* overlayView;

-(void)updateWithSummoner:(Summoner *)summoner;

-(void)leftClickAction;
-(void)rightClickAction;
-(void)beingDragged:(UIPanGestureRecognizer *)gestureRecognizer;

@end
