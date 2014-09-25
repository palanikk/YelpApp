//
//  CellGroup.h
//  Yelp
//
//  Created by Palanisamy Kozhanthaiappan on 9/23/14.
//  Copyright (c) 2014 Palanisamy Kozhanthaiappan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CellGroup : NSObject

@property (nonatomic) BOOL expanded;
@property (nonatomic) NSInteger selectedRow;
@property (nonatomic, strong) NSString *label;
@property (nonatomic, strong) NSArray *cells;
@property (nonatomic, strong) NSString *filterName;

+ (CellGroup *)withLabel:(NSString *)label
              filterName:(NSString *)filterName
                   cells:(NSArray *)cells;

+ (CellGroup *)withLabel:(NSString *)label
              filterName:(NSString *)filterName
                   cells:(NSArray *)cells
                expanded:(BOOL)expanded;

@end
