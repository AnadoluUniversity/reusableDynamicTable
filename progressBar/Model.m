    //
    //  Model.m
    //  progressBar
    //
    //  Created by Erk EKIN on 19/03/14.
    //  Copyright (c) 2014 mac. All rights reserved.
    //

#import "Model.h"

@implementation Model

- (void)startDownload:(NSURLRequest*)request{
    __weak typeof(self) weakSelf = self;
 self.operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
     weakSelf.operation.responseSerializer = [AFImageResponseSerializer serializer];
    
    [ self.operation setDownloadProgressBlock:^(NSUInteger bytesRead, NSInteger totalBytesRead, NSInteger totalBytesExpectedToRead) {
        
        float progress = ((float)totalBytesRead) / totalBytesExpectedToRead;
      
        NSLog(@"%f",progress);
        
       weakSelf.progress=progress;
        
        
    }];
    
    [ self.operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        weakSelf.operation=nil;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];
    
    [ self.operation start];

}



- (id)initWithBlock:(void (^)(void))blockName
{ if (self = [super init]) {
    
        self.progress = 0;
        self.isRunning = NO;    
        self.link= @"";
        self.title= @"";
        self.runLoop = [NSRunLoop currentRunLoop];

}
    return self;
}



@end
