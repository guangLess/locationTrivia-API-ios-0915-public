//
//  FISAPIClient.m
//  locationTrivia-API
//
//  Created by James Campagno on 7/13/15.
//  Copyright (c) 2015 Joe Burgess. All rights reserved.
//

#import "FISAPIClient.h"
//#import <AFNetworking/AFHTTPRequestOperationManager.h>
#import <AFNetworking/UIKit+AFNetworking.h> 
#import <AFNetworking/AFNetworking.h>

// note : locations.json gaves back the json, when just locations it does not read

NSString * const api_key = @"29a7c25f985174cc828695e7812b5681543f9ccf";
NSString * const base_url = @"http://locationtrivia.herokuapp.com/locations.json";

@implementation FISAPIClient


+(void)getTheLocationFromApiwithCompletionBlock:(void (^)(NSArray *))locations{
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    NSDictionary *params = @{@"key": api_key};
    
    [sessionManager GET:@"http://locationtrivia.herokuapp.com/locations.json?" parameters:params success:^(NSURLSessionDataTask * task, id responseObject) {
        //NSLog(@"JSON: %@", responseObject);
        locations(responseObject);
    } failure:^(NSURLSessionDataTask * task, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

+(void)postLocationsWithDetails:(NSDictionary *)locationInfo withCompelationBlock:(void (^)(BOOL postLocation))compelationBlock{
    
    AFHTTPSessionManager * sessionManager = [AFHTTPSessionManager manager];
    //NSDictionary *params = @{@"key": api_key};
//    
//   NSDictionary *params = @{@"key":api_key,
//      @"location[name]":@"testOne",
//      @"location[latitude]":@983,
//      @"location[longitude]":@432,
//                            };
    NSDictionary * params = locationInfo;

    [sessionManager POST:@"http://locationtrivia.herokuapp.com/locations.json" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        compelationBlock(YES);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
    }];
}

+(void)deleteLocationsWithDetails:(NSString *)locationID withCompelationBlock:(void (^)(BOOL postLocation))compelationBlock{
    AFHTTPSessionManager * sessionmanager = [AFHTTPSessionManager manager];
    
    NSDictionary * params = @{@"key": api_key};

    NSString * apiString = [NSString stringWithFormat: @"http://locationtrivia.herokuapp.com/locations/%@.json",locationID];
    [sessionmanager DELETE:apiString parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject)
     {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSLog(@"deleteLocation statusCode %lu", response.statusCode);
        compelationBlock(YES);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@" deleting location failed");
    }];
}

+(void)postTrvium:(NSString *)trviaContent withCompelationBloack:(void (^)(BOOL postTravia))compelationBloack{
    AFHTTPSessionManager * sessionManager = [AFHTTPSessionManager manager];
   
    NSDictionary * params = @{@"key":api_key,
                              @"trivium[content]": trviaContent,
                              };
    NSString * travia = @"http://locationtrivia.herokuapp.com/locations/1251/trivia.json";
    
    [sessionManager POST:travia parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSLog(@"JSON: %@", responseObject);
        compelationBloack(YES);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
    }];
}

@end

