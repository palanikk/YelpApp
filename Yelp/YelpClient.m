//
//  YelpClient.m
//  Yelp
//
//  Created by Palanisamy Kozhanthaiappan on 9/23/14.
//  Copyright (c) 2014 Palanisamy Kozhanthaiappan. All rights reserved.
//

#import "YelpClient.h"
#import "YelpBusiness.h"

@implementation YelpClient

- (id)initWithConsumerKey:(NSString *)consumerKey
           consumerSecret:(NSString *)consumerSecret
              accessToken:(NSString *)accessToken
             accessSecret:(NSString *)accessSecret {

    NSURL *baseURL = [NSURL URLWithString:@"http://api.yelp.com/v2/"];
    self = [super initWithBaseURL:baseURL consumerKey:consumerKey consumerSecret:consumerSecret];
    if (self) {
        BDBOAuthToken *token = [BDBOAuthToken tokenWithToken:accessToken secret:accessSecret expiration:nil];
        //self.responseSerializer = [AFJSONResponseSerializer serializer];
        [self.requestSerializer saveAccessToken:token];
    }
    return self;
}

- (AFHTTPRequestOperation *)searchWithParams:(NSDictionary *)params
                                   success:(void (^)(AFHTTPRequestOperation *operation, id response, NSArray *businesses))success
                                   failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    // For additional parameters, see http://www.yelp.com/developers/documentation/v2/search_api
    NSMutableDictionary *parameters = [params mutableCopy];
    parameters[@"location"] = @"San Francisco";

    // On success we'll parse the response into a list of businesses
    void (^successToMovies)(AFHTTPRequestOperation *, id) = ^(AFHTTPRequestOperation *operation, id response){
        NSMutableArray *businesses = [[NSMutableArray alloc] init];

        for (id bizDict in response[@"businesses"]) {
            YelpBusiness *biz = [[YelpBusiness alloc] initWithDictionary:bizDict];
            [businesses addObject:biz];
        }

        success(operation, response, businesses);
    };
    
    return [self GET:@"search" parameters:parameters success:successToMovies failure:failure];
}


@end
