//
//  ConnectionHelper.m
//  SanFranciscoStreets
//
//  Created by JACKIE TRILLO on 11/13/14.
//  Copyright (c) 2014 JACKIE TRILLO. All rights reserved.
//

#import "ConnectionHelper.h"

@interface ConnectionHelper()

@end;

@implementation ConnectionHelper

-(NSData*) sendSyncRequest: (NSString*)url method:(NSString*)method accept: (NSString*)accept
{
    NSMutableURLRequest* urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
  
    [urlRequest setHTTPMethod:method];
    [urlRequest setValue:accept forHTTPHeaderField:@"Accept"];
    
    NSError* error;
    NSURLResponse* response;
    NSData* data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse: &response error:&error];
    
    return data;
}

-(NSData*) sendAsyncRequest: (NSString*)url method:(NSString*)method accept: (NSString*)accept
{
    NSURL* urlString = [NSURL URLWithString:url];
    
    //setup request
    NSMutableURLRequest* urlRequest = [NSMutableURLRequest requestWithURL:urlString];
  
    //application/json
    [urlRequest setValue:accept forHTTPHeaderField:@"Accept"];
   
    //GET POST
    [urlRequest setHTTPMethod:method];
   
    NSData* theData;
    NSOperationQueue* queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest queue: queue completionHandler:^(NSURLResponse* response, NSData* data, NSError* connectionError)
    {
        if (connectionError == nil)
        {
           // theData = data;
        }
    }];
    
    return theData;
}


@end
