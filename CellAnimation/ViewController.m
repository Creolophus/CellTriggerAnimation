//
//  ViewController.m
//  CellAnimation
//
//  Created by TaoLiang on 2019/4/25.
//  Copyright © 2019 CreolophusGG. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>
#import "TableViewCell.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray<NSNumber *> *triggers;
@property (assign, nonatomic) NSUInteger currentSelectIndex;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"cell trigger animation";
    
    _currentSelectIndex = NSUIntegerMax;
    _triggers = @[].mutableCopy;
    for (int i=0; i<20; i++) {
        [_triggers addObject:@NO];
    }
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [UIView new];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:TableViewCell.class forCellReuseIdentifier:NSStringFromClass(TableViewCell.class)];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make){
        make.edges.equalTo(self.view);
    }];
    
}


#pragma mark - table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _triggers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(TableViewCell.class)];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", @(indexPath.row)];
    cell.trigger = _triggers[indexPath.row].boolValue;
    return cell;
}
#pragma mark - table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_currentSelectIndex == indexPath.row && _triggers[_currentSelectIndex].boolValue) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    _triggers[indexPath.row] = @(!_triggers[indexPath.row].boolValue);
    
        
    if (_currentSelectIndex != NSUIntegerMax && _currentSelectIndex != indexPath.row) {
        _triggers[_currentSelectIndex] = @NO;
    }
    _currentSelectIndex = indexPath.row;
    
    if (@available(iOS 11, *)) {
        [_tableView performBatchUpdates:nil completion:nil];
    } else {
        [_tableView beginUpdates];
        [_tableView endUpdates];
    }

    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    static TableViewCell *theCell;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        theCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(TableViewCell.class)];
    });
    theCell.trigger = _triggers[indexPath.row].boolValue;
    CGFloat height = [theCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 1.0f;
    return height;
}

@end
