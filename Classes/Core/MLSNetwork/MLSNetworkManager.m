//
//  MLSNetworkManager.m
//  MLSNetwork
//
//  Created by minlison on 2019/2/27.
//

#import "MLSNetworkManager.h"
#import "MLSNetworkConfig.h"
#import "MLSNetworkAgent.h"
#import "MLSBatchRequestAgent.h"
#import "MLSChainRequestAgent.h"
@interface MLSNetworkManager ()
@property (nonatomic, strong) NSMutableDictionary *configs;
@property (nonatomic, strong) NSMutableDictionary *agents;
@property (nonatomic, strong) NSMutableDictionary *batchAgents;
@property (nonatomic, strong) NSMutableDictionary *chainAgents;
@end
@implementation MLSNetworkManager
+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static MLSNetworkManager *instance = nil;
    dispatch_once(&onceToken,^{
        instance = [[self alloc] init];
    });
    return instance;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.configs = [NSMutableDictionary dictionaryWithCapacity:10];
        self.agents = [NSMutableDictionary dictionaryWithCapacity:10];
        self.batchAgents = [NSMutableDictionary dictionaryWithCapacity:10];
        self.chainAgents = [NSMutableDictionary dictionaryWithCapacity:10];
    }
    return self;
}
+ (id)allocWithZone:(struct _NSZone *)zone{
    return [self sharedInstance];
}

+ (MLSNetworkConfig *)configWithMoudleIdentifier:(NSString *)moudleIdentifier {
    if (moudleIdentifier.length <= 0) {
        return MLSNetworkConfig.sharedConfig;
    }
    MLSNetworkConfig *config = [[MLSNetworkManager sharedInstance].configs objectForKey:moudleIdentifier];
    if (config == nil) {
        config = [[MLSNetworkConfig alloc] init];
        [[MLSNetworkManager sharedInstance].configs setObject:config forKey:moudleIdentifier];
    }
    return config;
}

+ (MLSNetworkAgent *)agentWithMoudleIdentifier:(NSString *)moudleIdentifier {
    if (moudleIdentifier.length <= 0) {
        return MLSNetworkAgent.sharedAgent;
    }
    MLSNetworkAgent *agent = [[MLSNetworkManager sharedInstance].agents objectForKey:moudleIdentifier];
    if (agent == nil) {
        agent = [MLSNetworkAgent shareAgentWithMoudleIdentifer:moudleIdentifier];
        [[MLSNetworkManager sharedInstance].agents setObject:agent forKey:moudleIdentifier];
    }
    return agent;
}


+ (MLSBatchRequestAgent *)batchAgentWithMoudleIdentifier:(NSString *)moudleIdentifier {
    if (moudleIdentifier.length <= 0) {
        return MLSBatchRequestAgent.sharedAgent;
    }
    MLSBatchRequestAgent *batchAgent = [[MLSNetworkManager sharedInstance].batchAgents objectForKey:moudleIdentifier];
    if (batchAgent == nil) {
        batchAgent = [MLSBatchRequestAgent shareAgentWithMoudleIdentifer:moudleIdentifier];
        [[MLSNetworkManager sharedInstance].batchAgents setObject:batchAgent forKey:moudleIdentifier];
    }
    return batchAgent;
}


+ (MLSChainRequestAgent *)chainAgentWithMoudleIdentifier:(NSString *)moudleIdentifier {
    if (moudleIdentifier.length <= 0) {
        return MLSChainRequestAgent.sharedAgent;
    }
    MLSChainRequestAgent *chainAgent = [[MLSNetworkManager sharedInstance].chainAgents objectForKey:moudleIdentifier];
    if (chainAgent == nil) {
        chainAgent = [MLSChainRequestAgent shareAgentWithMoudleIdentifer:moudleIdentifier];
        [[MLSNetworkManager sharedInstance].chainAgents setObject:chainAgent forKey:moudleIdentifier];
    }
    return chainAgent;
}
@end
