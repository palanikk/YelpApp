//
//  FilterViewController.h
//  Yelp
//
//  Created by Palanisamy Kozhanthaiappan on 9/23/14.
//  Copyright (c) 2014 Palanisamy Kozhanthaiappan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FilterViewController;

@protocol SearchDelegate <NSObject>

- (void) updateSearch:(FilterViewController *)filterViewController;

@end

@interface FilterViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) id <SearchDelegate> delegate;
@property (nonatomic, strong) NSDictionary *filters;

@end
