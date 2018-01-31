//
//  DetailViewController.h
//  TradeMeBrowser
//
//  Created by Ian Stewart on 27/01/2018.
//  Copyright © 2018 igstewart3. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>

// Category to display
@property (strong, nonatomic) NSDictionary *detailItem;

// Set to true if details are being pushed by master view controller.
@property (nonatomic, assign) BOOL masterPush;

// UI Outlets
@property (weak, nonatomic) IBOutlet UICollectionView *listingCollection;
@property (weak, nonatomic) IBOutlet UILabel *noItemsLabel;

@end

