//
//  MasterViewController.m
//  TradeMeBrowser
//
//  Created by Ian Stewart on 27/01/2018.
//  Copyright © 2018 igstewart3. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "RequestManager.h"
#import "Constants.h"

@interface MasterViewController ()

// All categories
@property NSMutableArray *categories;

@end

@implementation MasterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}


- (void)viewWillAppear:(BOOL)animated
{
    // Get full category list to display
    [self retrieveCategories];
    
    [super viewWillAppear:animated];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.categories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCell forIndexPath:indexPath];

    // Set category name as cell label
    NSDictionary *object = self.categories[indexPath.row];
    cell.textLabel.text = [object valueForKey:kName];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *detailVC = [self.storyboard instantiateViewControllerWithIdentifier:kDetailViewController];
    
    // Set category for detail view
    NSDictionary *object = self.categories[indexPath.row];
    [detailVC setDetailItem:object];
    
    // Display detail view for selected category
    [self.navigationController pushViewController:detailVC animated:YES];
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

#pragma Categories

-(void)retrieveCategories
{
    // Retrieve categories from server and display
    [[RequestManager sharedInstance] retrieveAllCategoriesWithCompletionHandler:^(NSDictionary *jsonData)
     {
         [self displayCategories:jsonData];
     }];
}

-(void)displayCategories:(NSDictionary *)jsonData
{
    if(jsonData != nil)
    {
        // Pull categories from subcategories value
        self.categories = [jsonData mutableArrayValueForKey:kSubcategories];
        [self.tableView reloadData];
    }
}

@end
