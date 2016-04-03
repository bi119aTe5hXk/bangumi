//
//  API.h
//  bangumi2
//
//  Created by bi119aTe5hXk on 2016/03/21.
//  Copyright © 2016年 HT&L. All rights reserved.
//

#ifndef API_h
#define API_h




#define BaseLoginURL @"http://%@:%@@api.bgm.tv/auth"
#define PostLoginURL @"http://api.bgm.tv/auth"
#define appName @"BGMbi119aTe5hXk"

#define rakuenURL @"http://bgm.tv/m"

#define WatchingListURL @"http://api.bgm.tv/user/%@/collection?cat=watching"
#define ProgressListURL @"http://api.bgm.tv/user/%@/progress?subject_id=%@"
#define SubjectInfoURL @"http://api.bgm.tv/subject/%@"
#define SubjectEPlistURL @"http://api.bgm.tv/subject/%@/ep"
#define CollectionInfoURL @"http://api.bgm.tv/collection/%@"


#define setCollectionURL @"http://api.bgm.tv/collection/%@/%@"
#define setProgressURL @"http://api.bgm.tv/ep/%@/status/%@"

#define dayBGMListURL @"http://api.bgm.tv/calendar"

#define SearchURL @"http://api.bgm.tv/search/subject/%@"

#define notifyURL @"http://api.bgm.tv/notify/count"

#endif /* API_h */
