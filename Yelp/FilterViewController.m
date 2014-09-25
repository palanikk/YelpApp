//
//  FilterViewController.m
//  Yelp
//
//  Created by Palanisamy Kozhanthaiappan on 9/23/14.
//  Copyright (c) 2014 Palanisamy Kozhanthaiappan. All rights reserved.
//

#import "FilterViewController.h"
#import "CellGroup.h"
#import "FilterCell.h"

@interface FilterViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *cells;
@property (nonatomic, strong) NSArray *cellsExpandedState;

@end

@implementation FilterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.cells = @[[CellGroup withLabel:@"Deals"
                                 filterName:@"deals_filter"
                                      cells:@[[FilterCell toggleWithLabel:@"Offering a Deal"
                                                              filterValue:@"true"
                                                                       on:NO]]
                                   expanded:YES],

                       [CellGroup withLabel:@"Sort"
                                 filterName:@"sort"
                                    cells:@[[FilterCell withLabel:@"Best Matched" filterValue:@"0"],
                                            [FilterCell withLabel:@"Distance" filterValue:@"1"],
                                            [FilterCell withLabel:@"Highest Rated" filterValue:@"2"]]],


                       [CellGroup withLabel:@"Distance"
                                 filterName:@"radius_filter"
                                      cells:@[[FilterCell withLabel:@"Auto" filterValue:@""],
                                              [FilterCell withLabel:@"100 meters" filterValue:@"100"],
                                              [FilterCell withLabel:@"200 meters" filterValue:@"200"],
                                              [FilterCell withLabel:@"1 Mile" filterValue:@"1600"],
                                              [FilterCell withLabel:@"5 Miles" filterValue:@"3200"]]],

                       [CellGroup withLabel:@"Category"
                                 filterName:@"category_filter"
                                      cells:@[[FilterCell withLabel:@"Indian" filterValue:@"indpak"],
                                              [FilterCell withLabel:@"American" filterValue:@"tradamerican"],
                                              [FilterCell withLabel:@"Chinese" filterValue:@"chinese"],
                                              [FilterCell withLabel:@"Mexican" filterValue:@"mexican"],
                                              [FilterCell withLabel:@"Thai" filterValue:@"thai"]]]];
    }

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"Search";
    
    self.navigationItem.rightBarButtonItem =
        [[UIBarButtonItem alloc] initWithTitle:@"Search"
                                         style:UIBarButtonItemStylePlain
                                        target:self
                                        action:@selector(updateSearch)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) updateSearch
{
    NSMutableDictionary *filters = [[NSMutableDictionary alloc] init];

    for (CellGroup *cellGroup in self.cells) {
        FilterCell *filterCell = cellGroup.cells[cellGroup.selectedRow];
        if (filterCell.cell.accessoryView) {
            UISwitch *s = (UISwitch *)filterCell.cell.accessoryView;
            if (s.on) {
                filters[cellGroup.filterName] = filterCell.filterValue;
            }
        }
        else {
            if (![filterCell.filterValue isEqualToString:@""]) {
                filters[cellGroup.filterName] = filterCell.filterValue;
            }
        }
    }

    self.filters = filters;
    [self.delegate updateSearch:self];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.cells.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    CellGroup *g = self.cells[section];
   // NSLog(@"%@", self.cells);
    return g.expanded ? g.cells.count : 1;
}

- (NSString *)tableView:(UITableView *) tableView titleForHeaderInSection:(NSInteger)section {
    CellGroup *g = self.cells[section];
    return g.label;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    CellGroup *g = self.cells[indexPath.section];
    NSLog(@"in cell row");
    NSLog(@"%int", g.expanded);
    
    if (g.expanded) {
        
        FilterCell *fc = g.cells[indexPath.row];
        fc.cell.accessoryType = UITableViewCellAccessoryNone;
        return fc.cell;
    }
    else {
        FilterCell *fc = g.cells[g.selectedRow];
        
        fc.cell.accessoryType = UITableViewCellAccessoryCheckmark;

        return fc.cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CellGroup *g = self.cells[indexPath.section];
    g.expanded = !g.expanded;
    g.selectedRow = indexPath.row;
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section]
                  withRowAnimation:UITableViewRowAnimationNone];
}


@end
