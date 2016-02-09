//
//  ViewController.m
//  JRMenuDemo
//
//  Created by Andy on 16/1/27.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "ViewController.h"
#import "TableViewCell.h"
#import "JRMenuView.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * tableview;
}
@property(nonatomic,strong)NSMutableArray * thumbsArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor yellowColor];
    [self initTableview];
}
#pragma mark - thumbsArray懒加载
-(NSMutableArray *)thumbsArray
{
    if (!_thumbsArray) {
        _thumbsArray = [NSMutableArray array];
    }
    return _thumbsArray;
}
#pragma mark - 初始化TableView
- (void)initTableview
{
    tableview = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    [tableview registerClass:[TableViewCell class] forCellReuseIdentifier:@"TableViewCell"];
    tableview.backgroundColor = [UIColor yellowColor];
    tableview.dataSource = self;
    tableview.delegate = self;
    [self.view addSubview:tableview];
    
    //为tableview添加点击事件 当点击tableview任意位置都可以收回当前已展开的JRMenu
    UITapGestureRecognizer * tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapTableview)];
    [tableview addGestureRecognizer:tapGR];
}
#pragma mark - tableview点击事件
- (void)onTapTableview
{
    [JRMenuView dismissAllJRMenu];//点击tableview收回所有展开的JRMenu
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [JRMenuView dismissAllJRMenu];//滚动tableview收回所有展开的JRMenu
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableViewCell * cell = [tableview dequeueReusableCellWithIdentifier:@"TableViewCell"];
    
    if ([self.thumbsArray containsObject:indexPath]) {//判断点赞数组中是否包含该indexPath
        cell.label.text = @"已点赞";
        cell.CLICKMENUBLOCK = ^{
            NSArray * itemsArray = @[@"取消点赞",@"评论",@"分享"];
            return itemsArray;
        };
    }else{
        cell.label.text = @"未点赞";
        cell.CLICKMENUBLOCK = ^{
            NSArray * itemsArray = @[@"点赞",@"评论",@"分享"];
            return itemsArray;
        };
    }
    cell.CLICKITEMSBLOCK = ^(NSInteger itemIndex){
        switch (itemIndex) {
            case 0:
                NSLog(@"0");
                if ([self.thumbsArray containsObject:indexPath]) {
                    [self.thumbsArray removeObject:indexPath];
                }else{
                    [self.thumbsArray addObject:indexPath];
                }
                [tableView reloadData];
                break;
            case 1:
                NSLog(@"点击了评论");
                break;
            case 2:
                NSLog(@"点击了分享");
                break;
            default:
                break;
        }
    };
    
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
