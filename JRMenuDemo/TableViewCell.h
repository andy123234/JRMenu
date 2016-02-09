//
//  TableViewCell.h
//  JRMenuDemo
//
//  Created by Andy on 16/2/4.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell

@property(nonatomic,strong)UILabel * label;
@property(nonatomic,copy)NSArray *(^CLICKMENUBLOCK)(void);
@property(nonatomic,copy)void(^CLICKITEMSBLOCK)(NSInteger);
@end
