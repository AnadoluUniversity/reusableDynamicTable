    //
    //  Model.h
    //  progressBar
    //
    //  Created by Erk EKIN on 19/03/14.
    //  Copyright (c) 2014 mac. All rights reserved.
    //

#import "AFNetworking.h"
#import "ViewController.h"

@interface Model : NSObject

@property (readwrite) float progress;

@property (strong, nonatomic)  NSRunLoop * runLoop;
@property (strong, nonatomic)  AFHTTPRequestOperation *operation;
@property (readwrite)  BOOL isRunning;
@property (readwrite) NSString *title;
@property (readwrite) NSString *link;

- (void)startDownload:(NSURLRequest*)request andVC:(ViewController*)vc;
- (id)initWithBlock:(void (^)(void))blockName;

@end
