# SKPariseButtonDemo
点赞、喜欢、评论等的按钮

### 使用说明
```
//不带label的按钮
SKPariseButton *pariseBtn = [[SKPariseButton alloc] initWithFrame:CGRectMake(10, 100, 100, 50)];
    pariseBtn.backgroundColor = [UIColor brownColor];
    [self.view addSubview:pariseBtn];
    pariseBtn.skPariseHandler = ^(SKPariseButton *obj) {
        
        obj.isPariseSelected = NO;
    };
```
```
//带label的按钮
    SKPariseView *pariseView = [[SKPariseView alloc] initWithFrame:CGRectMake(10, 200, 100, 50)];
    pariseView.textColor = [UIColor grayColor];
    pariseView.backgroundColor = [UIColor brownColor];
    [self.view addSubview:pariseView];
    [pariseView addTargetHandler:^(id obj) {
        
        SKPariseView *pariseView = (SKPariseView *)obj;
        
        pariseView.isPariseSelected = YES;
    }];
```