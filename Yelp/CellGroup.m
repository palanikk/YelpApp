//
//  CellGroup.m
//  Yelp
//
//  Created by Palanisamy Kozhanthaiappan on 9/23/14.
//  Copyright (c) 2014 Palanisamy Kozhanthaiappan. All rights reserved.
//

#import "CellGroup.h"

@implementation CellGroup

+ (CellGroup *)withLabel:(NSString *)label
              filterName:(NSString *)filterName
                   cells:(NSArray *)cells
                expanded:(BOOL)expanded
{
    CellGroup *g = [[CellGroup alloc] init];

    g.filterName = filterName;
    g.expanded = expanded;
    g.selectedRow = 0;

    g.label = label;
    g.cells = cells;
    return g;
}

+ (CellGroup *)withLabel:(NSString *)label
              filterName:(NSString *)filterName
                   cells:(NSArray *)cells
{
    return [CellGroup withLabel:label filterName:filterName cells:cells expanded:NO];
}

@end
