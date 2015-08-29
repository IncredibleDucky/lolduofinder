//
//  FixedSummonerProfileView.h
//  testing swiping
//
//  Created by Mattthew Bailey on 8/27/15.
//  Copyright (c) 2015 Richard Kim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Summoner.h"
#import "LOLLabel.h"

@interface FixedSummonerProfileView : UIView


//Summoner Info on each card
@property (nonatomic, strong)LOLLabel* summonerName;
@property (nonatomic, strong)UIImageView* summonerLeagueIcon;
@property (nonatomic, strong)UIImageView* summonerProfileIcon;
@property (nonatomic, strong)LOLLabel* winsLossesLabel;
@property (nonatomic, strong)LOLLabel* lossesLabel;
@property (nonatomic, strong)LOLLabel* tierDivisionLabel;
@property (nonatomic, strong)LOLLabel* leaguePointsLabel;

-(void)fillCardWithSummonerInfo:(Summoner *)summoner;


@end
