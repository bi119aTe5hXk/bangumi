//
//  API.h
//  bangumi
//
//  Created by bi119aTe5hXk on 2014/04/17.
//  Copyright (c) 2014年 bi119aTe5hXk. All rights reserved.
//

#define debugmode 0

#define BaseLoginURL @"https://%@:%@@api.bgm.tv/auth"
#define PostLoginURL @"https://api.bgm.tv/auth"
#define appName @"BGMbi119aTe5hXk"
#define groupName @"group.BGM"

#define rakuenURL @"https://bgm.tv/m"

#define WatchingListURL @"https://api.bgm.tv/user/%@/collection?cat=watching"
#define ProgressListURL @"https://api.bgm.tv/user/%@/progress?subject_id=%@"
#define SubjectInfoURL @"https://api.bgm.tv/subject/%@"
#define SubjectEPlistURL @"https://api.bgm.tv/subject/%@/ep"
#define CollectionInfoURL @"https://api.bgm.tv/collection/%@"


#define setCollectionURL @"https://api.bgm.tv/collection/%@/%@"
#define setProgressURL @"https://api.bgm.tv/ep/%@/status/%@"

#define dayBGMListURL @"https://api.bgm.tv/calendar"

#define SearchURL @"https://api.bgm.tv/search/subject/%@"

#define notifyURL @"https://api.bgm.tv/notify/count"
