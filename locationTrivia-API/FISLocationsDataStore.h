//
//  FISLocationsDataStore.h
//  locationTrivia-dataStore
//
//  Created by Joe Burgess on 6/23/14.
//  Copyright (c) 2014 Joe Burgess. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FISLocation.h"

@interface FISLocationsDataStore : NSObject

@property (strong, nonatomic) NSMutableArray *locations;

+ (instancetype)sharedLocationsDataStore;
- (instancetype)init;

-(void)getallLocationsWithCompletion:(void (^)(BOOL success))completionBlock;
-(void)addLocation:(FISLocation *)location;
-(void)deleteCell:(FISLocation *)location WithCompletion:(void (^)(BOOL success))completionBlock; //command point move the blink!


@end
