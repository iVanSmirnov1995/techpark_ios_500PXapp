//
//  ISRootPegeVC.m
//  recipe
//
//  Created by Smirnov Ivan on 07.09.16.
//  Copyright © 2016 Ivan Smirnov. All rights reserved.
//

#import "ISRootPegeVC.h"
#import "ISPageContentVC.h"
#import "ISShowFullPhotoVC.h"
#import "UIImageView+AFNetworking.h"

//#import "ISChooseResept.h"

@interface ISRootPegeVC ()<UIPageViewControllerDataSource>

@property(strong,nonatomic)NSArray* ar;
@property(strong,nonatomic)NSMutableArray* imageViewArray;
@property(assign,nonatomic)NSInteger i;
@property(strong,nonatomic)UIPageControl* pageControl;

@end

@implementation ISRootPegeVC


- (void)viewDidLoad {
    
    UISwipeGestureRecognizer* swipe=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(cleanVC:)];
    swipe.direction=UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:swipe];
    
    
    [super viewDidLoad];
    self.i=0;

    self.imageViewmArray=[NSMutableArray array];
    
    for (NSString* url in self.imageURLArray) {
        
        UIImageView* imV=[[UIImageView alloc]init];
        [imV setImageWithURL:[NSURL URLWithString:url]];
        [self.imageViewArray addObject:imV];
        
    }
    NSLog(@"%lu",(unsigned long)self.imageURLArray.count);
    
   // self.imageArray=@[[UIImage imageNamed:@"1.jpg"],[UIImage imageNamed:@"5.jpg"],
     //                 [UIImage imageNamed:@"3.jpg"],[UIImage imageNamed:@"4.jpg"]];
    
    
    
    
    // Do any additional setup after loading the view.
    self.pageView=[self.storyboard instantiateViewControllerWithIdentifier:@"pageVC"];
    ISShowFullPhotoVC* vc=[self.storyboard instantiateViewControllerWithIdentifier:@"photoVC"];
//    CGRect fr=CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+100,
//                         self.view.frame.size.width,  self.view.frame.size.height);
    vc.view.bounds=self.view.frame;
    
    vc.pageIndex=0;
    vc.photo=[self.imageURLArray objectAtIndex:0];
    
    NSArray* ar=@[vc];
    [self.pageView setViewControllers:ar direction: UIPageViewControllerNavigationDirectionForward
                             animated:NO completion:^(BOOL finished) {
                                 
                             }];
    self.pageView.dataSource=self;

    [self addChildViewController:self.pageView];
    [self.view addSubview:self.pageView.view];
    [self.pageView didMoveToParentViewController:self];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers{
    
    
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    NSInteger index = ((ISShowFullPhotoVC*) viewController).pageIndex;
    if((index ==0) || (index==NSNotFound)){
        self.pageControl.currentPage=index-1;
        return nil;
    }
    self.pageControl.currentPage=index;
    index--;
    return [self viewControllerAtIndex:index];
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    
    NSInteger index = ((ISShowFullPhotoVC*) viewController).pageIndex;
    if(index==NSNotFound){
        return nil;
    }
    self.pageControl.currentPage=index;
    index++;
    if(index==[self.imageViewArray count]){
        
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

-(ISPageContentVC *)viewControllerAtIndex:(NSUInteger)index{
    if (([self.imageViewArray count] == 0) || (index >=[self.imageViewArray count])) {
        return nil;
    }
    
    
    ISShowFullPhotoVC *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"photoVC"];
    pageContentViewController.view;
    [pageContentViewController.view setNeedsLayout];
    
    pageContentViewController.pageIndex = index;
    pageContentViewController.photo=[[self.imageViewArray objectAtIndex:index] image];
    
    return pageContentViewController;
}


-(void)criatePageControler{
    UIPageControl* pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(280, 100, 0, 0)];
    //  pageControl.center=self.view.center;
    pageControl.pageIndicatorTintColor=[UIColor redColor];
    pageControl.currentPageIndicatorTintColor=[UIColor greenColor];
    pageControl.numberOfPages=self.imageViewArray.count;
    [self.view addSubview:pageControl];
    self.pageControl=pageControl;
}








- (void)cleanVC:(UISwipeGestureRecognizer *)sender {
    
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
