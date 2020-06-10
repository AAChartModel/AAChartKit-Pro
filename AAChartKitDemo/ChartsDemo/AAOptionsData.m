//
//  AAOptionsData.m
//  AAChartKitDemo
//
//  Created by AnAn on 2020/6/6.
//  Copyright © 2020 Danny boy. All rights reserved.
//

#import "AAOptionsData.h"

@implementation AAOptionsData

+ (NSArray *)sankeyChartData {
    return @[
        @[@"巴西", @"葡萄牙", @5 ],
        @[@"巴西", @"法国", @1 ],
        @[@"巴西", @"西班牙", @1 ],
        @[@"巴西", @"英国", @1 ],
        @[@"加拿大", @"葡萄牙", @1 ],
        @[@"加拿大", @"法国", @5 ],
        @[@"加拿大", @"英国", @1 ],
        @[@"墨西哥", @"葡萄牙", @1 ],
        @[@"墨西哥", @"法国", @1 ],
        @[@"墨西哥", @"西班牙", @5 ],
        @[@"墨西哥", @"英国", @1 ],
        @[@"美国", @"葡萄牙", @1 ],
        @[@"美国", @"法国", @1 ],
        @[@"美国", @"西班牙", @1 ],
        @[@"美国", @"英国", @5 ],
        @[@"葡萄牙", @"安哥拉", @2 ],
        @[@"葡萄牙", @"塞内加尔", @1 ],
        @[@"葡萄牙", @"摩洛哥", @1 ],
        @[@"葡萄牙", @"南非", @3 ],
        @[@"法国", @"安哥拉", @1 ],
        @[@"法国", @"塞内加尔", @3 ],
        @[@"法国", @"马里", @3 ],
        @[@"法国", @"摩洛哥", @3 ],
        @[@"法国", @"南非", @1 ],
        @[@"西班牙", @"塞内加尔", @1 ],
        @[@"西班牙", @"摩洛哥", @3 ],
        @[@"西班牙", @"南非", @1 ],
        @[@"英国", @"安哥拉", @1 ],
        @[@"英国", @"塞内加尔", @1 ],
        @[@"英国", @"摩洛哥", @2 ],
        @[@"英国", @"南非", @7 ],
        @[@"南非", @"中国", @5 ],
        @[@"南非", @"印度", @1 ],
        @[@"南非", @"日本", @3 ],
        @[@"安哥拉", @"中国", @5 ],
        @[@"安哥拉", @"印度", @1 ],
        @[@"安哥拉", @"日本", @3 ],
        @[@"塞内加尔", @"中国", @5 ],
        @[@"塞内加尔", @"印度", @1 ],
        @[@"塞内加尔", @"日本", @3 ],
        @[@"马里", @"中国", @5 ],
        @[@"马里", @"印度", @1 ],
        @[@"马里", @"日本", @3 ],
        @[@"摩洛哥", @"中国", @5 ],
        @[@"摩洛哥", @"印度", @1 ],
        @[@"摩洛哥", @"日本", @3 ]
    ];
}

+ (NSArray *)dependencywheelChartData {
    return @[
        @[@"Brazil", @"Portugal", @5],
        @[@"Brazil", @"France", @1],
        @[@"Brazil", @"Spain", @1],
        @[@"Brazil", @"England", @1],
        @[@"Canada", @"Portugal", @1],
        @[@"Canada", @"France", @5],
        @[@"Canada", @"England", @1],
        @[@"Mexico", @"Portugal", @1],
        @[@"Mexico", @"France", @1],
        @[@"Mexico", @"Spain", @5],
        @[@"Mexico", @"England", @1],
        @[@"USA", @"Portugal", @1],
        @[@"USA", @"France", @1],
        @[@"USA", @"Spain", @1],
        @[@"USA", @"England", @5],
        @[@"Portugal", @"Angola", @2],
        @[@"Portugal", @"Senegal", @1],
        @[@"Portugal", @"Morocco", @1],
        @[@"Portugal", @"South Africa", @3],
        @[@"France", @"Angola", @1],
        @[@"France", @"Senegal", @3],
        @[@"France", @"Mali", @3],
        @[@"France", @"Morocco", @3],
        @[@"France", @"South Africa", @1],
        @[@"Spain", @"Senegal", @1],
        @[@"Spain", @"Morocco", @3],
        @[@"Spain", @"South Africa", @1],
        @[@"England", @"Angola", @1],
        @[@"England", @"Senegal", @1],
        @[@"England", @"Morocco", @2],
        @[@"England", @"South Africa", @7],
        @[@"South Africa", @"China", @5],
        @[@"South Africa", @"India", @1],
        @[@"South Africa", @"Japan", @3],
        @[@"Angola", @"China", @5],
        @[@"Angola", @"India", @1],
        @[@"Angola", @"Japan", @3],
        @[@"Senegal", @"China", @5],
        @[@"Senegal", @"India", @1],
        @[@"Senegal", @"Japan", @3],
        @[@"Mali", @"China", @5],
        @[@"Mali", @"India", @1],
        @[@"Mali", @"Japan", @3],
        @[@"Morocco", @"China", @5],
        @[@"Morocco", @"India", @1],
        @[@"Morocco", @"Japan", @3],
        @[@"Japan", @"Brazil", @1]
    ];
}

