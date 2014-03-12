//
//  TableViewCell.h
//  progressBar
//
//  Created by mac on 11/03/14.
//  Copyright (c) 2014 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIButton *startButton;

@property (nonatomic, strong) IBOutlet UILabel *progressLabel;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) NSTimer *myTimer;
@property (readwrite) float percentage;
@end
