
//
//  FirebaseNetworkController.m
//  testing swiping
//
//  Created by Mattthew Bailey on 9/2/15.
//  Copyright (c) 2015 Richard Kim. All rights reserved.
//

#import "FirebaseNetworkController.h"
#import "Firebase/Firebase.h"
#import "KeychainItemWrapper.h"
#import "Summoner.h"
#import "SummonerController.h"

static NSString *rootURL = @"https://lolduofinder.firebaseio.com";


@implementation FirebaseNetworkController

+ (void)createUserWithEmail:(NSString *)email andPassword:(NSString *)password completion:(void (^)(void))completion{

    
    Firebase *ref = [[Firebase alloc] initWithUrl:rootURL];
    [ref childByAppendingPath:@"users"];
    
    [ref createUser:email password:password withValueCompletionBlock:^(NSError *error, NSDictionary *result) {
        if (error) {
            NSLog(@"%@", error.localizedDescription);
        } else {
            NSString *uid = [result objectForKey:@"uid"];
            NSLog(@"Successfully created user account with uid: %@", uid);
        }
        completion();
    }];
    
}

+ (void)loginWithUserName:(NSString *)username password:(NSString *)password completion:(void (^)(void))completion{
    Firebase *ref = [[Firebase alloc] initWithUrl:rootURL];
        
    [ref authUser:username password:password withCompletionBlock:^(NSError *error, FAuthData *authData) {
        if(error ) {
            NSLog(@"%@", error);
        }else {
            NSLog(@"%@", authData);
            
            
            //Set KeyChain after successfull login.
            KeychainItemWrapper *keyChain = [[KeychainItemWrapper alloc] initWithIdentifier:@"emailLogin" accessGroup:nil];
            
            [keyChain setObject:password forKey:(__bridge id)(kSecValueData)];
            [keyChain setObject:username forKey:(__bridge id)(kSecAttrAccount)];
            [FirebaseNetworkController loadUsersSummonerWithCompletion:^{
                NSLog(@"Hello");
                completion();
            }];
       
        }
    }];
    
}

+ (void)loadUsersSummonerWithCompletion:(void (^)(void))completion {
    Firebase *ref = [[Firebase alloc] initWithUrl:rootURL];
    
    
    [ref observeAuthEventWithBlock:^(FAuthData *authData) {
        if(authData ) {
            
            Firebase *summonerRef = [[Firebase alloc] initWithUrl:rootURL];
            [[[summonerRef childByAppendingPath:@"users"] childByAppendingPath:authData.uid] observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
                NSLog(@"%@", snapshot.value);
                if(snapshot.value != [NSNull null]){
                    NSDictionary *snapshotDictionary = [[NSDictionary alloc] initWithDictionary:(NSDictionary *)(snapshot.value)];
                    if([snapshotDictionary objectForKey:@"summoner"]) {
                        [SummonerController sharedInstance].summoner = [[Summoner alloc] initWithDictionary:snapshotDictionary[@"summoner"]];
                    }
                    if([snapshotDictionary objectForKey:@"matches"]){
                       [[SummonerController sharedInstance] setMatches:[snapshotDictionary[@"matches"] allKeys]];
                    }
                    if([snapshotDictionary objectForKey:@"potentialMatches"]){
                       [[SummonerController sharedInstance] setPotentialMatches:[snapshotDictionary[@"potentialMatches"] allKeys]];
                    }
                    if([snapshotDictionary objectForKey:@"pendingMatches"]){
                        [[SummonerController sharedInstance] setPendingMatches:[snapshotDictionary[@"pendingMatches"] allKeys]];
                    }
                    if([snapshotDictionary objectForKey:@"denied"]){
                        [[SummonerController sharedInstance] setDenied:[snapshotDictionary[@"denied"] allKeys]];
                    }
                }
                completion();
                
                
            } withCancelBlock:^(NSError *error) {
                NSLog(@"%@", error.description);
                completion();
                
            }];
            
            
        }
        
    }];
}

+(void)loadUsersPotentialMatchesWithCompletion:(void (^)(void))completion {
    Firebase *ref = [[Firebase alloc] initWithUrl:rootURL];
    
    
    [ref observeAuthEventWithBlock:^(FAuthData *authData) {
        if(authData ) {
            
            Firebase *summonerRef = [[Firebase alloc] initWithUrl:[rootURL stringByAppendingString:[NSString stringWithFormat:@"/users/%@/potentialMatches", authData.uid]]];
            
            [summonerRef observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
                NSLog(@"%@", snapshot.value);
                NSArray *snapshotAray = [[NSArray alloc] initWithArray:(NSArray *)(snapshot.value)];
                if(snapshotAray) {
                    [[SummonerController sharedInstance] setMatches:snapshotAray];
                }
                completion();
                
                
            } withCancelBlock:^(NSError *error) {
                NSLog(@"%@", error.description);
                completion();
                
            }];
        }
    }];
}

