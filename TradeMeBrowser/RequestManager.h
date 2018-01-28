//
//  RequestManager.h
//  TradeMeBrowser
//
//  Created by Ian Stewart on 27/01/2018.
//  Copyright © 2018 igstewart3. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestManager : NSObject

/**
 Returns the shared instance.

 @return shared instance
 */
+ (RequestManager *)sharedInstance;


/**
 Retrieves full category list from server. Completion handler is called on the main thread.

 @param completionHandler Completion handler for category list - should handle an NSDictionary object.
 */
- (void)retrieveAllCategoriesWithCompletionHandler:(void(^)(NSDictionary *))completionHandler;

/**
 Retrieves the first 20 listings for the supplied category from the server. Completion handler is called on the main thread.

 @param categoryNumber The category to retrieve listings for.
 @param completionHandler Completion handler for listings - should handle an NSDictionary object.
 */
- (void)retrieveListingsForCategory:(NSString *)categoryNumber withCompletionHandler:(void(^)(NSDictionary *))completionHandler;

/**
 Retrieves the listing associated with the listing ID from the server. Completion handler is called on the main thread.

 @param listingId The ID of the listing to retrieve.
 @param completionHandler Completion handler for the listing - should handle an NSDictionary object.
 */
- (void)retrieveListingForID:(NSNumber *)listingId withCompletionHandler:(void(^)(NSDictionary *))completionHandler;


/**
 Sends a request to the supplied URL and returns the data retrieved. Completion handler is called on the main thread.

 @param urlString The URL to contact in NSString form.
 @param completionHandler Completion handler for the data - should handle an NSData object.
 */
- (void)sendRequestToURL:(NSString *)urlString withCompletionHandler:(void (^)(NSData *))completionHandler;

@end