+ (NSArray *)sunburstChartData {
    return @[@{
            @"id": @"0.0",
            @"parent": @"",
            @"name": @"The World"
            }, @{
            @"id": @"1.3",
            @"parent": @"0.0",
            @"name": @"亚洲"
            }, @{
            @"id": @"1.1",
            @"parent": @"0.0",
            @"name": @"非洲"
            }, @{
            @"id": @"1.2",
            @"parent": @"0.0",
            @"name": @"美洲"
            }, @{
            @"id": @"1.4",
            @"parent": @"0.0",
            @"name": @"欧洲"
            }, @{
            @"id": @"1.5",
            @"parent": @"0.0",
            @"name": @"大洋洲"
            },
        
      /* Africa */
    @{
            @"id": @"2.1",
            @"parent": @"1.1",
            @"name": @"东非"
            },
        
    @{
            @"id": @"3.1",
            @"parent": @"2.1",
            @"name": @"埃塞俄比亚",
            @"value": @104957438
            }, @{
            @"id": @"3.2",
            @"parent": @"2.1",
            @"name": @"坦桑尼亚",
            @"value": @57310019
            }, @{
            @"id": @"3.3",
            @"parent": @"2.1",
            @"name": @"肯尼亚",
            @"value": @49699862
            }, @{
            @"id": @"3.4",
            @"parent": @"2.1",
            @"name": @"乌干达",
            @"value": @42862958
            }, @{
            @"id": @"3.5",
            @"parent": @"2.1",
            @"name": @"莫桑比克",
            @"value": @29668834
            }, @{
            @"id": @"3.6",
            @"parent": @"2.1",
            @"name": @"马达加斯加岛",
            @"value": @25570895
            }, @{
            @"id": @"3.7",
            @"parent": @"2.1",
            @"name": @"马拉维",
            @"value": @18622104
            }, @{
            @"id": @"3.8",
            @"parent": @"2.1",
            @"name": @"赞比亚",
            @"value": @17094130
            }, @{
            @"id": @"3.9",
            @"parent": @"2.1",
            @"name": @"津巴布韦",
            @"value": @16529904
            }, @{
            @"id": @"3.10",
            @"parent": @"2.1",
            @"name": @"索马里",
            @"value": @14742523
            }, @{
            @"id": @"3.11",
            @"parent": @"2.1",
            @"name": @"南苏丹",
            @"value": @12575714
            }, @{
            @"id": @"3.12",
            @"parent": @"2.1",
            @"name": @"卢旺达",
            @"value": @12208407
            }, @{
            @"id": @"3.13",
            @"parent": @"2.1",
            @"name": @"布隆迪",
            @"value": @10864245
            }, @{
            @"id": @"3.14",
            @"parent": @"2.1",
            @"name": @"厄立特里亚国",
            @"value": @5068831
            }, @{
            @"id": @"3.15",
            @"parent": @"2.1",
            @"name": @"毛里求斯",
            @"value": @1265138
            }, @{
            @"id": @"3.16",
            @"parent": @"2.1",
            @"name": @"吉布提",
            @"value": @956985
            }, @{
            @"id": @"3.17",
            @"parent": @"2.1",
            @"name": @"留尼汪岛",
            @"value": @876562
            }, @{
            @"id": @"3.18",
            @"parent": @"2.1",
            @"name": @"科摩罗",
            @"value": @813912
            }, @{
            @"id": @"3.19",
            @"parent": @"2.1",
            @"name": @"马约特岛",
            @"value": @253045
            }, @{
            @"id": @"3.20",
            @"parent": @"2.1",
            @"name": @"塞舌尔群岛",
            @"value": @94737
            },
        
    @{
            @"id": @"2.5",
            @"parent": @"1.1",
            @"name": @"西非"
            },
        
    @{
            @"id": @"3.42",
            @"parent": @"2.5",
            @"name": @"尼日利亚",
            @"value": @190886311
            }, @{
            @"id": @"3.43",
            @"parent": @"2.5",
            @"name": @"加纳",
            @"value": @28833629
            }, @{
            @"id": @"3.44",
            @"parent": @"2.5",
            @"name": @"科特迪瓦共和国",
            @"value": @24294750
            }, @{
            @"id": @"3.45",
            @"parent": @"2.5",
            @"name": @"尼日尔",
            @"value": @21477348
            }, @{
            @"id": @"3.46",
            @"parent": @"2.5",
            @"name": @"布基纳法索",
            @"value": @19193382
            }, @{
            @"id": @"3.47",
            @"parent": @"2.5",
            @"name": @"马里",
            @"value": @18541980
            }, @{
            @"id": @"3.48",
            @"parent": @"2.5",
            @"name": @"塞内加尔",
            @"value": @15850567
            }, @{
            @"id": @"3.49",
            @"parent": @"2.5",
            @"name": @"几内亚共和国",
            @"value": @12717176
            }, @{
            @"id": @"3.50",
            @"parent": @"2.5",
            @"name": @"贝宁",
            @"value": @11175692
            }, @{
            @"id": @"3.51",
            @"parent": @"2.5",
            @"name": @"多哥",
            @"value": @7797694
            }, @{
            @"id": @"3.52",
            @"parent": @"2.5",
            @"name": @"塞拉利昂",
            @"value": @7557212
            }, @{
            @"id": @"3.53",
            @"parent": @"2.5",
            @"name": @"利比里亚",
            @"value": @4731906
            }, @{
            @"id": @"3.54",
            @"parent": @"2.5",
            @"name": @"毛里塔尼亚",
            @"value": @4420184
            }, @{
            @"id": @"3.55",
            @"parent": @"2.5",
            @"name": @"The Gambia",
            @"value": @2100568
            }, @{
            @"id": @"3.56",
            @"parent": @"2.5",
            @"name": @"Guinea-Bissau",
            @"value": @1861283
            }, @{
            @"id": @"3.57",
            @"parent": @"2.5",
            @"name": @"Cabo Verde",
            @"value": @546388
            }, @{
            @"id": @"3.58",
            @"parent": @"2.5",
            @"name": @"Saint Helena, Ascension and Tristan da Cunha",
            @"value": @4049
            },
        
    @{
            @"id": @"2.3",
            @"parent": @"1.1",
            @"name": @"北非"
            },
        
    @{
            @"id": @"3.30",
            @"parent": @"2.3",
            @"name": @"Egypt",
            @"value": @97553151
            }, @{
            @"id": @"3.31",
            @"parent": @"2.3",
            @"name": @"Algeria",
            @"value": @41318142
            }, @{
            @"id": @"3.32",
            @"parent": @"2.3",
            @"name": @"Sudan",
            @"value": @40533330
            }, @{
            @"id": @"3.33",
            @"parent": @"2.3",
            @"name": @"Morocco",
            @"value": @35739580
            }, @{
            @"id": @"3.34",
            @"parent": @"2.3",
            @"name": @"Tunisia",
            @"value": @11532127
            }, @{
            @"id": @"3.35",
            @"parent": @"2.3",
            @"name": @"Libya",
            @"value": @6374616
            }, @{
            @"id": @"3.36",
            @"parent": @"2.3",
            @"name": @"Western Sahara",
            @"value": @552628
            },
        
    @{
            @"id": @"2.2",
            @"parent": @"1.1",
            @"name": @"Central Africa"
            },
        
    @{
            @"id": @"3.21",
            @"parent": @"2.2",
            @"name": @"Democratic Republic of the Congo",
            @"value": @81339988
            }, @{
            @"id": @"3.22",
            @"parent": @"2.2",
            @"name": @"Angola",
            @"value": @29784193
            }, @{
            @"id": @"3.23",
            @"parent": @"2.2",
            @"name": @"Cameroon",
            @"value": @24053727
            }, @{
            @"id": @"3.24",
            @"parent": @"2.2",
            @"name": @"Chad",
            @"value": @14899994
            }, @{
            @"id": @"3.25",
            @"parent": @"2.2",
            @"name": @"Congo",
            @"value": @5260750
            }, @{
            @"id": @"3.26",
            @"parent": @"2.2",
            @"name": @"Central African Republic",
            @"value": @4659080
            }, @{
            @"id": @"3.27",
            @"parent": @"2.2",
            @"name": @"Gabon",
            @"value": @2025137
            }, @{
            @"id": @"3.28",
            @"parent": @"2.2",
            @"name": @"Equatorial Guinea",
            @"value": @1267689
            }, @{
            @"id": @"3.29",
            @"parent": @"2.2",
            @"name": @"Sao Tome and Principe",
            @"value": @204327
            },
        
    @{
            @"id": @"2.4",
            @"parent": @"1.1",
            @"name": @"南美洲"
            },
        
    @{
            @"id": @"3.37",
            @"parent": @"2.4",
            @"name": @"南非",
            @"value": @56717156
            }, @{
            @"id": @"3.38",
            @"parent": @"2.4",
            @"name": @"Namibia",
            @"value": @2533794
            }, @{
            @"id": @"3.39",
            @"parent": @"2.4",
            @"name": @"Botswana",
            @"value": @2291661
            }, @{
            @"id": @"3.40",
            @"parent": @"2.4",
            @"name": @"Lesotho",
            @"value": @2233339
            }, @{
            @"id": @"3.41",
            @"parent": @"2.4",
            @"name": @"Swaziland",
            @"value": @1367254
            },
        
      /***********/
        
      /* America */
    @{
            @"id": @"2.9",
            @"parent": @"1.2",
            @"name": @"南美洲"
            },
        
    @{
            @"id": @"3.98",
            @"parent": @"2.9",
            @"name": @"Brazil",
            @"value": @209288278
            }, @{
            @"id": @"3.99",
            @"parent": @"2.9",
            @"name": @"Colombia",
            @"value": @49065615
            }, @{
            @"id": @"3.100",
            @"parent": @"2.9",
            @"name": @"Argentina",
            @"value": @44271041
            }, @{
            @"id": @"3.101",
            @"parent": @"2.9",
            @"name": @"Peru",
            @"value": @32165485
            }, @{
            @"id": @"3.102",
            @"parent": @"2.9",
            @"name": @"Venezuela",
            @"value": @31977065
            }, @{
            @"id": @"3.103",
            @"parent": @"2.9",
            @"name": @"Chile",
            @"value": @18054726
            }, @{
            @"id": @"3.104",
            @"parent": @"2.9",
            @"name": @"Ecuador",
            @"value": @16624858
            }, @{
            @"id": @"3.105",
            @"parent": @"2.9",
            @"name": @"Bolivia",
            @"value": @11051600
            }, @{
            @"id": @"3.106",
            @"parent": @"2.9",
            @"name": @"Paraguay",
            @"value": @6811297
            }, @{
            @"id": @"3.107",
            @"parent": @"2.9",
            @"name": @"Uruguay",
            @"value": @3456750
            }, @{
            @"id": @"3.108",
            @"parent": @"2.9",
            @"name": @"Guyana",
            @"value": @777859
            }, @{
            @"id": @"3.109",
            @"parent": @"2.9",
            @"name": @"Suriname",
            @"value": @563402
            }, @{
            @"id": @"3.110",
            @"parent": @"2.9",
            @"name": @"French Guiana",
            @"value": @282731
            }, @{
            @"id": @"3.111",
            @"parent": @"2.9",
            @"name": @"Falkland Islands",
            @"value": @2910
            },
        
    @{
            @"id": @"2.8",
            @"parent": @"1.2",
            @"name": @"北美洲"
            },
        
    @{
            @"id": @"3.93",
            @"parent": @"2.8",
            @"name": @"美国",
            @"value": @324459463
            }, @{
            @"id": @"3.94",
            @"parent": @"2.8",
            @"name": @"加拿大",
            @"value": @36624199
            }, @{
            @"id": @"3.95",
            @"parent": @"2.8",
            @"name": @"百慕大群岛",
            @"value": @61349
            }, @{
            @"id": @"3.96",
            @"parent": @"2.8",
            @"name": @"格陵兰",
            @"value": @56480
            }, @{
            @"id": @"3.97",
            @"parent": @"2.8",
            @"name": @"Saint Pierre and Miquelon",
            @"value": @6320
            },
        
    @{
            @"id": @"2.7",
            @"parent": @"1.2",
            @"name": @"中美洲"
            },
        
    @{
            @"id": @"3.85",
            @"parent": @"2.7",
            @"name": @"墨西哥",
            @"value": @129163276
            }, @{
            @"id": @"3.86",
            @"parent": @"2.7",
            @"name": @"危地马拉",
            @"value": @16913503
            }, @{
            @"id": @"3.87",
            @"parent": @"2.7",
            @"name": @"Honduras",
            @"value": @9265067
            }, @{
            @"id": @"3.88",
            @"parent": @"2.7",
            @"name": @"El Salvador",
            @"value": @6377853
            }, @{
            @"id": @"3.89",
            @"parent": @"2.7",
            @"name": @"Nicaragua",
            @"value": @6217581
            }, @{
            @"id": @"3.90",
            @"parent": @"2.7",
            @"name": @"Costa Rica",
            @"value": @4905769
            }, @{
            @"id": @"3.91",
            @"parent": @"2.7",
            @"name": @"Panama",
            @"value": @4098587
            }, @{
            @"id": @"3.92",
            @"parent": @"2.7",
            @"name": @"Belize",
            @"value": @374681
            },
        
    @{
            @"id": @"2.6",
            @"parent": @"1.2",
            @"name": @"Caribbean"
            },
        
    @{
            @"id": @"3.59",
            @"parent": @"2.6",
            @"name": @"Cuba",
            @"value": @11484636
            }, @{
            @"id": @"3.60",
            @"parent": @"2.6",
            @"name": @"Haiti",
            @"value": @10981229
            }, @{
            @"id": @"3.61",
            @"parent": @"2.6",
            @"name": @"Dominican Republic",
            @"value": @10766998
            }, @{
            @"id": @"3.62",
            @"parent": @"2.6",
            @"name": @"Puerto Rico",
            @"value": @3663131
            }, @{
            @"id": @"3.63",
            @"parent": @"2.6",
            @"name": @"Jamaica",
            @"value": @2890299
            }, @{
            @"id": @"3.64",
            @"parent": @"2.6",
            @"name": @"Trinidad and Tobago",
            @"value": @1369125
            }, @{
            @"id": @"3.65",
            @"parent": @"2.6",
            @"name": @"Guadeloupe",
            @"value": @449568
            }, @{
            @"id": @"3.66",
            @"parent": @"2.6",
            @"name": @"Bahamas",
            @"value": @395361
            }, @{
            @"id": @"3.67",
            @"parent": @"2.6",
            @"name": @"Martinique",
            @"value": @384896
            }, @{
            @"id": @"3.68",
            @"parent": @"2.6",
            @"name": @"Barbados",
            @"value": @285719
            }, @{
            @"id": @"3.69",
            @"parent": @"2.6",
            @"name": @"Saint Lucia",
            @"value": @178844
            }, @{
            @"id": @"3.70",
            @"parent": @"2.6",
            @"name": @"Curaçao",
            @"value": @160539
            }, @{
            @"id": @"3.71",
            @"parent": @"2.6",
            @"name": @"Saint Vincent and the Grenadines",
            @"value": @109897
            }, @{
            @"id": @"3.72",
            @"parent": @"2.6",
            @"name": @"Grenada",
            @"value": @107825
            }, @{
            @"id": @"3.73",
            @"parent": @"2.6",
            @"name": @"Aruba",
            @"value": @105264
            }, @{
            @"id": @"3.74",
            @"parent": @"2.6",
            @"name": @"United States Virgin Islands",
            @"value": @104901
            }, @{
            @"id": @"3.75",
            @"parent": @"2.6",
            @"name": @"Antigua and Barbuda",
            @"value": @102012
            }, @{
            @"id": @"3.76",
            @"parent": @"2.6",
            @"name": @"Dominica",
            @"value": @73925
            }, @{
            @"id": @"3.77",
            @"parent": @"2.6",
            @"name": @"Cayman Islands",
            @"value": @61559
            }, @{
            @"id": @"3.78",
            @"parent": @"2.6",
            @"name": @"Saint Kitts and Nevis",
            @"value": @55345
            }, @{
            @"id": @"3.79",
            @"parent": @"2.6",
            @"name": @"Sint Maarten",
            @"value": @40120
            }, @{
            @"id": @"3.80",
            @"parent": @"2.6",
            @"name": @"Turks and Caicos Islands",
            @"value": @35446
            }, @{
            @"id": @"3.81",
            @"parent": @"2.6",
            @"name": @"British Virgin Islands",
            @"value": @31196
            }, @{
            @"id": @"3.82",
            @"parent": @"2.6",
            @"name": @"Caribbean Netherlands",
            @"value": @25398
            }, @{
            @"id": @"3.83",
            @"parent": @"2.6",
            @"name": @"Anguilla",
            @"value": @14909
            }, @{
            @"id": @"3.84",
            @"parent": @"2.6",
            @"name": @"Montserrat",
            @"value": @5177
            },
      /***********/
        
      /* Asia */
    @{
            @"id": @"2.13",
            @"parent": @"1.3",
            @"name": @"南亚"
            },
        
    @{
            @"id": @"3.136",
            @"parent": @"2.13",
            @"name": @"印度",
            @"value": @1339180127
            }, @{
            @"id": @"3.137",
            @"parent": @"2.13",
            @"name": @"巴基斯坦",
            @"value": @197015955
            }, @{
            @"id": @"3.138",
            @"parent": @"2.13",
            @"name": @"孟加拉国",
            @"value": @164669751
            }, @{
            @"id": @"3.139",
            @"parent": @"2.13",
            @"name": @"伊朗",
            @"value": @81162788
            }, @{
            @"id": @"3.140",
            @"parent": @"2.13",
            @"name": @"阿富汗",
            @"value": @35530081
            }, @{
            @"id": @"3.141",
            @"parent": @"2.13",
            @"name": @"尼泊尔",
            @"value": @29304998
            }, @{
            @"id": @"3.142",
            @"parent": @"2.13",
            @"name": @"斯里兰卡",
            @"value": @20876917
            }, @{
            @"id": @"3.143",
            @"parent": @"2.13",
            @"name": @"不丹",
            @"value": @807610
            }, @{
            @"id": @"3.144",
            @"parent": @"2.13",
            @"name": @"马尔代夫",
            @"value": @436330
            },
        
    @{
            @"id": @"2.11",
            @"parent": @"1.3",
            @"name": @"东亚"
            },
        
    @{
            @"id": @"3.117",
            @"parent": @"2.11",
            @"name": @"中国",
            @"value": @(1409517397 + 622567 + 7364883 + 23626456)
            }, @{
            @"id": @"3.118",
            @"parent": @"2.11",
            @"name": @"日本",
            @"value": @127484450
            }, @{
            @"id": @"3.119",
            @"parent": @"2.11",
            @"name": @"南韩",
            @"value": @50982212
            }, @{
            @"id": @"3.120",
            @"parent": @"2.11",
            @"name": @"朝鲜",
            @"value": @25490965
            }, /*@{
                @"id": @"3.121",
                @"parent": @"2.11",
                @"name": @"台湾省（中国）",
                @"value": @23626456
                }, @{
                @"id": @"3.122",
                @"parent": @"2.11",
                @"name": @"香港特别行政区（中国）",
                @"value": @7364883
                }, */@{
            @"id": @"3.123",
            @"parent": @"2.11",
            @"name": @"蒙古",
            @"value": @3075647
            }, /*@{
                @"id": @"3.124",
                @"parent": @"2.11",
                @"name": @"澳门特别行政区（中国）",
                @"value": @622567
                },*/
        
    @{
            @"id": @"2.12",
            @"parent": @"1.3",
            @"name": @"东南亚"
            },
        
    @{
            @"id": @"3.125",
            @"parent": @"2.12",
            @"name": @"印尼",
            @"value": @263991379
            }, @{
            @"id": @"3.126",
            @"parent": @"2.12",
            @"name": @"菲律宾",
            @"value": @104918090
            }, @{
            @"id": @"3.127",
            @"parent": @"2.12",
            @"name": @"越南",
            @"value": @95540800
            }, @{
            @"id": @"3.128",
            @"parent": @"2.12",
            @"name": @"泰国",
            @"value": @69037513
            }, @{
            @"id": @"3.129",
            @"parent": @"2.12",
            @"name": @"缅甸",
            @"value": @53370609
            }, @{
            @"id": @"3.130",
            @"parent": @"2.12",
            @"name": @"马来西亚",
            @"value": @31624264
            }, @{
            @"id": @"3.131",
            @"parent": @"2.12",
            @"name": @"柬埔寨",
            @"value": @16005373
            }, @{
            @"id": @"3.132",
            @"parent": @"2.12",
            @"name": @"老挝",
            @"value": @6858160
            }, @{
            @"id": @"3.133",
            @"parent": @"2.12",
            @"name": @"新加坡",
            @"value": @5708844
            }, @{
            @"id": @"3.134",
            @"parent": @"2.12",
            @"name": @"东帝汶民主共和国",
            @"value": @1296311
            }, @{
            @"id": @"3.135",
            @"parent": @"2.12",
            @"name": @"文莱",
            @"value": @428697
            // @"color": @""
            },
        
    @{
            @"id": @"2.14",
            @"parent": @"1.3",
            @"name": @"西亚"
            },
        
    @{
            @"id": @"3.145",
            @"parent": @"2.14",
            @"name": @"土耳其",
            @"value": @80745020
            }, @{
            @"id": @"3.146",
            @"parent": @"2.14",
            @"name": @"伊拉克",
            @"value": @38274618
            }, @{
            @"id": @"3.147",
            @"parent": @"2.14",
            @"name": @"沙特阿拉伯",
            @"value": @32938213
            }, @{
            @"id": @"3.148",
            @"parent": @"2.14",
            @"name": @"也门",
            @"value": @28250420
            }, @{
            @"id": @"3.149",
            @"parent": @"2.14",
            @"name": @"叙利亚",
            @"value": @18269868
            }, @{
            @"id": @"3.150",
            @"parent": @"2.14",
            @"name": @"阿塞拜疆",
            @"value": @9827589
            }, @{
            @"id": @"3.151",
            @"parent": @"2.14",
            @"name": @"约旦",
            @"value": @9702353
            }, @{
            @"id": @"3.152",
            @"parent": @"2.14",
            @"name": @"阿拉伯联合酋长国",
            @"value": @9400145
            }, @{
            @"id": @"3.153",
            @"parent": @"2.14",
            @"name": @"以色列",
            @"value": @8321570
            }, @{
            @"id": @"3.154",
            @"parent": @"2.14",
            @"name": @"黎巴嫩",
            @"value": @6082357
            }, @{
            @"id": @"3.155",
            @"parent": @"2.14",
            @"name": @"勒斯坦",
            @"value": @4920724
            }, @{
            @"id": @"3.156",
            @"parent": @"2.14",
            @"name": @"阿曼",
            @"value": @4636262
            }, @{
            @"id": @"3.157",
            @"parent": @"2.14",
            @"name": @"科威特",
            @"value": @4136528
            }, @{
            @"id": @"3.158",
            @"parent": @"2.14",
            @"name": @"乔治亚州",
            @"value": @3912061
            }, @{
            @"id": @"3.159",
            @"parent": @"2.14",
            @"name": @"美尼亚",
            @"value": @2930450
            }, @{
            @"id": @"3.160",
            @"parent": @"2.14",
            @"name": @"卡塔尔",
            @"value": @2639211
            }, @{
            @"id": @"3.161",
            @"parent": @"2.14",
            @"name": @"巴林王国",
            @"value": @1492584
            },
        
    @{
            @"id": @"2.10",
            @"parent": @"1.3",
            @"name": @"中亚"
            },
        
    @{
            @"id": @"3.112",
            @"parent": @"2.10",
            @"name": @"乌兹别克斯坦",
            @"value": @31910641
            }, @{
            @"id": @"3.113",
            @"parent": @"2.10",
            @"name": @"哈萨克斯坦",
            @"value": @18204499
            }, @{
            @"id": @"3.114",
            @"parent": @"2.10",
            @"name": @"塔吉克斯坦",
            @"value": @8921343
            }, @{
            @"id": @"3.115",
            @"parent": @"2.10",
            @"name": @"吉尔吉斯斯坦",
            @"value": @6045117
            }, @{
            @"id": @"3.116",
            @"parent": @"2.10",
            @"name": @"土库曼斯坦",
            @"value": @5758075
            },
      /***********/
        
      /* Europe */
    @{
            @"id": @"2.15",
            @"parent": @"1.4",
            @"name": @"东欧"
            },
        
    @{
            @"id": @"3.162",
            @"parent": @"2.15",
            @"name": @"俄罗斯",
            @"value": @143989754
            }, @{
            @"id": @"3.163",
            @"parent": @"2.15",
            @"name": @"乌克兰",
            @"value": @44222947
            }, @{
            @"id": @"3.164",
            @"parent": @"2.15",
            @"name": @"波兰",
            @"value": @38170712
            }, @{
            @"id": @"3.165",
            @"parent": @"2.15",
            @"name": @"罗马尼亚",
            @"value": @19679306
            }, @{
            @"id": @"3.166",
            @"parent": @"2.15",
            @"name": @"捷克",
            @"value": @10618303
            }, @{
            @"id": @"3.167",
            @"parent": @"2.15",
            @"name": @"匈牙利",
            @"value": @9721559
            }, @{
            @"id": @"3.168",
            @"parent": @"2.15",
            @"name": @"白俄罗斯",
            @"value": @9468338
            }, @{
            @"id": @"3.169",
            @"parent": @"2.15",
            @"name": @"保加利亚",
            @"value": @7084571
            }, @{
            @"id": @"3.170",
            @"parent": @"2.15",
            @"name": @"斯洛伐克",
            @"value": @5447662
            }, @{
            @"id": @"3.171",
            @"parent": @"2.15",
            @"name": @"摩尔多瓦",
            @"value": @4051212
            }, @{
            @"id": @"3.172",
            @"parent": @"2.15",
            @"name": @"塞浦路斯",
            @"value": @1179551
            },
        
    @{
            @"id": @"2.16",
            @"parent": @"1.4",
            @"name": @"北欧"
            },
        
    @{
            @"id": @"3.173",
            @"parent": @"2.16",
            @"name": @"英国",
            @"value": @66181585
            }, @{
            @"id": @"3.174",
            @"parent": @"2.16",
            @"name": @"瑞典",
            @"value": @9910701
            }, @{
            @"id": @"3.175",
            @"parent": @"2.16",
            @"name": @"丹麦",
            @"value": @5733551
            }, @{
            @"id": @"3.176",
            @"parent": @"2.16",
            @"name": @"芬兰",
            @"value": @5523231
            }, @{
            @"id": @"3.177",
            @"parent": @"2.16",
            @"name": @"挪威",
            @"value": @5305383
            }, @{
            @"id": @"3.178",
            @"parent": @"2.16",
            @"name": @"爱尔兰",
            @"value": @4761657
            }, @{
            @"id": @"3.179",
            @"parent": @"2.16",
            @"name": @"立陶宛",
            @"value": @2890297
            }, @{
            @"id": @"3.180",
            @"parent": @"2.16",
            @"name": @"拉脱维亚",
            @"value": @1949670
            }, @{
            @"id": @"3.181",
            @"parent": @"2.16",
            @"name": @"爱沙尼亚",
            @"value": @1309632
            }, @{
            @"id": @"3.182",
            @"parent": @"2.16",
            @"name": @"冰岛",
            @"value": @335025
            }, @{
            @"id": @"3.183",
            @"parent": @"2.16",
            @"name": @"Guernsey and  Jersey",
            @"value": @165314
            }, @{
            @"id": @"3.184",
            @"parent": @"2.16",
            @"name": @"Isle of Man",
            @"value": @84287
            }, @{
            @"id": @"3.185",
            @"parent": @"2.16",
            @"name": @"Faroe Islands",
            @"value": @49290
            },
        
    @{
            @"id": @"2.17",
            @"parent": @"1.4",
            @"name": @"Southern Europe"
            },
        
    @{
            @"id": @"3.186",
            @"parent": @"2.17",
            @"name": @"Italy",
            @"value": @59359900
            }, @{
            @"id": @"3.187",
            @"parent": @"2.17",
            @"name": @"Spain",
            @"value": @46354321
            }, @{
            @"id": @"3.188",
            @"parent": @"2.17",
            @"name": @"Greece",
            @"value": @11159773
            }, @{
            @"id": @"3.189",
            @"parent": @"2.17",
            @"name": @"Portugal",
            @"value": @10329506
            }, @{
            @"id": @"3.190",
            @"parent": @"2.17",
            @"name": @"Serbia",
            @"value": @8790574
            }, @{
            @"id": @"3.191",
            @"parent": @"2.17",
            @"name": @"Croatia",
            @"value": @4189353
            }, @{
            @"id": @"3.192",
            @"parent": @"2.17",
            @"name": @"Bosnia and Herzegovina",
            @"value": @3507017
            }, @{
            @"id": @"3.193",
            @"parent": @"2.17",
            @"name": @"Albania",
            @"value": @2930187
            }, @{
            @"id": @"3.194",
            @"parent": @"2.17",
            @"name": @"Republic of Macedonia",
            @"value": @2083160
            }, @{
            @"id": @"3.195",
            @"parent": @"2.17",
            @"name": @"Slovenia",
            @"value": @2079976
            }, @{
            @"id": @"3.196",
            @"parent": @"2.17",
            @"name": @"Montenegro",
            @"value": @628960
            }, @{
            @"id": @"3.197",
            @"parent": @"2.17",
            @"name": @"Malta",
            @"value": @430835
            }, @{
            @"id": @"3.198",
            @"parent": @"2.17",
            @"name": @"Andorra",
            @"value": @76965
            }, @{
            @"id": @"3.199",
            @"parent": @"2.17",
            @"name": @"Gibraltar",
            @"value": @34571
            }, @{
            @"id": @"3.200",
            @"parent": @"2.17",
            @"name": @"San Marino",
            @"value": @33400
            }, @{
            @"id": @"3.201",
            @"parent": @"2.17",
            @"name": @"Vatican City",
            @"value": @792
            },
        
    @{
            @"id": @"2.18",
            @"parent": @"1.4",
            @"name": @"Western Europe"
            },
        
    @{
            @"id": @"3.202",
            @"parent": @"2.18",
            @"name": @"Germany",
            @"value": @82114224
            }, @{
            @"id": @"3.203",
            @"parent": @"2.18",
            @"name": @"France",
            @"value": @64979548
            }, @{
            @"id": @"3.204",
            @"parent": @"2.18",
            @"name": @"Netherlands",
            @"value": @17035938
            }, @{
            @"id": @"3.205",
            @"parent": @"2.18",
            @"name": @"Belgium",
            @"value": @11429336
            }, @{
            @"id": @"3.206",
            @"parent": @"2.18",
            @"name": @"Austria",
            @"value": @8735453
            }, @{
            @"id": @"3.207",
            @"parent": @"2.18",
            @"name": @"Switzerland",
            @"value": @8476005
            }, @{
            @"id": @"3.208",
            @"parent": @"2.18",
            @"name": @"Luxembourg",
            @"value": @583455
            }, @{
            @"id": @"3.209",
            @"parent": @"2.18",
            @"name": @"Monaco",
            @"value": @38695
            }, @{
            @"id": @"3.210",
            @"parent": @"2.18",
            @"name": @"Liechtenstein",
            @"value": @37922
            },
      /***********/
        
      /* Oceania */
    @{
            @"id": @"2.19",
            @"parent": @"1.5",
            @"name": @"Australia and New Zealand"
            },
        
    @{
            @"id": @"3.211",
            @"parent": @"2.19",
            @"name": @"Australia",
            @"value": @24450561
            }, @{
            @"id": @"3.212",
            @"parent": @"2.19",
            @"name": @"New Zealand",
            @"value": @4705818
            },
        
    @{
            @"id": @"2.20",
            @"parent": @"1.5",
            @"name": @"Melanesia"
            },
        
    @{
            @"id": @"3.213",
            @"parent": @"2.20",
            @"name": @"Papua New Guinea"
            }, @{
            @"id": @"3.214",
            @"parent": @"2.20",
            @"name": @"Fiji",
            @"value": @905502
            }, @{
            @"id": @"3.215",
            @"parent": @"2.20",
            @"name": @"Solomon Islands",
            @"value": @611343
            }, @{
            @"id": @"3.216",
            @"parent": @"2.20",
            @"name": @"New Caledonia",
            @"value": @276255
            }, @{
            @"id": @"3.217",
            @"parent": @"2.20",
            @"name": @"Vanuatu",
            @"value": @276244
            },
        
    @{
            @"id": @"2.21",
            @"parent": @"1.5",
            @"name": @"Micronesia"
            },
        
    @{
            @"id": @"3.218",
            @"parent": @"2.21",
            @"name": @"Guam",
            @"value": @164229
            }, @{
            @"id": @"3.219",
            @"parent": @"2.21",
            @"name": @"Kiribati",
            @"value": @116398
            }, @{
            @"id": @"3.220",
            @"parent": @"2.21",
            @"name": @"Federated States of Micronesia",
            @"value": @105544
            }, @{
            @"id": @"3.221",
            @"parent": @"2.21",
            @"name": @"Northern Mariana Islands",
            @"value": @55144
            }, @{
            @"id": @"3.222",
            @"parent": @"2.21",
            @"name": @"Marshall Islands",
            @"value": @53127
            }, @{
            @"id": @"3.223",
            @"parent": @"2.21",
            @"name": @"Palau",
            @"value": @21729
            }, @{
            @"id": @"3.224",
            @"parent": @"2.21",
            @"name": @"Nauru",
            @"value": @11359
            },
        
    @{
            @"id": @"2.22",
            @"parent": @"1.5",
            @"name": @"Polynesia"
            },
        
    @{
            @"id": @"3.225",
            @"parent": @"2.22",
            @"name": @"French Polynesia",
            @"value": @283007
            }, @{
            @"id": @"3.226",
            @"parent": @"2.22",
            @"name": @"Samoa",
            @"value": @196440
            }, @{
            @"id": @"3.227",
            @"parent": @"2.22",
            @"name": @"Tonga",
            @"value": @108020
            }, @{
            @"id": @"3.228",
            @"parent": @"2.22",
            @"name": @"American Samoa",
            @"value": @55641
            }, @{
            @"id": @"3.229",
            @"parent": @"2.22",
            @"name": @"Cook Islands",
            @"value": @17380
            }, @{
            @"id": @"3.230",
            @"parent": @"2.22",
            @"name": @"Wallis and Futuna",
            @"value": @11773
            }, @{
            @"id": @"3.231",
            @"parent": @"2.22",
            @"name": @"Tuvalu",
            @"value": @11192
            }, @{
            @"id": @"3.232",
            @"parent": @"2.22",
            @"name": @"Niue",
            @"value": @1618
            }, @{
            @"id": @"3.233",
            @"parent": @"2.22",
            @"name": @"Tokelau",
            @"value": @1300
            }];
}

