//
//  ViewController.m
//  蓝牙开发
//
//  Created by mini on 15/9/18.
//  Copyright (c) 2015年 mini. All rights reserved.
//

#import "ViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface ViewController ()<CBCentralManagerDelegate,CBPeripheralDelegate>
{
    //系统蓝牙设备管理对象，可以把他理解为主设备，通过他，可以去扫描和链接外设
    CBCentralManager *manager;
}
@end

@implementation ViewController

//http://blog.csdn.net/xufeidll/article/details/24022261

- (void)viewDidLoad {
    [super viewDidLoad];
    /**
     设置主设备的委托,CBCentralManagerDelegate
     必须实现的：
     -?(void)centralManagerDidUpdateState:(CBCentralManager?*)central;//主设备状态改变的委托，在初始化CBCentralManager的适合会打开设备，只有当设备正确打开后才能使用
     其他选择实现的委托中比较重要的：
     -?(void)centralManager:(CBCentralManager?*)central?didDiscoverPeripheral:(CBPeripheral?*)peripheral?advertisementData:(NSDictionary?*)advertisementData?RSSI:(NSNumber?*)RSSI;?//找到外设的委托
    -?(void)centralManager:(CBCentralManager?*)central?didConnectPeripheral:(CBPeripheral?*)peripheral;//连接外设成功的委托
     -?(void)centralManager:(CBCentralManager?*)central?didFailToConnectPeripheral:(CBPeripheral?*)peripheral?error:(NSError?*)error;//外设连接失败的委托
     -?(void)centralManager:(CBCentralManager?*)central?didDisconnectPeripheral:(CBPeripheral?*)peripheral?error:(NSError?*)error;//断开外设的委托

   //初始化并设置委托和线程队列，最好一个线程的参数可以为nil，默认会就main线程
     */
    manager = [[CBCentralManager alloc]initWithDelegate:self queue:dispatch_get_main_queue()];
    manager.delegate = self;
    NSDictionary* scanOptions = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:CBCentralManagerScanOptionAllowDuplicatesKey];
    [manager scanForPeripheralsWithServices:nil options:scanOptions];
}

- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    switch (central.state) {
        case CBCentralManagerStateUnknown:
        {
            
        }
            break;
        case CBCentralManagerStateResetting:
        {
            
        }
            break;
        case CBCentralManagerStateUnsupported:
        {
            
        }
            break;
        case CBCentralManagerStateUnauthorized:
        {
            
        }
            break;
        case CBCentralManagerStatePoweredOff:
        {
            
        }
            break;
        case CBCentralManagerStatePoweredOn:
        {
            [manager scanForPeripheralsWithServices:nil options:nil];
        }
            break;
            
            
        default:
            break;
    }
}

#pragma mark - 连接外设
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    NSLog(@"当前扫描到设备：%@",peripheral.name);
    if ([peripheral.name hasPrefix:@"p"]) {
//        [manager cancelPeripheralConnection:peripheral];
        [manager connectPeripheral:peripheral options:nil];
    }
}

#pragma mark - 连接结果
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    NSLog(@">>> 连接到名称为 （%@） 的设备-成功",peripheral.name);
    //设置的peripheral委托CBPeripheralDelegate
    [peripheral setDelegate:self];
    
    [peripheral discoverServices:nil];
}

- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSLog(@">>> 连接到名称为 （%@） 的设备-失败，    失败原因：%@",peripheral.name,[error localizedDescription]);
}

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
     NSLog(@">>> 连接到名称为 （%@） 的设备-断开，    失败原因：%@",peripheral.name,[error localizedDescription]);
}

#pragma mark - 扫描到服务

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    NSLog(@">>>扫描到服务：%@",peripheral.services);
    if (error) {
        NSLog(@">>> 获取到名称为 （%@） 的设备原因：%@",peripheral.name,[error localizedDescription]);
    }
    
    for (CBService *service in peripheral.services) {
        NSLog(@"%@",service.UUID);
        [peripheral discoverCharacteristics:nil forService:service];
    }
}

#pragma mark - 获取外设的characteristics，获取characteristics的值，获取characteristics 的descriptor和其值
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    NSLog(@"error?Discovered?characteristics?for?%@?with?error:?%@",service.UUID,[error localizedDescription]);
    for (CBCharacteristic *characteristic in service.characteristics) {
        [peripheral readValueForCharacteristic:characteristic];
//        搜索Characteristic的Descriptors -(void)peripheral:(CBPeripheral?*)peripheral?didDiscoverDescriptorsForCharacteristic:(CBCharacteristic?*)characteristic?error:(NSErro
        [peripheral discoverDescriptorsForCharacteristic:characteristic];
    }
    
}

#pragma mark - 获取characteristic的值
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    NSLog(@"characteristic.uuid:%@  value:%@",characteristic.UUID,characteristic.value);
}

#pragma mark - 搜索到characteristic的Dsecriptors
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverDescriptorsForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    NSLog(@"characteristic.uuid:%@",characteristic.UUID);

    for (CBDescriptor *d in characteristic.descriptors) {
        NSLog(@"Descriptor.uuid:%@",d.UUID);
    }
}

#pragma mark - 获取Dsecriptors 的值
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForDescriptor:(CBDescriptor *)descriptor error:(NSError *)error
{
    //    /打印出DescriptorsUUID?和value
    //    ????????//这个descriptor都是对于characteristic的描述，一般都是字符串，所以这里我们转换成字符串去解析
    NSLog(@"characteristic.uuid:%@   value:%@",[NSString stringWithFormat:@"%@",descriptor.UUID],descriptor.value);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  1. 建立中心角色
 (1)
 http://www.cocoachina.com/ios/20150915/13454.html
 (2)
 http://www.cocoachina.com/ios/20150917/13456.html
 
 2. 扫描外设（discover）
 
 3. 连接外设(connect)
 
 4. 扫描外设中的服务和特征(discover)
 
 ? ? - 4.1 获取外设的services
 
 ? ? - 4.2 获取外设的Characteristics,获取Characteristics的值，获取Characteristics的Descriptor和Descriptor的值
 
 5. 与外设做数据交互(explore and interact)
 
 6. 订阅Characteristic的通知
 
 7. 断开连接(disconnect)
 */

@end
