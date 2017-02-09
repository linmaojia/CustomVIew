

#import <UIKit/UIKit.h>
#import "SCSXSaveModel.h"
@interface SCSXTopCollectionCell : UICollectionViewCell


@property (nonatomic,strong) SCSXSaveModel *model;

@property (nonatomic,copy) void(^ClickBlock)();

@end
