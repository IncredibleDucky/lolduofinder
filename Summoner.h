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

//Properties retrieved from league servers.
@property (nonatomic, strong) NSNumber *summonerID;
@property (nonatomic, strong) NSString *summonerName;
@property (nonatomic, strong) NSDate *lastUpdatedDate;
@property (nonatomic, strong) NSNumber *profileIconID;
@property (nonatomic, strong) NSNumber *summonerLevel;
@property (nonatomic, strong) NSString *rankedTier;
@property (nonatomic, strong) NSString *rankedDivision;
@property (nonatomic, strong) NSNumber *leaguePoints;
@property (nonatomic, strong) NSNumber *rankedWins;
@property (nonatomic, strong) NSNumber *rankedLosses;
@property (nonatomic) BOOL isHotStreak;
@property (nonatomic) BOOL isInactive;
@property (nonatomic) BOOL isVeteran;
@property (nonatomic) BOOL isFreshBlood;

//Property our server sets.
@property (nonatomic, strong) NSString *uid;

//Properties user customizes.
@property (nonatomic, strong)NSString *favoriteChampion;
@property (nonatomic, strong)NSString *favoriteSkin;
@property (nonatomic) BOOL usesVoiceComms;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
- (void)setSummonerWithName:(NSString *)summonerName completion:(void (^)(void))completion;

- (NSString *)leagueSpecificImageNameForSummoner;
-(NSDictionary *)dictionaryRepresentation;


@end