+ (void)updateUsersSummoner:(Summoner *)summoner withUid:(NSString *)uid {
    
    Firebase *dataReference = [[Firebase alloc] initWithUrl:rootURL];
    
    //Saves summoner data at <baseURL>/users/<uid>/summoner
    [[[[dataReference childByAppendingPath:@"users"] childByAppendingPath: dataReference.authData.uid] childByAppendingPath:@"summoner"]
     setValue:[summoner dictionaryRepresentation]];
    
    Firebase *newRef = [[Firebase alloc] initWithUrl:[NSString stringWithFormat:@"%@/ranks/%@/%@/%@", rootURL, summoner.rankedTier, summoner.rankedDivision, dataReference.authData.uid]];
    [newRef setValue:@{@"name" : summoner.summonerName, @"dateLastUpdated" : [summoner.lastUpdatedDate description] }];
    
}


+ (void)loadQueriedSummonersWithUIDWithCompletion:(void (^)(void))completion{
    
    NSMutableArray *summoners = [NSMutableArray new];
    
    for (int i = 0; i < [SummonerController sharedInstance].queried.count; i++) {
        
        Firebase *summonerRef = [[Firebase alloc] initWithUrl:[NSString stringWithFormat:@"%@/users/%@/summoner", rootURL, [SummonerController sharedInstance].queried[i]]];
        [summonerRef observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
            NSLog(@"%@",snapshot.value);
            
            [summoners addObject:[[Summoner alloc] initWithDictionary:snapshot.value]];
            [[SummonerController sharedInstance] setCards:summoners];
            if (i == [SummonerController sharedInstance].queried.count - 1) {
                completion();
            }
        }];
        
    }
}

+ (void)loadMatchesSummonersWithUIDAtIndex:(NSInteger)index WithCompletion:(void (^)(void))completion{
    
    NSMutableArray *summoners = [NSMutableArray new];
    if (![[SummonerController sharedInstance].matchesSummoners isEqualToArray:@[]]) {
        summoners = [[SummonerController sharedInstance].matchesSummoners mutableCopy];
    }
        
        Firebase *summonerRef = [[Firebase alloc] initWithUrl:[NSString stringWithFormat:@"%@/users/%@/summoner", rootURL, [SummonerController sharedInstance].matches[(long)index]]];
        [summonerRef observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
            NSLog(@"%@",snapshot.value);
            
            [summoners addObject:[[Summoner alloc] initWithDictionary:snapshot.value]];
            [[SummonerController sharedInstance] setMatchesSummoners:summoners];
            if ((long)index == [SummonerController sharedInstance].matches.count - 1) {
                completion();
            }
        }];
}


+ (void)queryForMatchesWithCompletion:(void (^)(void))completion{
    Firebase *retrieveData = [[Firebase alloc] initWithUrl:[NSString stringWithFormat:@"%@/ranks/%@/%@", rootURL, [SummonerController sharedInstance].summoner.rankedTier, [SummonerController sharedInstance].summoner.rankedDivision]];
    
    [retrieveData observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        
        NSArray *matches = [NSArray new];
        NSMutableArray *queried = [NSMutableArray new];
        if(![snapshot.value isEqual: [NSNull null]]) {
            
        
            matches = [snapshot.value allKeys];
        NSLog(@"%@", snapshot.value);
        NSLog(@"%@", matches);
        
        //Make sure queried users are not ourselves, denied or matched users. Add potential matches at the beginning.
        if(![matches  isEqual: [NSNull null]]) {
            
            
            
            //Add potential matches first;
            for(int j = 0; j < [SummonerController sharedInstance].potentialMatches.count; j++) {
                
                [queried addObject:[SummonerController sharedInstance].potentialMatches[j]];
                
            }
            
            //Add new
            for(int j = 0; j < matches.count; j++) {
                BOOL hasBeenQueued = false;
                //check if it already has been queried.
                for (int i = 0; i < queried.count; i++) {
                    if([queried[i] isEqual:matches[j]]) {
                        hasBeenQueued = true;
                    }
                }
                if(hasBeenQueued == false) {
                    [queried addObject:matches[j]];
                }
                
            }
            
            for(int i = 0; i < matches.count; i++) {
                
                
                if ([matches[i] isEqualToString: retrieveData.authData.uid]) {
                    [queried removeObject:matches[i]];
                    
                }
                
                for(int j = 0; j < [SummonerController sharedInstance].pendingMatches.count; j++) {
                    
                    if([matches[i] isEqual: [SummonerController sharedInstance].pendingMatches[j]]) {
                        [queried removeObject:matches[i]];
                    }
                }
                
                for(int j = 0; j < [SummonerController sharedInstance].matches.count; j++) {
                    
                    if([matches[i] isEqual: [SummonerController sharedInstance].matches[j]]) {
                        [queried removeObject:matches[i]];
                    }
                }
                
                for(int j = 0; j < [SummonerController sharedInstance].denied.count; j++) {
                    
                    if(matches[i] == [SummonerController sharedInstance].denied[j]) {
                        [queried removeObject:matches[i]];
                        
                    }
                }
                
            }
            if(![queried  isEqualToArray:@[]]) {
                [[SummonerController sharedInstance] setQueried:queried];
            } else{
                NSLog(@"No More Summs this rank");
            }
            
            
            
        } else {
            NSLog(@"No more summoners this rank");
        }
        } else {
            NSLog(@"No summs found at this rank");
            [SummonerController sharedInstance].queried = @[];
        }
        completion();
    }];
}


