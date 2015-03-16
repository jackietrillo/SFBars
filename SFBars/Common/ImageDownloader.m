//
//  ImageDownloader.m
//  SFBars
//
//  Created by JACKIE TRILLO on 1/21/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "ImageDownloader.h"
#import "BaseEntity.h"

#define kAppIconSize 300

@interface ImageDownloader ()

@property (nonatomic, strong) NSMutableData *activeDownload;
@property (nonatomic, strong) NSURLConnection *imageConnection;

@end

@implementation ImageDownloader

static NSString* serviceUrl = @"http://www.sanfranciscostreets.net/images/";

- (void)startDownload {
    self.activeDownload = [NSMutableData data];
    
    NSString* imageDownloadUrl = [serviceUrl stringByAppendingString:self.entity.imageUrl];
    imageDownloadUrl = [imageDownloadUrl stringByReplacingOccurrencesOfString: @ ".png" withString: @ "@2x.png"];
    
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:imageDownloadUrl]];
    
    NSURLConnection* connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    self.imageConnection = connection;
}

- (void)cancelDownload {
    [self.imageConnection cancel];
    self.imageConnection = nil;
    self.activeDownload = nil;
}

#pragma mark - NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.activeDownload appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    self.activeDownload = nil;
    self.imageConnection = nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    UIImage *image = [[UIImage alloc] initWithData:self.activeDownload];
    
    if (image == nil) {
        self.entity.icon = nil;
        return;
    }
    if (image.size.width != kAppIconSize || image.size.height != kAppIconSize) {
        CGSize itemSize = CGSizeMake(kAppIconSize, kAppIconSize);
        UIGraphicsBeginImageContextWithOptions(itemSize, NO, 0.0f);
        CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
        [image drawInRect:imageRect];
        self.entity.icon = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    else {
        self.entity.icon = image;
    }
    
    self.activeDownload = nil;
    self.imageConnection = nil;
    
    if (self.completionHandler) {
        self.completionHandler();
    }
}

@end

