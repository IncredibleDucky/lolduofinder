//
//  FixedSummonerProfileView.m
//  testing swiping
//
//  Created by Mattthew Bailey on 8/27/15.
//  Copyright (c) 2015 Richard Kim. All rights reserved.
//

#import "FixedSummonerProfileView.h"

@interface FixedSummonerProfileView ()

@property (strong, nonatomic) Summoner *summoner;

@end

@implementation FixedSummonerProfileView

@synthesize summonerName;
@synthesize summonerLeagueIcon;
@synthesize summonerProfileIcon;
@synthesize winsLossesLabel;
@synthesize lossesLabel;
@synthesize tierDivisionLabel;
@synthesize leaguePointsLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
        
        summonerName = [[LOLLabel alloc]initWithFrame:CGRectMake(self.frame.size.width/2 - 150, 200, 300, 25)];
        [summonerName setTextAlignment:NSTextAlignmentCenter];
        summonerName.textColor = [UIColor whiteColor];
        
        summonerLeagueIcon = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width/2 - 40, 10, 80, 80)];
        
        summonerProfileIcon = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width/2 - 100, 200, 25, 25)];
        
        
        winsLossesLabel = [[LOLLabel alloc]initWithFrame:CGRectMake(30, 250, 100, 25)];
        [winsLossesLabel setTextAlignment:NSTextAlignmentCenter];
        winsLossesLabel.textColor = [UIColor whiteColor];
        
        lossesLabel = [[LOLLabel alloc]initWithFrame:CGRectMake(150, 250, 100, 25)];
        [lossesLabel setTextAlignment:NSTextAlignmentCenter];
        lossesLabel.textColor = [UIColor whiteColor];
        
        tierDivisionLabel = [[LOLLabel alloc]initWithFrame:CGRectMake(self.frame.size.width/2 - 100, 100, 200, 40)];
        [tierDivisionLabel setTextAlignment:NSTextAlignmentCenter];
        tierDivisionLabel.textColor = [UIColor whiteColor];
        
        leaguePointsLabel = [[LOLLabel alloc]initWithFrame:CGRectMake(self.frame.size.width/2 - 100, 150, 200, 40)];
        [leaguePointsLabel setTextAlignment:NSTextAlignmentCenter];
        leaguePointsLabel.textColor = [UIColor whiteColor];
        
        self.backgroundColor = [UIColor darkGrayColor];
        

        [self fillCardWithSummonerInfo:self.summoner];
        
        
        //Add all subviews to card.
        [self addSubview:summonerName];
        [self addSubview:summonerLeagueIcon];
        [self addSubview:summonerProfileIcon];
        [self addSubview:winsLossesLabel];
        [self addSubview:lossesLabel];
        [self addSubview:tierDivisionLabel];
        [self addSubview:leaguePointsLabel];
    }
    return self;
}

-(void)setupView
{
    self.layer.cornerRadius = 4;
    self.layer.shadowRadius = 3;
    self.layer.shadowOpacity = 0.2;
    self.layer.shadowOffset = CGSizeMake(1, 1);
}

-(void)fillCardWithSummonerInfo:(Summoner *)summoner {
    
    self.summonerName.text = summoner.summonerName; //%%% placeholder for card-specific information
    self.winsLossesLabel.text = [NSString stringWithFormat:@"W: %@", summoner.rankedWins];
    self.lossesLabel.text = [NSString stringWithFormat:@"L: %@", summoner.rankedLosses];
    self.tierDivisionLabel.text = [NSString stringWithFormat:@"%@ %@", summoner.rankedTier, summoner.rankedDivision];
    self.leaguePointsLabel.text = [NSString stringWithFormat:@"%@ LP", summoner.leaguePoints];
    
    
    self.summonerLeagueIcon.image = [UIImage imageNamed:[summoner leagueSpecificImageNameForSummoner]];
    
    NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://ddragon.leagueoflegends.com/cdn/5.2.1/img/profileicon/%ld.png", (long)[summoner.profileIconID integerValue]]]];
    
    self.summonerProfileIcon.image = [UIImage imageWithData:imageData];
    
}


@end
