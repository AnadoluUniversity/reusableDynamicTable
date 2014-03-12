//
//  ViewController.m
//  progressBar
//
//  Created by mac on 11/03/14.
//  Copyright (c) 2014 mac. All rights reserved.
//

#import "ViewController.h"
#import "TableViewCell.h"
#import "NSTimer+Blocks.h"
#import "UIControl-JTTargetActionBlock.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.array = [NSMutableArray  array];
    for (int i = 0; i<1000; i++) {
        
            NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithDictionary:@{@"progress":@0.0,
                                                                                     @"title":[NSString stringWithFormat:@"satir: %d",i]
                                                                                         }];
        [self.array addObject:dict];
        
        
    }
    [self.tableView reloadData];
	// Do any additional setup after loading the view, typically from a nib.
    
}

-(void)updateDataStructureWithProgress:(NSNumber*)progress andIndex:(NSUInteger)index{
    NSMutableDictionary * obj = self.array[index];
    obj[@"progress"] = progress;
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"pass";
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    __block TableViewCell *blockcell = cell;
    
    [cell.startButton addEventHandler:^(id sender, UIEvent *event) {
        
        blockcell.myTimer = [NSTimer scheduledTimerWithTimeInterval:1 block:^{
            
            NSLog(@"asdasd %f",blockcell.percentage++);
            
            [self updateDataStructureWithProgress:[NSNumber numberWithFloat:blockcell.percentage] andIndex:indexPath.row];
            
        } repeats:YES];
    } forControlEvent:UIControlEventTouchUpInside];
    
    
    
    /* if (cell == nil) {
     cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
     } */
    
    return cell;
}

- (IBAction)showModel:(id)sender {
    
    
    NSLog(@"erk %@",self.array);
}
@end
