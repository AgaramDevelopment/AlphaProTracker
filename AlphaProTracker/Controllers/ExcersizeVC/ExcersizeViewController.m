//
//  ExcersizeViewController.m
//  AlphaProTracker
//
//  Created by user on 16/01/18.
//  Copyright © 2018 agaraminfotech. All rights reserved.
//

#import "ExcersizeViewController.h"
#import "ExcersizeCollectionViewCell.h"
#import "HeaderCollectionReusableView.h"
#import "Config.h"
#import "WebService.h"
#import "CustomNavigation.h"
#import "AppCommon.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ExcierseDetailVC.h"

@interface ExcersizeViewController ()
{
    NSMutableArray* arrayExcersizeList;
}

@end

@implementation ExcersizeViewController
@synthesize excersizeCollection;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [excersizeCollection registerNib:[UINib nibWithNibName:@"ExcersizeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"First"];
    [excersizeCollection registerNib:[UINib nibWithNibName:@"HeaderCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Second"];
    [self customnavigationmethod];
    arrayExcersizeList = [NSMutableArray new];
    [self loadProgramWebService];

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
-(void)customnavigationmethod
{
    CustomNavigation * objCustomNavigation = [[CustomNavigation alloc] init];
    [self.topView addSubview:objCustomNavigation.view];
    objCustomNavigation.tittle_lbl.text=@"";
    objCustomNavigation.btn_back.hidden =NO;
    objCustomNavigation.menu_btn.hidden = YES;
    objCustomNavigation.home_btn.hidden =YES;
    [objCustomNavigation.btn_back addTarget:self action:@selector(didClickbackBtn) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)didClickbackBtn
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [[arrayExcersizeList valueForKey:@"lstExcercise_programs"] count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray* resultArray = [self getValueSectionWise:[NSIndexPath indexPathForRow:0 inSection:section]];
    return resultArray.count;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    if([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        HeaderCollectionReusableView * cell = [excersizeCollection dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Second" forIndexPath:indexPath];
        self.lblHeaderName.text = [[[arrayExcersizeList valueForKey:@"lstExcercise_programs"] objectAtIndex:indexPath.row]valueForKey:@"programName"];
        
        UILabel* label= [[UILabel alloc] initWithFrame:CGRectMake(10, 0, cell.frame.size.width, cell.frame.size.height)];
        label.text = [[[arrayExcersizeList valueForKey:@"lstExcercise_programs"] objectAtIndex:indexPath.row] valueForKey:@"programName"];
        [label setTextColor:[UIColor whiteColor]];
        [cell addSubview:label];
        

        UICollectionViewFlowLayout* lay1 = (UICollectionViewFlowLayout *)excersizeCollection.collectionViewLayout;
        lay1.sectionHeadersPinToVisibleBounds = YES;
        
        return cell;
        
    }
    return nil;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray* resultArray = [self getValueSectionWise:indexPath];

    ExcersizeCollectionViewCell* cell = [excersizeCollection dequeueReusableCellWithReuseIdentifier:@"First" forIndexPath:indexPath];
    NSString* strImg = [NSString stringWithFormat:@"%@%@",IMG_URL,[[resultArray objectAtIndex:indexPath.row]valueForKey:@"PhotoPath"]];
    
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:strImg] placeholderImage:[UIImage imageNamed:@"banner"]];
    cell.lblExcersize.text = [[resultArray objectAtIndex:indexPath.row] valueForKey:@"ExcerciseName"];

    
    return cell;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray* array = [self getValueSectionWise:indexPath];
    ExcierseDetailVC* VC = [ExcierseDetailVC new];
    [self.navigationController pushViewController:VC animated:YES];
}

-(NSArray *)getValueSectionWise:(NSIndexPath *)indexPath
{
    NSArray *arr = [[arrayExcersizeList valueForKey:@"lstExcercise_programs"] objectAtIndex:indexPath.section];
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"programcode == %@",[arr valueForKey:@"programcode"]];
    NSArray *resultArray = [[arrayExcersizeList valueForKey:@"lstExcercise_Details"] filteredArrayUsingPredicate:predicate];
    return resultArray;
}
#pragma mark - UICollectionView Delegate FlowLayout

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//
//    return CGSizeMake((self.frame.size.width-7*SPACE_COLLECTIONVIEW_CELL)/7, self.frame.size.height);
//}
//
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
//    return SPACE_COLLECTIONVIEW_CELL;
//}
//
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
//    return SPACE_COLLECTIONVIEW_CELL;
//}


-(void)loadProgramWebService
{
    /*
     API URL : http://192.168.1.84:8029/AGAPTSERVICE.svc/GETALLPLAYERPROGRAMS
     METHOD : POST
     INPUT PARAMS :
     {
     "Clientcode":"CLI0000001",
     "UserCode":"USM0000012",
     "UserReferenceCode":"AMR0000011"
     }
     */
    
    NSString *URLString =  [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@",AllPlayerProgramKey]];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    manager.requestSerializer = requestSerializer;
    
    NSString * usercode = [[NSUserDefaults standardUserDefaults]stringForKey:@"UserCode"];
    NSString *cliendcode = [[NSUserDefaults standardUserDefaults]stringForKey:@"ClientCode"];
    NSString *userref = [[NSUserDefaults standardUserDefaults]stringForKey:@"Userreferencecode"];

    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    if(cliendcode) [dic setObject:cliendcode forKey:@"Clientcode"];
    if(usercode) [dic setObject:usercode forKey:@"Usercode"];
    if(userref) [dic setObject:userref forKey:@"UserReferenceCode"];
    
    NSLog(@"parameters : %@",dic);
    [manager POST:URLString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"response ; %@",responseObject);
        if(responseObject >0)
        {
            arrayExcersizeList = responseObject;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.excersizeCollection reloadData];
            });
        }
        
        [COMMON RemoveLoadingIcon];
        [self.view setUserInteractionEnabled:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failed");
        [COMMON webServiceFailureError];
        [self.view setUserInteractionEnabled:YES];
        
    }];
    
}

@end
