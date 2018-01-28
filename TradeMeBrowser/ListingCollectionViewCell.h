//
//  ListingCollectionViewCell.h
//  TradeMeBrowser
//
//  Created by Ian Stewart on 28/01/2018.
//  Copyright © 2018 igstewart3. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListingCollectionViewCell : UICollectionViewCell

// UI Outlets
@property (weak, nonatomic) IBOutlet UIImageView *listingImage;
@property (weak, nonatomic) IBOutlet UILabel *listingTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *listingIdLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadIndicator;
@property (weak, nonatomic) IBOutlet UILabel *noImageLabel;

@end