+ (void)logout {
    Firebase *dataReference = [[Firebase alloc] initWithUrl:rootURL];
    [dataReference unauth];
}

+ (void)cardSwipedRightWithCompletion:(void (^)(void))completion {
    
    Firebase *dataReference = [[Firebase alloc] initWithUrl:[NSString stringWithFormat:@"%@/users/%@/pendingMatches", rootURL, [SummonerController sharedInstance].queried[0]]];
    
    [dataReference observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        NSMutableArray *pendingMatches = [NSMutableArray new];
        NSLog(@"%@", dataReference);
        NSLog(@"%@", snapshot.value);
        if(![snapshot.value isEqual:[NSNull null]]) {
            pendingMatches = [[snapshot.value allKeys] mutableCopy];
        }
        BOOL isPending = false;
        
        if(![pendingMatches isEqualToArray:@[]]) {
            for (int i = 0; i < pendingMatches.count; i++) {
                if([pendingMatches[i] isEqualToString:dataReference.authData.uid]) {
                    isPending = true;
                }
            }
        }
        
        if(isPending == true) {
            NSLog(@"Match Found!");
            Firebase *matchesRef = [[Firebase alloc] initWithUrl:[NSString stringWithFormat:@"%@/users/%@/matches/%@", rootURL, dataReference.authData.uid, [SummonerController sharedInstance].queried[0]]];
            [matchesRef setValue:@"match"];
            
            //Update other users matches
            Firebase *otherMatchesRef = [[Firebase alloc] initWithUrl:[NSString stringWithFormat:@"%@/users/%@/matches/%@", rootURL, [SummonerController sharedInstance].queried[0], dataReference.authData.uid]];
            [otherMatchesRef setValue:@"match"];

            //Update shared instance;
            NSMutableArray *newMatches = [NSMutableArray arrayWithArray:[SummonerController sharedInstance].matches];
            [newMatches addObject:[SummonerController sharedInstance].queried[0]];
            [[SummonerController sharedInstance] setMatches:newMatches];
            
                //Remove them from potential and you from their pending
                Firebase *removePotentialRef = [[Firebase alloc] initWithUrl:[NSString stringWithFormat:@"%@/users/%@/potentialMatches/%@", rootURL, dataReference.authData.uid, [SummonerController sharedInstance].queried[0]]];
                
            [removePotentialRef setValue:[NSNull null]];
                    
                    Firebase *removePendingRef = [[Firebase alloc] initWithUrl:[NSString stringWithFormat:@"%@/users/%@/pendingMatches/%@", rootURL, [SummonerController sharedInstance].queried[0], dataReference.authData.uid]];
            [removePendingRef setValue:[NSNull null]];
            
        }
        else {
            NSMutableArray *pendingMatches = [NSMutableArray arrayWithArray:[SummonerController sharedInstance].pendingMatches];
            [pendingMatches addObject:[SummonerController sharedInstance].queried[0]];
            [[SummonerController sharedInstance] setPendingMatches:pendingMatches];
            Firebase *pendingRef = [[Firebase alloc] initWithUrl:[NSString stringWithFormat:@"%@/users/%@/pendingMatches/%@", rootURL, dataReference.authData.uid, [SummonerController sharedInstance].queried[0]]];
            [pendingRef setValue:@"pending"];
            
            //Add to other users potentialMatches
            Firebase *potentialRef = [[Firebase alloc] initWithUrl:[NSString stringWithFormat:@"%@/users/%@/potentialMatches/%@", rootURL, [SummonerController sharedInstance].queried[0], dataReference.authData.uid]];
            [potentialRef setValue:@"potential"];
        }
        completion();

    }];
    
}

+ (void)cardSwipedLeftWithCompletion:(void (^)(void))completion {
    
}
//- (void)loadPotentialMatches{
//
//    Firebase *dataReference = [[Firebase allco] initWithUrl:rootURL];
//    [[dataReference childByAppendingPath:dataReference.authData.uid] childByAppendingPath:@"potentialMatches"];
//
//    dataReference observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
//        [SummonerController sharedInstance]. snapshot.value
//    }
//    
//}

@end
