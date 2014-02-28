//
//  TableViewController.m
//  teste
//
//  Created by Lucas Salton Cardinali on 2/28/14.
//  Copyright (c) 2014 Lucas Salton Cardinali. All rights reserved.
//

#import "TableViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "UIImageView+WebCache.h"

@interface TableViewController () {
    NSMutableArray *_objects;
}

@end

@implementation TableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"https://gdata.youtube.com/feeds/api/videos?author=Qu4troCoisas&v=2&max-results=10&alt=jsonc&orderby=published" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        _objects = [[responseObject objectForKey:@"data"]objectForKey:@"items"];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
   // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    [cell.imageView setImageWithURL: [NSURL URLWithString: [[[_objects objectAtIndex: indexPath.row] objectForKey: @"thumbnail"] objectForKey: @"sqDefault"]]
      placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
   
   
    cell.textLabel.text = [[_objects objectAtIndex: indexPath.row] objectForKey: @"title"];
    
    return cell;
}



@end
