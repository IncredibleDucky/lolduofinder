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

@interface Summoner ()
@end

@implementation Summoner


- (void)setSummonerWithName:(NSString *)summonerName completion:(void (^)(void))completion {
    
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
    if(dictionary[@"revisionDate"]) {
        self.revisionDate = [NSDate dateWithTimeIntervalSince1970:(NSTimeInterval)[dictionary[@"revisionDate"] doubleValue]];
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
                      @"lp"     : self.leaguePoints
                      //@"hotStreak": self.hasHotStreak,
                      //@"revisionDate": self.revisionDate
                      };
    return summonerDictionary;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {

    self = [super init];
    if (self) {
        if(dictionary[@"id"]) {
            self.summonerID = dictionary[@"id"];
        }
        if(dictionary[@"name"]) {
            self.summonerName = dictionary[@"name"];
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
    }
    return self;
}


@end
