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

//#import "ISChooseResept.h"

@interface ISRootPegeVC ()<UIPageViewControllerDataSource>

@property(strong,nonatomic)NSArray* ar;
@property(strong,nonatomic)NSArray* imageArray;
@property(assign,nonatomic)NSInteger i;
@property(strong,nonatomic)UIPageControl* pageControl;

@end

@implementation ISRootPegeVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.i=0;

    
    self.imageArray=@[[UIImage imageNamed:@"1.jpg"],[UIImage imageNamed:@"5.jpg"],
                      [UIImage imageNamed:@"3.jpg"],[UIImage imageNamed:@"4.jpg"]];
    
    
    // Do any additional setup after loading the view.
    self.pageView=[self.storyboard instantiateViewControllerWithIdentifier:@"pageVC"];
    ISShowFullPhotoVC* vc=[self.storyboard instantiateViewControllerWithIdentifier:@"photoVC"];
    vc.view.frame=self.view.frame;
    
    vc.pageIndex=0;
    vc.photo.image=[self.imageArray objectAtIndex:0];
    
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
    if(index==[self.imageArray count]){
        
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

-(ISPageContentVC *)viewControllerAtIndex:(NSUInteger)index{
    if (([self.imageArray count] == 0) || (index >=[self.imageArray count])) {
        return nil;
    }
    
    
    ISShowFullPhotoVC *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"photoVC"];
    pageContentViewController.view;
    [pageContentViewController.view setNeedsLayout];
    
    pageContentViewController.pageIndex = index;
    pageContentViewController.photo.image=[self.imageArray objectAtIndex:index];
    
    return pageContentViewController;
}


-(void)criatePageControler{
    UIPageControl* pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(280, 100, 0, 0)];
    //  pageControl.center=self.view.center;
    pageControl.pageIndicatorTintColor=[UIColor redColor];
    pageControl.currentPageIndicatorTintColor=[UIColor greenColor];
    pageControl.numberOfPages=self.imageArray.count;
    [self.view addSubview:pageControl];
    self.pageControl=pageControl;
}








@end
