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
#import <Foundation/NSObject.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.indexArray = [NSMutableArray  array];
    
    self.indexes=[NSArray array];
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


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // static NSString *CellIdentifier = @"pass";
    //  TableViewCell *cell =[[TableViewCell alloc] initWithStyle:<#(UITableViewCellStyle)#> reuseIdentifier:NSString "abc"];
    
    
    static NSString *CellIdentifier = @"pass";
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
 
    
    cell.progressLabel.text =[NSString stringWithFormat:@"qqqq %f",[self.array[indexPath.row][@"progress"] floatValue]] ;
    __block TableViewCell *blockcell = cell;
    
    
    [cell.startButton addEventHandler:^(UIButton * sender, UIEvent *event) {
        
        sender.selected = ! sender.selected;
        if (sender.selected) {
            
            [sender setTitle:@"Stop" forState:UIControlStateSelected];
       
            
            NSLog(@"%@",self.array[indexPath.row]);
            blockcell.myTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 block:^{
                float progress = [self.array[indexPath.row][@"progress"] floatValue] +1;
                [self updateDataStructureWithProgress:[NSNumber numberWithFloat:progress] andIndex:indexPath.row];
                NSString * string =  [  NSString stringWithFormat:@"e %f",progress] ;
                
                blockcell.progressLabel.text=string;
                
            } repeats:YES];
            
        }else{
      
            [sender setTitle:@"Start" forState:UIControlStateNormal];
            
            [blockcell.myTimer invalidate];
            
        }
        
        
    } forControlEvent:UIControlEventTouchUpInside];
    
    return cell;
}

- (IBAction)showModel:(id)sender {
    
    NSLog(@"erk %@",self.array);
    
    
    
}

@end
