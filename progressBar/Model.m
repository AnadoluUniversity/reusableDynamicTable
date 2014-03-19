    //
    //  Model.m
    //  progressBar
    //
    //  Created by Erk EKIN on 19/03/14.
    //  Copyright (c) 2014 mac. All rights reserved.
    //

#import "Model.h"
#import "NSTimer+Blocks.h"

@implementation Model

- (id)initWithBlock:(void (^)(void))blockName
{
  if (self = [super init]) {
        
        NSTimer * timer = [NSTimer timerWithTimeInterval:0.1 block:^{
            blockName();
            self.progress++;
            
        } repeats:YES];
        
        self.progress = 0;
        self.isRunning = NO;
        self.timer = timer;
        self.runLoop = [NSRunLoop currentRunLoop];

    }
    return self;
}

-(void)startTimer{
  
    [self.runLoop addTimer:self.timer forMode:NSDefaultRunLoopMode];
    
}

-(void)stopTimer:(int)index{
    [self.timer invalidate];
    
    self.timer = [NSTimer timerWithTimeInterval:0.1 block:^{
        
        self.progress++;
        
    } repeats:YES];
    
}


@end
