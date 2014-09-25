//
//  YelClient.h
//  Yelp
//
//  Created by Palanisamy Kozhanthaiappan on 9/23/14.
//  Copyright (c) 2014 Palanisamy Kozhanthaiappan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BDBOAuth1RequestOperationManager.h"

@interface YelpClient : BDBOAuth1RequestOperationManager

- (id)initWithConsumerKey:(NSString *)consumerKey
           consumerSecret:(NSString *)consumerSecret
              accessToken:(NSString *)accessToken
             accessSecret:(NSString *)accessSecret;

- (AFHTTPRequestOperation *)searchWithParams:(NSDictionary *)params
                                   success:(void (^)(AFHTTPRequestOperation *operation, id response, NSArray *businesses))success
                                   failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end
