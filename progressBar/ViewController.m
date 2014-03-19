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

#import "Model.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.array = [NSMutableArray  array];
    for (int i = 0; i<1000; i++) {
        
        Model* model= [[Model alloc] initWithBlock:^{
            
            [self showModel:nil];
            
        }];
        
              
        [self.array addObject:model];
        
        
    }
    [self.tableView reloadData];
    
}

- (IBAction)showModel:(id)sender {
    
    [self.array enumerateObjectsUsingBlock:^(Model * model, NSUInteger modelIndex, BOOL *stop) {
        if (model.progress>0) {
            
            [[self.tableView visibleCells] enumerateObjectsUsingBlock:^(TableViewCell* cell, NSUInteger idx, BOOL *stop) {
                
                if ([self.tableView indexPathForCell:cell].row == modelIndex) {
                    
                    cell.progressLabel.text =[NSString stringWithFormat:@"%.1f",model.progress] ;
                    cell.progressBar.progress = model.progress/1000;
                }
                
            }];
            
        }
    }];
    
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
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    Model * model = self.array[indexPath.row];
    cell.progressLabel.text =[NSString stringWithFormat:@"%.1f",model.progress] ;
    
    cell.progressBar.progress = model.progress/1000;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Model * model = self.array[indexPath.row];
    
    model.isRunning = ! model.isRunning;
    
    if (model.isRunning) {
        
        [model startTimer];
        
    }else{
        
        [model stopTimer:indexPath.row];
        
    }
    
    
}
@end
