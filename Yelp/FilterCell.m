//
//  FilterCell.m
//  Yelp
//
//  Created by Palanisamy Kozhanthaiappan on 9/23/14.
//  Copyright (c) 2014 Palanisamy Kozhanthaiappan. All rights reserved.
//

#import "FilterCell.h"

@implementation FilterCell

+ (FilterCell *)withLabel:(NSString *)label filterValue:(NSString *)filterValue;
{
    FilterCell *f = [[FilterCell alloc] init];

    f.cell = [[UITableViewCell alloc] init];
    f.cell.textLabel.text = label;

    f.filterValue = filterValue;
    return f;
}

+ (FilterCell *)toggleWithLabel:(NSString *)label filterValue:(NSString *)filterValue on:(BOOL)on
{
    FilterCell *f = [FilterCell withLabel:label filterValue:filterValue];

    UISwitch *switchView = [[UISwitch alloc] init];
    switchView.on = on;

    f.cell.accessoryView = switchView;
    f.cell.textLabel.text = label;
    f.cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return f;
}

@end
