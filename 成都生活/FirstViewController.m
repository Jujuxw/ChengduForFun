//
//  FirstViewController.m
//  成都生活
//
//  Created by 刘晓微 on 15/8/14.
//  Copyright (c) 2015年 刘晓微. All rights reserved.
//

#import "FirstViewController.h"
#import "MyCells.h"

#define KImageCount 7

@interface FirstViewController ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *infos;
@property (nonatomic, strong) NSMutableArray *array;

@property (nonatomic, weak) UIPageControl *pageControl;
@property (nonatomic, weak) NSTimer *timer;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //标题
    self.titleLabel.text = @"首页";
    
    [self loadScrollView];
    [self loadPageControl];
    [self loadTimer];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    _scrollView.frame = CGRectMake(0, 75, JDefaultScreenWidth, 200);
    [self.view addSubview:_scrollView];
}
//加载轮播图片
- (void)loadScrollView {
    
    NSArray *arrays = [[NSArray alloc] init];
    arrays = @[@"frontpage1",@"frontpage2",@"frontpage3",@"dufucaotang",@"huanlegu",@"jinli",@"wuhouci"];
    
    for (int i = 0; i < KImageCount; i++) {
        CGFloat imageViewX = JDefaultScreenSize.width * i;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(imageViewX, 0, JDefaultScreenSize.width, JDefaultScreenSize.height)];
        
        imageView.image = [UIImage imageNamed:arrays[i]];
        
        [self.scrollView addSubview:imageView];
    }
    
    CGFloat imageViewW = KImageCount * JDefaultScreenWidth;
    
    self.scrollView.contentSize = CGSizeMake(imageViewW, 0);
    
    self.scrollView.showsHorizontalScrollIndicator = YES;
    self.scrollView.showsVerticalScrollIndicator = YES;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.scrollView.mas_bottom);
        make.bottom.equalTo(self.view.mas_bottom).offset(-49);
    }];
}
//加载页码
- (void)loadPageControl {
    self.pageControl.numberOfPages = KImageCount;
    self.pageControl.currentPage = 0;
    self.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    self.pageControl.pageIndicatorTintColor = [UIColor grayColor];
}

- (void)loadTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(pageChanged:) userInfo:nil repeats:YES];
    NSRunLoop *mainLoop = [NSRunLoop mainRunLoop];
    [mainLoop addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)pageChanged:(id)sender {
    NSInteger currentPage = self.pageControl.currentPage;
    
    CGPoint offset = self.scrollView.contentOffset;
    
    if (offset.x >= JDefaultScreenWidth * (KImageCount - 1)) {
        currentPage = 0;
        offset.x = 0;
    }else {
        currentPage ++;
        offset.x += JDefaultScreenWidth;
    }
    self.pageControl.currentPage = currentPage;
    [self.scrollView setContentOffset:offset animated:NO];
}

//根据偏移量获取当前页码
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGPoint offset = scrollView.contentOffset;
    NSInteger currentPage = offset.x / JDefaultScreenWidth;
    self.pageControl.currentPage = currentPage;
}

//设置代理方法，当拖拽的时候，计时器停止
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.timer invalidate];
}

//设置代理方法，当拖拽结束时，调用计时器，让其自动滚动
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self loadTimer];
}

- (UITableView *)tableView {
    _infos = [NSMutableArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForAuxiliaryExecutable:@"place.plist"]];
    
    if(!_tableView){
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        UINib *nib = [UINib nibWithNibName:@"MyCells" bundle:nil];//从当前工程中，载入xib文件
        [_tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _infos.count;
}

- (MyCells *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify = @"cell";//cell重识标识
    MyCells *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[MyCells alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identify];//构造一个cell
    }
    NSDictionary *cellInfo = _infos[indexPath.row];
    cell.imageViewLabel.image = [UIImage imageNamed:cellInfo[@"images"]];
    cell.detailLabel.text = cellInfo[@"detailLabels"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 250;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //    if (indexPath.row == 0) {
    //        tvc1.nextView.image = [UIImage imageNamed:arrayInfo[@"images"]];
    //         tvc1.nextTextLabel.frame = CGRectMake(10, 280 , 350,678-310);
    //        tvc1.nextTextLabel.text = arrayInfo[@"labels"];
    //    }else if (indexPath.row == 1){
    //        tvc1.nextView.image = [UIImage imageNamed:@"杜甫草堂1.jpg"];
    //        tvc1.nextTextLabel.text = @"";
    //    }else if(indexPath.row == 2){
    //        tvc1.nextView.image = [UIImage imageNamed:@"欢乐谷1.jpg"];
    //        tvc1.nextTextLabel.text = @"";
    //    }else if (indexPath.row ==3){
    //        tvc1.nextView.image = [UIImage imageNamed:@"武侯祠1.jpg"];
    //        tvc1.nextTextLabel.text = @"";
    //    }else if (indexPath.row == 4){
    //        tvc1.nextView.image = [UIImage imageNamed:@"熊猫基地1.jpg"];
    //        tvc1.nextTextLabel.text = @"";
    //    }else if(indexPath.row == 5)
    //    {
    //        tvc1.nextView.image = [UIImage imageNamed:@"锦里1.jpg"];
    //        tvc1.nextTextLabel.frame = CGRectMake(10, 270 , 350,678-310);
    //        tvc1.nextTextLabel.text = @"";
    //    }
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