+ (NSArray *)dumbbellChartData {
    return @[@{
        @"name": @"Austria",
        @"low": @69,
        @"high": @82
    }, @{
        @"name": @"Belgium",
        @"low": @70,
        @"high": @81
    }, @{
        @"name": @"Bulgaria",
        @"low": @69,
        @"high": @75
    }, @{
        @"name": @"Croatia",
        @"low": @65,
        @"high": @78
    }, @{
        @"name": @"Cyprus",
        @"low": @70,
        @"high": @81
    }, @{
        @"name": @"Czech Republic",
        @"low": @70,
        @"high": @79
    }, @{
        @"name": @"Denmark",
        @"low": @72,
        @"high": @81
    }, @{
        @"name": @"Estonia",
        @"low": @68,
        @"high": @78
    }, @{
        @"name": @"Finland",
        @"low": @69,
        @"high": @81
    }, @{
        @"name": @"France",
        @"low": @70,
        @"high": @83
    }, @{
        @"name": @"Greece",
        @"low": @68,
        @"high": @81
    }, @{
        @"name": @"Spain",
        @"low": @69,
        @"high": @83
    }, @{
        @"name": @"Netherlands",
        @"low": @73,
        @"high": @82
    }, @{
        @"name": @"Ireland",
        @"low": @70,
        @"high": @82
    }, @{
        @"name": @"Lithuania",
        @"low": @70,
        @"high": @75
    }, @{
        @"name": @"Luxembourg",
        @"low": @68,
        @"high": @83
    }, @{
        @"name": @"Latvia",
        @"low": @70,
        @"high": @75
    }, @{
        @"name": @"Malta",
        @"low": @69,
        @"high": @82
    }, @{
        @"name": @"Germany",
        @"low": @69,
        @"high": @81
    }, @{
        @"name": @"Poland",
        @"low": @68,
        @"high": @78
    }, @{
        @"name": @"Portugal",
        @"low": @63,
        @"high": @81
    }, @{
        @"name": @"Romania",
        @"low": @66,
        @"high": @75
    }, @{
        @"name": @"Slovakia",
        @"low": @70,
        @"high": @77
    }, @{
        @"name": @"Slovenia",
        @"low": @69,
        @"high": @81
    }, @{
        @"name": @"Sweden",
        @"low": @73,
        @"high": @82
    }, @{
        @"name": @"Hungary",
        @"low": @68,
        @"high": @76
    }, @{
        @"name": @"Italy",
        @"low": @69,
        @"high": @83
    }, @{
        @"name": @"UK",
        @"low": @71,
        @"high": @81
    }];
}


