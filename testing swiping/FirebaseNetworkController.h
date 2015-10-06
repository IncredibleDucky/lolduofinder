//
//  FirebaseNetworkController.h
//  testing swiping
//
//  Created by Mattthew Bailey on 9/2/15.
//  Copyright (c) 2015 Richard Kim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Summoner.h"
#import "Firebase/Firebase.h"

@interface FirebaseNetworkController : NSObject


+ (void)createUserWithEmail:(NSString *)email andPassword:(NSString *)password completion:(void (^)(void))completion;

+ (void)loginWithUserName:(NSString *)username password:(NSString *)password completion:(void (^)(void))completion;

+ (void)loadUsersPotentialMatches;

+ (void)grabPotentialMatches;

+ (void)loadSummonersWithUIDWithCompletion:(void (^)(void))completion;

+ (void)loadMatchesSummonersWithUIDAtIndex:(NSInteger)index WithCompletion:(void (^)(void))completion;

+ (void)updateUsersSummoner;

+ (void)queryForMatchesWithCompletion:(void (^)(void))completion;

+ (void)setPotentialMatch:(NSString *)matchUID;

+ (void)logout;

+ (void)cardSwipedRightWithCompletion:(void (^)(void))completion;

+ (void)cardSwipedLeftWithCompletion:(void (^)(void))completion;

@end
