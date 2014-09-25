//
//  FilterCell.h
//  Yelp
//
//  Created by Palanisamy Kozhanthaiappan on 9/23/14.
//  Copyright (c) 2014 Palanisamy Kozhanthaiappan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FilterCell : NSObject

@property (nonatomic, strong) UITableViewCell *cell;
@property (nonatomic, strong) NSString *filterValue;

+ (FilterCell *)withLabel:(NSString *)label filterValue:(NSString *)filterValue;
+ (FilterCell *)toggleWithLabel:(NSString *)label filterValue:(NSString *)filterValue on:(BOOL)on;

@end
