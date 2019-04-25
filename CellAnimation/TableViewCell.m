//
//  TableViewCell.m
//  CellAnimation
//
//  Created by TaoLiang on 2019/4/25.
//  Copyright © 2019 CreolophusGG. All rights reserved.
//

#import "TableViewCell.h"
#import <Masonry.h>

@interface TableViewCell ()
@property (strong, nonatomic) UIView *customContentView;
@property (strong, nonatomic) UILabel *label;;


@end

@implementation TableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
//        self.textLabel.font = [UIFont systemFontOfSize:14];
        _customContentView = [UIView new];
        _customContentView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_customContentView];
        [_customContentView mas_makeConstraints:^(MASConstraintMaker *make){
            make.edges.inset(5);
            make.height.equalTo(@90).priorityLow();
        }];
        
        _label = [UILabel new];
        _label.text = @"wtffffffffff";
        [_customContentView addSubview:_label];
        [_label mas_makeConstraints:^(MASConstraintMaker *make){
            make.right.bottom.equalTo(@-5);
        }];

    }
    return self;
}

- (void)setTrigger:(BOOL)trigger {
    _trigger = trigger;
    CGFloat customContentViewHeight = _trigger ? 190 : 90;
    [_customContentView mas_updateConstraints:^(MASConstraintMaker *make){
        make.height.mas_equalTo(customContentViewHeight).priorityLow();
    }];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    [UIView animateWithDuration:0.5 animations:^{
        _customContentView.backgroundColor = selected ? [UIColor redColor] : [UIColor lightGrayColor];
        CATransform3D tf = _label.layer.transform;
        _label.layer.transform = selected ? CATransform3DMakeScale(1.5, 1.5, 1) : CATransform3DIdentity;
    } completion:nil];

}


@end
