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

+(void)postLocations{
    
    AFHTTPSessionManager * sessionManager = [AFHTTPSessionManager manager];
    NSDictionary * params = @{@"key":api_key,
                              @"location[name]":@"India",
                              @"location[latitude]":@983,
                              @"location[longitude]":@432,
                              };
    [sessionManager POST:@"http://locationtrivia.herokuapp.com/locations.json" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSLog(@"JSON: %@", responseObject);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
    }];
}

+(void)postTrvium{
    
    AFHTTPSessionManager * sessionManager = [AFHTTPSessionManager manager];
    NSDictionary * params = @{@"key":api_key,
                              @"trivium[content]": @"holly cow cuttieCow"
                              };
    NSString * travia = @"http://locationtrivia.herokuapp.com/locations/1251/trivia.json";
    
    [sessionManager POST:travia parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSLog(@"JSON: %@", responseObject);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
    }];
}

@end