+ (NSArray *)vennChartData {
    return @[@{
        @"sets": @[@"Good"],
        @"value": @2
    }, @{
        @"sets": @[@"Fast"],
        @"value": @2
    }, @{
        @"sets": @[@"Cheap"],
        @"value": @2
    }, @{
        @"sets": @[@"Good", @"Fast"],
        @"value": @1,
        @"name": @"More expensive"
    }, @{
        @"sets": @[@"Good", @"Cheap"],
        @"value": @1,
        @"name": @"Will take time to deliver"
    }, @{
        @"sets": @[@"Fast", @"Cheap"],
        @"value": @1,
        @"name": @"Not the best quality"
    }, @{
        @"sets": @[@"Fast", @"Cheap", @"Good"],
        @"value": @1,
        @"name": @"They are dreaming"
    }];
}

+ (NSArray *)lollipopChartData {
    return @[@{
        @"name": @"China",
        @"low": @1427647786
    }, @{
        @"name": @"India",
        @"low": @1352642280
    }, @{
        @"name": @"United States",
        @"low": @327096265
    }, @{
        @"name": @"Indonesia",
        @"low": @267670543
    }, @{
        @"name": @"Pakistan",
        @"low": @212228286
    }, @{
        @"name": @"Brazil",
        @"low": @209469323
    }, @{
        @"name": @"Nigeria",
        @"low": @195874683
    }, @{
        @"name": @"Bangladesh",
        @"low": @161376708
    }, @{
        @"name": @"Russia",
        @"low": @145734038
    }, @{
        @"name": @"Mexico",
        @"low": @126190788
    }];
}

@end
