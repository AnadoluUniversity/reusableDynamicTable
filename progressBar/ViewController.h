//
//  ViewController.h
//  progressBar
//
//  Created by mac on 11/03/14.
//  Copyright (c) 2014 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController < UITableViewDataSource, UITableViewDelegate>
 

- (IBAction)showModel:(id)sender;
   @property (nonatomic, strong) UIProgressView *progressView;
@property (strong, nonatomic) NSMutableArray * array ;
@property (strong, nonatomic) NSMutableArray * indexArray ;
@property (strong, nonatomic) IBOutlet UITableView * tableView;
@property (strong, nonatomic) NSArray * indexes ;
@property (strong, nonatomic) NSString * string ;
@property  (readwrite) int x ;
@property (nonatomic, strong) NSIndexPath *privateInt;
@end
