//
//  BarsGateway.m
//  SFBars
//
//  Created by JACKIE TRILLO on 2/22/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "BarsGateway.h"

@interface BarsGateway()

@property (readwrite, nonatomic, strong) NSArray* bars;
@property (readwrite, nonatomic, strong) NSArray* barTypes;
@property (readwrite, nonatomic, strong) NSArray* districts;
@property (readwrite, nonatomic, strong) NSArray* parties;
@property (readwrite, nonatomic, strong) NSArray* events;
@property (readwrite, nonatomic, strong) NSArray* musicTypes;

@end

@implementation BarsGateway

static NSString* kGET = @"GET";
static NSString* kJSON = @"JSON";
static NSString* kAccept = @"Accept";

static NSString* kBarServiceUrl = @"http://www.sanfranciscostreets.net/api/bars/bar/";
static NSString* kDistrictServiceUrl = @"http://www.sanfranciscostreets.net/api/bars/district/";
static NSString* kBarTypeServiceUrl = @"http://www.sanfranciscostreets.net/api/bars/barType/";
static NSString* kMusicTypeServiceUrl = @"http://www.sanfranciscostreets.net/api/bars/musicType/";
static NSString* kEventServiceUrl = @"http://www.sanfranciscostreets.net/api/bars/event/";
static NSString* kPartyServiceUrl = @"http://www.sanfranciscostreets.net/api/bars/party/";

-(id)init {
    self = [super init];
    
    return self;
}

-(void)dealloc {
    self.bars = nil;
    self.barTypes = nil;
    self.districts = nil;
    self.parties = nil;
    self.events = nil;
    self.musicTypes = nil;
}

-(void)getBars:(BarsGatewayCompletionHandler) completionHandler {
    
    if (!self.bars) {
        
        NSMutableURLRequest* urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:kBarServiceUrl]];
        
        [urlRequest setHTTPMethod:kGET];
        [urlRequest setValue:kJSON forHTTPHeaderField:kAccept];
        
        NSOperationQueue* queue = [[NSOperationQueue alloc] init];
        
        [NSURLConnection sendAsynchronousRequest:urlRequest queue: queue
            completionHandler:^(NSURLResponse* response, NSData* data, NSError* connectionError) {
               
               if (!connectionError && data) {
                   
                   NSArray* barsArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                  
                   NSMutableArray* bars = [[NSMutableArray alloc] init];
                   
                   if (barsArray.count > 0) {
                       for (int i = 0; i < barsArray.count; i++) {
                           NSDictionary* dictTemp = barsArray[i];
                           Bar* bar = [Bar initFromDictionary:dictTemp];
                           [bars addObject:bar];
                       }
                   }
                   self.bars  = [bars copy];
               }
               
               dispatch_async(dispatch_get_main_queue(), ^{
                   
                   if (completionHandler) {
                       completionHandler(self.bars);
                   }
                   
               });
            }];
    } else {
        if (completionHandler) {
            completionHandler(self.bars);
        }
    }
}

-(void)getBarTypes:(BarsGatewayCompletionHandler) completionHandler {
    
    if (!self.barTypes) {
        NSMutableURLRequest* urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:kBarTypeServiceUrl]];

        [urlRequest setHTTPMethod:kGET];
        [urlRequest setValue:kJSON forHTTPHeaderField:kAccept];

        NSOperationQueue* queue = [[NSOperationQueue alloc] init];

        [NSURLConnection sendAsynchronousRequest:urlRequest queue: queue
            completionHandler:^(NSURLResponse* response, NSData* data, NSError* connectionError) {
            
            if (!connectionError && data) {

                 NSArray* barTypesArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                 NSMutableArray* barTypes = [[NSMutableArray alloc] init];
                 
                 if (barTypesArray.count > 0) {
                     for (int i = 0; i < barTypesArray.count; i++) {
                         NSDictionary* dictTemp = barTypesArray[i];
                         BarType* barType = [BarType initFromDictionary:dictTemp];
                         [barTypes addObject:barType];
                     }
                 }
                 self.barTypes  = [barTypes copy];
            }

            dispatch_async(dispatch_get_main_queue(), ^{
                
                 if (completionHandler) {
                     completionHandler(self.barTypes);
                 }
             
             });
         }];
    } else {
        if (completionHandler) {
            completionHandler(self.barTypes);
        }
    }
}

