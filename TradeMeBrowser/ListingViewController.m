//
//  ListingViewController.m
//  TradeMeBrowser
//
//  Created by Ian Stewart on 27/01/2018.
//  Copyright © 2018 igstewart3. All rights reserved.
//

#import "ListingViewController.h"
#import "RequestManager.h"
#import "Constants.h"

@interface ListingViewController ()

@end

@implementation ListingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Reset details to sensible defaults
    [self clearDetails];
    
    // Display initial details
    [self displayInitialListingDetails];
    
    // Retievee full details
    [self retrieveFullDetails];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clearDetails
{
    self.nameLabel.text = kItemNameText;
    self.idLabel.text = kItemIdText;
    self.priceLabel.text = kItemPriceText;
    self.mainImage.image = nil;
    self.noImageLabel.hidden = YES;
    self.loadIndicator.hidden = NO;
}

- (void)displayInitialListingDetails
{
    self.nameLabel.text = [self.listingItem valueForKey:kTitle];
    
    NSNumber *listingId = [self.listingItem valueForKey:kListingId];
    self.idLabel.text = [NSString stringWithFormat:kShowIdText, [listingId stringValue]];
    
    self.priceLabel.text = [self.listingItem valueForKey:kPriceDisplay];
}

- (void)retrieveFullDetails
{
    NSNumber *listingId = [self.listingItem valueForKey:kListingId];
    
    // Request full listing details
    [[RequestManager sharedInstance] retrieveListingForID:listingId withCompletionHandler:^(NSDictionary *jsonData)
     {
         [self displayListingDetails:jsonData];
     }];
}

- (void)displayListingDetails:(NSDictionary *)listingDetails
{
    if(listingDetails != nil)
    {
        // Retrieve full size photos
        NSArray *photoArray = [listingDetails valueForKey:kPhotos];
        if(photoArray != nil && photoArray.count > 0)
        {
            NSDictionary *photo = photoArray[0];
            NSDictionary *value = [photo objectForKey:kValue];
            NSString* imageUrl = [value objectForKey:kFullSize];
            
            // Retrieve image in background
            [[RequestManager sharedInstance] sendRequestToURL:imageUrl withCompletionHandler:^(NSData *imageData)
            {
                [self setupImage:imageData];
            }];
        }
        else
        {
            [self setupImage:nil];
        }
    }
}

- (void)setupImage:(NSData *)imageData
{
    // Display image if present, otherwise label
    if(imageData != nil)
    {
        self.mainImage.image = [UIImage imageWithData:imageData];
        self.loadIndicator.hidden = YES;
    }
    else
    {
        self.noImageLabel.hidden = NO;
        self.loadIndicator.hidden = YES;
    }
}

@end
