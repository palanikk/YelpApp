//
//  MainViewController.m
//  Yelp
//
//  Created by Palanisamy Kozhanthaiappan on 9/23/14.
//  Copyright (c) 2014 Palanisamy Kozhanthaiappan. All rights reserved.
//

#import "MainViewController.h"
#import "YelpClient.h"
#import "YelpBusiness.h"
#import "YelpBusinessCellTableViewCell.h"
#import "FilterViewController.h"
#import <MBProgressHUD.h>

NSString * const kYelpConsumerKey = @"vxKwwcR_NMQ7WaEiQBK_CA";
NSString * const kYelpConsumerSecret = @"33QCvh5bIF5jIHR5klQr7RtBDhQ";
NSString * const kYelpToken = @"uRcRswHFYa1VkDrGV6LAW2F8clGh5JHV";
NSString * const kYelpTokenSecret = @"mqtKIxMIR4iBtBPZCmCLEb-Dz3Y";

@interface MainViewController ()
{
    YelpBusinessCellTableViewCell *_stubCell;
}

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) YelpClient *client;
@property (nonatomic, strong) NSArray *businesses;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) FilterViewController *fvc;

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.searchBar = [[UISearchBar alloc] init];
        self.searchBar.delegate = self;

        UIBarButtonItem *filterButton = [[UIBarButtonItem alloc]
                                        initWithTitle:@"Filter"
                                        style:UIBarButtonItemStylePlain
                                        target:self
                                        action:@selector(showFilters:)];
        
        self.navigationItem.leftBarButtonItem = filterButton;

        // You can register for Yelp API keys here: http://www.yelp.com/developers/manage_api_keys
        self.client = [[YelpClient alloc] initWithConsumerKey:kYelpConsumerKey
                                               consumerSecret:kYelpConsumerSecret
                                                  accessToken:kYelpToken
                                                 accessSecret:kYelpTokenSecret];
        


        self.fvc = [[FilterViewController alloc] init];
        self.fvc.delegate = self;
    }

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.titleView = self.searchBar;

    UINib *cellNib = [UINib nibWithNibName:@"YelpBusinessCellTableViewCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"BizCell"];

    _stubCell = [cellNib instantiateWithOwner:nil options:nil][0];

    //change Back -> Cancel
    self.navigationItem.backBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@"Cancel"
                                     style:UIBarButtonItemStylePlain
                                    target:nil
                                    action:nil];

    [self runSearch:@{@"category_filter": @"restaurants"}];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) runSearch:(NSDictionary *)params
{
    // show loading spinner and kick off search
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self.client searchWithParams:params
                        success:^(AFHTTPRequestOperation *operation, id response, NSArray *businesses) {
                            NSLog(@"loaded");
                            self.businesses = businesses;
                            [self.tableView reloadData];
                            // update loading spinner and buttons
                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                        }
                        failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                            NSLog(@"error: %@", [error description]);
                            // TODO: show network error view
                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                        }];
}

- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSMutableDictionary *params = [@{@"category_filter": @"restaurants"} mutableCopy];
    if (![searchBar.text isEqualToString:@""]) {
        params[@"term"] = searchBar.text;
    }
    [self runSearch:params];
    [searchBar endEditing:YES];
}

- (void) showFilters:(id)sender
{
    [self.navigationController pushViewController:self.fvc animated:YES];
}

- (void) updateSearch:(FilterViewController *)filterViewController
{
    [self.navigationController popViewControllerAnimated:YES];
    [self runSearch:filterViewController.filters];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.businesses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YelpBusiness *biz = self.businesses[indexPath.row];
    YelpBusinessCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BizCell"];
    cell.count = indexPath.row + 1;
    cell.business = biz;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YelpBusiness *biz = self.businesses[indexPath.row];
    _stubCell.business = biz;
    [_stubCell layoutSubviews];

    CGFloat height = [_stubCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    return height + 1;
}
@end