-(void)getDistricts:(BarsGatewayCompletionHandler) completionHandler {
    
    if (!self.districts) {
        NSMutableURLRequest* urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:kDistrictServiceUrl]];
        
        [urlRequest setHTTPMethod:kGET];
        [urlRequest setValue:kJSON forHTTPHeaderField:kAccept];
        
        NSOperationQueue* queue = [[NSOperationQueue alloc] init];
        
        [NSURLConnection sendAsynchronousRequest:urlRequest
                                           queue: queue
                               completionHandler:^(NSURLResponse* response, NSData* data, NSError* connectionError) {
             
              if (!connectionError && data) {
                  
                 NSArray* districtsAray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                
                  NSMutableArray* districts = [[NSMutableArray alloc] init];
                 
                 if (districtsAray.count > 0) {
                     for (int i = 0; i < districtsAray.count; i++) {
                         NSDictionary* dictTemp = districtsAray[i];
                         District* district = [District initFromDictionary:dictTemp];
                         [districts addObject:district];
                     }
                 }
                 self.districts  = [districts copy];
             }
    
             dispatch_async(dispatch_get_main_queue(), ^{
                 
                if (completionHandler) {
                     completionHandler(self.districts);
                 }
             });
         }];
    } else {
        if (completionHandler) {
            completionHandler(self.districts);
        }
    }
}

-(void)getMusicTypes:(BarsGatewayCompletionHandler) completionHandler {
    
    if (!self.musicTypes) {
        
        NSMutableURLRequest* urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:kMusicTypeServiceUrl]];
        
        [urlRequest setHTTPMethod:kGET];
        [urlRequest setValue:kJSON forHTTPHeaderField:kAccept];
        
        NSOperationQueue* queue = [[NSOperationQueue alloc] init];
        
        [NSURLConnection sendAsynchronousRequest:urlRequest queue: queue
                               completionHandler:^(NSURLResponse* response, NSData* data, NSError* connectionError) {
                                   
               if (!connectionError && data) {
                   
                   NSArray* musicTypesArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                  
                   NSMutableArray* musicTypes = [[NSMutableArray alloc] init];
                   
                   if (musicTypesArray.count > 0) {
                       for (int i = 0; i < musicTypesArray.count; i++) {
                           NSDictionary* dictTemp = musicTypesArray[i];
                           MusicType* musicType = [MusicType initFromDictionary:dictTemp];
                           [musicTypes addObject:musicType];
                       }
                   }
                   
                   self.musicTypes  = [musicTypes copy];
               }
               
               dispatch_async(dispatch_get_main_queue(), ^{
                   
                   if (completionHandler) {
                       completionHandler(self.musicTypes);
                   }
               });
           }];
    } else {
        if (completionHandler) {
            completionHandler(self.musicTypes);
        }
    }
}

-(void)getParties:(BarsGatewayCompletionHandler) completionHandler {
    
    if (!self.parties) {
        
        NSMutableURLRequest* urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:kPartyServiceUrl]];
        
        [urlRequest setHTTPMethod:kGET];
        [urlRequest setValue:kJSON forHTTPHeaderField:kAccept];
        
        NSOperationQueue* queue = [[NSOperationQueue alloc] init];
        
        [NSURLConnection sendAsynchronousRequest:urlRequest queue: queue
            completionHandler:^(NSURLResponse* response, NSData* data, NSError* connectionError) {
               
                if (!connectionError && data) {
                   
                    NSArray* partiesArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                    NSMutableArray* parties = [[NSMutableArray alloc] init];

                    if (partiesArray.count > 0) {
                       for (int i = 0; i < partiesArray.count; i++) {
                           NSDictionary* dictTemp = partiesArray[i];
                           Party* musicType = [Party initFromDictionary:dictTemp];
                           [parties addObject:musicType];
                       }
                    }

                    self.parties  = [parties copy];
                }

                dispatch_async(dispatch_get_main_queue(), ^{
                   
                   if (completionHandler) {
                       completionHandler(self.parties);
                   }
                });
            }];
    } else {
        if (completionHandler) {
            completionHandler(self.parties);
        }
    }
}

-(void)getEvents:(BarsGatewayCompletionHandler) completionHandler {
    
    if (!self.events) {
        
        NSMutableURLRequest* urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:kEventServiceUrl]];
        
        [urlRequest setHTTPMethod:kGET];
        [urlRequest setValue:kJSON forHTTPHeaderField:kAccept];
        
        NSOperationQueue* queue = [[NSOperationQueue alloc] init];
        
        [NSURLConnection sendAsynchronousRequest:urlRequest queue: queue
            completionHandler:^(NSURLResponse* response, NSData* data, NSError* connectionError) {

                if (!connectionError && data) {
                   
                   NSArray* eventsArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                   NSMutableArray* events = [[NSMutableArray alloc] init];
                   
                   if (eventsArray.count > 0) {
                       for (int i = 0; i < eventsArray.count; i++) {
                           NSDictionary* dictTemp = eventsArray[i];
                           Event* event = [Event initFromDictionary:dictTemp];
                           [events addObject:event];
                       }
                   }
                   
                   self.events  = [events copy];
                }

                dispatch_async(dispatch_get_main_queue(), ^{
                   
                   if (completionHandler) {
                       completionHandler(self.events);
                   }
                });
            }];
    } else {
        if (completionHandler) {
            completionHandler(self.events);
        }
    }
}

@end
