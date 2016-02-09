//
//  TableViewCell.m
//  JRMenuDemo
//
//  Created by Andy on 16/2/4.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "TableViewCell.h"
#import "JRMenuView.h"

@interface TableViewCell()<JRMenuDelegate>
{
    UIButton * menuBtn;
    JRMenuView * jrMenu;
}
@end

@implementation TableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupCell];
    }
    return self;
}
#pragma mark - Cell布局
- (void)setupCell
{
    //cell文字
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 220,50)];
    self.textLabel.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:_label];
    
    //菜单按钮
    menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    menuBtn.frame = CGRectMake(300, 10, 50, 50);
    menuBtn.backgroundColor = [UIColor yellowColor];
    [menuBtn addTarget:self action:@selector(showJRMenu:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:menuBtn];
    
    
}
- (void)showJRMenu:(UIButton *)sender
{
    NSArray * itemsArray = self.CLICKMENUBLOCK();
    
    if (!jrMenu) {
        jrMenu = [[JRMenuView alloc] init];
    }
    [jrMenu setTargetView:menuBtn InView:self.contentView];
    [jrMenu setTitleArray:itemsArray];
    jrMenu.delegate = self;
    [self.contentView addSubview:jrMenu];
    [jrMenu show];
}

#pragma mark - JRMenuDelegate
-(void)hasSelectedJRMenuIndex:(NSInteger)jrMenuIndex
{
    self.CLICKITEMSBLOCK(jrMenuIndex);
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
