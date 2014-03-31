//
//  ViewController.m
//  progressBar
//
//  Created by Erk Ekin on 11/03/14.
//  Copyright (c) 2014 mac. All rights reserved.
//

#import "ViewController.h"
#import "TableViewCell.h"
#import "AFNetworking.h"
#import "Model.h"

@interface ViewController () < UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIProgressView *progressView;
@property (strong, nonatomic) NSMutableArray * modelArray ;
@property (strong, nonatomic) IBOutlet UITableView * tableView;

@end

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.modelArray = [NSMutableArray  array];
    
    for (int i = 0; i<1000; i++) {
        
        Model* model= [[Model alloc] init];
        
        [self.modelArray addObject:model];
        
    }
    
    NSURL *url = [NSURL URLWithString:@"http://ios.anadolu.edu.tr/lab/getArray.php"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [responseObject enumerateObjectsUsingBlock:^(NSDictionary* dictionary, NSUInteger idx, BOOL *stop) {
            
            Model *mod=self.modelArray[idx];
            [mod setValue:dictionary[@"title"] forKey:@"title"];
            [mod setValue:dictionary[@"link"] forKey:@"link"];
            
        }];
        
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"hata  %@",error);
    }];
    
    [operation start];
    
    
}

- (TableViewCell *)bringCellOfModel:(Model *)model {
    NSUInteger  index =    [self.modelArray indexOfObject:model];
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    
    TableViewCell * cell = (TableViewCell*)[self.tableView cellForRowAtIndexPath:indexPath];
    return cell;
}

-(void)updateCellForModel:(Model*)model{
    
    TableViewCell *cell;
    cell = [self bringCellOfModel:model];
    
    if ( [[self.tableView visibleCells] containsObject:cell]) {
        
        cell.progressBar.progress = model.progress;
    }
    
}
#pragma mark TableView

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.modelArray.count;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"pass";
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    Model * model = self.modelArray[indexPath.row];
    
    cell.progressLabel.text = model.title;
    cell.progressBar.progress=model.progress;
    
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Model * model = self.modelArray[indexPath.row];
  
    if (model.isRunning){
       
        [model.operation cancel];
        model.progress = 0;
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        return;
        
    }
    NSURL *url = [NSURL URLWithString:model.link];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [model startDownload:request andVC:self];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
