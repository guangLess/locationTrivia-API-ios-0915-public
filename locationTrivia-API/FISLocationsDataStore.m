//
//  FISLocationsDataStore.m
//  locationTrivia-dataStore
//
//  Created by Joe Burgess on 6/23/14.
//  Copyright (c) 2014 Joe Burgess. All rights reserved.
//
#import "FISLocation.h"
#import "FISTrivia.h"
#import "FISLocationsDataStore.h"
#import "FISAPIClient.h"

@implementation FISLocationsDataStore


+ (instancetype)sharedLocationsDataStore {
    static FISLocationsDataStore *_sharedLocationsDataStore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedLocationsDataStore = [[FISLocationsDataStore alloc] init];
    });

    return _sharedLocationsDataStore;
}


-(instancetype)init
{
    self = [super init];
    if (self) {
        self.locations = [[NSMutableArray alloc]init];
        //[self getallLocations];
    }
    return self;
}

-(void)getallLocationsWithCompletion:(void (^)(BOOL success))completionBlock{
    
    [FISAPIClient getTheLocationFromApiwithCompletionBlock:^(NSArray * locations) {
        
        for (NSDictionary * eachLocation in locations) {
            
            NSString * name = eachLocation[@"name"];
            NSNumber *latitude = eachLocation[@"latitude "];
            NSNumber *longitude = eachLocation[@"longitude"];
            NSMutableArray * trivias = eachLocation[@"trivia"];
            
            FISLocation * eachLocation = [[FISLocation alloc] initWithName: name Latitude:latitude Longitude:longitude];
            
            NSMutableArray * manyTrivia = [NSMutableArray new];
            for (NSDictionary * eachTrivia in trivias) {
                NSString * content = eachTrivia[@"content"];
                FISTrivia * trivia = [[FISTrivia alloc] initWithContent:content Likes:333];
                [manyTrivia addObject:trivia];
            }
            eachLocation.trivia = manyTrivia;
            [self.locations addObject:eachLocation];
        }
        
        completionBlock(YES);
    }];
}


@end
