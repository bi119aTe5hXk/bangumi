//
//  API.h
//  bangumi
//
//  Created by bi119aTe5hXk on 2014/04/17.
//  Copyright (c) 2014年 HT&L. All rights reserved.
//

#define debugmode 1

#define LoginURL @"http://%@:%@@api.bgm.tv/auth"
#define appName @"BGMbi119aTe5hXk"

//#define APIBaseURL @"http://api.bgm.tv"
#define WatchingListURL @"http://api.bgm.tv/user/%@/collection?cat=watching"
#define ProgressListURL @"http://api.bgm.tv/user/%@/progress?subject_id=%@"
#define SubjectInfoURL @"http://api.bgm.tv/subject/%@"
#define SubjectEPlistURL @"http://api.bgm.tv/subject/%@/ep"
#define CollectionInfoURL @"http://api.bgm.tv/collection/%@"
#define setCollectionURL @"http://api.bgm.tv/collection/%@/update"
#define setProgressURL @"http://api.bgm.tv/ep/%@/status/%@"

#define dayBGMListURL @"http://api.bgm.tv/calendar"