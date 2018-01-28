//
//  RequestManager.m
//  TradeMeBrowser
//
//  Created by Ian Stewart on 27/01/2018.
//  Copyright © 2018 igstewart3. All rights reserved.
//

#import "RequestManager.h"
#import "Constants.h"

@interface RequestManager ()

@property NSURLSession *urlSession;

@end

// Authorization strings
static NSString *const kAuthorizationString = @"OAuth oauth_consumer_key=\"A1AC63F0332A131A78FAC304D007E7D1\", oauth_signature=\"EC7F18B17A062962C6930A8AE88B16C7&B89EA041DAAF27FD08BA54FD74D9792E\", oauth_signature_method=PLAINTEXT, oauth_token=\"EB80A8C754C266509A430F82D3EC56F4\"";
static NSString *const kAuthorization = @"Authorization";
static NSString *const kContentType = @"Content-Type";
static NSString *const kFormUrlEncoded = @"application/x-www-form-urlencoded";

// URLs
static NSString *const kCategoriesUrl = @"https://api.tmsandbox.co.nz/v1/Categories/0.json";
static NSString *const kListingsUrl = @"https://api.tmsandbox.co.nz/v1/Search/General.json?rows=20&category=%@";
static NSString *const kListingIdUrl = @"https://api.tmsandbox.co.nz/v1/Listings/%@.json";

// Errors
static NSString *const kError = @"Error: %@";

@implementation RequestManager

-(id)init
{
    self = [super init];
    if(self)
    {
        // Setup session with OAuth data to allow authorised connections
        NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        sessionConfig.HTTPAdditionalHeaders = @{kAuthorization : kAuthorizationString,
                                                kContentType   : kFormUrlEncoded};
        self.urlSession = [NSURLSession sessionWithConfiguration:sessionConfig];
    }
    return self;
}

+(RequestManager *)sharedInstance
{
    // Setup instance once, then return
    static RequestManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[RequestManager alloc] init];
    });
    return sharedInstance;
}

-(void)retrieveAllCategoriesWithCompletionHandler:(void(^)(NSDictionary *))completionHandler
{
    [self sendJSONRequestToURL:kCategoriesUrl withCompletionHandler:completionHandler];
}

- (void)retrieveListingsForCategory:(NSString *)categoryNumber withCompletionHandler:(void(^)(NSDictionary *))completionHandler
{
    NSString *urlString = [NSString stringWithFormat:kListingsUrl, categoryNumber];
    
    [self sendJSONRequestToURL:urlString withCompletionHandler:completionHandler];
}

- (void)retrieveListingForID:(NSNumber *)listingId withCompletionHandler:(void (^)(NSDictionary *))completionHandler
{
    NSString *urlString = [NSString stringWithFormat:kListingIdUrl, [listingId stringValue]];
    
    [self sendJSONRequestToURL:urlString withCompletionHandler:completionHandler];
}

- (void)sendJSONRequestToURL:(NSString *)urlString withCompletionHandler:(void (^)(NSDictionary *))completionHandler
{
    [self sendRequestToURL:urlString withCompletionHandler:^(NSData *data)
    {
        NSDictionary *jsonData = nil;
        if(data != nil)
        {
            // Serialise JSON data to NSDictionary
            NSError *error = nil;
            jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            
            NSString *errorDesc = [jsonData valueForKey:kErrorDescription];
            if(errorDesc != nil)
            {
                NSLog(kError, errorDesc);
                completionHandler(nil);
            }
            else
            {
                completionHandler(jsonData);
            }
        }
        else
        {
            completionHandler(nil);
        }
    }];
}

- (void)sendRequestToURL:(NSString *)urlString withCompletionHandler:(void (^)(NSData *))completionHandler
{
    NSURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    [[self.urlSession dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
      {
          if(error != nil)
          {
              NSLog(kError, [error description]);
          }
          
          // Return results to main thread
          dispatch_sync(dispatch_get_main_queue(), ^{
              completionHandler(data);
          });
          
      }] resume];
}

@end
