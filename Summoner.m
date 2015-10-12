//
//  Summoner.m
//  testing swiping
//
//  Created by Mattthew Bailey on 8/25/15.
//  Copyright (c) 2015 Richard Kim. All rights reserved.
//

#import "Summoner.h"
#import "SummonerController.h"
#import "LeagueNetworkController.h"
#import "FirebaseNetworkController.h"
#import "Foundation/Foundation.h"

static NSString *rootURL = @"https://lolduofinder.firebaseio.com";

@interface Summoner ()
@end

@implementation Summoner


- (void)setSummonerWithName:(NSString *)summonerName completion:(void (^)(void))completion {
    
    Firebase *userAuthRef = [[Firebase alloc] initWithUrl:rootURL];
    
    //Initialize properties to a default value if they haven't been set so we aren't trying to pass nil objects to firebase server.
    if (!self.uid.length) {
        self.uid = userAuthRef.authData.uid;
    }
    if (!self.favoriteChampion.length) {
        self.favoriteChampion = @"Alistar";
    }
    if (!self.favoriteSkin.length) {
        self.favoriteSkin = @"0";
    }
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURL *path = [[NSURL alloc] initWithString:[LeagueNetworkController getSummonderURLWithSummName:summonerName]];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:path completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"%@", error.localizedDescription);
            completion();
        }
        else {
            NSLog(@"%@", data);
            
            NSError *serializationError;
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&serializationError];
            
            NSLog(@"%@", responseDictionary);
            
            NSString *summonerNameKey = [summonerName lowercaseString];
            summonerNameKey = [summonerNameKey stringByReplacingOccurrencesOfString:@" " withString:@""];
            [self setSummonerInfoWithDictionary:responseDictionary[summonerNameKey] completion:^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion();
                });
            }];
        }
        
        
    }];
    
    
    [dataTask resume];
    
    
}

- (void)setSummonerInfoWithDictionary:(NSDictionary *)dictionary completion:(void (^)(void))completion {
    
    
    NSLog(@"%@", dictionary);
    if(dictionary[@"id"]) {
        NSNumber *num = dictionary[@"id"];
        self.summonerID = num;
    }
    if(dictionary[@"name"]) {
        self.summonerName = dictionary[@"name"];
    }
    if(dictionary[@"profileIconId"]) {
        self.profileIconID = dictionary[@"profileIconId"];
    }
    if(dictionary[@"summonerLevel"]) {
        self.summonerLevel = dictionary[@"summonerLevel"];
    }
    
    
    if(dictionary[@"id"]) {
        
        
        NSURLSession *session = [NSURLSession sharedSession];
        
        NSURL *path = [NSURL URLWithString:[LeagueNetworkController getLeagueInfoForSummonerURLWithSummoner:self]];
        
        NSURLSessionDataTask *dataTask = [session dataTaskWithURL:path completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            
            if (error) {
                NSLog(@"%@", error.localizedDescription);
            }
            else {
                //  NSLog(@"%@", data);
                
                NSError *serializationError;
                NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&serializationError];
                
                // NSLog(@"%@", responseDictionary);
                
                [self setRankedDataWithDictionary:responseDictionary[[NSString stringWithFormat:@"%@", self.summonerID]][0]];
                
            }
            [SummonerController sharedInstance].summoner = self;
            completion();
        }];
        [dataTask resume];
        
    }
    
}

- (void)setRankedDataWithDictionary:(NSDictionary *)dictionary {
    
    NSLog(@"%@", dictionary);
    if(dictionary[@"tier"]) {
        self.rankedTier = dictionary[@"tier"];
    }
    NSNumber *participantID = nil;
    NSDictionary *leagueData = [NSDictionary new];
    if(dictionary[@"participantId"]) {
        participantID = dictionary[@"participantId"];
    }
    
    if (participantID) {
        NSArray *league = dictionary[@"entries"];
        for (int i = 0; i < league.count; i ++)
        {
            NSNumber *comparisonID = league[i][@"playerOrTeamId"];
            if([participantID isEqual: comparisonID]) {
                leagueData = league[i];
            }
            
        }
    }
    
    if(leagueData[@"division"]) {
        self.rankedDivision = leagueData[@"division"];
    }
    if(leagueData[@"leaguePoints"]) {
        self.leaguePoints = (NSNumber *)leagueData[@"leaguePoints"];
    }
    if(leagueData[@"wins"]) {
        self.rankedWins = leagueData[@"wins"];
    }
    if(leagueData[@"losses"]) {
        self.rankedLosses = leagueData[@"losses"];
    }
    if(leagueData[@"isHotStreak"]) {
        self.isHotStreak = [leagueData[@"isHotStreak"] boolValue];
    }
    if(leagueData[@"isFreshBlood"]) {
        self.isFreshBlood = [leagueData[@"isFreshBlood"] boolValue];
    }
    if(leagueData[@"isInactive"]) {
        self.isInactive = [leagueData[@"isInactive"] boolValue];
    }
    if(leagueData[@"isVeteran"]) {
        self.isVeteran = [leagueData[@"isVeteran"] boolValue];
    }
    
    self.lastUpdatedDate = [NSDate date];
    
    [SummonerController sharedInstance].summoner = self;
    
}


