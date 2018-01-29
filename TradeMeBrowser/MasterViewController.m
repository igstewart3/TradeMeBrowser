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
@property BOOL Remove;

@end

@implementation MasterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Handle tree of categories up to 50 subcategories
    self.categories = [[NSMutableArray alloc] initWithCapacity:50];
    
    // Get all categories
    [self retrieveCategories];
    
    _Remove = YES;
    
    // Set up detail view
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backButtonPressed:(id)sender
{
    if(_Remove)
    {
        [self.categories removeObjectAtIndex:(self.categories.count - 1)];
    }
    else
    {
        _Remove = YES;
    }
    [self.tableView reloadData];
    NSDictionary *previous = self.categories[(self.categories.count - 1)];
    self.detailViewController.detailItem = previous;
    
    if(self.categories.count == 1)
    {
        self.navigationItem.leftBarButtonItem = nil;
    }
}

- (void)detailBackButtonPressed:(id)sender
{
    self.detailViewController.navigationItem.leftBarButtonItem = nil;
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.categories != nil && self.categories.count > 0)
    {
        NSDictionary *object = self.categories[self.categories.count - 1];
        NSMutableArray *currentCategories = [object valueForKey:kSubcategories];
        return currentCategories.count;
    }
    else
    {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCell forIndexPath:indexPath];

    // Set category name as cell label
    NSDictionary *object = self.categories[self.categories.count - 1];
    NSMutableArray *subcategories = [object valueForKey:kSubcategories];
    NSDictionary *subcategory = subcategories[indexPath.row];
    cell.textLabel.text = [subcategory valueForKey:kName];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Set back button
    if(self.navigationItem.leftBarButtonItem == nil)
    {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:kBack style:UIBarButtonItemStylePlain target:self action:@selector(backButtonPressed:)];
    }
    
    NSUInteger categoryCount = self.categories.count - 1;
    
    // Set category for detail view
    NSDictionary *object = self.categories[categoryCount];
    NSMutableArray *subcategories = [object valueForKey:kSubcategories];
    NSDictionary *nextObject = subcategories[indexPath.row];
    
    [self.detailViewController setDetailItem:nextObject];
    NSMutableArray *nextSubcategories = [nextObject valueForKey:kSubcategories];
    if(nextSubcategories != nil)
    {
        [self.categories insertObject:nextObject atIndex:++categoryCount];
        [self.tableView reloadData];
    }
    else
    {
        _Remove = NO;
        if(self.splitViewController.isCollapsed)
        {
            [self.navigationController pushViewController:self.detailViewController animated:YES];
            self.detailViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:kBack style:UIBarButtonItemStylePlain target:self action:@selector(detailBackButtonPressed:)];
        }
        else
        {
            self.splitViewController.preferredDisplayMode = UISplitViewControllerDisplayModePrimaryHidden;
        }
    }
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
        [self.categories removeAllObjects];
        self.navigationItem.leftBarButtonItem = nil;
        [self.categories insertObject:jsonData atIndex:0];
        [self.tableView reloadData];
        self.detailViewController.detailItem = jsonData;
    }
}

@end
