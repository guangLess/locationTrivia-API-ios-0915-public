//
//  FISAPIClient.h
//  locationTrivia-API
//
//  Created by James Campagno on 7/13/15.
//  Copyright (c) 2015 Joe Burgess. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FISAPIClient : NSObject

extern NSString * const api_key; 
extern NSString * const base_url;


+(void)getTheLocationFromApiwithCompletionBlock:(void (^)(NSArray *))locations;

+(void)postLocations;

+(void)postTrvium;

@end
