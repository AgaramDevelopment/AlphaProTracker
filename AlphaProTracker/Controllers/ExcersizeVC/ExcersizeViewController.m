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

@interface ExcersizeViewController ()

@end

@implementation ExcersizeViewController
@synthesize excersizeCollection;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [excersizeCollection registerNib:[UINib nibWithNibName:@"ExcersizeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"First"];
    [excersizeCollection registerNib:[UINib nibWithNibName:@"HeaderCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Second"];
//    let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout // casting is required because UICollectionViewLayout doesn't offer header pin. Its feature of UICollectionViewFlowLayout
//    layout?.sectionHeadersPinToVisibleBounds = true
    
//    UICollectionViewFlowLayout* lay1 = (UICollectionViewFlowLayout *)excersizeCollection.collectionViewLayout;
//    lay1.sectionHeadersPinToVisibleBounds = YES;
    
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

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 4;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
       HeaderCollectionReusableView * cell = [excersizeCollection dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Second" forIndexPath:indexPath];
        
        UICollectionViewFlowLayout* lay1 = (UICollectionViewFlowLayout *)excersizeCollection.collectionViewLayout;
        lay1.sectionHeadersPinToVisibleBounds = YES;
        
        return cell;

    }
    return nil;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ExcersizeCollectionViewCell* cell = [excersizeCollection dequeueReusableCellWithReuseIdentifier:@"First" forIndexPath:indexPath];
    
    return cell;

}

@end
