//
//  YelpBusiness.h
//  Yelp
//
//  Created by Palanisamy Kozhanthaiappan on 9/23/14.
//  Copyright (c) 2014 Palanisamy Kozhanthaiappan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YelpBusiness : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *imageURL;
@property (nonatomic, strong) NSString *ratingImageURL;
@property (nonatomic, assign) NSInteger reviewCount;
@property (nonatomic, strong) NSString *streetAddress;
@property (nonatomic, strong) NSString *neighborhood;
@property (nonatomic, strong) NSArray *categories;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
