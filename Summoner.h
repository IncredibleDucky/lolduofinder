//
//  Summoner.h
//  testing swiping
//
//  Created by Mattthew Bailey on 8/25/15.
//  Copyright (c) 2015 Richard Kim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Summoner : NSObject

@property (nonatomic, strong) NSNumber * summonerID;
@property (nonatomic, strong) NSString * summonerName;
@property (nonatomic, strong) NSDate * revisionDate;
@property (nonatomic, strong) NSNumber * profileIconID;
@property (nonatomic, strong) NSNumber * summonerLevel;
@property (nonatomic, strong) NSString * rankedTier;
@property (nonatomic, strong) NSString * rankedDivision;
@property (nonatomic, strong) NSNumber * leaguePoints;
@property (nonatomic, strong) NSNumber * rankedWins;
@property (nonatomic, strong) NSNumber * rankedLosses;
@property (nonatomic, strong) NSNumber * hasHotStreak;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
- (void)setSummonerWithName:(NSString *)summonerName completion:(void (^)(void))completion;

- (NSString *)leagueSpecificImageNameForSummoner;
-(NSDictionary *)dictionaryRepresentation;


@end
