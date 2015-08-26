//
//  Summoner.m
//  testing swiping
//
//  Created by Mattthew Bailey on 8/25/15.
//  Copyright (c) 2015 Richard Kim. All rights reserved.
//

#import "Summoner.h"
#import "SummonerController.h"
#import "NetworkController.h"

@interface Summoner ()
@end

@implementation Summoner

@dynamic summonerID;
@dynamic summonerName;
@dynamic revisionDate;
@dynamic profileIconID;
@dynamic summonerLevel;
@dynamic rankedTier;
@dynamic rankedDivision;
@dynamic leaguePoints;
@dynamic rankedWins;
@dynamic rankedLosses;
@dynamic hasHotStreak;

- (void)setSummonerWithName:(NSString *)summonerName completion:(void (^)(void))completion {
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURL *path = [[NSURL alloc] initWithString:@"https://na.api.pvp.net/api/lol/na/v1.4/summoner/by-name/GodMechanix?api_key=77169713-d987-4b15-a5d9-4bde08f92c20"];
    
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
                   completion();
            }];
        }
        
      
    }];
    
    
    [dataTask resume];
    
    
}

- (void)setSummonerInfoWithDictionary:(NSDictionary *)dictionary completion:(void (^)(void))completion {
    
        
        if(dictionary[@"id"]) {
            self.summonerID = dictionary[@"id"];
        }
        if(dictionary[@"name"]) {
            self.summonerName = dictionary[@"name"];
        }
        if(dictionary[@"profileIconId"]) {
            self.profileIconID = dictionary[@"profileIconId"];
        }
        if(dictionary[@"revisionDate"]) {
            self.revisionDate = [NSDate dateWithTimeIntervalSince1970:[dictionary[@"revisionDate"] doubleValue]];
        }
        if(dictionary[@"summonerLevel"]) {
            self.summonerLevel = dictionary[@"summonerLevel"];
        }
        if(dictionary[@"id"]) {
            
            
            NSURLSession *session = [NSURLSession sharedSession];
            
            NSURL *path = [NSURL URLWithString:[NetworkController getLeagueInfoForSummonerURLWithSummoner:self]];
            
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


@end