-(NSString *)leagueSpecificImageNameForSummoner{
    
    NSMutableString *imageName = [NSMutableString new];
    
    [imageName appendString:self.rankedTier];
    
    if(![self.rankedTier isEqualToString:@"CHALLENGER"] && ![self.rankedTier isEqualToString:@"MASTER"]) {
        [imageName appendString:@"_"];
        [imageName appendString:self.rankedDivision];
    }
    
    [imageName appendString:@".png"];
    
    
    
    return [imageName lowercaseString];
    
}

-(NSDictionary *)dictionaryRepresentation {
    
    NSDictionary *summonerDictionary = @{
                                         @"id"     : self.summonerID,
                                         @"name"   : self.summonerName,
                                         @"level"  : self.summonerLevel,
                                         @"iconID" : self.profileIconID,
                                         @"tier"   : self.rankedTier,
                                         @"division": self.rankedDivision,
                                         @"losses" : self.rankedLosses,
                                         @"wins"   : self.rankedWins,
                                         @"lp"     : self.leaguePoints,
                                         
                                         @"isHotStreak": [NSNumber numberWithBool:self.isHotStreak],
                                         @"isFreshBlood": [NSNumber numberWithBool:self.isFreshBlood],
                                         @"isVeteran": [NSNumber numberWithBool:self.isVeteran],
                                         @"isInactive": [NSNumber numberWithBool:self.isHotStreak],
                                         
                                         @"lastUpdatedDate" : [self.lastUpdatedDate description],
                                         
                                         @"favoriteChampion" : self.favoriteChampion,
                                         @"favoriteSkin" : self.favoriteSkin,
                                         @"usesVoiceComms" : [NSNumber numberWithBool:self.usesVoiceComms],
                                         
                                         @"uid" : self.uid

                                         };
    return summonerDictionary;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    self = [super init];
    if (self) {
        //Check last updated date and name of summoner. If it's been 24 hours since last update call setSummoner on existing summoner for updated rito info.
        if(dictionary[@"lastUpdatedDate"]) {
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"yyyy-MM-dd H:m:s Z"];
            self.lastUpdatedDate = [dateFormat dateFromString:dictionary[@"lastUpdatedDate"]];
        }
        if(dictionary[@"name"]) {
            self.summonerName = dictionary[@"name"];
        }
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd H:m:s Z"];
        
        if ([self.lastUpdatedDate timeIntervalSinceNow] < -(double)86400) { //Comparing time interval since last update to 24 hours in seconds.
            
           __block Summoner *blockSummoner = self;
            
            [self setSummonerWithName:self.summonerName completion:^{
                NSLog(@"Longer than 24 hours has past since last update, refresh info from Rito's servers and update our servers.");
                [FirebaseNetworkController updateUsersSummoner:blockSummoner withUid:blockSummoner.uid];
            }];
        }
        else {
            //If it has been less than 24 hours since this summoner's info was last grabbed we'll just init the summoner with info from our server.
            
            if(dictionary[@"id"]) {
                self.summonerID = dictionary[@"id"];
            }
            if(dictionary[@"level"]) {
                self.summonerLevel = dictionary[@"level"];
            }
            if(dictionary[@"iconID"]) {
                self.profileIconID = dictionary[@"iconID"];
            }
            if(dictionary[@"tier"]) {
                self.rankedTier = dictionary[@"tier"];
            }
            if(dictionary[@"division"]) {
                self.rankedDivision = dictionary[@"division"];
            }
            if(dictionary[@"losses"]) {
                self.rankedLosses = dictionary[@"losses"];
            }
            if(dictionary[@"wins"]) {
                self.rankedWins = dictionary[@"wins"];
            }
            if(dictionary[@"lp"]) {
                self.leaguePoints = dictionary[@"lp"];
            }
            if(dictionary[@"isHotStreak"]) {
                self.isHotStreak = dictionary[@"isHotStreak"];
            }
            if(dictionary[@"isInactive"]) {
                self.isInactive = dictionary[@"isInactive"];
            }
            if(dictionary[@"isVeteran"]) {
                     self.isVeteran = dictionary[@"isVeteran"];
            }
            if(dictionary[@"isFreshBlood"]) {
                self.leaguePoints = dictionary[@"isFreshBlood"];
            }
            if(dictionary[@"favoriteChampion"]) {
                self.favoriteChampion = dictionary[@"favoriteChampion"];
            }
            if(dictionary[@"favoriteSkin"]) {
                self.favoriteSkin = dictionary[@"favoriteSkin"];
            }
            if(dictionary[@"usesVoiceComms"]) {
                self.usesVoiceComms = dictionary[@"usesVoiceComms"];
            }
            if(dictionary[@"uid"]) {
                self.uid = dictionary[@"uid"];
            }
        }
    }
    return self;
}


@end
