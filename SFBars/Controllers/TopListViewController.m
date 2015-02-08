//
//  TopListViewController.m
//  SFBars
//
//  Created by JACKIE TRILLO on 1/30/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "TopListViewController.h"

@interface TopListViewController ()

@property (readwrite, nonatomic, strong) NSMutableArray* data;

@end

@implementation TopListViewController

static NSString* reuseIdentifier = @"Cell";
static NSString* serviceUrl = @"http://www.sanfranciscostreets.net/api/bars/bar/";

- (void)viewDidLoad {
    [super viewDidLoad];
    

    [self initNavigation];
    
    if (!self.appDelegate.cachedBars)
    {
        [self sendAsyncRequest:serviceUrl method:@"GET" accept:@"application/json"];
    }
    else
    {
        [self loadData: self.appDelegate.cachedBars];
    }

}

- (void)initNavigation {
    
    self.navigationItem.title = @"TOP LIST"; //TODO: localize
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)loadData: (NSMutableArray*) data {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    if (!self.appDelegate.cachedBars) {
        self.appDelegate.cachedBars = data;
    }
    
    self.tableView.hidden = NO;
    self.tableView.delegate = self;
    self.data = data;
    [self.tableView reloadData];
}

-(NSMutableArray*)parseData: (NSData*)responseData {
    
    NSError* errorData;
    NSArray* arrayData = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&errorData];
    
    if (errorData != nil) {
        //TODO: alert user
    }
    
    NSMutableArray* data = [[NSMutableArray alloc] init];
    if (arrayData.count > 0)
    {
        for (int i = 0; i < arrayData.count; i++)
        {
            NSDictionary* dictTemp = arrayData[i];
            Bar* bar = [Bar initFromDictionary:dictTemp];
            [data addObject:bar];
        }
    }
    return data;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch(section)
    {
        case 0:
            return [self.data count];
        default:
            return 0;
    }
}

-(void)setCellStyle:(UITableViewCell *)cell {
    
  //
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    switch(indexPath.section)
    {
        case 0:
            if (indexPath.row < self.data.count)
            {
                Bar* bar = (Bar*)[self.data objectAtIndex:indexPath.row];
                UILabel* ranklabel = (UILabel*)[cell viewWithTag:1];
                UILabel* namelabel = (UILabel*)[cell viewWithTag:2];
                UILabel* descriplabel = (UILabel*)[cell viewWithTag:3];
                
                NSInteger rank = indexPath.row + 1;
                ranklabel.text = [NSString stringWithFormat:@"%d", (int)rank];
                namelabel.text = bar.name;
                descriplabel.text = bar.descrip;
                
                [self setCellStyle:cell];
            }
            break;
    }
    
    return cell;
}


#pragma mark - Navigation

 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     
     if ([segue.destinationViewController isKindOfClass: [BarDetailsViewController class]]) {
         BarDetailsViewController* barDetailsViewController = segue.destinationViewController;
         NSIndexPath* indexPath =   [self.tableView indexPathForSelectedRow];
         barDetailsViewController.selectedBar = self.data[indexPath.row];
     }
 }

@end
