//
//  Summoner.h
//  testing swiping
//
//  Created by Mattthew Bailey on 8/25/15.
//  Copyright (c) 2015 Richard Kim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Summoner : NSManagedObject

@property (nonatomic, retain) NSNumber * summonerID;
@property (nonatomic, retain) NSString * summonerName;
@property (nonatomic, retain) NSDate * revisionDate;
@property (nonatomic, retain) NSNumber * profileIconID;
@property (nonatomic, retain) NSNumber * summonerLevel;
@property (nonatomic, retain) NSString * rankedTier;
@property (nonatomic, retain) NSString * rankedDivision;
@property (nonatomic, retain) NSNumber * leaguePoints;
@property (nonatomic, retain) NSNumber * rankedWins;
@property (nonatomic, retain) NSNumber * rankedLosses;
@property (nonatomic, retain) NSNumber * hasHotStreak;

- (void)setSummonerWithName:(NSString *)summonerName completion:(void(^)(void))completion;

- (NSString *)leagueSpecificImageNameForSummoner;

@end
