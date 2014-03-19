    //
    //  Model.h
    //  progressBar
    //
    //  Created by Erk EKIN on 19/03/14.
    //  Copyright (c) 2014 mac. All rights reserved.
    //

#import <Foundation/Foundation.h>

@interface Model : NSObject

@property (readwrite) float progress;
@property (strong, nonatomic)  NSTimer * timer;
@property (strong, nonatomic)  NSRunLoop * runLoop;
@property (readwrite)  BOOL isRunning;

- (void)startTimer;
- (void)stopTimer:(int)index;
- (id)initWithBlock:(void (^)(void))blockName;

@end
