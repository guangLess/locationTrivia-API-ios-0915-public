//
//  FISLocationsDataStore.m
//  locationTrivia-dataStore
//
//  Created by Joe Burgess on 6/23/14.
//  Copyright (c) 2014 Joe Burgess. All rights reserved.
//
//#import "FISLocation.h"
#import "FISTrivia.h"
#import "FISLocationsDataStore.h"
#import "FISAPIClient.h"

#import "FISAddLocationViewController.h"

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
    }
    return self;
}

-(void)getallLocationsWithCompletion:(void (^)(BOOL success))completionBlock{
    
    [FISAPIClient getTheLocationFromApiwithCompletionBlock:^(NSArray * locations) {
        
        for (NSDictionary * eachLocation in locations) {
            
            NSString * name = eachLocation[@"name"];
            NSNumber *latitude = eachLocation[@"latitude "];
            NSNumber *longitude = eachLocation[@"longitude"];
            NSNumber *location_id = eachLocation[@"id"];

            NSMutableArray * trivias = eachLocation[@"trivia"];
            
            FISLocation * eachLocation = [[FISLocation alloc] initWithName: name Latitude:latitude Longitude:longitude location_id:location_id];
            
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


-(void)addLocation:(FISLocation *)location{     
//    [FISAPIClient ] @{@"key":api_key,
//                      @"location[name]":@"India",
//                      @"location[latitude]":@983,
//                      @"location[longitude]":@432,
//                      };
    
    NSDictionary * locationAsD = @{@"key": api_key,
                                   @"location[name]":location.name,
                                   @"location[latitude]":location.latitude,
                                   @"location[longitude]":location.longitude,
                                   @"location[id]": location.location_id,
                                };
    
     [FISAPIClient postLocationsWithDetails:locationAsD withCompelationBlock:^(BOOL postLocation) {
         if (postLocation == YES){
             [self.locations addObject:location];
             NSLog(@"adding success %@",location.name);
         }else{
             NSLog(@"adding error ");
         }
     }];
}

-(void)deleteCell:(FISLocation *)location WithCompletion:(void (^)(BOOL success))completionBlock{
    
//    NSDictionary * locationAsD = @{@"key": api_key,
//                                   @"location[id]":location.location_id,
//                                   };
    
    NSString * idString = [location.location_id stringValue];
    
    [FISAPIClient deleteLocationsWithDetails:idString withCompelationBlock:^(BOOL postLocation) {
        if (postLocation == YES) {
            completionBlock(YES);
        }
    }];
}

@end
