//
//  ViewController.m
//  progressBar
//
//  Created by mac on 11/03/14.
//  Copyright (c) 2014 mac. All rights reserved.
//

#import "ViewController.h"
#import "TableViewCell.h"
@interface ViewController ()

@end

@implementation ViewController
- (IBAction)click:(id)sender {
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.array = [NSMutableArray  array];
    for (int i = 0; i<10000; i++) {
        
        NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithDictionary:@{@"progress":@0.0,@"title":[NSString stringWithFormat:@"satir: %d",i]}];
        [self.array addObject:dict];
        
        
    }
    NSLog(@"erk %@",self.array);
    [self.tableView reloadData];
	// Do any additional setup after loading the view, typically from a nib.
    
}

- (IBAction)startCountWithCell:(TableViewCell*)cell {
    NSLog(@"çalıkıyor ");
  cell.myTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateUI) userInfo:nil repeats:YES];
   // cell.myTimer=[NSTimer timerWithTimeInterval:1 target:self selector:(updateUI) userInfo:nil repeats:YES];
}
-(void)updateDataStructureWithProgress:(NSNumber*)progress andIndex:(NSUInteger)index{
    NSMutableDictionary * obj = self.array[index];
    obj[@"progress"] = progress;
    
    
}
- (void)updateUI
{
    
   
    NSLog(@"asdasd");
//    static int count =0; count++;
//    
//    if (count <=10)
//    {
     //   cell.progressLabel.text = [NSString stringWithFormat:@"%f %%", [cell.myTimer timeInterval]];
//        cell.progressView.progress = (float)count/10.0f;
//    } else
//    {
//        [cell.myTimer invalidate];
//        cell.myTimer = nil;
//    }
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
    
    [cell.startButton addTarget:self action:@selector(startCountWithCell:) forControlEvents:UIControlEventTouchDown];
    
    
    /* if (cell == nil) {
     cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
     } */
    
    return cell;
}

@end
