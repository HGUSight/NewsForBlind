//
//  HanjatoHangle.m
//  StoryboardNavigation
//
//  Created by 김사랑 on 2014. 3. 5..
//  Copyright (c) 2014년 김사랑. All rights reserved.
//

#import "HanjatoHangle.h"

@implementation HanjatoHangle



    /*
    private void loadMap(String filename, Map<Character, Character> map, char beginChar) throws IOException {
        063
        BufferedReader reader = null;
        064
        try {
            065
            reader = new BufferedReader(new InputStreamReader(Hanja.class.getResourceAsStream(filename)));
            066
            int index = 0;
            067
            String read = null;
            068
            while ( (read = reader.readLine()) != null) {
                069
                read = StringUtils.trim(read);
                070
                if (read.startsWith("/")) {
                    071
                    // 주석이므로 무시한다.
                    072
                    continue;
                    073
                }
                074
                String[] codeArray = StringUtils.split(read, ",");
                075
                if (codeArray != null && codeArray.length > 0) {
                    076
                    for (String code : codeArray) {
                        077
                        if (StringUtils.isNotBlank(code)) {
                            078
                            map.put( (char)(beginChar + (index++)), (char)(Integer.decode(code.trim()).intValue()));
                            079
                        }
                        080
                    }
                    081
                }
                082
            }
            083
        } finally {
            084
            if (reader != null) try { reader.close(); } catch(IOException e) {}
            085
        }
        086
    }
    087

    
}
*/
-(void)gethanja:(char)hanja {
    
    int index=0;
    list=[[NSMutableArray alloc]init];
    hanjatohangle=[[NSMutableArray alloc]init];
    hanjaarray=[[NSMutableArray alloc]init];
    hanglearray=[[NSMutableArray alloc]init];
    
    
    filePath=[[NSBundle mainBundle] pathForResource:@"hanja" ofType:@"txt"];
    
    if(filePath) {
        NSString *content=[[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        for (NSString *line in [content componentsSeparatedByString:@"\n"]) {
            [list addObject:line];
        }
    }
    
    for (int i=0;i<[list count];i++) {
        
        NSRange range;
        NSString *oneline=list[i];
        range=[oneline rangeOfString:@"/*"];
        if(range.location==NSNotFound) {
            for(NSString *line in [oneline componentsSeparatedByString:@","]) {
                [hanjatohangle addObject:line];
            }
            
        }
        
    }
    
    for (int i=0;i<[hanjatohangle count];i++) {
        if (hanjatohangle[i]!=NULL) {
            NSNumber *hanjaint=[NSNumber numberWithInt:(0x4E00+index++)];
            [hanjaarray addObject:hanjaint];
            [hanglearray addObject:hanglearray[i]];
           
            //[ hanjamap setObject:((char)0x4E00+index++) forKey:[hanjatohangle[i] cStringUsingEncoding:NSUTF8StringEncoding]];
        }
    }
     NSLog(@"%@",hanjaarray);
    
    /*
        if (read.startsWith("/")) {
            071
            // 주석이므로 무시한다.
            072
            continue;
            073
        }
        074
        String[] codeArray = StringUtils.split(read, ",");
        075
        if (codeArray != null && codeArray.length > 0) {
            076
            for (String code : codeArray) {
                077
                if (StringUtils.isNotBlank(code)) {
                    078
                    map.put( (char)(beginChar + (index++)), (char)(Integer.decode(code.trim()).intValue()));
                    079
                }
                080
            }
            081
        }
        082
    }


    NSLog(@"%@",list);
    /*
    public class Hanja {
        012
     
        013
        private static final Hanja instance = new Hanja();
        014
     
        015
        /**
         016
         * Unified CJK Ideographs : 4E00-9FCF
         017
         */
    /*
        018
        private Map<Character, Character> cjkHangulMap = new HashMap<Character, Character>();
        019
        
        020
        /**
         021
         * CJK Ideographs Ext. A : 3400-4DBF
         022
         */
    /*
        023
        private Map<Character, Character> cjkExtAHangulMap = new HashMap<Character, Character>();
        024
        
        025
        /**
         026
         * CJK Compatibility Ideographs : F900-FAFF
         027
         */
    /*
        028
        private Map<Character, Character> cjkCompHangulMap = new HashMap<Character, Character>();
        029
        
        030
        private IllegalStateException exception = null;
        031
        
        032
        /**
         033
         * <p>생성자</p>
         034
         */
    /*
        035
        private Hanja() {
            036
            try {
                037
                loadMap("CJK_Ideographs.txt", cjkHangulMap, (char)0x4E00);
                038
                loadMap("CJK_Ideographs_Ext_A.txt", cjkExtAHangulMap, (char)0x3400);
                039
                loadMap("CJK_Ideographs_Compatibility.txt", cjkCompHangulMap, (char)0xF900);
                040
            } catch (IOException e) {
                041
                exception = new IllegalStateException("한자-한글 맵핑 정보를 가져오는 중 에러가 발생했습니다.", e);
                042
            }
            043
        }
        044
        
        045
        /**
         046
         * <p>인스턴스를 가져온다.</p>
         047
         *
         048
         * @return
         049
         */
    /*
        050
        public static Hanja getInstance() {
            051
            return instance;
            052
        }
        053
        
        054
        /**
         055
         * <p>한자-한글 맵핑 정보를 읽어와 Map에 담는다.</p>
         056
         *
         057
         * @param filename 파일명
         058
         * @param map
         059
         * @param beginChar
         060
         * @throws IOException
         061
         */
    /*
        062
        private void loadMap(String filename, Map<Character, Character> map, char beginChar) throws IOException {
            063
            BufferedReader reader = null;
            064
            try {
                065
                reader = new BufferedReader(new InputStreamReader(Hanja.class.getResourceAsStream(filename)));
                066
                int index = 0;
                067
                String read = null;
                068
                while ( (read = reader.readLine()) != null) {
                    069
                    read = StringUtils.trim(read);
                    070
                    if (read.startsWith("/")) {
                        071
                        // 주석이므로 무시한다.
                        072
                        continue;
                        073
                    }
                    074
                    String[] codeArray = StringUtils.split(read, ",");
                    075
                    if (codeArray != null && codeArray.length > 0) {
                        076
                        for (String code : codeArray) {
                            077
                            if (StringUtils.isNotBlank(code)) {
                                078
                                map.put( (char)(beginChar + (index++)), (char)(Integer.decode(code.trim()).intValue()));
                                079
                            }
                            080
                        }
                        081
                    }
                    082
                }
                083
            } finally {
                084
                if (reader != null) try { reader.close(); } catch(IOException e) {}
                085
            }
            086
        }
        087
        
        088
        /**
         089
         * <p>한자를 한글로 변환한다.</p>
         090
         *
         091
         * @param ch 한자
         092
         * @return
         093
         * @throws JaruException
         094
         */
    /*
        095
        public char toHangul(char ch) throws IllegalStateException {
            096
            if (exception != null) {
                097
                throw exception;
                098
            }
            099
            if (ch >= 0x4E00 && ch <= 0x9FCF) {
                100
                return cjkHangulMap.get(ch);
                101
            } else if (ch >= 0x3400 && ch <= 0x4DBF) {
                102
                return cjkExtAHangulMap.get(ch);
                103
            } else if (ch >= 0xF900 && ch <= 0xFAFF) {
                104
                return cjkCompHangulMap.get(ch);
                105
            } else {
                106
                return ch;
                107
            }
            108
        }
        109
        
        110
        /**
         111
         * <p>한자를 한글로 변환한다.</p>
         112
         *
         113
         * @param str 한자
         114
         * @return
         115
         * @throws IllegalStateException
         116
         */
    /*
        117
        public String toHangul(String str) throws IllegalStateException {
            118
            if (str == null) {
                119
                return null;
                120
            }
            121
            char[] hangulCharArray = new char[str.length()];
            122
            for (int i = 0; i < hangulCharArray.length; i++) {
                123
                hangulCharArray[i] = toHangul(str.charAt(i));
                124
            }
            125
            return new String(hangulCharArray);
            126
        }
        127
    }

    
    //[hanjatohangle objectAtIndex:hanja];
    NSLog(@"한글: %@",[hanjatohangle objectAtIndex:hanja]);
    
    //NSLog("한글: %C", [hanjatohangle objectAtIndex:hanja]);
    
       //return (new String(hanjaByte, "UTF-8"));
    */
    
}

@end
