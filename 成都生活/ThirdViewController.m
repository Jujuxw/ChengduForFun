//
//  ThirdViewController.m
//  成都生活
//
//  Created by 刘晓微 on 15/8/13.
//  Copyright (c) 2015年 刘晓微. All rights reserved.
//

#import "ThirdViewController.h"
#import "MyCell.h"
#import "ThirdViewController1.h"
@interface ThirdViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong,nonatomic)UITableView *tableView;
@property (strong,nonatomic)NSMutableArray *infos;
@property (strong,nonatomic)NSMutableArray *array;

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"游记攻略";//标题栏
    [self.view addSubview:self.tableView];//添加到视图上
    
}

-(UITableView *)tableView
{
    _infos = [NSMutableArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForAuxiliaryExecutable:@"Infos.plist"]];
    _array = [NSMutableArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForAuxiliaryExecutable:@"third.plist"]];
    
//    NSLog(@"123==%d,",_infos.count);
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:
                      CGRectMake(0, 75, 375, 667-75-49) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
       UINib *nib = [UINib nibWithNibName:@"MyCell" bundle:nil];//从当前工程中，载入xib文件
        [_tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}
#pragma mark -tableView delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _infos.count;
}

-(MyCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cell";//cell重识标识
    MyCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[MyCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identify];//构造一个cell
    }
    NSDictionary *cellInfo = _infos [indexPath.row];
    
    cell.pictureLabel.image = [UIImage imageNamed:cellInfo[@"picture"]];
    cell.nameLabel.text = cellInfo[@"name"];
    cell.phoneLabel.text = cellInfo[@"phone"];
    cell.adressLabel.text = cellInfo[@"adress"];
    cell.adressLabel.numberOfLines = 2;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ThirdViewController1 *tvc1 = [[ThirdViewController1 alloc]init];
    [self presentViewController:tvc1 animated:YES completion:nil];
    NSDictionary *arrayInfo = _array[indexPath.row];
    tvc1.nextView.image = [UIImage imageNamed:arrayInfo[@"images"]];
    tvc1.nextTextLabel.text = arrayInfo[@"labels"];
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
