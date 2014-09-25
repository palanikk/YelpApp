//
//  YelpBusinessCellTabletViewCell.h
//  Yelp
//
//  Created by Palanisamy Kozhanthaiappan on 9/23/14.
//  Copyright (c) 2014 Palanisamy Kozhanthaiappan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YelpBusiness.h"

@interface YelpBusinessCellTableViewCell : UITableViewCell

@property (nonatomic) NSInteger count;
@property (nonatomic, strong) YelpBusiness *business;

@end
