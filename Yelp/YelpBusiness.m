//
//  YelBusiness.m
//  Yelp
//
//  Created by Palanisamy Kozhanthaiappan on 9/23/14.
//  Copyright (c) 2014 Palanisamy Kozhanthaiappan. All rights reserved.
//

#import "YelpBusiness.h"

@implementation YelpBusiness

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.name = dictionary[@"name"];
        self.imageURL = dictionary[@"image_url"];
        self.ratingImageURL = dictionary[@"rating_img_url_large"];
        self.reviewCount = [dictionary[@"review_count"] integerValue];

        NSArray *addressParts = dictionary[@"location"][@"display_address"];
        self.streetAddress = addressParts[0];
        self.neighborhood = addressParts[1];

        NSMutableArray *categories = [[NSMutableArray alloc] init];
        for (NSArray *pair in dictionary[@"categories"]) {
            [categories addObject:pair[0]];
        }
        self.categories = categories;
    }

    return self;
}


@end
