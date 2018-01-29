//
//  DetailViewController.m
//  TradeMeBrowser
//
//  Created by Ian Stewart on 27/01/2018.
//  Copyright © 2018 igstewart3. All rights reserved.
//

#import "DetailViewController.h"
#import "ListingViewController.h"
#import "ListingCollectionViewCell.h"
#import "RequestManager.h"
#import "Constants.h"

@interface DetailViewController ()

// All listings retrieved for this category
@property NSArray *listings;

@end

@implementation DetailViewController

- (void)configureView
{
    // Update the UI to reflect category details.
    if (self.detailItem != nil)
    {
        self.title = [self.detailItem valueForKey:kName];
        [self retrieveListings];
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // Configure initial layout
    [self configureView];
    
    // Retrieve listings to display
    [self retrieveListings];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Managing the detail item

- (void)setDetailItem:(NSDictionary *)newDetailItem
{
    _detailItem = newDetailItem;
        
    // Update the view.
    [self configureView];
}

#pragma mark - Collection View

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.listings.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // Dequeue cell and populate
    ListingCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionCell forIndexPath:indexPath];
    
    NSDictionary *object = self.listings[indexPath.row];
    cell.listingTitleLabel.text = [object valueForKey:kTitle];
    
    NSNumber *listingId = [object valueForKey:kListingId];
    cell.listingIdLabel.text = [listingId stringValue];
    
    // Show loading until image is ready
    cell.loadIndicator.hidden = NO;
    cell.noImageLabel.hidden = YES;
    
    NSString *imageUrl = [object valueForKey:kPictureHref];
    
    if(imageUrl != nil)
    {
        // Retrieve image thumbnail
        [[RequestManager sharedInstance] sendRequestToURL:imageUrl withCompletionHandler:^(NSData *imageData)
        {
            if(imageData != nil)
            {
                // Show image
                cell.listingImage.image = [UIImage imageWithData:imageData];
            }
            else
            {
                // Show no image label
                cell.noImageLabel.hidden = NO;
            }
            cell.loadIndicator.hidden = YES;
        }];
    }
    else
    {
        // Show no image label
        cell.loadIndicator.hidden = YES;
        cell.noImageLabel.hidden = NO;
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    // Setup listing view controller with selected listing
    ListingViewController *listingVC = [self.storyboard instantiateViewControllerWithIdentifier:kListingViewController];
    NSDictionary *object = self.listings[indexPath.row];
    [listingVC setListingItem:object];
    
    // Display listing
    [self.navigationController pushViewController:listingVC animated:YES];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    // Dequeue collection header
    UICollectionReusableView *header = [self.listingCollection dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kCollectionHeader forIndexPath:indexPath];
    
    // Only show header if there are listings present and subcategories being displayed
    header.hidden = !(self.listings != nil && self.listings.count);
    
    return header;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

#pragma Listings

-(void)retrieveListings
{
    if(self.detailItem == nil)
        return;
    
    // Retrieve category number
    NSString *categoryNumber = nil;
    NSObject *numberObject = [self.detailItem valueForKey:kNumber];
    if([numberObject isKindOfClass:[NSNumber class]])
    {
        categoryNumber = [((NSNumber*)numberObject) stringValue];
    }
    else if([numberObject isKindOfClass:[NSString class]])
    {
        categoryNumber = ((NSString*)numberObject);
    }
    else
    {
        // invalid object - no listings
        return;
    }
    
    // Request first 20 listings for category
    [[RequestManager sharedInstance] retrieveListingsForCategory:categoryNumber withCompletionHandler:^(NSDictionary *jsonData)
     {
         [self displayListings:jsonData];
     }];
}

-(void)displayListings:(NSDictionary *)jsonData
{
    if(jsonData != nil)
    {
        self.listings = [jsonData mutableArrayValueForKey:kList];
        [self.listingCollection reloadData];
    }
    
    // If no listings, hide listings collection
    if(self.listings == nil || self.listings.count == 0)
    {
        self.listingCollection.hidden = YES;
        
        UILabel *noResultsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.stackView.frame.size.width, 20)];
        noResultsLabel.text = kNoItemsText;
        noResultsLabel.textAlignment = NSTextAlignmentCenter;
        
        [self.stackView addSubview:noResultsLabel];
    }
}


@end
