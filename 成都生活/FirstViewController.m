//
//  FirstViewController.m
//  成都生活
//
//  Created by 刘晓微 on 15/8/14.
//  Copyright (c) 2015年 刘晓微. All rights reserved.
//

#import "FirstViewController.h"
#import "Mycells.h"

#define imageCount 7
#define scrollViewSize (self.scrollView.frame.size)

@interface FirstViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property (strong,nonatomic) UITableView *tableView;
@property (strong,nonatomic) NSMutableArray *infos;
@property (strong,nonatomic) NSMutableArray *array;

@property (weak,nonatomic) UIPageControl *pageControl;
@property (weak,nonatomic) NSTimer *timer;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //标题
    self.titleLabel.text = @"首页";
//    [self addFirstScroView];
    [self.view addSubview:self.tableView];
    
    [self loadScrollView];
    [self loadPageControl];
    [self loadTimer];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
//    _scrollView.backgroundColor = [UIColor greenColor];
    _scrollView.frame = CGRectMake(0, 75, scrollViewSize.width, 250);
    [self.view addSubview:_scrollView];
}
//加载轮播图片
- (void)loadScrollView {
    
    NSArray *arrays = [[NSArray alloc] init];
    arrays = @[@"首页1.png",@"首页2.png",@"首页3.png",@"杜甫草堂.jpg",@"欢乐谷.jpg",@"锦里.jpg",@"武侯祠.jpg"];
    
    for (int i = 0; i < imageCount; i++) {
        CGFloat imageViewX = scrollViewSize.width * i;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(imageViewX, 0, scrollViewSize.width, scrollViewSize.height)];
        
        imageView.image = [UIImage imageNamed:arrays[i]];
        
        [self.scrollView addSubview:imageView];
    }
    
    CGFloat imageViewW = imageCount * scrollViewSize.width;
    
    self.scrollView.contentSize = CGSizeMake(imageViewW, 0);
    
    self.scrollView.showsHorizontalScrollIndicator = YES;
    self.scrollView.showsVerticalScrollIndicator = YES;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
}
//加载页码
- (void)loadPageControl {
    self.pageControl.numberOfPages = imageCount;
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
    
    if (offset.x >= scrollViewSize.width * (imageCount - 1)) {
        
        currentPage = 0;
        
        offset.x = 0;
//        [self loadTimer];
        NSLog(@"重新加载了么？");
    }else {
        currentPage ++;
        
        offset.x += scrollViewSize.width;
    }
    
    self.pageControl.currentPage = currentPage;
    
    [self.scrollView setContentOffset:offset animated:NO];
}

//根据偏移量获取当前页码
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGPoint offset = scrollView.contentOffset;
    NSInteger currentPage = offset.x / scrollViewSize.width;
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

-(UITableView *)tableView
{
    _infos = [NSMutableArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForAuxiliaryExecutable:@"place.plist"]];
    
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:
                      CGRectMake(0, 75 + 255, 375, 667-75-49) style:UITableViewStylePlain];
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
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _infos.count;
}

-(MyCells *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
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
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 250;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
