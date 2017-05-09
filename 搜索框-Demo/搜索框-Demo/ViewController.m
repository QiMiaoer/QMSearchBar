//
//  ViewController.m
//  搜索框-Demo
//
//  Created by zyx on 17/4/5.
//  Copyright © 2017年 其妙. All rights reserved.
//

#import "ViewController.h"
#import "TestViewController.h"

#define CellID @"cellid"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource,UISearchResultsUpdating>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UISearchController *searchController;

@property (nonatomic, assign) NSInteger number;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.tableView];
}

- (void)addA {
    NSLog(@"click adda");
}

#pragma mark --- 代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.searchController.active ? self.number : 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
    
    if (self.searchController.active) {
        cell.textLabel.text = [NSString stringWithFormat:@"active %ld", indexPath.row];
    } else {
        cell.textLabel.text = [NSString stringWithFormat:@"normal %ld", indexPath.row];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"click %@", cell.textLabel.text);
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSLog(@"%@", searchController.searchBar.text);
    
    self.number = [searchController.searchBar.text integerValue];
    [self.tableView reloadData];
}

#pragma mark --- lazy
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellID];
        _tableView.tableHeaderView = self.searchController.searchBar;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

- (UISearchController *)searchController {
    if (!_searchController) {
        _searchController = [[UISearchController alloc] initWithSearchResultsController:[TestViewController new]];
//        _searchController.searchBar.frame = CGRectMake(0, 0, 0, 44);
        _searchController.searchBar.placeholder = @"快来搜索吧...";
//        _searchController.searchBar.prompt = @"什么玩意";
        _searchController.searchResultsUpdater = self;
//        _searchController.searchBar.barTintColor = [UIColor cyanColor];
//        _searchController.searchBar.tintColor = [UIColor redColor];
//        _searchController.searchBar.showsSearchResultsButton = YES;
        _searchController.searchBar.showsCancelButton = YES;
        UIButton *canceLBtn = [_searchController.searchBar valueForKey:@"cancelButton"];
        [canceLBtn setTitle:@"取消" forState:UIControlStateNormal];
        [canceLBtn setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
        
        // 搜索时，背景变暗
        _searchController.dimsBackgroundDuringPresentation = NO;
        // 搜索时，背景模糊
//        _searchController.obscuresBackgroundDuringPresentation = NO;
        // 搜索时，隐藏导航栏
//        _searchController.hidesNavigationBarDuringPresentation = NO;
        
        [_searchController.searchBar sizeToFit];
    }
    return _searchController;
}

@end
