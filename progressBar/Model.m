//
//  Model.m
//  progressBar
//
//  Created by Erk EKIN on 19/03/14.
//  Copyright (c) 2014 mac. All rights reserved.
//

#import "Model.h"

@implementation Model

- (id)init

{
    if (self = [super init]) {
    
    self.progress = 0;
    self.isRunning = NO;
    self.link= @"";
    self.title= @"";
    
}
    return self;
}

- (void)startDownload:(NSURLRequest*)request andVC:(ViewController*)vc{
    self.isRunning = YES;
    
    __weak typeof(self) weakSelf = self;
    self.operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    weakSelf.operation.responseSerializer = [AFImageResponseSerializer serializer];
    
    [ self.operation setDownloadProgressBlock:^(NSUInteger bytesRead, NSInteger totalBytesRead, NSInteger totalBytesExpectedToRead) {
        
        float progress = ((float)totalBytesRead) / totalBytesExpectedToRead;
        
        weakSelf.progress=progress;
        
        [vc updateCellForModel:weakSelf];
        
    }];
    
    [self.operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        weakSelf.operation=nil;
        weakSelf.isRunning = NO;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        weakSelf.isRunning = NO;
        
    }];
    
    [self.operation start];
    
}


@end
