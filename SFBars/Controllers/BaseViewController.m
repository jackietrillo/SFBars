//
//  BaseViewController.m
//  SFBars
//
//  Created by JACKIE TRILLO on 2/7/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

static NSString* reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)sendAsyncRequest: (NSString*)url method:(NSString*)method accept: (NSString*)accept {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSMutableURLRequest* urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    [urlRequest setHTTPMethod:method];
    [urlRequest setValue:accept forHTTPHeaderField:@"Accept"];
    
    NSOperationQueue* queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest
                                       queue: queue
                           completionHandler:^(NSURLResponse* response, NSData* data, NSError* connectionError)
     {
         NSMutableArray* arrayData;
         if (connectionError == nil && data != nil) {
             arrayData = [self parseData:data];
         }
         else {
             //TODO: handle error
         }
         
         dispatch_async(dispatch_get_main_queue(), ^{
             
             if (arrayData != nil) {
                 [self loadData: arrayData];
             }
             else {
                //TODO: handle error
             }
         });
         
     }];
}

//TODO: put in a protocol
-(NSMutableArray*)parseData: (NSData*)responseData {
    return nil;
}

//TODO: put in a protocol
-(void)loadData: (NSMutableArray*) data {
   
}
@end
