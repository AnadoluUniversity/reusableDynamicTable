    //
    //  ViewController.m
    //  progressBar
    //
    //  Created by Erk Ekin on 11/03/14.
    //  Copyright (c) 2014 mac. All rights reserved.
    //

#import "ViewController.h"
#import "TableViewCell.h"
#import "NSTimer+Blocks.h"

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
            
            [self updateUI];
            
        }];
        
        [self.array addObject:model];
        
    }
    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}

- (void)updateUI{
    
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

- (void)downloadLimitCheck:(Model *)model {
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"isRunning == 1"];
    int limit = 4;
    if ([self.array filteredArrayUsingPredicate:predicate].count>limit) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[NSString stringWithFormat:@"No more downloads than %d",limit] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert   show];
        model.isRunning = 0;
        return;
    }
    
}

#pragma mark TableView

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
        
        [self downloadLimitCheck:model];
        [model startTimer];
        
    }else{
        
        [model stopTimer:indexPath.row];
        
    }
    
    
}
@end
