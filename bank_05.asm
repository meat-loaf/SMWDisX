                      ORG $058000                               ;;  J |  U + SS / E0 \ E1 ;
                                                                ;;                        ;
TilesetMAP16Loc:      dw Map16Tileset0                          ;;8000|8000+8000/8000\8000; Addresses to tileset-specific MAP16 data
                      dw Map16Tileset1                          ;;8002|8002+8002/8002\8002;
                      dw Map16Tileset2                          ;;8004|8004+8004/8004\8004;
                      dw Map16Tileset3                          ;;8006|8006+8006/8006\8006;
                      dw Map16Tileset4                          ;;8008|8008+8008/8008\8008;
                      dw Map16Tileset4                          ;;800A|800A+800A/800A\800A;
                      dw Map16Tileset2                          ;;800C|800C+800C/800C\800C;
                      dw Map16Tileset0                          ;;800E|800E+800E/800E\800E;
                      dw Map16Tileset2                          ;;8010|8010+8010/8010\8010;
                      dw Map16Tileset3                          ;;8012|8012+8012/8012\8012;
                      dw Map16Tileset3                          ;;8014|8014+8014/8014\8014;
                      dw Map16Tileset3                          ;;8016|8016+8016/8016\8016;
                      dw Map16Tileset0                          ;;8018|8018+8018/8018\8018;
                      dw Map16Tileset4                          ;;801A|801A+801A/801A\801A;
                      dw Map16Tileset3                          ;;801C|801C+801C/801C\801C;
                                                                ;;                        ;
CODE_05801E:          PHP                                       ;;801E|801E+801E/801E\801E;
                      SEP #$20                                  ;;801F|801F+801F/801F\801F; 8 bit A ; Accum (8 bit)
                      REP #$10                                  ;;8021|8021+8021/8021\8021; 16 bit X,Y ; Index (16 bit)
                      LDX.W #$0000                              ;;8023|8023+8023/8023\8023; \
                    - LDA.B #$25                                ;;8026|8026+8026/8026\8026;  |
                      STA.L !Layer2TilemapLow,X                 ;;8028|8028+8028/8028\8028;  |Set all background tiles (lower bytes) to x25
                      STA.L !Layer2TilemapLow+$200,X            ;;802C|802C+802C/802C\802C;  |
                      INX                                       ;;8030|8030+8030/8030\8030;  |
                      CPX.W #$0200                              ;;8031|8031+8031/8031\8031;  |
                      BNE -                                     ;;8034|8034+8034/8034\8034; /
                      STZ.W !LevelLoadObject                    ;;8036|8036+8036/8036\8036;
                      LDA.B !Layer2DataPtr+2                    ;;8039|8039+8039/8039\8039; \
                      CMP.B #$FF                                ;;803B|803B+803B/803B\803B;  |If the layer 2 data is a background,
                      BNE CODE_058074                           ;;803D|803D+803D/803D\803D; / branch to $8074
                      REP #$10                                  ;;803F|803F+803F/803F\803F; 16 bit X,Y ; Index (16 bit)
                      LDY.W #$0000                              ;;8041|8041+8041/8041\8041; \
                      LDX.B !Layer2DataPtr                      ;;8044|8044+8044/8044\8044;  |
                      CPX.W #DATA_0CE8FE                        ;;8046|8046+8046/8046\8046;  |If Layer 2 pointer >= $E8FF,
                      BCC +                                     ;;8049|8049+8049/8049\8049;  |the background should use Map16 page x11 instead of x10
                      LDY.W #$0001                              ;;804B|804B+804B/804B\804B;  |
                    + LDX.W #$0000                              ;;804E|804E+804E/804E\804E; \
                      TYA                                       ;;8051|8051+8051/8051\8051;  |
                    - STA.L !Layer2TilemapHigh,X                ;;8052|8052+8052/8052\8052;  |Set the background's Map16 page
                      STA.L !Layer2TilemapHigh+$200,X           ;;8056|8056+8056/8056\8056;  |(i.e. setting all high tile bytes to Y)
                      INX                                       ;;805A|805A+805A/805A\805A;  |
                      CPX.W #$0200                              ;;805B|805B+805B/805B\805B;  |
                      BNE -                                     ;;805E|805E+805E/805E\805E; /
                      LDA.B #$0C                                ;;8060|8060+8060/8060\8060; \ Set highest Layer 2 address to x0C
                      STA.B !Layer2DataPtr+2                    ;;8062|8062+8062/8062\8062; / (All backgrounds are stored in bank 0C)
                      STZ.W !Empty1932                          ;;8064|8064+8064/8064\8064; \ Set tileset to 0
                      STZ.W !ObjectTileset                      ;;8067|8067+8067/8067\8067; /
                      LDX.W #$B900                              ;;806A|806A+806A/806A\806A;
                      STX.B !_D                                 ;;806D|806D+806D/806D\806D;
                      REP #$20                                  ;;806F|806F+806F/806F\806F; 16 bit A ; Accum (16 bit)
                      JSR CODE_058126                           ;;8071|8071+8071/8071\8071;
CODE_058074:          SEP #$20                                  ;;8074|8074+8074/8074\8074; 8 bit A ; Accum (8 bit)
                      LDX.W #$0000                              ;;8076|8076+8076/8076\8076; \
                    - LDA.B #$00                                ;;8079|8079+8079/8079\8079;  |
                      JSR CODE_05833A                           ;;807B|807B+807B/807B\807B;  |Clear level data
                      DEX                                       ;;807E|807E+807E/807E\807E;  |
                      LDA.B #$25                                ;;807F|807F+807F/807F\807F;  |
                      JSR CODE_0582C8                           ;;8081|8081+8081/8081\8081;  |
                      CPX.W #$0200                              ;;8084|8084+8084/8084\8084;  |
                      BNE -                                     ;;8087|8087+8087/8087\8087; /
                      STZ.W !LevelLoadObject                    ;;8089|8089+8089/8089\8089;
                      JSR LoadLevel                             ;;808C|808C+808C/808C\808C; Load the level
                      SEP #$30                                  ;;808F|808F+808F/808F\808F; 8 bit A,X,Y ; Index (8 bit) Accum (8 bit)
                      LDA.W !GameMode                           ;;8091|8091+8091/8091\8091; \
                      CMP.B #$22                                ;;8094|8094+8094/8094\8094;  |
                      BPL +                                     ;;8096|8096+8096/8096\8096;  |If level mode is less than x22,
                      JSL CODE_02A751                           ;;8098|8098+8098/8098\8098;  |JSL to $02A751
                    + PLP                                       ;;809C|809C+809C/809C\809C;
                      RTL                                       ;;809D|809D+809D/809D\809D; Return
                                                                ;;                        ;
                   if ver_is_lores(!_VER)             ;\   IF   ;;++++++++++++++++++++++++; J, U, SS, & E0
CODE_05809E:          PHP                                       ;;809E|809E+809E/809E     ;
                      SEP #$20                                  ;;809F|809F+809F/809F     ; Accum (8 bit)
                   else                               ;<  ELSE  ;;------------------------; E1
EDATA_05809E:         db $20,$00,$5F,$FE,$FA,$18,$30,$00        ;;                   \809E;
                      db $5F,$FE,$FA,$18,$FF                    ;;                   \80A6;
                                                                ;;                        ;
CODE_05809E:          PHP                                       ;;                   \80AB;
                      SEP #$20                                  ;;                   \80AC;
                      LDX.B #$0C                                ;;                   \80AE;
                    - LDA.L EDATA_05809E,X                      ;;                   \80B0;
                      STA.L !DynamicStripeImage,X               ;;                   \80B4;
                      DEX                                       ;;                   \80B8;
                      BPL -                                     ;;                   \80B9;
                      STZ.B !StripeImage                        ;;                   \80BB;
                      JSL CODE_0084C8                           ;;                   \80BD;
                      LDA.B #$80                                ;;                   \80C1;
                      STA.W !HW_M7SEL                           ;;                   \80C3;
                   endif                              ;/ ENDIF  ;;++++++++++++++++++++++++;
                      STZ.W !LevelLoadObject                    ;;80A1|80A1+80A1/80A1\80C6; Zero a byte in the middle of the RAM table for the level header
                      REP #$30                                  ;;80A4|80A4+80A4/80A4\80C9; Index (16 bit) Accum (16 bit)
                      LDA.W #$FFFF                              ;;80A6|80A6+80A6/80A6\80CB;
                      STA.B !Layer1PrevTileUp                   ;;80A9|80A9+80A9/80A9\80CE; $4D to $50 = #$FF
                      STA.B !Layer1PrevTileDown                 ;;80AB|80AB+80AB/80AB\80D0;
                      JSR CODE_05877E                           ;;80AD|80AD+80AD/80AD\80D2; -> here
                      LDA.B !Layer1TileUp                       ;;80B0|80B0+80B0/80B0\80D5;
                      STA.B !Layer1TileDown                     ;;80B2|80B2+80B2/80B2\80D7;
                      LDA.B !Layer2TileUp                       ;;80B4|80B4+80B4/80B4\80D9;
                      STA.B !Layer2TileDown                     ;;80B6|80B6+80B6/80B6\80DB;
                      LDA.W #$0202                              ;;80B8|80B8+80B8/80B8\80DD;
                      STA.B !Layer1ScrollDir                    ;;80BB|80BB+80BB/80BB\80E0;
CODE_0580BD:          REP #$30                                  ;;80BD|80BD+80BD/80BD\80E2; Index (16 bit) Accum (16 bit)
                      JSL CODE_0588EC                           ;;80BF|80BF+80BF/80BF\80E4;
                      JSL CODE_058955                           ;;80C3|80C3+80C3/80C3\80E8;
                      JSL CODE_0087AD                           ;;80C7|80C7+80C7/80C7\80EC;
                      REP #$30                                  ;;80CB|80CB+80CB/80CB\80F0; Index (16 bit) Accum (16 bit)
                      INC.B !Layer1TileDown                     ;;80CD|80CD+80CD/80CD\80F2;
                      INC.B !Layer2TileDown                     ;;80CF|80CF+80CF/80CF\80F4;
                      SEP #$30                                  ;;80D1|80D1+80D1/80D1\80F6; Index (8 bit) Accum (8 bit)
                      LDA.B !Layer1TileDown                     ;;80D3|80D3+80D3/80D3\80F8;
                      LSR A                                     ;;80D5|80D5+80D5/80D5\80FA;
                      LSR A                                     ;;80D6|80D6+80D6/80D6\80FB;
                      LSR A                                     ;;80D7|80D7+80D7/80D7\80FC;
                      REP #$30                                  ;;80D8|80D8+80D8/80D8\80FD; Index (16 bit) Accum (16 bit)
                      AND.W #$0006                              ;;80DA|80DA+80DA/80DA\80FF;
                      TAX                                       ;;80DD|80DD+80DD/80DD\8102;
                      LDA.W #$0133                              ;;80DE|80DE+80DE/80DE\8103;
                      ASL A                                     ;;80E1|80E1+80E1/80E1\8106;
                      TAY                                       ;;80E2|80E2+80E2/80E2\8107;
                      LDA.W #$0007                              ;;80E3|80E3+80E3/80E3\8108;
                      STA.B !_0                                 ;;80E6|80E6+80E6/80E6\810B;
                      LDA.L MAP16AppTable,X                     ;;80E8|80E8+80E8/80E8\810D;
                    - STA.W !Map16Pointers,Y                    ;;80EC|80EC+80EC/80EC\8111;
                      INY                                       ;;80EF|80EF+80EF/80EF\8114;
                      INY                                       ;;80F0|80F0+80F0/80F0\8115;
                      CLC                                       ;;80F1|80F1+80F1/80F1\8116;
                      ADC.W #$0008                              ;;80F2|80F2+80F2/80F2\8117;
                      DEC.B !_0                                 ;;80F5|80F5+80F5/80F5\811A;
                      BPL -                                     ;;80F7|80F7+80F7/80F7\811C;
                      SEP #$20                                  ;;80F9|80F9+80F9/80F9\811E; Accum (8 bit)
                      INC.W !LevelLoadObject                    ;;80FB|80FB+80FB/80FB\8120;
                      LDA.W !LevelLoadObject                    ;;80FE|80FE+80FE/80FE\8123;
                      CMP.B #$20                                ;;8101|8101+8101/8101\8126;
                      BNE CODE_0580BD                           ;;8103|8103+8103/8103\8128;
                      LDA.W !ThroughMain                        ;;8105|8105+8105/8105\812A;
                      STA.W !HW_TM                              ;;8108|8108+8108/8108\812D; Background and Object Enable
                      STA.W !HW_TMW                             ;;810B|810B+810B/810B\8130; Window Mask Designation for Main Screen
                      LDA.W !ThroughSub                         ;;810E|810E+810E/810E\8133;
                      STA.W !HW_TS                              ;;8111|8111+8111/8111\8136; Sub Screen Designation
                      STA.W !HW_TSW                             ;;8114|8114+8114/8114\8139; Window Mask Designation for Sub Screen
                      REP #$20                                  ;;8117|8117+8117/8117\813C; Accum (16 bit)
                      LDA.W #$FFFF                              ;;8119|8119+8119/8119\813E;
                      STA.B !Layer1PrevTileUp                   ;;811C|811C+811C/811C\8141;
                      STA.B !Layer1PrevTileDown                 ;;811E|811E+811E/811E\8143;
                      STA.B !Layer2PrevTileUp                   ;;8120|8120+8120/8120\8145;
                      STA.B !Layer2PrevTileDown                 ;;8122|8122+8122/8122\8147;
                      PLP                                       ;;8124|8124+8124/8124\8149;
                      RTL                                       ;;8125|8125+8125/8125\814A; Return
                                                                ;;                        ;
CODE_058126:          PHP                                       ;;8126|8126+8126/8126\814B;
                      REP #$30                                  ;;8127|8127+8127/8127\814C; Index (16 bit) Accum (16 bit)
                      LDY.W #$0000                              ;;8129|8129+8129/8129\814E;
                      STY.B !_3                                 ;;812C|812C+812C/812C\8151;
                      STY.B !_5                                 ;;812E|812E+812E/812E\8153;
                      SEP #$30                                  ;;8130|8130+8130/8130\8155; Index (8 bit) Accum (8 bit)
                      LDA.B #$7E                                ;;8132|8132+8132/8132\8157;
                      STA.B !_F                                 ;;8134|8134+8134/8134\8159;
CODE_058136:          SEP #$20                                  ;;8136|8136+8136/8136\815B; Accum (8 bit)
                      REP #$10                                  ;;8138|8138+8138/8138\815D; Index (16 bit)
                      LDY.B !_3                                 ;;813A|813A+813A/813A\815F;
                      LDA.B [!Layer2DataPtr],Y                  ;;813C|813C+813C/813C\8161;
                      STA.B !_7                                 ;;813E|813E+813E/813E\8163;
                      INY                                       ;;8140|8140+8140/8140\8165;
                      REP #$20                                  ;;8141|8141+8141/8141\8166; Accum (16 bit)
                      STY.B !_3                                 ;;8143|8143+8143/8143\8168;
                      SEP #$20                                  ;;8145|8145+8145/8145\816A; Accum (8 bit)
                      AND.B #$80                                ;;8147|8147+8147/8147\816C;
                      BEQ CODE_05816A                           ;;8149|8149+8149/8149\816E;
                      LDA.B !_7                                 ;;814B|814B+814B/814B\8170;
                      AND.B #$7F                                ;;814D|814D+814D/814D\8172;
                      STA.B !_7                                 ;;814F|814F+814F/814F\8174;
                      LDA.B [!Layer2DataPtr],Y                  ;;8151|8151+8151/8151\8176;
                      INY                                       ;;8153|8153+8153/8153\8178;
                      REP #$20                                  ;;8154|8154+8154/8154\8179; Accum (16 bit)
                      STY.B !_3                                 ;;8156|8156+8156/8156\817B;
                      LDY.B !_5                                 ;;8158|8158+8158/8158\817D;
                    - SEP #$20                                  ;;815A|815A+815A/815A\817F; Accum (8 bit)
                      STA.B [!_D],Y                             ;;815C|815C+815C/815C\8181;
                      INY                                       ;;815E|815E+815E/815E\8183;
                      DEC.B !_7                                 ;;815F|815F+815F/815F\8184;
                      BPL -                                     ;;8161|8161+8161/8161\8186;
                      REP #$20                                  ;;8163|8163+8163/8163\8188; Accum (16 bit)
                      STY.B !_5                                 ;;8165|8165+8165/8165\818A;
                      JMP CODE_058188                           ;;8167|8167+8167/8167\818C;
                                                                ;;                        ;
CODE_05816A:          REP #$20                                  ;;816A|816A+816A/816A\818F; Accum (16 bit)
                      LDY.B !_3                                 ;;816C|816C+816C/816C\8191;
                      SEP #$20                                  ;;816E|816E+816E/816E\8193; Accum (8 bit)
                      LDA.B [!Layer2DataPtr],Y                  ;;8170|8170+8170/8170\8195;
                      INY                                       ;;8172|8172+8172/8172\8197;
                      REP #$20                                  ;;8173|8173+8173/8173\8198; Accum (16 bit)
                      STY.B !_3                                 ;;8175|8175+8175/8175\819A;
                      LDY.B !_5                                 ;;8177|8177+8177/8177\819C;
                      SEP #$20                                  ;;8179|8179+8179/8179\819E; Accum (8 bit)
                      STA.B [!_D],Y                             ;;817B|817B+817B/817B\81A0;
                      REP #$20                                  ;;817D|817D+817D/817D\81A2; Accum (16 bit)
                      INY                                       ;;817F|817F+817F/817F\81A4;
                      STY.B !_5                                 ;;8180|8180+8180/8180\81A5;
                      SEP #$20                                  ;;8182|8182+8182/8182\81A7; Accum (8 bit)
                      DEC.B !_7                                 ;;8184|8184+8184/8184\81A9;
                      BPL CODE_05816A                           ;;8186|8186+8186/8186\81AB;
CODE_058188:          REP #$20                                  ;;8188|8188+8188/8188\81AD; Accum (16 bit)
                      LDY.B !_3                                 ;;818A|818A+818A/818A\81AF;
                      SEP #$20                                  ;;818C|818C+818C/818C\81B1; Accum (8 bit)
                      LDA.B [!Layer2DataPtr],Y                  ;;818E|818E+818E/818E\81B3;
                      CMP.B #$FF                                ;;8190|8190+8190/8190\81B5;
                      BNE CODE_058136                           ;;8192|8192+8192/8192\81B7;
                      INY                                       ;;8194|8194+8194/8194\81B9;
                      LDA.B [!Layer2DataPtr],Y                  ;;8195|8195+8195/8195\81BA;
                      CMP.B #$FF                                ;;8197|8197+8197/8197\81BC;
                      BNE CODE_058136                           ;;8199|8199+8199/8199\81BE;
                      REP #$20                                  ;;819B|819B+819B/819B\81C0; Accum (16 bit)
                      LDA.W #Map16BGTiles                       ;;819D|819D+819D/819D\81C2;
                      STA.B !_0                                 ;;81A0|81A0+81A0/81A0\81C5;
                      LDX.W #$0000                              ;;81A2|81A2+81A2/81A2\81C7;
                    - LDA.B !_0                                 ;;81A5|81A5+81A5/81A5\81CA;
                      STA.W !Map16Pointers,X                    ;;81A7|81A7+81A7/81A7\81CC;
                      LDA.B !_0                                 ;;81AA|81AA+81AA/81AA\81CF;
                      CLC                                       ;;81AC|81AC+81AC/81AC\81D1;
                      ADC.W #$0008                              ;;81AD|81AD+81AD/81AD\81D2;
                      STA.B !_0                                 ;;81B0|81B0+81B0/81B0\81D5;
                      INX                                       ;;81B2|81B2+81B2/81B2\81D7;
                      INX                                       ;;81B3|81B3+81B3/81B3\81D8;
                      CPX.W #$0400                              ;;81B4|81B4+81B4/81B4\81D9;
                      BNE -                                     ;;81B7|81B7+81B7/81B7\81DC;
                      PLP                                       ;;81B9|81B9+81B9/81B9\81DE;
                      RTS                                       ;;81BA|81BA+81BA/81BA\81DF; Return
                                                                ;;                        ;
                                                                ;;                        ;
DATA_0581BB:          db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF        ;;81BB|81BB+81BB/81BB\81E0;
                      db $FF,$FF,$FF,$FF,$FF,$FF,$E0,$00        ;;81C3|81C3+81C3/81C3\81E8;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;81CB|81CB+81CB/81CB\81F0;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;81D3|81D3+81D3/81D3\81F8;
                      db $FE,$00,$7F,$FF,$FF,$FF,$FF,$FF        ;;81DB|81DB+81DB/81DB\8200;
                      db $FF,$FF,$E0,$00,$00,$03,$FF,$FF        ;;81E3|81E3+81E3/81E3\8208;
                      db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF        ;;81EB|81EB+81EB/81EB\8210;
                      db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF        ;;81F3|81F3+81F3/81F3\8218;
                                                                ;;                        ;
CODE_0581FB:          SEP #$30                                  ;;81FB|81FB+81FB/81FB\8220; Index (8 bit) Accum (8 bit)
                      LDA.W !ObjectTileset                      ;;81FD|81FD+81FD/81FD\8222; \
                      ASL A                                     ;;8200|8200+8200/8200\8225;  |Store tileset*2 in X
                      TAX                                       ;;8201|8201+8201/8201\8226; /
                      LDA.B #DATA_0581BB>>16                    ;;8202|8202+8202/8202\8227; \Store x05 in $0F
                      STA.B !_F                                 ;;8204|8204+8204/8204\8229; /
                      LDA.B #DATA_00E55E>>16                    ;;8206|8206+8206/8206\822B; \Store x00 in $84
                      STA.B !SlopesPtr+2                        ;;8208|8208+8208/8208\822D; /
                      LDA.B #$C4                                ;;820A|820A+820A/820A\822F; \Store xC4 in $1430
                      STA.W !SolidTileStart                     ;;820C|820C+820C/820C\8231; /
                      LDA.B #$CA                                ;;820F|820F+820F/820F\8234; \Store xCA in $1431
                      STA.W !SolidTileEnd                       ;;8211|8211+8211/8211\8236; /
                      REP #$20                                  ;;8214|8214+8214/8214\8239; Accum (16 bit)
                      LDA.W #DATA_00E55E                        ;;8216|8216+8216/8216\823B; \Store xE55E in $82-$83
                      STA.B !SlopesPtr                          ;;8219|8219+8219/8219\823E; /
                      LDA.L TilesetMAP16Loc,X                   ;;821B|821B+821B/821B\8240; \Store address to MAP16 data in $00-$01
                      STA.B !_0                                 ;;821F|821F+821F/821F\8244; /
                      LDA.W #Map16Common                        ;;8221|8221+8221/8221\8246; \Store x8000 in $02-$03
                      STA.B !_2                                 ;;8224|8224+8224/8224\8249; /
                      LDA.W #DATA_0581BB                        ;;8226|8226+8226/8226\824B; \Store x81BB in $0D-$0E
                      STA.B !_D                                 ;;8229|8229+8229/8229\824E; /
                      STZ.B !_4                                 ;;822B|822B+822B/822B\8250; \
                      STZ.B !_9                                 ;;822D|822D+822D/822D\8252;  |Store x00 in $04, $09 and $0B
                      STZ.B !_B                                 ;;822F|822F+822F/822F\8254; /
                      REP #$10                                  ;;8231|8231+8231/8231\8256; Index (16 bit)
                      LDY.W #$0000                              ;;8233|8233+8233/8233\8258; \Set X and Y to x0000
                      TYX                                       ;;8236|8236+8236/8236\825B; /
CODE_058237:          SEP #$20                                  ;;8237|8237+8237/8237\825C; Accum (8 bit)
                      LDA.B [!_D],Y                             ;;8239|8239+8239/8239\825E;
                      STA.B !_C                                 ;;823B|823B+823B/823B\8260;
CODE_05823D:          ASL.B !_C                                 ;;823D|823D+823D/823D\8262;
                      BCC +                                     ;;823F|823F+823F/823F\8264;
                      REP #$20                                  ;;8241|8241+8241/8241\8266; Accum (16 bit)
                      LDA.B !_2                                 ;;8243|8243+8243/8243\8268;
                      STA.W !Map16Pointers,X                    ;;8245|8245+8245/8245\826A;
                      LDA.B !_2                                 ;;8248|8248+8248/8248\826D;
                      CLC                                       ;;824A|824A+824A/824A\826F;
                      ADC.W #$0008                              ;;824B|824B+824B/824B\8270;
                      STA.B !_2                                 ;;824E|824E+824E/824E\8273;
                      JMP CODE_058262                           ;;8250|8250+8250/8250\8275;
                                                                ;;                        ;
                    + REP #$20                                  ;;8253|8253+8253/8253\8278; Accum (16 bit)
                      LDA.B !_0                                 ;;8255|8255+8255/8255\827A;
                      STA.W !Map16Pointers,X                    ;;8257|8257+8257/8257\827C;
                      LDA.B !_0                                 ;;825A|825A+825A/825A\827F;
                      CLC                                       ;;825C|825C+825C/825C\8281;
                      ADC.W #$0008                              ;;825D|825D+825D/825D\8282;
                      STA.B !_0                                 ;;8260|8260+8260/8260\8285;
CODE_058262:          SEP #$20                                  ;;8262|8262+8262/8262\8287; Accum (8 bit)
                      INX                                       ;;8264|8264+8264/8264\8289;
                      INX                                       ;;8265|8265+8265/8265\828A;
                      INC.B !_9                                 ;;8266|8266+8266/8266\828B;
                      INC.B !_B                                 ;;8268|8268+8268/8268\828D;
                      LDA.B !_B                                 ;;826A|826A+826A/826A\828F;
                      CMP.B #$08                                ;;826C|826C+826C/826C\8291;
                      BNE CODE_05823D                           ;;826E|826E+826E/826E\8293;
                      STZ.B !_B                                 ;;8270|8270+8270/8270\8295;
                      INY                                       ;;8272|8272+8272/8272\8297;
                      CPY.W #$0040                              ;;8273|8273+8273/8273\8298;
                      BNE CODE_058237                           ;;8276|8276+8276/8276\829B;
                      LDA.W !ObjectTileset                      ;;8278|8278+8278/8278\829D;
                      BEQ CODE_058281                           ;;827B|827B+827B/827B\82A0;
                      CMP.B #$07                                ;;827D|827D+827D/827D\82A2;
                      BNE CODE_0582C5                           ;;827F|827F+827F/827F\82A4;
CODE_058281:          LDA.B #$FF                                ;;8281|8281+8281/8281\82A6;
                      STA.W !SolidTileStart                     ;;8283|8283+8283/8283\82A8;
                      STA.W !SolidTileEnd                       ;;8286|8286+8286/8286\82AB;
                      REP #$30                                  ;;8289|8289+8289/8289\82AE; Index (16 bit) Accum (16 bit)
                      LDA.W #DATA_00E5C8                        ;;828B|828B+828B/828B\82B0;
                      STA.B !SlopesPtr                          ;;828E|828E+828E/828E\82B3;
                      LDA.W #$01C4                              ;;8290|8290+8290/8290\82B5;
                      ASL A                                     ;;8293|8293+8293/8293\82B8;
                      TAY                                       ;;8294|8294+8294/8294\82B9;
                      LDA.W #$8A70                              ;;8295|8295+8295/8295\82BA;
                      STA.B !_0                                 ;;8298|8298+8298/8298\82BD;
                      LDX.W #$0003                              ;;829A|829A+829A/829A\82BF;
                    - LDA.B !_0                                 ;;829D|829D+829D/829D\82C2;
                      STA.W !Map16Pointers,Y                    ;;829F|829F+829F/829F\82C4;
                      CLC                                       ;;82A2|82A2+82A2/82A2\82C7;
                      ADC.W #$0008                              ;;82A3|82A3+82A3/82A3\82C8;
                      STA.B !_0                                 ;;82A6|82A6+82A6/82A6\82CB;
                      INY                                       ;;82A8|82A8+82A8/82A8\82CD;
                      INY                                       ;;82A9|82A9+82A9/82A9\82CE;
                      DEX                                       ;;82AA|82AA+82AA/82AA\82CF;
                      BPL -                                     ;;82AB|82AB+82AB/82AB\82D0;
                      LDA.W #$01EC                              ;;82AD|82AD+82AD/82AD\82D2;
                      ASL A                                     ;;82B0|82B0+82B0/82B0\82D5;
                      TAY                                       ;;82B1|82B1+82B1/82B1\82D6;
                      LDX.W #$0003                              ;;82B2|82B2+82B2/82B2\82D7;
                    - LDA.B !_0                                 ;;82B5|82B5+82B5/82B5\82DA;
                      STA.W !Map16Pointers,Y                    ;;82B7|82B7+82B7/82B7\82DC;
                      CLC                                       ;;82BA|82BA+82BA/82BA\82DF;
                      ADC.W #$0008                              ;;82BB|82BB+82BB/82BB\82E0;
                      STA.B !_0                                 ;;82BE|82BE+82BE/82BE\82E3;
                      INY                                       ;;82C0|82C0+82C0/82C0\82E5;
                      INY                                       ;;82C1|82C1+82C1/82C1\82E6;
                      DEX                                       ;;82C2|82C2+82C2/82C2\82E7;
                      BPL -                                     ;;82C3|82C3+82C3/82C3\82E8;
CODE_0582C5:          SEP #$30                                  ;;82C5|82C5+82C5/82C5\82EA; Index (8 bit) Accum (8 bit)
                      RTS                                       ;;82C7|82C7+82C7/82C7\82EC; Return
                                                                ;;                        ;
CODE_0582C8:          STA.L !Map16TilesLow,X                    ;;82C8|82C8+82C8/82C8\82ED;
                      STA.L !Map16TilesLow+$200,X               ;;82CC|82CC+82CC/82CC\82F1;
                      STA.L !Map16TilesLow+$400,X               ;;82D0|82D0+82D0/82D0\82F5;
                      STA.L !Map16TilesLow+$600,X               ;;82D4|82D4+82D4/82D4\82F9;
                      STA.L !Map16TilesLow+$800,X               ;;82D8|82D8+82D8/82D8\82FD;
                      STA.L !Map16TilesLow+$A00,X               ;;82DC|82DC+82DC/82DC\8301;
                      STA.L !Map16TilesLow+$C00,X               ;;82E0|82E0+82E0/82E0\8305;
                      STA.L !Map16TilesLow+$E00,X               ;;82E4|82E4+82E4/82E4\8309;
                      STA.L !Map16TilesLow+$1000,X              ;;82E8|82E8+82E8/82E8\830D;
                      STA.L !Map16TilesLow+$1200,X              ;;82EC|82EC+82EC/82EC\8311;
                      STA.L !Map16TilesLow+$1400,X              ;;82F0|82F0+82F0/82F0\8315;
                      STA.L !Map16TilesLow+$1600,X              ;;82F4|82F4+82F4/82F4\8319;
                      STA.L !Map16TilesLow+$1800,X              ;;82F8|82F8+82F8/82F8\831D;
                      STA.L !Map16TilesLow+$1A00,X              ;;82FC|82FC+82FC/82FC\8321;
                      STA.L !Map16TilesLow+$1C00,X              ;;8300|8300+8300/8300\8325;
                      STA.L !Map16TilesLow+$1E00,X              ;;8304|8304+8304/8304\8329;
                      STA.L !Map16TilesLow+$2000,X              ;;8308|8308+8308/8308\832D;
                      STA.L !Map16TilesLow+$2200,X              ;;830C|830C+830C/830C\8331;
                      STA.L !Map16TilesLow+$2400,X              ;;8310|8310+8310/8310\8335;
                      STA.L !Map16TilesLow+$2600,X              ;;8314|8314+8314/8314\8339;
                      STA.L !Map16TilesLow+$2800,X              ;;8318|8318+8318/8318\833D;
                      STA.L !Map16TilesLow+$2A00,X              ;;831C|831C+831C/831C\8341;
                      STA.L !Map16TilesLow+$2C00,X              ;;8320|8320+8320/8320\8345;
                      STA.L !Map16TilesLow+$2E00,X              ;;8324|8324+8324/8324\8349;
                      STA.L !Map16TilesLow+$3000,X              ;;8328|8328+8328/8328\834D;
                      STA.L !Map16TilesLow+$3200,X              ;;832C|832C+832C/832C\8351;
                      STA.L !Map16TilesLow+$3400,X              ;;8330|8330+8330/8330\8355;
                      STA.L !Map16TilesLow+$3600,X              ;;8334|8334+8334/8334\8359;
                      INX                                       ;;8338|8338+8338/8338\835D;
                      RTS                                       ;;8339|8339+8339/8339\835E; Return
                                                                ;;                        ;
CODE_05833A:          STA.L !Map16TilesHigh,X                   ;;833A|833A+833A/833A\835F;
                      STA.L !Map16TilesHigh+$200,X              ;;833E|833E+833E/833E\8363;
                      STA.L !Map16TilesHigh+$400,X              ;;8342|8342+8342/8342\8367;
                      STA.L !Map16TilesHigh+$600,X              ;;8346|8346+8346/8346\836B;
                      STA.L !Map16TilesHigh+$800,X              ;;834A|834A+834A/834A\836F;
                      STA.L !Map16TilesHigh+$A00,X              ;;834E|834E+834E/834E\8373;
                      STA.L !Map16TilesHigh+$C00,X              ;;8352|8352+8352/8352\8377;
                      STA.L !Map16TilesHigh+$E00,X              ;;8356|8356+8356/8356\837B;
                      STA.L !Map16TilesHigh+$1000,X             ;;835A|835A+835A/835A\837F;
                      STA.L !Map16TilesHigh+$1200,X             ;;835E|835E+835E/835E\8383;
                      STA.L !Map16TilesHigh+$1400,X             ;;8362|8362+8362/8362\8387;
                      STA.L !Map16TilesHigh+$1600,X             ;;8366|8366+8366/8366\838B;
                      STA.L !Map16TilesHigh+$1800,X             ;;836A|836A+836A/836A\838F;
                      STA.L !Map16TilesHigh+$1A00,X             ;;836E|836E+836E/836E\8393;
                      STA.L !Map16TilesHigh+$1C00,X             ;;8372|8372+8372/8372\8397;
                      STA.L !Map16TilesHigh+$1E00,X             ;;8376|8376+8376/8376\839B;
                      STA.L !Map16TilesHigh+$2000,X             ;;837A|837A+837A/837A\839F;
                      STA.L !Map16TilesHigh+$2200,X             ;;837E|837E+837E/837E\83A3;
                      STA.L !Map16TilesHigh+$2400,X             ;;8382|8382+8382/8382\83A7;
                      STA.L !Map16TilesHigh+$2600,X             ;;8386|8386+8386/8386\83AB;
                      STA.L !Map16TilesHigh+$2800,X             ;;838A|838A+838A/838A\83AF;
                      STA.L !Map16TilesHigh+$2A00,X             ;;838E|838E+838E/838E\83B3;
                      STA.L !Map16TilesHigh+$2C00,X             ;;8392|8392+8392/8392\83B7;
                      STA.L !Map16TilesHigh+$2E00,X             ;;8396|8396+8396/8396\83BB;
                      STA.L !Map16TilesHigh+$3000,X             ;;839A|839A+839A/839A\83BF;
                      STA.L !Map16TilesHigh+$3200,X             ;;839E|839E+839E/839E\83C3;
                      STA.L !Map16TilesHigh+$3400,X             ;;83A2|83A2+83A2/83A2\83C7;
                      STA.L !Map16TilesHigh+$3600,X             ;;83A6|83A6+83A6/83A6\83CB;
                      INX                                       ;;83AA|83AA+83AA/83AA\83CF;
                      RTS                                       ;;83AB|83AB+83AB/83AB\83D0; Return
                                                                ;;                        ;
LoadLevel:            PHP                                       ;;83AC|83AC+83AC/83AC\83D1;
                      SEP #$30                                  ;;83AD|83AD+83AD/83AD\83D2; Index (8 bit) Accum (8 bit)
                      STZ.W !LayerProcessing                    ;;83AF|83AF+83AF/83AF\83D4; Layer number (0=Layer 1, 1=Layer 2)
                      JSR CODE_0584E3                           ;;83B2|83B2+83B2/83B2\83D7; Loads level header
                      JSR CODE_0581FB                           ;;83B5|83B5+83B5/83B5\83DA;
LoadAgain:            LDA.W !LevelModeSetting                   ;;83B8|83B8+83B8/83B8\83DD; Get current level mode
                      CMP.B #$09                                ;;83BB|83BB+83BB/83BB\83E0; \
                      BEQ LoadLevelDone                         ;;83BD|83BD+83BD/83BD\83E2;  |
                      CMP.B #$0B                                ;;83BF|83BF+83BF/83BF\83E4;  |If the current level is a boss level,
                      BEQ LoadLevelDone                         ;;83C1|83C1+83C1/83C1\83E6;  |don't load anything else.
                      CMP.B #$10                                ;;83C3|83C3+83C3/83C3\83E8;  |
                      BEQ LoadLevelDone                         ;;83C5|83C5+83C5/83C5\83EA; /
                      LDY.B #$00                                ;;83C7|83C7+83C7/83C7\83EC; \
                      LDA.B [!Layer1DataPtr],Y                  ;;83C9|83C9+83C9/83C9\83EE;  |
                      CMP.B #$FF                                ;;83CB|83CB+83CB/83CB\83F0;  |If level isn't empty, load the level.
                      BEQ +                                     ;;83CD|83CD+83CD/83CD\83F2;  |
                      JSR LoadLevelData                         ;;83CF|83CF+83CF/83CF\83F4; /
                    + SEP #$30                                  ;;83D2|83D2+83D2/83D2\83F7; Index (8 bit) Accum (8 bit)
                      LDA.W !LevelModeSetting                   ;;83D4|83D4+83D4/83D4\83F9; Get current level mode
                      BEQ LoadLevelDone                         ;;83D7|83D7+83D7/83D7\83FC; \
                      CMP.B #$0A                                ;;83D9|83D9+83D9/83D9\83FE;  |
                      BEQ LoadLevelDone                         ;;83DB|83DB+83DB/83DB\8400;  |
                      CMP.B #$0C                                ;;83DD|83DD+83DD/83DD\8402;  |
                      BEQ LoadLevelDone                         ;;83DF|83DF+83DF/83DF\8404;  |If the current level isn't a Layer 2 level,
                      CMP.B #$0D                                ;;83E1|83E1+83E1/83E1\8406;  |branch to LoadLevelDone
                      BEQ LoadLevelDone                         ;;83E3|83E3+83E3/83E3\8408;  |
                      CMP.B #$0E                                ;;83E5|83E5+83E5/83E5\840A;  |
                      BEQ LoadLevelDone                         ;;83E7|83E7+83E7/83E7\840C;  |
                      CMP.B #$11                                ;;83E9|83E9+83E9/83E9\840E;  |
                      BEQ LoadLevelDone                         ;;83EB|83EB+83EB/83EB\8410;  |
                      CMP.B #$1E                                ;;83ED|83ED+83ED/83ED\8412;  |
                      BEQ LoadLevelDone                         ;;83EF|83EF+83EF/83EF\8414; /
                      INC.W !LayerProcessing                    ;;83F1|83F1+83F1/83F1\8416; \Increase layer number and load into A
                      LDA.W !LayerProcessing                    ;;83F4|83F4+83F4/83F4\8419; /
                      CMP.B #$02                                ;;83F7|83F7+83F7/83F7\841C; \If it is x02, end. (Layer 1 and 2 are done)
                      BEQ LoadLevelDone                         ;;83F9|83F9+83F9/83F9\841E; /
                      LDA.B !Layer2DataPtr                      ;;83FB|83FB+83FB/83FB\8420; \
                      CLC                                       ;;83FD|83FD+83FD/83FD\8422;  |
                      ADC.B #$05                                ;;83FE|83FE+83FE/83FE\8423;  |
                      STA.B !Layer1DataPtr                      ;;8400|8400+8400/8400\8425;  |Move address stored in $68-$6A to $65-$67.
                      LDA.B !Layer2DataPtr+1                    ;;8402|8402+8402/8402\8427;  |(Move Layer 2 address to "Level to load" address)
                      ADC.B #$00                                ;;8404|8404+8404/8404\8429;  |It also increases the address by 5 (to ignore Layer 2's header)
                      STA.B !Layer1DataPtr+1                    ;;8406|8406+8406/8406\842B;  |
                      LDA.B !Layer2DataPtr+2                    ;;8408|8408+8408/8408\842D;  |
                      STA.B !Layer1DataPtr+2                    ;;840A|840A+840A/840A\842F; /
                      STZ.W !LevelLoadObject                    ;;840C|840C+840C/840C\8431;
                      JMP LoadAgain                             ;;840F|840F+840F/840F\8434;
                                                                ;;                        ;
LoadLevelDone:        STZ.W !LayerProcessing                    ;;8412|8412+8412/8412\8437;
                      PLP                                       ;;8415|8415+8415/8415\843A;
                      RTS                                       ;;8416|8416+8416/8416\843B; Return
                                                                ;;                        ;
                                                                ;;                        ;
VerticalTable:        db $00,$00,$80,$01,$81,$02,$82,$03        ;;8417|8417+8417/8417\843C; Vertical level settings for each level mode ; Format:
                      db $83,$00,$01,$00,$00,$01,$00,$00        ;;841F|841F+841F/841F\8444; ?uuuuu?v
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;8427|8427+8427/8427\844C; ?= Unknown purpose ; u= Unused?
                      db $00,$00,$00,$00,$00,$00,$00,$80        ;;842F|842F+842F/842F\8454; v= Vertical level
LevMainScrnTbl:       db $15,$15,$17,$15,$15,$15,$17,$15        ;;8437|8437+8437/8437\845C; Main screen settings for each level mode
                      db $17,$15,$15,$15,$15,$15,$04,$04        ;;843F|843F+843F/843F\8464;
                      db $15,$17,$15,$15,$15,$15,$15,$15        ;;8447|8447+8447/8447\846C;
                      db $15,$15,$15,$15,$15,$15,$01,$02        ;;844F|844F+844F/844F\8474;
LevSubScrnTbl:        db $02,$02,$00,$02,$02,$02,$00,$02        ;;8457|8457+8457/8457\847C; Subscreen settings for each level mode
                      db $00,$00,$02,$00,$02,$02,$13,$13        ;;845F|845F+845F/845F\8484;
                      db $00,$00,$02,$02,$02,$02,$02,$02        ;;8467|8467+8467/8467\848C;
                      db $02,$02,$02,$02,$02,$02,$16,$15        ;;846F|846F+846F/846F\8494;
LevCGADSUBtable:      db $24,$24,$24,$24,$24,$24,$20,$24        ;;8477|8477+8477/8477\849C; CGADSUB settings for each level mode
                      db $24,$20,$24,$20,$70,$70,$24,$24        ;;847F|847F+847F/847F\84A4;
                      db $20,$FF,$24,$24,$24,$24,$24,$24        ;;8487|8487+8487/8487\84AC;
                      db $24,$24,$24,$24,$24,$24,$21,$22        ;;848F|848F+848F/848F\84B4;
SpecialLevTable:      db $00,$00,$00,$00,$00,$00,$00,$00        ;;8497|8497+8497/8497\84BC; Special level settings for each level mode ; 00: Normal level
                      db $00,$C0,$00,$80,$00,$00,$00,$00        ;;849F|849F+849F/849F\84C4; 80: Iggy/Larry level ; C0: Morton/Ludwig/Roy level
                      db $C1,$00,$00,$00,$00,$00,$00,$00        ;;84A7|84A7+84A7/84A7\84CC; C1: Bowser level
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;84AF|84AF+84AF/84AF\84D4;
LevXYPPCCCTtbl:       db $20,$20,$20,$30,$30,$30,$30,$30        ;;84B7|84B7+84B7/84B7\84DC; XYPPCCCT settings for each level mode ; (The XYPPCCCT setting appears to be XORed with nearly all
                      db $30,$30,$30,$30,$30,$30,$20,$20        ;;84BF|84BF+84BF/84BF\84E4; sprites' XYPPCCCT settings)
                      db $30,$30,$30,$30,$30,$30,$30,$30        ;;84C7|84C7+84C7/84C7\84EC;
                      db $30,$30,$30,$30,$30,$30,$30,$30        ;;84CF|84CF+84CF/84CF\84F4;
TimerTable:           db $00,$02,$03,$04                        ;;84D7|84D7+84D7/84D7\84FC;
                                                                ;;                        ;
LevelMusicTable:      db !BGM_OVERWORLD                         ;;84DB|84DB+84DB/84DB\8500; A level can choose between 8 tracks. ; This table contains the tracks to choose from.
                      db !BGM_UNDERGROUND                       ;;84DC|84DC+84DC/84DC\8501;
                      db !BGM_ATHLETIC                          ;;84DD|84DD+84DD/84DD\8502;
                      db !BGM_CASTLE                            ;;84DE|84DE+84DE/84DE\8503;
                      db !BGM_GHOSTHOUSE                        ;;84DF|84DF+84DF/84DF\8504;
                      db !BGM_UNDERWATER                        ;;84E0|84E0+84E0/84E0\8505;
                      db !BGM_BOSSFIGHT                         ;;84E1|84E1+84E1/84E1\8506;
                      db !BGM_BONUSGAME                         ;;84E2|84E2+84E2/84E2\8507;
                                                                ;;                        ;
CODE_0584E3:          LDY.B #$00                                ;;84E3|84E3+84E3/84E3\8508;
                      LDA.B [!Layer1DataPtr],Y                  ;;84E5|84E5+84E5/84E5\850A; Get first byte
                      TAX                                       ;;84E7|84E7+84E7/84E7\850C; \
                      AND.B #$1F                                ;;84E8|84E8+84E8/84E8\850D;  |Get amount of screens
                      INC A                                     ;;84EA|84EA+84EA/84EA\850F;  |
                      STA.B !LevelScrLength                     ;;84EB|84EB+84EB/84EB\8510; /
                      TXA                                       ;;84ED|84ED+84ED/84ED\8512; \
                      LSR A                                     ;;84EE|84EE+84EE/84EE\8513;  |
                      LSR A                                     ;;84EF|84EF+84EF/84EF\8514;  |
                      LSR A                                     ;;84F0|84F0+84F0/84F0\8515;  |Get BG color setting
                      LSR A                                     ;;84F1|84F1+84F1/84F1\8516;  |
                      LSR A                                     ;;84F2|84F2+84F2/84F2\8517;  |
                      STA.W !BackgroundPalette                  ;;84F3|84F3+84F3/84F3\8518; /
                      INY                                       ;;84F6|84F6+84F6/84F6\851B; \Get second byte
                      LDA.B [!Layer1DataPtr],Y                  ;;84F7|84F7+84F7/84F7\851C; /
                      AND.B #$1F                                ;;84F9|84F9+84F9/84F9\851E; \Get level mode
                      STA.W !LevelModeSetting                   ;;84FB|84FB+84FB/84FB\8520; /
                      TAX                                       ;;84FE|84FE+84FE/84FE\8523;
                      LDA.L LevXYPPCCCTtbl,X                    ;;84FF|84FF+84FF/84FF\8524; \Get XYPPCCCT settings from table
                      STA.B !SpriteProperties                   ;;8503|8503+8503/8503\8528; /
                      LDA.L LevMainScrnTbl,X                    ;;8505|8505+8505/8505\852A; \Get main screen setting from table
                      STA.W !ThroughMain                        ;;8509|8509+8509/8509\852E; /
                      LDA.L LevSubScrnTbl,X                     ;;850C|850C+850C/850C\8531; \Get subscreen setting from table
                      STA.W !ThroughSub                         ;;8510|8510+8510/8510\8535; /
                      LDA.L LevCGADSUBtable,X                   ;;8513|8513+8513/8513\8538; \Get CGADSUB settings from table
                      STA.B !ColorSettings                      ;;8517|8517+8517/8517\853C; /
                      LDA.L SpecialLevTable,X                   ;;8519|8519+8519/8519\853E; \Get special level setting from table
                      STA.W !IRQNMICommand                      ;;851D|851D+851D/851D\8542; /
                      LDA.L VerticalTable,X                     ;;8520|8520+8520/8520\8545; \Get vertical level setting from table
                      STA.B !ScreenMode                         ;;8524|8524+8524/8524\8549; /
                      LSR A                                     ;;8526|8526+8526/8526\854B; \
                      LDA.B !LevelScrLength                     ;;8527|8527+8527/8527\854C;  |
                      LDX.B #$01                                ;;8529|8529+8529/8529\854E;  |If level mode is even:
                      BCC +                                     ;;852B|852B+852B/852B\8550;  |Store screen amount in $5E and x01 in $5F
                      TAX                                       ;;852D|852D+852D/852D\8552;  |Otherwise:
                      LDA.B #$01                                ;;852E|852E+852E/852E\8553;  |Store x01 in $5E and screen amount in $5F
                    + STA.B !LastScreenHoriz                    ;;8530|8530+8530/8530\8555;  |
                      STX.B !LastScreenVert                     ;;8532|8532+8532/8532\8557; /
                      LDA.B [!Layer1DataPtr],Y                  ;;8534|8534+8534/8534\8559; Reload second byte
                      LSR A                                     ;;8536|8536+8536/8536\855B; \
                      LSR A                                     ;;8537|8537+8537/8537\855C;  |
                      LSR A                                     ;;8538|8538+8538/8538\855D;  |Get BG color settings
                      LSR A                                     ;;8539|8539+8539/8539\855E;  |
                      LSR A                                     ;;853A|853A+853A/853A\855F;  |
                      STA.W !BackAreaColor                      ;;853B|853B+853B/853B\8560; /
                      INY                                       ;;853E|853E+853E/853E\8563; \Get third byte
                      LDA.B [!Layer1DataPtr],Y                  ;;853F|853F+853F/853F\8564; /
                      STA.B !_0                                 ;;8541|8541+8541/8541\8566; "Push" third byte
                      TAX                                       ;;8543|8543+8543/8543\8568; "Push" third byte
                      AND.B #$0F                                ;;8544|8544+8544/8544\8569; \Load sprite set
                      STA.W !SpriteTileset                      ;;8546|8546+8546/8546\856B; /
                      TXA                                       ;;8549|8549+8549/8549\856E; "Pull" third byte
                      LSR A                                     ;;854A|854A+854A/854A\856F; \
                      LSR A                                     ;;854B|854B+854B/854B\8570;  |
                      LSR A                                     ;;854C|854C+854C/854C\8571;  |
                      LSR A                                     ;;854D|854D+854D/854D\8572;  |
                      AND.B #$07                                ;;854E|854E+854E/854E\8573;  |
                      TAX                                       ;;8550|8550+8550/8550\8575;  |Get music
                      LDA.L LevelMusicTable,X                   ;;8551|8551+8551/8551\8576;  |
                      LDX.W !MusicBackup                        ;;8555|8555+8555/8555\857A;  | \
                      BPL +                                     ;;8558|8558+8558/8558\857D;  |  |
                      ORA.B #$80                                ;;855A|855A+855A/855A\857F;  |  |Related to not restarting music if the new track
                    + CMP.W !MusicBackup                        ;;855C|855C+855C/855C\8581;  |  |is the same as the old one?
                      BNE +                                     ;;855F|855F+855F/855F\8584;  |  |
                      ORA.B #$40                                ;;8561|8561+8561/8561\8586;  | /
                    + STA.W !MusicBackup                        ;;8563|8563+8563/8563\8588; /
                      LDA.B !_0                                 ;;8566|8566+8566/8566\858B; "Pull" third byte
                      AND.B #$80                                ;;8568|8568+8568/8568\858D; \
                      LSR A                                     ;;856A|856A+856A/856A\858F;  |
                      LSR A                                     ;;856B|856B+856B/856B\8590;  |
                      LSR A                                     ;;856C|856C+856C/856C\8591;  |Get Layer 3 priority
                      LSR A                                     ;;856D|856D+856D/856D\8592;  |
                      ORA.B #$01                                ;;856E|856E+856E/856E\8593;  |
                      STA.B !MainBGMode                         ;;8570|8570+8570/8570\8595; /
                      INY                                       ;;8572|8572+8572/8572\8597; \Get fourth bit
                      LDA.B [!Layer1DataPtr],Y                  ;;8573|8573+8573/8573\8598; /
                      STA.B !_0                                 ;;8575|8575+8575/8575\859A; "Push" fourth bit
                      LSR A                                     ;;8577|8577+8577/8577\859C; \
                      LSR A                                     ;;8578|8578+8578/8578\859D;  |
                      LSR A                                     ;;8579|8579+8579/8579\859E;  |
                      LSR A                                     ;;857A|857A+857A/857A\859F;  |
                      LSR A                                     ;;857B|857B+857B/857B\85A0;  |
                      LSR A                                     ;;857C|857C+857C/857C\85A1;  |
                      TAX                                       ;;857D|857D+857D/857D\85A2;  |Get time
                      LDA.W !SublevelCount                      ;;857E|857E+857E/857E\85A3;  |
                      BNE +                                     ;;8581|8581+8581/8581\85A6;  |
                      LDA.L TimerTable,X                        ;;8583|8583+8583/8583\85A8;  |
                      STA.W !InGameTimerHundreds                ;;8587|8587+8587/8587\85AC;  |
                      STZ.W !InGameTimerTens                    ;;858A|858A+858A/858A\85AF;  |
                      STZ.W !InGameTimerOnes                    ;;858D|858D+858D/858D\85B2; /
                    + LDA.B !_0                                 ;;8590|8590+8590/8590\85B5; "Pull" fourth bit
                      AND.B #$07                                ;;8592|8592+8592/8592\85B7; \Get FG color settings
                      STA.W !ForegroundPalette                  ;;8594|8594+8594/8594\85B9; /
                      LDA.B !_0                                 ;;8597|8597+8597/8597\85BC; "Pull" fourth bit (again)
                      AND.B #$38                                ;;8599|8599+8599/8599\85BE; \
                      LSR A                                     ;;859B|859B+859B/859B\85C0;  |
                      LSR A                                     ;;859C|859C+859C/859C\85C1;  |Get sprite palette
                      LSR A                                     ;;859D|859D+859D/859D\85C2;  |
                      STA.W !SpritePalette                      ;;859E|859E+859E/859E\85C3; /
                      INY                                       ;;85A1|85A1+85A1/85A1\85C6; \Get fifth byte
                      LDA.B [!Layer1DataPtr],Y                  ;;85A2|85A2+85A2/85A2\85C7; /
                      AND.B #$0F                                ;;85A4|85A4+85A4/85A4\85C9; \
                      STA.W !ObjectTileset                      ;;85A6|85A6+85A6/85A6\85CB;  |Get tileset
                      STA.W !Empty1932                          ;;85A9|85A9+85A9/85A9\85CE; /
                      LDA.B [!Layer1DataPtr],Y                  ;;85AC|85AC+85AC/85AC\85D1; Reload fifth byte
                      AND.B #$C0                                ;;85AE|85AE+85AE/85AE\85D3; \
                      ASL A                                     ;;85B0|85B0+85B0/85B0\85D5;  |
                      ROL A                                     ;;85B1|85B1+85B1/85B1\85D6;  |Get item memory settings
                      ROL A                                     ;;85B2|85B2+85B2/85B2\85D7;  |
                      STA.W !ItemMemorySetting                  ;;85B3|85B3+85B3/85B3\85D8; /
                      LDA.B [!Layer1DataPtr],Y                  ;;85B6|85B6+85B6/85B6\85DB; Reload fifth byte
                      AND.B #$30                                ;;85B8|85B8+85B8/85B8\85DD; \
                      LSR A                                     ;;85BA|85BA+85BA/85BA\85DF;  |Get horizontal/vertical scroll
                      LSR A                                     ;;85BB|85BB+85BB/85BB\85E0;  |
                      LSR A                                     ;;85BC|85BC+85BC/85BC\85E1;  |
                      LSR A                                     ;;85BD|85BD+85BD/85BD\85E2;  |
                      CMP.B #$03                                ;;85BE|85BE+85BE/85BE\85E3;  | \
                      BNE +                                     ;;85C0|85C0+85C0/85C0\85E5;  |  |If scroll mode is x03, disable both
                      STZ.W !HorizLayer1Setting                 ;;85C2|85C2+85C2/85C2\85E7;  |  |vertical and horizontal scroll
                      LDA.B #$00                                ;;85C5|85C5+85C5/85C5\85EA;  | /
                    + STA.W !VertLayer1Setting                  ;;85C7|85C7+85C7/85C7\85EC; /
                      LDA.B !Layer1DataPtr                      ;;85CA|85CA+85CA/85CA\85EF; \
                      CLC                                       ;;85CC|85CC+85CC/85CC\85F1;  |
                      ADC.B #$05                                ;;85CD|85CD+85CD/85CD\85F2;  |
                      STA.B !Layer1DataPtr                      ;;85CF|85CF+85CF/85CF\85F4;  |Make $65 point at the level data
                      LDA.B !Layer1DataPtr+1                    ;;85D1|85D1+85D1/85D1\85F6;  |(Level data comes right after the header)
                      ADC.B #$00                                ;;85D3|85D3+85D3/85D3\85F8;  |
                      STA.B !Layer1DataPtr+1                    ;;85D5|85D5+85D5/85D5\85FA; /
                      RTS                                       ;;85D7|85D7+85D7/85D7\85FC; We're done!
                                                                ;;                        ;
CODE_0585D8:          LDA.B !LvlLoadObjNo                       ;;85D8|85D8+85D8/85D8\85FD;
                      BNE CODE_0585E2                           ;;85DA|85DA+85DA/85DA\85FF;
                      LDA.B !LvlLoadObjSize                     ;;85DC|85DC+85DC/85DC\8601;
                      CMP.B #$02                                ;;85DE|85DE+85DE/85DE\8603;
                      BCC +                                     ;;85E0|85E0+85E0/85E0\8605;
CODE_0585E2:          LDA.B !_A                                 ;;85E2|85E2+85E2/85E2\8607;
                      AND.B #$0F                                ;;85E4|85E4+85E4/85E4\8609;
                      STA.B !_0                                 ;;85E6|85E6+85E6/85E6\860B;
                      LDA.B !_B                                 ;;85E8|85E8+85E8/85E8\860D;
                      AND.B #$0F                                ;;85EA|85EA+85EA/85EA\860F;
                      STA.B !_1                                 ;;85EC|85EC+85EC/85EC\8611;
                      LDA.B !_A                                 ;;85EE|85EE+85EE/85EE\8613;
                      AND.B #$F0                                ;;85F0|85F0+85F0/85F0\8615;
                      ORA.B !_1                                 ;;85F2|85F2+85F2/85F2\8617;
                      STA.B !_A                                 ;;85F4|85F4+85F4/85F4\8619;
                      LDA.B !_B                                 ;;85F6|85F6+85F6/85F6\861B;
                      AND.B #$F0                                ;;85F8|85F8+85F8/85F8\861D;
                      ORA.B !_0                                 ;;85FA|85FA+85FA/85FA\861F;
                      STA.B !_B                                 ;;85FC|85FC+85FC/85FC\8621;
                    + RTS                                       ;;85FE|85FE+85FE/85FE\8623; Return
                                                                ;;                        ;
LoadLevelData:        SEP #$30                                  ;;85FF|85FF+85FF/85FF\8624; Index (8 bit) Accum (8 bit)
                      LDY.B #$00                                ;;8601|8601+8601/8601\8626; \
                      LDA.B [!Layer1DataPtr],Y                  ;;8603|8603+8603/8603\8628;  |
                      STA.B !_A                                 ;;8605|8605+8605/8605\862A;  |
                      INY                                       ;;8607|8607+8607/8607\862C;  |
                      LDA.B [!Layer1DataPtr],Y                  ;;8608|8608+8608/8608\862D;  |Read three bytes of level data
                      STA.B !_B                                 ;;860A|860A+860A/860A\862F;  |Store them in $0A, $0B and $59
                      INY                                       ;;860C|860C+860C/860C\8631;  |
                      LDA.B [!Layer1DataPtr],Y                  ;;860D|860D+860D/860D\8632;  |
                      STA.B !LvlLoadObjSize                     ;;860F|860F+860F/860F\8634;  |
                      INY                                       ;;8611|8611+8611/8611\8636; /
                      TYA                                       ;;8612|8612+8612/8612\8637; \
                      CLC                                       ;;8613|8613+8613/8613\8638;  |
                      ADC.B !Layer1DataPtr                      ;;8614|8614+8614/8614\8639;  |
                      STA.B !Layer1DataPtr                      ;;8616|8616+8616/8616\863B;  |Increase address by 3 (as 3 bytes were read)
                      LDA.B !Layer1DataPtr+1                    ;;8618|8618+8618/8618\863D;  |
                      ADC.B #$00                                ;;861A|861A+861A/861A\863F;  |
                      STA.B !Layer1DataPtr+1                    ;;861C|861C+861C/861C\8641; /
                      LDA.B !_B                                 ;;861E|861E+861E/861E\8643; \
                      LSR A                                     ;;8620|8620+8620/8620\8645;  |
                      LSR A                                     ;;8621|8621+8621/8621\8646;  |
                      LSR A                                     ;;8622|8622+8622/8622\8647;  |
                      LSR A                                     ;;8623|8623+8623/8623\8648;  |
                      STA.B !LvlLoadObjNo                       ;;8624|8624+8624/8624\8649;  |Get block number, store in $5A
                      LDA.B !_A                                 ;;8626|8626+8626/8626\864B;  |
                      AND.B #$60                                ;;8628|8628+8628/8628\864D;  |
                      LSR A                                     ;;862A|862A+862A/862A\864F;  |
                      ORA.B !LvlLoadObjNo                       ;;862B|862B+862B/862B\8650;  |
                      STA.B !LvlLoadObjNo                       ;;862D|862D+862D/862D\8652; /
                      LDA.B !ScreenMode                         ;;862F|862F+862F/862F\8654; A = vertical level setting
                      LDY.W !LayerProcessing                    ;;8631|8631+8631/8631\8656; \
                      BEQ +                                     ;;8634|8634+8634/8634\8659;  |If $1933=x00, divide A by 2
                      LSR A                                     ;;8636|8636+8636/8636\865B; /
                    + AND.B #$01                                ;;8637|8637+8637/8637\865C; \
                      BEQ +                                     ;;8639|8639+8639/8639\865E;  |If lowest bit of A is set, jump to sub
                      JSR CODE_0585D8                           ;;863B|863B+863B/863B\8660; /
                    + LDA.B !_A                                 ;;863E|863E+863E/863E\8663; \
                      AND.B #$0F                                ;;8640|8640+8640/8640\8665;  |
                      ASL A                                     ;;8642|8642+8642/8642\8667;  |
                      ASL A                                     ;;8643|8643+8643/8643\8668;  |
                      ASL A                                     ;;8644|8644+8644/8644\8669;  |Set upper half of $57 to Y pos
                      ASL A                                     ;;8645|8645+8645/8645\866A;  |and lower half of $57 to X pos
                      STA.B !LevelLoadPos                       ;;8646|8646+8646/8646\866B;  |
                      LDA.B !_B                                 ;;8648|8648+8648/8648\866D;  |
                      AND.B #$0F                                ;;864A|864A+864A/864A\866F;  |
                      ORA.B !LevelLoadPos                       ;;864C|864C+864C/864C\8671;  |
                      STA.B !LevelLoadPos                       ;;864E|864E+864E/864E\8673; /
                      REP #$20                                  ;;8650|8650+8650/8650\8675; Accum (16 bit)
                      LDA.W !LayerProcessing                    ;;8652|8652+8652/8652\8677; \
                      AND.W #$00FF                              ;;8655|8655+8655/8655\867A;  |Load $1993*2 into X
                      ASL A                                     ;;8658|8658+8658/8658\867D;  |
                      TAX                                       ;;8659|8659+8659/8659\867E; /
                      LDA.L LoadBlkPtrs,X                       ;;865A|865A+865A/865A\867F;
                      STA.B !_3                                 ;;865E|865E+865E/865E\8683;
                      LDA.L LoadBlkTable2,X                     ;;8660|8660+8660/8660\8685;
                      STA.B !_6                                 ;;8664|8664+8664/8664\8689;
                      LDA.W !LevelModeSetting                   ;;8666|8666+8666/8666\868B; \
                      AND.W #$001F                              ;;8669|8669+8669/8669\868E;  |Set Y to Level Mode*2
                      ASL A                                     ;;866C|866C+866C/866C\8691;  |
                      TAY                                       ;;866D|866D+866D/866D\8692; /
                      SEP #$20                                  ;;866E|866E+866E/866E\8693; Accum (8 bit)
                      LDA.B #$00                                ;;8670|8670+8670/8670\8695;
                      STA.B !_5                                 ;;8672|8672+8672/8672\8697;
                      STA.B !_8                                 ;;8674|8674+8674/8674\8699;
                      LDA.B [!_3],Y                             ;;8676|8676+8676/8676\869B;
                      STA.B !_0                                 ;;8678|8678+8678/8678\869D;
                      LDA.B [!_6],Y                             ;;867A|867A+867A/867A\869F;
                      STA.B !_D                                 ;;867C|867C+867C/867C\86A1;
                      INY                                       ;;867E|867E+867E/867E\86A3;
                      LDA.B [!_3],Y                             ;;867F|867F+867F/867F\86A4;
                      STA.B !_1                                 ;;8681|8681+8681/8681\86A6;
                      LDA.B [!_6],Y                             ;;8683|8683+8683/8683\86A8;
                      STA.B !_E                                 ;;8685|8685+8685/8685\86AA;
                      LDA.B #$00                                ;;8687|8687+8687/8687\86AC;
                      STA.B !_2                                 ;;8689|8689+8689/8689\86AE;
                      STA.B !_F                                 ;;868B|868B+868B/868B\86B0;
                      LDA.B !_A                                 ;;868D|868D+868D/868D\86B2; \
                      AND.B #$80                                ;;868F|868F+868F/868F\86B4;  |
                      ASL A                                     ;;8691|8691+8691/8691\86B6;  |If New Page flag is set, increase $1928 by 1
                      ADC.W !LevelLoadObject                    ;;8692|8692+8692/8692\86B7;  |(A = $1928)
                      STA.W !LevelLoadObject                    ;;8695|8695+8695/8695\86BA; /
                      STA.W !LevelLoadObjectTile                ;;8698|8698+8698/8698\86BD; Store A in $1BA1
                      ASL A                                     ;;869B|869B+869B/869B\86C0; \
                      CLC                                       ;;869C|869C+869C/869C\86C1;  |Multiply A by 2 and add $1928 to it
                      ADC.W !LevelLoadObject                    ;;869D|869D+869D/869D\86C2;  |Set Y to A
                      TAY                                       ;;86A0|86A0+86A0/86A0\86C5; /
                      LDA.B [!_0],Y                             ;;86A1|86A1+86A1/86A1\86C6;
                      STA.B !Map16LowPtr                        ;;86A3|86A3+86A3/86A3\86C8;
                      LDA.B [!_D],Y                             ;;86A5|86A5+86A5/86A5\86CA;
                      STA.B !Map16HighPtr                       ;;86A7|86A7+86A7/86A7\86CC;
                      INY                                       ;;86A9|86A9+86A9/86A9\86CE;
                      LDA.B [!_0],Y                             ;;86AA|86AA+86AA/86AA\86CF;
                      STA.B !Map16LowPtr+1                      ;;86AC|86AC+86AC/86AC\86D1;
                      LDA.B [!_D],Y                             ;;86AE|86AE+86AE/86AE\86D3;
                      STA.B !Map16HighPtr+1                     ;;86B0|86B0+86B0/86B0\86D5;
                      INY                                       ;;86B2|86B2+86B2/86B2\86D7;
                      LDA.B [!_0],Y                             ;;86B3|86B3+86B3/86B3\86D8;
                      STA.B !Map16LowPtr+2                      ;;86B5|86B5+86B5/86B5\86DA;
                      LDA.B [!_D],Y                             ;;86B7|86B7+86B7/86B7\86DC;
                      STA.B !Map16HighPtr+2                     ;;86B9|86B9+86B9/86B9\86DE;
                      LDA.B !_A                                 ;;86BB|86BB+86BB/86BB\86E0; \
                      AND.B #$10                                ;;86BD|86BD+86BD/86BD\86E2;  |If high coordinate is set...
                      BEQ +                                     ;;86BF|86BF+86BF/86BF\86E4;  |(Lower half of horizontal level)
                      INC.B !Map16LowPtr+1                      ;;86C1|86C1+86C1/86C1\86E6;  |(Right half of vertical level)
                      INC.B !Map16HighPtr+1                     ;;86C3|86C3+86C3/86C3\86E8;  |...increase $6C and $6F
                    + LDA.B !LvlLoadObjNo                       ;;86C5|86C5+86C5/86C5\86EA; \
                      BNE +                                     ;;86C7|86C7+86C7/86C7\86EC;  |If block number is x00 (extended object),
                      JSR LevLoadExtObj                         ;;86C9|86C9+86C9/86C9\86EE;  |Jump to sub LevLoadExtObj
                      JMP LevLoadContinue                       ;;86CC|86CC+86CC/86CC\86F1;  |                  (Why didn't they use BRA here?)
                                                                ;;                        ;
                    + JSR LevLoadNrmObj                         ;;86CF|86CF+86CF/86CF\86F4;  |Jump to sub LevLoadNrmObj
LevLoadContinue:      SEP #$20                                  ;;86D2|86D2+86D2/86D2\86F7; Accum (8 bit)
                      REP #$10                                  ;;86D4|86D4+86D4/86D4\86F9; Index (16 bit)
                      LDY.W #$0000                              ;;86D6|86D6+86D6/86D6\86FB; \
                      LDA.B [!Layer1DataPtr],Y                  ;;86D9|86D9+86D9/86D9\86FE;  |
                      CMP.B #$FF                                ;;86DB|86DB+86DB/86DB\8700;  |If the next byte is xFF, return (loading is done).
                      BEQ +                                     ;;86DD|86DD+86DD/86DD\8702;  |Otherwise, repeat this routine.
                      JMP LoadLevelData                         ;;86DF|86DF+86DF/86DF\8704;  |
                                                                ;;                        ;
                    + RTS                                       ;;86E2|86E2+86E2/86E2\8707; /
                                                                ;;                        ;
LevLoadExtObj:        SEP #$30                                  ;;86E3|86E3+86E3/86E3\8708; Index (8 bit) Accum (8 bit)
                      JSL GenExtendedObj                        ;;86E5|86E5+86E5/86E5\870A; In Bank 0D
                      RTS                                       ;;86E9|86E9+86E9/86E9\870E; Return
                                                                ;;                        ;
LevLoadNrmObj:        SEP #$30                                  ;;86EA|86EA+86EA/86EA\870F; Index (8 bit) Accum (8 bit)
                      JSL GenNormalObj                          ;;86EC|86EC+86EC/86EC\8711; In Bank 0D
                      RTS                                       ;;86F0|86F0+86F0/86F0\8715; Return
                                                                ;;                        ;
CODE_0586F1:          PHP                                       ;;86F1|86F1+86F1/86F1\8716;
                      REP #$30                                  ;;86F2|86F2+86F2/86F2\8717; Index (16 bit) Accum (16 bit)
                      JSR CODE_05877E                           ;;86F4|86F4+86F4/86F4\8719;
                      SEP #$20                                  ;;86F7|86F7+86F7/86F7\871C; Accum (8 bit)
                      LDA.B !ScreenMode                         ;;86F9|86F9+86F9/86F9\871E;
                      AND.B #$01                                ;;86FB|86FB+86FB/86FB\8720;
                      BNE CODE_058713                           ;;86FD|86FD+86FD/86FD\8722;
                      REP #$20                                  ;;86FF|86FF+86FF/86FF\8724; Accum (16 bit)
                      LDA.B !Layer1ScrollDir                    ;;8701|8701+8701/8701\8726;
                      AND.W #$00FF                              ;;8703|8703+8703/8703\8728;
                      TAX                                       ;;8706|8706+8706/8706\872B;
                      LDA.B !Layer1XPos                         ;;8707|8707+8707/8707\872C;
                      AND.W #$FFF0                              ;;8709|8709+8709/8709\872E;
                      CMP.B !Layer1PrevTileUp,X                 ;;870C|870C+870C/870C\8731;
                      BEQ +                                     ;;870E|870E+870E/870E\8733;
                      JMP CODE_058724                           ;;8710|8710+8710/8710\8735;
                                                                ;;                        ;
CODE_058713:          REP #$20                                  ;;8713|8713+8713/8713\8738; Accum (16 bit)
                      LDA.B !Layer1ScrollDir                    ;;8715|8715+8715/8715\873A;
                      AND.W #$00FF                              ;;8717|8717+8717/8717\873C;
                      TAX                                       ;;871A|871A+871A/871A\873F;
                      LDA.B !Layer1YPos                         ;;871B|871B+871B/871B\8740;
                      AND.W #$FFF0                              ;;871D|871D+871D/871D\8742;
                      CMP.B !Layer1PrevTileUp,X                 ;;8720|8720+8720/8720\8745;
                      BEQ +                                     ;;8722|8722+8722/8722\8747;
CODE_058724:          STA.B !Layer1PrevTileUp,X                 ;;8724|8724+8724/8724\8749;
                      TXA                                       ;;8726|8726+8726/8726\874B;
                      EOR.W #$0002                              ;;8727|8727+8727/8727\874C;
                      TAX                                       ;;872A|872A+872A/872A\874F;
                      LDA.W #$FFFF                              ;;872B|872B+872B/872B\8750;
                      STA.B !Layer1PrevTileUp,X                 ;;872E|872E+872E/872E\8753;
                      JSL CODE_05881A                           ;;8730|8730+8730/8730\8755;
                      JMP CODE_058774                           ;;8734|8734+8734/8734\8759;
                                                                ;;                        ;
                    + SEP #$20                                  ;;8737|8737+8737/8737\875C; Accum (8 bit)
                      LDA.B !ScreenMode                         ;;8739|8739+8739/8739\875E;
                      AND.B #$02                                ;;873B|873B+873B/873B\8760;
                      BNE CODE_058753                           ;;873D|873D+873D/873D\8762;
                      REP #$20                                  ;;873F|873F+873F/873F\8764; Accum (16 bit)
                      LDA.B !Layer2ScrollDir                    ;;8741|8741+8741/8741\8766;
                      AND.W #$00FF                              ;;8743|8743+8743/8743\8768;
                      TAX                                       ;;8746|8746+8746/8746\876B;
                      LDA.B !Layer2XPos                         ;;8747|8747+8747/8747\876C;
                      AND.W #$FFF0                              ;;8749|8749+8749/8749\876E;
                      CMP.B !Layer2PrevTileUp,X                 ;;874C|874C+874C/874C\8771;
                      BEQ CODE_058774                           ;;874E|874E+874E/874E\8773;
                      JMP CODE_058764                           ;;8750|8750+8750/8750\8775;
                                                                ;;                        ;
CODE_058753:          REP #$20                                  ;;8753|8753+8753/8753\8778; Accum (16 bit)
                      LDA.B !Layer2ScrollDir                    ;;8755|8755+8755/8755\877A;
                      AND.W #$00FF                              ;;8757|8757+8757/8757\877C;
                      TAX                                       ;;875A|875A+875A/875A\877F;
                      LDA.B !Layer2YPos                         ;;875B|875B+875B/875B\8780;
                      AND.W #$FFF0                              ;;875D|875D+875D/875D\8782;
                      CMP.B !Layer2PrevTileUp,X                 ;;8760|8760+8760/8760\8785;
                      BEQ CODE_058774                           ;;8762|8762+8762/8762\8787;
CODE_058764:          STA.B !Layer2PrevTileUp,X                 ;;8764|8764+8764/8764\8789;
                      TXA                                       ;;8766|8766+8766/8766\878B;
                      EOR.W #$0002                              ;;8767|8767+8767/8767\878C;
                      TAX                                       ;;876A|876A+876A/876A\878F;
                      LDA.W #$FFFF                              ;;876B|876B+876B/876B\8790;
                      STA.B !Layer2PrevTileUp,X                 ;;876E|876E+876E/876E\8793;
                      JSL CODE_058883                           ;;8770|8770+8770/8770\8795;
CODE_058774:          PLP                                       ;;8774|8774+8774/8774\8799;
                      RTL                                       ;;8775|8775+8775/8775\879A; Return
                                                                ;;                        ;
                                                                ;;                        ;
MAP16AppTable:        db $B0,$8A,$E0,$84,$F0,$8A,$30,$8B        ;;8776|8776+8776/8776\879B;
                                                                ;;                        ;
CODE_05877E:          PHP                                       ;;877E|877E+877E/877E\87A3;
                      SEP #$20                                  ;;877F|877F+877F/877F\87A4; Accum (8 bit)
                      LDA.B !ScreenMode                         ;;8781|8781+8781/8781\87A6;
                      AND.B #$01                                ;;8783|8783+8783/8783\87A8;
                      BNE CODE_0587CB                           ;;8785|8785+8785/8785\87AA;
                      REP #$20                                  ;;8787|8787+8787/8787\87AC; Accum (16 bit)
                      LDA.B !Layer1XPos                         ;;8789|8789+8789/8789\87AE; Load "Xpos of Screen Boundary"
                      LSR A                                     ;;878B|878B+878B/878B\87B0; \
                      LSR A                                     ;;878C|878C+878C/878C\87B1;  |Multiply by 16
                      LSR A                                     ;;878D|878D+878D/878D\87B2;  |
                      LSR A                                     ;;878E|878E+878E/878E\87B3; /
                      TAY                                       ;;878F|878F+878F/878F\87B4;
                      SEC                                       ;;8790|8790+8790/8790\87B5; \
                      SBC.W #$0008                              ;;8791|8791+8791/8791\87B6; /Subtract 8
                      STA.B !Layer1TileUp                       ;;8794|8794+8794/8794\87B9; Store to $45 (Seems to be Scratch RAM)
                      TYA                                       ;;8796|8796+8796/8796\87BB; Get back the multiplied XPos
                      CLC                                       ;;8797|8797+8797/8797\87BC;
                      ADC.W #$0017                              ;;8798|8798+8798/8798\87BD; Add $17
                      STA.B !Layer1TileDown                     ;;879B|879B+879B/879B\87C0; Store to $47 (Seems to be Scratch RAM)
                      SEP #$30                                  ;;879D|879D+879D/879D\87C2; Index (8 bit) Accum (8 bit)
                      LDA.B !Layer1ScrollDir                    ;;879F|879F+879F/879F\87C4; \
                      TAX                                       ;;87A1|87A1+87A1/87A1\87C6;  | LDA $45,x  / $55
                      LDA.B !Layer1TileUp,X                     ;;87A2|87A2+87A2/87A2\87C7; /
                      LSR A                                     ;;87A4|87A4+87A4/87A4\87C9; \ multiply by 8
                      LSR A                                     ;;87A5|87A5+87A5/87A5\87CA;  |
                      LSR A                                     ;;87A6|87A6+87A6/87A6\87CB; /
                      REP #$30                                  ;;87A7|87A7+87A7/87A7\87CC; Index (16 bit) Accum (16 bit)
                      AND.W #$0006                              ;;87A9|87A9+87A9/87A9\87CE; AND to make it either 6, 4, 2, or 0.
                      TAX                                       ;;87AC|87AC+87AC/87AC\87D1;
                      LDA.W #$0133                              ;;87AD|87AD+87AD/87AD\87D2; \LDY #$0266
                      ASL A                                     ;;87B0|87B0+87B0/87B0\87D5; |
                      TAY                                       ;;87B1|87B1+87B1/87B1\87D6; /
                      LDA.W #$0007                              ;;87B2|87B2+87B2/87B2\87D7;
                      STA.B !_0                                 ;;87B5|87B5+87B5/87B5\87DA;
                      LDA.L MAP16AppTable,X                     ;;87B7|87B7+87B7/87B7\87DC;
                    - STA.W !Map16Pointers,Y                    ;;87BB|87BB+87BB/87BB\87E0; MAP16 pointer table
                      INY                                       ;;87BE|87BE+87BE/87BE\87E3;
                      INY                                       ;;87BF|87BF+87BF/87BF\87E4;
                      CLC                                       ;;87C0|87C0+87C0/87C0\87E5;
                      ADC.W #$0008                              ;;87C1|87C1+87C1/87C1\87E6; 8 bytes per tile?
                      DEC.B !_0                                 ;;87C4|87C4+87C4/87C4\87E9;
                      BPL -                                     ;;87C6|87C6+87C6/87C6\87EB;
                      JMP CODE_0587E1                           ;;87C8|87C8+87C8/87C8\87ED;
                                                                ;;                        ;
CODE_0587CB:          REP #$20                                  ;;87CB|87CB+87CB/87CB\87F0; Accum (16 bit)
                      LDA.B !Layer1YPos                         ;;87CD|87CD+87CD/87CD\87F2;
                      LSR A                                     ;;87CF|87CF+87CF/87CF\87F4;
                      LSR A                                     ;;87D0|87D0+87D0/87D0\87F5;
                      LSR A                                     ;;87D1|87D1+87D1/87D1\87F6;
                      LSR A                                     ;;87D2|87D2+87D2/87D2\87F7;
                      TAY                                       ;;87D3|87D3+87D3/87D3\87F8;
                      SEC                                       ;;87D4|87D4+87D4/87D4\87F9;
                      SBC.W #$0008                              ;;87D5|87D5+87D5/87D5\87FA;
                      STA.B !Layer1TileUp                       ;;87D8|87D8+87D8/87D8\87FD;
                      TYA                                       ;;87DA|87DA+87DA/87DA\87FF;
                      CLC                                       ;;87DB|87DB+87DB/87DB\8800;
                      ADC.W #$0017                              ;;87DC|87DC+87DC/87DC\8801;
                      STA.B !Layer1TileDown                     ;;87DF|87DF+87DF/87DF\8804;
CODE_0587E1:          SEP #$20                                  ;;87E1|87E1+87E1/87E1\8806; Accum (8 bit)
                      LDA.B !ScreenMode                         ;;87E3|87E3+87E3/87E3\8808; Load the vertical level flag
                      AND.B #$02                                ;;87E5|87E5+87E5/87E5\880A; \if bit 1 is set, process based on that
                      BNE +                                     ;;87E7|87E7+87E7/87E7\880C; /
                      REP #$20                                  ;;87E9|87E9+87E9/87E9\880E; Not a vertical level ; Accum (16 bit)
                      LDA.B !Layer2XPos                         ;;87EB|87EB+87EB/87EB\8810; \Y = L2XPos * 16
                      LSR A                                     ;;87ED|87ED+87ED/87ED\8812; |
                      LSR A                                     ;;87EE|87EE+87EE/87EE\8813; |
                      LSR A                                     ;;87EF|87EF+87EF/87EF\8814; |
                      LSR A                                     ;;87F0|87F0+87F0/87F0\8815; |
                      TAY                                       ;;87F1|87F1+87F1/87F1\8816; /
                      SEC                                       ;;87F2|87F2+87F2/87F2\8817;
                      SBC.W #$0008                              ;;87F3|87F3+87F3/87F3\8818;
                      STA.B !Layer2TileUp                       ;;87F6|87F6+87F6/87F6\881B;
                      TYA                                       ;;87F8|87F8+87F8/87F8\881D;
                      CLC                                       ;;87F9|87F9+87F9/87F9\881E;
                      ADC.W #$0017                              ;;87FA|87FA+87FA/87FA\881F;
                      STA.B !Layer2TileDown                     ;;87FD|87FD+87FD/87FD\8822;
                      JMP CODE_058818                           ;;87FF|87FF+87FF/87FF\8824;
                                                                ;;                        ;
                    + REP #$20                                  ;;8802|8802+8802/8802\8827; \A = Y = !4*16 (?)  ; Accum (16 bit)
                      LDA.B !Layer2YPos                         ;;8804|8804+8804/8804\8829; |
                      LSR A                                     ;;8806|8806+8806/8806\882B; |
                      LSR A                                     ;;8807|8807+8807/8807\882C; |
                      LSR A                                     ;;8808|8808+8808/8808\882D; |
                      LSR A                                     ;;8809|8809+8809/8809\882E; |
                      TAY                                       ;;880A|880A+880A/880A\882F; /
                      SEC                                       ;;880B|880B+880B/880B\8830; \
                      SBC.W #$0008                              ;;880C|880C+880C/880C\8831;  |Subtract x08 and store in $49
                      STA.B !Layer2TileUp                       ;;880F|880F+880F/880F\8834; /
                      TYA                                       ;;8811|8811+8811/8811\8836; \
                      CLC                                       ;;8812|8812+8812/8812\8837;  |"Undo", add x17 and store in $4B
                      ADC.W #$0017                              ;;8813|8813+8813/8813\8838;  |
                      STA.B !Layer2TileDown                     ;;8816|8816+8816/8816\883B; /
CODE_058818:          PLP                                       ;;8818|8818+8818/8818\883D;
                      RTS                                       ;;8819|8819+8819/8819\883E; Return
                                                                ;;                        ;
CODE_05881A:          SEP #$30                                  ;;881A|881A+881A/881A\883F; Index (8 bit) Accum (8 bit)
                      LDA.W !LevelModeSetting                   ;;881C|881C+881C/881C\8841;
                      JSL ExecutePtrLong                        ;;881F|881F+881F/881F\8844;
                                                                ;;                        ;
                      dl CODE_0589CE                            ;;8823|8823+8823/8823\8848;
                      dl CODE_0589CE                            ;;8826|8826+8826/8826\884B;
                      dl CODE_0589CE                            ;;8829|8829+8829/8829\884E;
                      dl CODE_058A9B                            ;;882C|882C+882C/882C\8851;
                      dl CODE_058A9B                            ;;882F|882F+882F/882F\8854;
                      dl CODE_0589CE                            ;;8832|8832+8832/8832\8857;
                      dl CODE_0589CE                            ;;8835|8835+8835/8835\885A;
                      dl CODE_058A9B                            ;;8838|8838+8838/8838\885D;
                      dl CODE_058A9B                            ;;883B|883B+883B/883B\8860;
                      dl Return058A9A                           ;;883E|883E+883E/883E\8863;
                      dl CODE_058A9B                            ;;8841|8841+8841/8841\8866;
                      dl Return058A9A                           ;;8844|8844+8844/8844\8869;
                      dl CODE_0589CE                            ;;8847|8847+8847/8847\886C;
                      dl CODE_058A9B                            ;;884A|884A+884A/884A\886F;
                      dl CODE_0589CE                            ;;884D|884D+884D/884D\8872;
                      dl CODE_0589CE                            ;;8850|8850+8850/8850\8875;
                      dl Return058A9A                           ;;8853|8853+8853/8853\8878;
                      dl CODE_0589CE                            ;;8856|8856+8856/8856\887B;
                      dl Return058A9A                           ;;8859|8859+8859/8859\887E;
                      dl Return058A9A                           ;;885C|885C+885C/885C\8881;
                      dl Return058A9A                           ;;885F|885F+885F/885F\8884;
                      dl Return058A9A                           ;;8862|8862+8862/8862\8887;
                      dl Return058A9A                           ;;8865|8865+8865/8865\888A;
                      dl Return058A9A                           ;;8868|8868+8868/8868\888D;
                      dl Return058A9A                           ;;886B|886B+886B/886B\8890;
                      dl Return058A9A                           ;;886E|886E+886E/886E\8893;
                      dl Return058A9A                           ;;8871|8871+8871/8871\8896;
                      dl Return058A9A                           ;;8874|8874+8874/8874\8899;
                      dl Return058A9A                           ;;8877|8877+8877/8877\889C;
                      dl Return058A9A                           ;;887A|887A+887A/887A\889F;
                      dl CODE_0589CE                            ;;887D|887D+887D/887D\88A2;
                      dl CODE_0589CE                            ;;8880|8880+8880/8880\88A5;
                                                                ;;                        ;
CODE_058883:          SEP #$30                                  ;;8883|8883+8883/8883\88A8; Index (8 bit) Accum (8 bit)
                      LDA.W !LevelModeSetting                   ;;8885|8885+8885/8885\88AA;
                      JSL ExecutePtrLong                        ;;8888|8888+8888/8888\88AD;
                                                                ;;                        ;
                      dl Return058C70                           ;;888C|888C+888C/888C\88B1;
                      dl CODE_058B8D                            ;;888F|888F+888F/888F\88B4;
                      dl CODE_058B8D                            ;;8892|8892+8892/8892\88B7;
                      dl CODE_058B8D                            ;;8895|8895+8895/8895\88BA;
                      dl CODE_058B8D                            ;;8898|8898+8898/8898\88BD;
                      dl CODE_058C71                            ;;889B|889B+889B/889B\88C0;
                      dl CODE_058C71                            ;;889E|889E+889E/889E\88C3;
                      dl CODE_058C71                            ;;88A1|88A1+88A1/88A1\88C6;
                      dl CODE_058C71                            ;;88A4|88A4+88A4/88A4\88C9;
                      dl Return058C70                           ;;88A7|88A7+88A7/88A7\88CC;
                      dl Return058C70                           ;;88AA|88AA+88AA/88AA\88CF;
                      dl Return058C70                           ;;88AD|88AD+88AD/88AD\88D2;
                      dl Return058C70                           ;;88B0|88B0+88B0/88B0\88D5;
                      dl Return058C70                           ;;88B3|88B3+88B3/88B3\88D8;
                      dl Return058C70                           ;;88B6|88B6+88B6/88B6\88DB;
                      dl CODE_058B8D                            ;;88B9|88B9+88B9/88B9\88DE;
                      dl Return058C70                           ;;88BC|88BC+88BC/88BC\88E1;
                      dl Return058C70                           ;;88BF|88BF+88BF/88BF\88E4;
                      dl Return058C70                           ;;88C2|88C2+88C2/88C2\88E7;
                      dl Return058C70                           ;;88C5|88C5+88C5/88C5\88EA;
                      dl Return058C70                           ;;88C8|88C8+88C8/88C8\88ED;
                      dl Return058C70                           ;;88CB|88CB+88CB/88CB\88F0;
                      dl Return058C70                           ;;88CE|88CE+88CE/88CE\88F3;
                      dl Return058C70                           ;;88D1|88D1+88D1/88D1\88F6;
                      dl Return058C70                           ;;88D4|88D4+88D4/88D4\88F9;
                      dl Return058C70                           ;;88D7|88D7+88D7/88D7\88FC;
                      dl Return058C70                           ;;88DA|88DA+88DA/88DA\88FF;
                      dl Return058C70                           ;;88DD|88DD+88DD/88DD\8902;
                      dl Return058C70                           ;;88E0|88E0+88E0/88E0\8905;
                      dl Return058C70                           ;;88E3|88E3+88E3/88E3\8908;
                      dl Return058C70                           ;;88E6|88E6+88E6/88E6\890B;
                      dl CODE_058B8D                            ;;88E9|88E9+88E9/88E9\890E;
                                                                ;;                        ;
CODE_0588EC:          SEP #$30                                  ;;88EC|88EC+88EC/88EC\8911; Index (8 bit) Accum (8 bit)
                      LDA.W !LevelModeSetting                   ;;88EE|88EE+88EE/88EE\8913;
                      JSL ExecutePtrLong                        ;;88F1|88F1+88F1/88F1\8916;
                                                                ;;                        ;
                      dl CODE_0589CE                            ;;88F5|88F5+88F5/88F5\891A;
                      dl CODE_0589CE                            ;;88F8|88F8+88F8/88F8\891D;
                      dl CODE_0589CE                            ;;88FB|88FB+88FB/88FB\8920;
                      dl CODE_058A9B                            ;;88FE|88FE+88FE/88FE\8923;
                      dl CODE_058A9B                            ;;8901|8901+8901/8901\8926;
                      dl CODE_0589CE                            ;;8904|8904+8904/8904\8929;
                      dl CODE_0589CE                            ;;8907|8907+8907/8907\892C;
                      dl CODE_058A9B                            ;;890A|890A+890A/890A\892F;
                      dl CODE_058A9B                            ;;890D|890D+890D/890D\8932;
                      dl Return058A9A                           ;;8910|8910+8910/8910\8935;
                      dl CODE_058A9B                            ;;8913|8913+8913/8913\8938;
                      dl Return058A9A                           ;;8916|8916+8916/8916\893B;
                      dl CODE_0589CE                            ;;8919|8919+8919/8919\893E;
                      dl CODE_058A9B                            ;;891C|891C+891C/891C\8941;
                      dl CODE_0589CE                            ;;891F|891F+891F/891F\8944;
                      dl CODE_0589CE                            ;;8922|8922+8922/8922\8947;
                      dl Return058A9A                           ;;8925|8925+8925/8925\894A;
                      dl CODE_0589CE                            ;;8928|8928+8928/8928\894D;
                      dl Return058A9A                           ;;892B|892B+892B/892B\8950;
                      dl Return058A9A                           ;;892E|892E+892E/892E\8953;
                      dl Return058A9A                           ;;8931|8931+8931/8931\8956;
                      dl Return058A9A                           ;;8934|8934+8934/8934\8959;
                      dl Return058A9A                           ;;8937|8937+8937/8937\895C;
                      dl Return058A9A                           ;;893A|893A+893A/893A\895F;
                      dl Return058A9A                           ;;893D|893D+893D/893D\8962;
                      dl Return058A9A                           ;;8940|8940+8940/8940\8965;
                      dl Return058A9A                           ;;8943|8943+8943/8943\8968;
                      dl Return058A9A                           ;;8946|8946+8946/8946\896B;
                      dl Return058A9A                           ;;8949|8949+8949/8949\896E;
                      dl Return058A9A                           ;;894C|894C+894C/894C\8971;
                      dl CODE_0589CE                            ;;894F|894F+894F/894F\8974;
                      dl CODE_0589CE                            ;;8952|8952+8952/8952\8977;
                                                                ;;                        ;
CODE_058955:          SEP #$30                                  ;;8955|8955+8955/8955\897A; Index (8 bit) Accum (8 bit)
                      LDA.W !LevelModeSetting                   ;;8957|8957+8957/8957\897C;
                      JSL ExecutePtrLong                        ;;895A|895A+895A/895A\897F;
                                                                ;;                        ;
                      dl CODE_058D7A                            ;;895E|895E+895E/895E\8983;
                      dl CODE_058B8D                            ;;8961|8961+8961/8961\8986;
                      dl CODE_058B8D                            ;;8964|8964+8964/8964\8989;
                      dl CODE_058B8D                            ;;8967|8967+8967/8967\898C;
                      dl CODE_058B8D                            ;;896A|896A+896A/896A\898F;
                      dl CODE_058C71                            ;;896D|896D+896D/896D\8992;
                      dl CODE_058C71                            ;;8970|8970+8970/8970\8995;
                      dl CODE_058C71                            ;;8973|8973+8973/8973\8998;
                      dl CODE_058C71                            ;;8976|8976+8976/8976\899B;
                      dl Return058C70                           ;;8979|8979+8979/8979\899E;
                      dl CODE_058D7A                            ;;897C|897C+897C/897C\89A1;
                      dl Return058C70                           ;;897F|897F+897F/897F\89A4;
                      dl CODE_058D7A                            ;;8982|8982+8982/8982\89A7;
                      dl CODE_058D7A                            ;;8985|8985+8985/8985\89AA;
                      dl CODE_058D7A                            ;;8988|8988+8988/8988\89AD;
                      dl CODE_058B8D                            ;;898B|898B+898B/898B\89B0;
                      dl Return058C70                           ;;898E|898E+898E/898E\89B3;
                      dl CODE_058D7A                            ;;8991|8991+8991/8991\89B6;
                      dl Return058C70                           ;;8994|8994+8994/8994\89B9;
                      dl Return058C70                           ;;8997|8997+8997/8997\89BC;
                      dl Return058C70                           ;;899A|899A+899A/899A\89BF;
                      dl Return058C70                           ;;899D|899D+899D/899D\89C2;
                      dl Return058C70                           ;;89A0|89A0+89A0/89A0\89C5;
                      dl Return058C70                           ;;89A3|89A3+89A3/89A3\89C8;
                      dl Return058C70                           ;;89A6|89A6+89A6/89A6\89CB;
                      dl Return058C70                           ;;89A9|89A9+89A9/89A9\89CE;
                      dl Return058C70                           ;;89AC|89AC+89AC/89AC\89D1;
                      dl Return058C70                           ;;89AF|89AF+89AF/89AF\89D4;
                      dl Return058C70                           ;;89B2|89B2+89B2/89B2\89D7;
                      dl Return058C70                           ;;89B5|89B5+89B5/89B5\89DA;
                      dl CODE_058D7A                            ;;89B8|89B8+89B8/89B8\89DD;
                      dl CODE_058B8D                            ;;89BB|89BB+89BB/89BB\89E0;
                                                                ;;                        ;
                      db $80,$00,$40,$00,$20,$00,$10,$00        ;;89BE|89BE+89BE/89BE\89E3;
                      db $08,$00,$04,$00,$02,$00,$01,$00        ;;89C6|89C6+89C6/89C6\89EB;
                                                                ;;                        ;
CODE_0589CE:          PHP                                       ;;89CE|89CE+89CE/89CE\89F3;
                      REP #$30                                  ;;89CF|89CF+89CF/89CF\89F4; Index (16 bit) Accum (16 bit)
                      LDA.W !LevelModeSetting                   ;;89D1|89D1+89D1/89D1\89F6;
                      AND.W #$00FF                              ;;89D4|89D4+89D4/89D4\89F9;
                      ASL A                                     ;;89D7|89D7+89D7/89D7\89FC;
                      TAX                                       ;;89D8|89D8+89D8/89D8\89FD;
                      SEP #$20                                  ;;89D9|89D9+89D9/89D9\89FE; Accum (8 bit)
                      LDA.L Ptrs00BDA8,X                        ;;89DB|89DB+89DB/89DB\8A00;
                      STA.B !_A                                 ;;89DF|89DF+89DF/89DF\8A04;
                      LDA.L Ptrs00BDA8+1,X                      ;;89E1|89E1+89E1/89E1\8A06;
                      STA.B !_B                                 ;;89E5|89E5+89E5/89E5\8A0A;
                      LDA.L Ptrs00BE28,X                        ;;89E7|89E7+89E7/89E7\8A0C;
                      STA.B !_D                                 ;;89EB|89EB+89EB/89EB\8A10;
                      LDA.L Ptrs00BE28+1,X                      ;;89ED|89ED+89ED/89ED\8A12;
                      STA.B !_E                                 ;;89F1|89F1+89F1/89F1\8A16;
                      LDA.B #$00                                ;;89F3|89F3+89F3/89F3\8A18;
                      STA.B !_C                                 ;;89F5|89F5+89F5/89F5\8A1A;
                      STA.B !_F                                 ;;89F7|89F7+89F7/89F7\8A1C;
                      LDA.B !Layer1ScrollDir                    ;;89F9|89F9+89F9/89F9\8A1E;
                      TAX                                       ;;89FB|89FB+89FB/89FB\8A20;
                      LDA.B !Layer1TileUp,X                     ;;89FC|89FC+89FC/89FC\8A21;
                      AND.B #$0F                                ;;89FE|89FE+89FE/89FE\8A23;
                      ASL A                                     ;;8A00|8A00+8A00/8A00\8A25;
                      STA.W !Layer1VramAddr+1                   ;;8A01|8A01+8A01/8A01\8A26;
                      LDY.W #$0020                              ;;8A04|8A04+8A04/8A04\8A29;
                      LDA.B !Layer1TileUp,X                     ;;8A07|8A07+8A07/8A07\8A2C;
                      AND.B #$10                                ;;8A09|8A09+8A09/8A09\8A2E;
                      BEQ +                                     ;;8A0B|8A0B+8A0B/8A0B\8A30;
                      LDY.W #$0024                              ;;8A0D|8A0D+8A0D/8A0D\8A32;
                    + TYA                                       ;;8A10|8A10+8A10/8A10\8A35;
                      STA.W !Layer1VramAddr                     ;;8A11|8A11+8A11/8A11\8A36;
                      REP #$20                                  ;;8A14|8A14+8A14/8A14\8A39; Accum (16 bit)
                      LDA.B !Layer1TileUp,X                     ;;8A16|8A16+8A16/8A16\8A3B;
                      AND.W #$01F0                              ;;8A18|8A18+8A18/8A18\8A3D;
                      LSR A                                     ;;8A1B|8A1B+8A1B/8A1B\8A40;
                      LSR A                                     ;;8A1C|8A1C+8A1C/8A1C\8A41;
                      LSR A                                     ;;8A1D|8A1D+8A1D/8A1D\8A42;
                      LSR A                                     ;;8A1E|8A1E+8A1E/8A1E\8A43;
                      STA.B !_0                                 ;;8A1F|8A1F+8A1F/8A1F\8A44;
                      ASL A                                     ;;8A21|8A21+8A21/8A21\8A46;
                      CLC                                       ;;8A22|8A22+8A22/8A22\8A47;
                      ADC.B !_0                                 ;;8A23|8A23+8A23/8A23\8A48;
                      TAY                                       ;;8A25|8A25+8A25/8A25\8A4A;
                      LDA.B [!_A],Y                             ;;8A26|8A26+8A26/8A26\8A4B;
                      STA.B !Map16LowPtr                        ;;8A28|8A28+8A28/8A28\8A4D;
                      LDA.B [!_D],Y                             ;;8A2A|8A2A+8A2A/8A2A\8A4F;
                      STA.B !Map16HighPtr                       ;;8A2C|8A2C+8A2C/8A2C\8A51;
                      SEP #$20                                  ;;8A2E|8A2E+8A2E/8A2E\8A53; Accum (8 bit)
                      INY                                       ;;8A30|8A30+8A30/8A30\8A55;
                      INY                                       ;;8A31|8A31+8A31/8A31\8A56;
                      LDA.B [!_A],Y                             ;;8A32|8A32+8A32/8A32\8A57;
                      STA.B !Map16LowPtr+2                      ;;8A34|8A34+8A34/8A34\8A59;
                      LDA.B [!_D],Y                             ;;8A36|8A36+8A36/8A36\8A5B;
                      STA.B !Map16HighPtr+2                     ;;8A38|8A38+8A38/8A38\8A5D;
                      SEP #$10                                  ;;8A3A|8A3A+8A3A/8A3A\8A5F; Index (8 bit)
                      LDY.B #$0D                                ;;8A3C|8A3C+8A3C/8A3C\8A61;
                      LDA.W !ObjectTileset                      ;;8A3E|8A3E+8A3E/8A3E\8A63;
                      CMP.B #$10                                ;;8A41|8A41+8A41/8A41\8A66;
                      BMI +                                     ;;8A43|8A43+8A43/8A43\8A68;
                      LDY.B #$05                                ;;8A45|8A45+8A45/8A45\8A6A;
                    + STY.B !_C                                 ;;8A47|8A47+8A47/8A47\8A6C;
                      REP #$30                                  ;;8A49|8A49+8A49/8A49\8A6E; Index (16 bit) Accum (16 bit)
                      LDA.B !Layer1TileUp,X                     ;;8A4B|8A4B+8A4B/8A4B\8A70;
                      AND.W #$000F                              ;;8A4D|8A4D+8A4D/8A4D\8A72;
                      STA.B !_8                                 ;;8A50|8A50+8A50/8A50\8A75;
                      LDX.W #$0000                              ;;8A52|8A52+8A52/8A52\8A77;
                    - LDY.B !_8                                 ;;8A55|8A55+8A55/8A55\8A7A;
                      LDA.B [!Map16LowPtr],Y                    ;;8A57|8A57+8A57/8A57\8A7C;
                      AND.W #$00FF                              ;;8A59|8A59+8A59/8A59\8A7E;
                      STA.B !_0                                 ;;8A5C|8A5C+8A5C/8A5C\8A81;
                      LDA.B [!Map16HighPtr],Y                   ;;8A5E|8A5E+8A5E/8A5E\8A83;
                      STA.B !_1                                 ;;8A60|8A60+8A60/8A60\8A85;
                      LDA.B !_0                                 ;;8A62|8A62+8A62/8A62\8A87;
                      ASL A                                     ;;8A64|8A64+8A64/8A64\8A89;
                      TAY                                       ;;8A65|8A65+8A65/8A65\8A8A;
                      LDA.W !Map16Pointers,Y                    ;;8A66|8A66+8A66/8A66\8A8B;
                      STA.B !_A                                 ;;8A69|8A69+8A69/8A69\8A8E;
                      LDY.W #$0000                              ;;8A6B|8A6B+8A6B/8A6B\8A90;
                      LDA.B [!_A],Y                             ;;8A6E|8A6E+8A6E/8A6E\8A93;
                      STA.W !Layer1VramBuffer,X                 ;;8A70|8A70+8A70/8A70\8A95;
                      INY                                       ;;8A73|8A73+8A73/8A73\8A98;
                      INY                                       ;;8A74|8A74+8A74/8A74\8A99;
                      LDA.B [!_A],Y                             ;;8A75|8A75+8A75/8A75\8A9A;
                      STA.W !Layer1VramBuffer+2,X               ;;8A77|8A77+8A77/8A77\8A9C;
                      INY                                       ;;8A7A|8A7A+8A7A/8A7A\8A9F;
                      INY                                       ;;8A7B|8A7B+8A7B/8A7B\8AA0;
                      LDA.B [!_A],Y                             ;;8A7C|8A7C+8A7C/8A7C\8AA1;
                      STA.W !Layer1VramBuffer+$80,X             ;;8A7E|8A7E+8A7E/8A7E\8AA3;
                      INY                                       ;;8A81|8A81+8A81/8A81\8AA6;
                      INY                                       ;;8A82|8A82+8A82/8A82\8AA7;
                      LDA.B [!_A],Y                             ;;8A83|8A83+8A83/8A83\8AA8;
                      STA.W !Layer1VramBuffer+$82,X             ;;8A85|8A85+8A85/8A85\8AAA;
                      INX                                       ;;8A88|8A88+8A88/8A88\8AAD;
                      INX                                       ;;8A89|8A89+8A89/8A89\8AAE;
                      INX                                       ;;8A8A|8A8A+8A8A/8A8A\8AAF;
                      INX                                       ;;8A8B|8A8B+8A8B/8A8B\8AB0;
                      LDA.B !_8                                 ;;8A8C|8A8C+8A8C/8A8C\8AB1;
                      CLC                                       ;;8A8E|8A8E+8A8E/8A8E\8AB3;
                      ADC.W #$0010                              ;;8A8F|8A8F+8A8F/8A8F\8AB4;
                      STA.B !_8                                 ;;8A92|8A92+8A92/8A92\8AB7;
                      CMP.W #$01B0                              ;;8A94|8A94+8A94/8A94\8AB9;
                      BCC -                                     ;;8A97|8A97+8A97/8A97\8ABC;
                      PLP                                       ;;8A99|8A99+8A99/8A99\8ABE;
Return058A9A:         RTL                                       ;;8A9A|8A9A+8A9A/8A9A\8ABF; Return
                                                                ;;                        ;
CODE_058A9B:          PHP                                       ;;8A9B|8A9B+8A9B/8A9B\8AC0;
                      REP #$30                                  ;;8A9C|8A9C+8A9C/8A9C\8AC1; Index (16 bit) Accum (16 bit)
                      LDA.W !LevelModeSetting                   ;;8A9E|8A9E+8A9E/8A9E\8AC3;
                      AND.W #$00FF                              ;;8AA1|8AA1+8AA1/8AA1\8AC6;
                      ASL A                                     ;;8AA4|8AA4+8AA4/8AA4\8AC9;
                      TAX                                       ;;8AA5|8AA5+8AA5/8AA5\8ACA;
                      SEP #$20                                  ;;8AA6|8AA6+8AA6/8AA6\8ACB; Accum (8 bit)
                      LDA.L Ptrs00BDA8,X                        ;;8AA8|8AA8+8AA8/8AA8\8ACD;
                      STA.B !_A                                 ;;8AAC|8AAC+8AAC/8AAC\8AD1;
                      LDA.L Ptrs00BDA8+1,X                      ;;8AAE|8AAE+8AAE/8AAE\8AD3;
                      STA.B !_B                                 ;;8AB2|8AB2+8AB2/8AB2\8AD7;
                      LDA.L Ptrs00BE28,X                        ;;8AB4|8AB4+8AB4/8AB4\8AD9;
                      STA.B !_D                                 ;;8AB8|8AB8+8AB8/8AB8\8ADD;
                      LDA.L Ptrs00BE28+1,X                      ;;8ABA|8ABA+8ABA/8ABA\8ADF;
                      STA.B !_E                                 ;;8ABE|8ABE+8ABE/8ABE\8AE3;
                      LDA.B #$00                                ;;8AC0|8AC0+8AC0/8AC0\8AE5;
                      STA.B !_C                                 ;;8AC2|8AC2+8AC2/8AC2\8AE7;
                      STA.B !_F                                 ;;8AC4|8AC4+8AC4/8AC4\8AE9;
                      LDA.B !Layer1ScrollDir                    ;;8AC6|8AC6+8AC6/8AC6\8AEB;
                      TAX                                       ;;8AC8|8AC8+8AC8/8AC8\8AED;
                      LDY.W #$0020                              ;;8AC9|8AC9+8AC9/8AC9\8AEE;
                      LDA.B !Layer1TileUp,X                     ;;8ACC|8ACC+8ACC/8ACC\8AF1;
                      AND.B #$10                                ;;8ACE|8ACE+8ACE/8ACE\8AF3;
                      BEQ +                                     ;;8AD0|8AD0+8AD0/8AD0\8AF5;
                      LDY.W #$0028                              ;;8AD2|8AD2+8AD2/8AD2\8AF7;
                    + TYA                                       ;;8AD5|8AD5+8AD5/8AD5\8AFA;
                      STA.B !_0                                 ;;8AD6|8AD6+8AD6/8AD6\8AFB;
                      LDA.B !Layer1TileUp,X                     ;;8AD8|8AD8+8AD8/8AD8\8AFD;
                      LSR A                                     ;;8ADA|8ADA+8ADA/8ADA\8AFF;
                      LSR A                                     ;;8ADB|8ADB+8ADB/8ADB\8B00;
                      AND.B #$03                                ;;8ADC|8ADC+8ADC/8ADC\8B01;
                      ORA.B !_0                                 ;;8ADE|8ADE+8ADE/8ADE\8B03;
                      STA.W !Layer1VramAddr                     ;;8AE0|8AE0+8AE0/8AE0\8B05;
                      LDA.B !Layer1TileUp,X                     ;;8AE3|8AE3+8AE3/8AE3\8B08;
                      AND.B #$03                                ;;8AE5|8AE5+8AE5/8AE5\8B0A;
                      ASL A                                     ;;8AE7|8AE7+8AE7/8AE7\8B0C;
                      ASL A                                     ;;8AE8|8AE8+8AE8/8AE8\8B0D;
                      ASL A                                     ;;8AE9|8AE9+8AE9/8AE9\8B0E;
                      ASL A                                     ;;8AEA|8AEA+8AEA/8AEA\8B0F;
                      ASL A                                     ;;8AEB|8AEB+8AEB/8AEB\8B10;
                      ASL A                                     ;;8AEC|8AEC+8AEC/8AEC\8B11;
                      STA.W !Layer1VramAddr+1                   ;;8AED|8AED+8AED/8AED\8B12;
                      REP #$20                                  ;;8AF0|8AF0+8AF0/8AF0\8B15; Accum (16 bit)
                      LDA.B !Layer1TileUp,X                     ;;8AF2|8AF2+8AF2/8AF2\8B17;
                      AND.W #$01F0                              ;;8AF4|8AF4+8AF4/8AF4\8B19;
                      LSR A                                     ;;8AF7|8AF7+8AF7/8AF7\8B1C;
                      LSR A                                     ;;8AF8|8AF8+8AF8/8AF8\8B1D;
                      LSR A                                     ;;8AF9|8AF9+8AF9/8AF9\8B1E;
                      LSR A                                     ;;8AFA|8AFA+8AFA/8AFA\8B1F;
                      STA.B !_0                                 ;;8AFB|8AFB+8AFB/8AFB\8B20;
                      ASL A                                     ;;8AFD|8AFD+8AFD/8AFD\8B22;
                      CLC                                       ;;8AFE|8AFE+8AFE/8AFE\8B23;
                      ADC.B !_0                                 ;;8AFF|8AFF+8AFF/8AFF\8B24;
                      TAY                                       ;;8B01|8B01+8B01/8B01\8B26;
                      LDA.B [!_A],Y                             ;;8B02|8B02+8B02/8B02\8B27;
                      STA.B !Map16LowPtr                        ;;8B04|8B04+8B04/8B04\8B29;
                      LDA.B [!_D],Y                             ;;8B06|8B06+8B06/8B06\8B2B;
                      STA.B !Map16HighPtr                       ;;8B08|8B08+8B08/8B08\8B2D;
                      SEP #$20                                  ;;8B0A|8B0A+8B0A/8B0A\8B2F; Accum (8 bit)
                      INY                                       ;;8B0C|8B0C+8B0C/8B0C\8B31;
                      INY                                       ;;8B0D|8B0D+8B0D/8B0D\8B32;
                      LDA.B [!_A],Y                             ;;8B0E|8B0E+8B0E/8B0E\8B33;
                      STA.B !Map16LowPtr+2                      ;;8B10|8B10+8B10/8B10\8B35;
                      LDA.B [!_D],Y                             ;;8B12|8B12+8B12/8B12\8B37;
                      STA.B !Map16HighPtr+2                     ;;8B14|8B14+8B14/8B14\8B39;
                      SEP #$10                                  ;;8B16|8B16+8B16/8B16\8B3B; Index (8 bit)
                      LDY.B #$0D                                ;;8B18|8B18+8B18/8B18\8B3D;
                      LDA.W !ObjectTileset                      ;;8B1A|8B1A+8B1A/8B1A\8B3F;
                      CMP.B #$10                                ;;8B1D|8B1D+8B1D/8B1D\8B42;
                      BMI +                                     ;;8B1F|8B1F+8B1F/8B1F\8B44;
                      LDY.B #$05                                ;;8B21|8B21+8B21/8B21\8B46;
                    + STY.B !_C                                 ;;8B23|8B23+8B23/8B23\8B48;
                      REP #$30                                  ;;8B25|8B25+8B25/8B25\8B4A; Index (16 bit) Accum (16 bit)
                      LDA.B !Layer1TileUp,X                     ;;8B27|8B27+8B27/8B27\8B4C;
                      AND.W #$000F                              ;;8B29|8B29+8B29/8B29\8B4E;
                      ASL A                                     ;;8B2C|8B2C+8B2C/8B2C\8B51;
                      ASL A                                     ;;8B2D|8B2D+8B2D/8B2D\8B52;
                      ASL A                                     ;;8B2E|8B2E+8B2E/8B2E\8B53;
                      ASL A                                     ;;8B2F|8B2F+8B2F/8B2F\8B54;
                      STA.B !_8                                 ;;8B30|8B30+8B30/8B30\8B55;
                      LDX.W #$0000                              ;;8B32|8B32+8B32/8B32\8B57;
CODE_058B35:          LDY.B !_8                                 ;;8B35|8B35+8B35/8B35\8B5A;
                      LDA.B [!Map16LowPtr],Y                    ;;8B37|8B37+8B37/8B37\8B5C;
                      AND.W #$00FF                              ;;8B39|8B39+8B39/8B39\8B5E;
                      STA.B !_0                                 ;;8B3C|8B3C+8B3C/8B3C\8B61;
                      LDA.B [!Map16HighPtr],Y                   ;;8B3E|8B3E+8B3E/8B3E\8B63;
                      STA.B !_1                                 ;;8B40|8B40+8B40/8B40\8B65;
                      LDA.B !_0                                 ;;8B42|8B42+8B42/8B42\8B67;
                      ASL A                                     ;;8B44|8B44+8B44/8B44\8B69;
                      TAY                                       ;;8B45|8B45+8B45/8B45\8B6A;
                      LDA.W !Map16Pointers,Y                    ;;8B46|8B46+8B46/8B46\8B6B;
                      STA.B !_A                                 ;;8B49|8B49+8B49/8B49\8B6E;
                      LDY.W #$0000                              ;;8B4B|8B4B+8B4B/8B4B\8B70;
                      LDA.B [!_A],Y                             ;;8B4E|8B4E+8B4E/8B4E\8B73;
                      STA.W !Layer1VramBuffer,X                 ;;8B50|8B50+8B50/8B50\8B75;
                      INY                                       ;;8B53|8B53+8B53/8B53\8B78;
                      INY                                       ;;8B54|8B54+8B54/8B54\8B79;
                      LDA.B [!_A],Y                             ;;8B55|8B55+8B55/8B55\8B7A;
                      STA.W !Layer1VramBuffer+$80,X             ;;8B57|8B57+8B57/8B57\8B7C;
                      INX                                       ;;8B5A|8B5A+8B5A/8B5A\8B7F;
                      INX                                       ;;8B5B|8B5B+8B5B/8B5B\8B80;
                      INY                                       ;;8B5C|8B5C+8B5C/8B5C\8B81;
                      INY                                       ;;8B5D|8B5D+8B5D/8B5D\8B82;
                      LDA.B [!_A],Y                             ;;8B5E|8B5E+8B5E/8B5E\8B83;
                      STA.W !Layer1VramBuffer,X                 ;;8B60|8B60+8B60/8B60\8B85;
                      INY                                       ;;8B63|8B63+8B63/8B63\8B88;
                      INY                                       ;;8B64|8B64+8B64/8B64\8B89;
                      LDA.B [!_A],Y                             ;;8B65|8B65+8B65/8B65\8B8A;
                      STA.W !Layer1VramBuffer+$80,X             ;;8B67|8B67+8B67/8B67\8B8C;
                      INX                                       ;;8B6A|8B6A+8B6A/8B6A\8B8F;
                      INX                                       ;;8B6B|8B6B+8B6B/8B6B\8B90;
                      LDA.B !_8                                 ;;8B6C|8B6C+8B6C/8B6C\8B91;
                      TAY                                       ;;8B6E|8B6E+8B6E/8B6E\8B93;
                      CLC                                       ;;8B6F|8B6F+8B6F/8B6F\8B94;
                      ADC.W #$0001                              ;;8B70|8B70+8B70/8B70\8B95;
                      STA.B !_8                                 ;;8B73|8B73+8B73/8B73\8B98;
                      AND.W #$000F                              ;;8B75|8B75+8B75/8B75\8B9A;
                      BNE +                                     ;;8B78|8B78+8B78/8B78\8B9D;
                      TYA                                       ;;8B7A|8B7A+8B7A/8B7A\8B9F;
                      AND.W #$FFF0                              ;;8B7B|8B7B+8B7B/8B7B\8BA0;
                      CLC                                       ;;8B7E|8B7E+8B7E/8B7E\8BA3;
                      ADC.W #$0100                              ;;8B7F|8B7F+8B7F/8B7F\8BA4;
                      STA.B !_8                                 ;;8B82|8B82+8B82/8B82\8BA7;
                    + LDA.B !_8                                 ;;8B84|8B84+8B84/8B84\8BA9;
                      AND.W #$010F                              ;;8B86|8B86+8B86/8B86\8BAB;
                      BNE CODE_058B35                           ;;8B89|8B89+8B89/8B89\8BAE;
                      PLP                                       ;;8B8B|8B8B+8B8B/8B8B\8BB0;
                      RTL                                       ;;8B8C|8B8C+8B8C/8B8C\8BB1; Return
                                                                ;;                        ;
CODE_058B8D:          PHP                                       ;;8B8D|8B8D+8B8D/8B8D\8BB2;
                      REP #$30                                  ;;8B8E|8B8E+8B8E/8B8E\8BB3; Index (16 bit) Accum (16 bit)
                      LDA.W !LevelModeSetting                   ;;8B90|8B90+8B90/8B90\8BB5;
                      AND.W #$00FF                              ;;8B93|8B93+8B93/8B93\8BB8;
                      ASL A                                     ;;8B96|8B96+8B96/8B96\8BBB;
                      TAX                                       ;;8B97|8B97+8B97/8B97\8BBC;
                      SEP #$20                                  ;;8B98|8B98+8B98/8B98\8BBD; Accum (8 bit)
                      LDY.W #$0000                              ;;8B9A|8B9A+8B9A/8B9A\8BBF;
                      LDA.W !ObjectTileset                      ;;8B9D|8B9D+8B9D/8B9D\8BC2;
                      CMP.B #$03                                ;;8BA0|8BA0+8BA0/8BA0\8BC5;
                      BNE +                                     ;;8BA2|8BA2+8BA2/8BA2\8BC7;
                      LDY.W #$1000                              ;;8BA4|8BA4+8BA4/8BA4\8BC9;
                    + STY.B !_3                                 ;;8BA7|8BA7+8BA7/8BA7\8BCC;
                      LDA.L Ptrs00BDE8,X                        ;;8BA9|8BA9+8BA9/8BA9\8BCE;
                      STA.B !_A                                 ;;8BAD|8BAD+8BAD/8BAD\8BD2;
                      LDA.L Ptrs00BDE8+1,X                      ;;8BAF|8BAF+8BAF/8BAF\8BD4;
                      STA.B !_B                                 ;;8BB3|8BB3+8BB3/8BB3\8BD8;
                      LDA.L Ptrs00BE68,X                        ;;8BB5|8BB5+8BB5/8BB5\8BDA;
                      STA.B !_D                                 ;;8BB9|8BB9+8BB9/8BB9\8BDE;
                      LDA.L Ptrs00BE68+1,X                      ;;8BBB|8BBB+8BBB/8BBB\8BE0;
                      STA.B !_E                                 ;;8BBF|8BBF+8BBF/8BBF\8BE4;
                      LDA.B #$00                                ;;8BC1|8BC1+8BC1/8BC1\8BE6;
                      STA.B !_C                                 ;;8BC3|8BC3+8BC3/8BC3\8BE8;
                      STA.B !_F                                 ;;8BC5|8BC5+8BC5/8BC5\8BEA;
                      LDA.B !Layer2ScrollDir                    ;;8BC7|8BC7+8BC7/8BC7\8BEC;
                      TAX                                       ;;8BC9|8BC9+8BC9/8BC9\8BEE;
                      LDA.B !Layer2TileUp,X                     ;;8BCA|8BCA+8BCA/8BCA\8BEF;
                      AND.B #$0F                                ;;8BCC|8BCC+8BCC/8BCC\8BF1;
                      ASL A                                     ;;8BCE|8BCE+8BCE/8BCE\8BF3;
                      STA.W !Layer2VramAddr+1                   ;;8BCF|8BCF+8BCF/8BCF\8BF4;
                      LDY.W #$0030                              ;;8BD2|8BD2+8BD2/8BD2\8BF7;
                      LDA.B !Layer2TileUp,X                     ;;8BD5|8BD5+8BD5/8BD5\8BFA;
                      AND.B #$10                                ;;8BD7|8BD7+8BD7/8BD7\8BFC;
                      BEQ +                                     ;;8BD9|8BD9+8BD9/8BD9\8BFE;
                      LDY.W #$0034                              ;;8BDB|8BDB+8BDB/8BDB\8C00;
                    + TYA                                       ;;8BDE|8BDE+8BDE/8BDE\8C03;
                      STA.W !Layer2VramAddr                     ;;8BDF|8BDF+8BDF/8BDF\8C04;
                      REP #$30                                  ;;8BE2|8BE2+8BE2/8BE2\8C07; Index (16 bit) Accum (16 bit)
                      LDA.B !Layer2TileUp,X                     ;;8BE4|8BE4+8BE4/8BE4\8C09;
                      AND.W #$01F0                              ;;8BE6|8BE6+8BE6/8BE6\8C0B;
                      LSR A                                     ;;8BE9|8BE9+8BE9/8BE9\8C0E;
                      LSR A                                     ;;8BEA|8BEA+8BEA/8BEA\8C0F;
                      LSR A                                     ;;8BEB|8BEB+8BEB/8BEB\8C10;
                      LSR A                                     ;;8BEC|8BEC+8BEC/8BEC\8C11;
                      STA.B !_0                                 ;;8BED|8BED+8BED/8BED\8C12;
                      ASL A                                     ;;8BEF|8BEF+8BEF/8BEF\8C14;
                      CLC                                       ;;8BF0|8BF0+8BF0/8BF0\8C15;
                      ADC.B !_0                                 ;;8BF1|8BF1+8BF1/8BF1\8C16;
                      TAY                                       ;;8BF3|8BF3+8BF3/8BF3\8C18;
                      LDA.B [!_A],Y                             ;;8BF4|8BF4+8BF4/8BF4\8C19;
                      STA.B !Map16LowPtr                        ;;8BF6|8BF6+8BF6/8BF6\8C1B;
                      LDA.B [!_D],Y                             ;;8BF8|8BF8+8BF8/8BF8\8C1D;
                      STA.B !Map16HighPtr                       ;;8BFA|8BFA+8BFA/8BFA\8C1F;
                      SEP #$20                                  ;;8BFC|8BFC+8BFC/8BFC\8C21; Accum (8 bit)
                      INY                                       ;;8BFE|8BFE+8BFE/8BFE\8C23;
                      INY                                       ;;8BFF|8BFF+8BFF/8BFF\8C24;
                      LDA.B [!_A],Y                             ;;8C00|8C00+8C00/8C00\8C25;
                      STA.B !Map16LowPtr+2                      ;;8C02|8C02+8C02/8C02\8C27;
                      LDA.B [!_D],Y                             ;;8C04|8C04+8C04/8C04\8C29;
                      STA.B !Map16HighPtr+2                     ;;8C06|8C06+8C06/8C06\8C2B;
                      SEP #$10                                  ;;8C08|8C08+8C08/8C08\8C2D; Index (8 bit)
                      LDY.B #$0D                                ;;8C0A|8C0A+8C0A/8C0A\8C2F;
                      LDA.W !ObjectTileset                      ;;8C0C|8C0C+8C0C/8C0C\8C31;
                      CMP.B #$10                                ;;8C0F|8C0F+8C0F/8C0F\8C34;
                      BMI +                                     ;;8C11|8C11+8C11/8C11\8C36;
                      LDY.B #$05                                ;;8C13|8C13+8C13/8C13\8C38;
                    + STY.B !_C                                 ;;8C15|8C15+8C15/8C15\8C3A;
                      REP #$30                                  ;;8C17|8C17+8C17/8C17\8C3C; Index (16 bit) Accum (16 bit)
                      LDA.B !Layer2TileUp,X                     ;;8C19|8C19+8C19/8C19\8C3E;
                      AND.W #$000F                              ;;8C1B|8C1B+8C1B/8C1B\8C40;
                      STA.B !_8                                 ;;8C1E|8C1E+8C1E/8C1E\8C43;
                      LDX.W #$0000                              ;;8C20|8C20+8C20/8C20\8C45;
                    - LDY.B !_8                                 ;;8C23|8C23+8C23/8C23\8C48;
                      LDA.B [!Map16LowPtr],Y                    ;;8C25|8C25+8C25/8C25\8C4A;
                      AND.W #$00FF                              ;;8C27|8C27+8C27/8C27\8C4C;
                      STA.B !_0                                 ;;8C2A|8C2A+8C2A/8C2A\8C4F;
                      LDA.B [!Map16HighPtr],Y                   ;;8C2C|8C2C+8C2C/8C2C\8C51;
                      STA.B !_1                                 ;;8C2E|8C2E+8C2E/8C2E\8C53;
                      LDA.B !_0                                 ;;8C30|8C30+8C30/8C30\8C55;
                      ASL A                                     ;;8C32|8C32+8C32/8C32\8C57;
                      TAY                                       ;;8C33|8C33+8C33/8C33\8C58;
                      LDA.W !Map16Pointers,Y                    ;;8C34|8C34+8C34/8C34\8C59;
                      STA.B !_A                                 ;;8C37|8C37+8C37/8C37\8C5C;
                      LDY.W #$0000                              ;;8C39|8C39+8C39/8C39\8C5E;
                      LDA.B [!_A],Y                             ;;8C3C|8C3C+8C3C/8C3C\8C61;
                      ORA.B !_3                                 ;;8C3E|8C3E+8C3E/8C3E\8C63;
                      STA.W !Layer2VramBuffer,X                 ;;8C40|8C40+8C40/8C40\8C65;
                      INY                                       ;;8C43|8C43+8C43/8C43\8C68;
                      INY                                       ;;8C44|8C44+8C44/8C44\8C69;
                      LDA.B [!_A],Y                             ;;8C45|8C45+8C45/8C45\8C6A;
                      ORA.B !_3                                 ;;8C47|8C47+8C47/8C47\8C6C;
                      STA.W !Layer2VramBuffer+2,X               ;;8C49|8C49+8C49/8C49\8C6E;
                      INY                                       ;;8C4C|8C4C+8C4C/8C4C\8C71;
                      INY                                       ;;8C4D|8C4D+8C4D/8C4D\8C72;
                      LDA.B [!_A],Y                             ;;8C4E|8C4E+8C4E/8C4E\8C73;
                      ORA.B !_3                                 ;;8C50|8C50+8C50/8C50\8C75;
                      STA.W !Layer2VramBuffer+$80,X             ;;8C52|8C52+8C52/8C52\8C77;
                      INY                                       ;;8C55|8C55+8C55/8C55\8C7A;
                      INY                                       ;;8C56|8C56+8C56/8C56\8C7B;
                      LDA.B [!_A],Y                             ;;8C57|8C57+8C57/8C57\8C7C;
                      ORA.B !_3                                 ;;8C59|8C59+8C59/8C59\8C7E;
                      STA.W !Layer2VramBuffer+$82,X             ;;8C5B|8C5B+8C5B/8C5B\8C80;
                      INX                                       ;;8C5E|8C5E+8C5E/8C5E\8C83;
                      INX                                       ;;8C5F|8C5F+8C5F/8C5F\8C84;
                      INX                                       ;;8C60|8C60+8C60/8C60\8C85;
                      INX                                       ;;8C61|8C61+8C61/8C61\8C86;
                      LDA.B !_8                                 ;;8C62|8C62+8C62/8C62\8C87;
                      CLC                                       ;;8C64|8C64+8C64/8C64\8C89;
                      ADC.W #$0010                              ;;8C65|8C65+8C65/8C65\8C8A;
                      STA.B !_8                                 ;;8C68|8C68+8C68/8C68\8C8D;
                      CMP.W #$01B0                              ;;8C6A|8C6A+8C6A/8C6A\8C8F;
                      BCC -                                     ;;8C6D|8C6D+8C6D/8C6D\8C92;
                      PLP                                       ;;8C6F|8C6F+8C6F/8C6F\8C94;
Return058C70:         RTL                                       ;;8C70|8C70+8C70/8C70\8C95; Return
                                                                ;;                        ;
CODE_058C71:          PHP                                       ;;8C71|8C71+8C71/8C71\8C96;
                      REP #$30                                  ;;8C72|8C72+8C72/8C72\8C97; Index (16 bit) Accum (16 bit)
                      LDA.W !LevelModeSetting                   ;;8C74|8C74+8C74/8C74\8C99;
                      AND.W #$00FF                              ;;8C77|8C77+8C77/8C77\8C9C;
                      ASL A                                     ;;8C7A|8C7A+8C7A/8C7A\8C9F;
                      TAX                                       ;;8C7B|8C7B+8C7B/8C7B\8CA0;
                      SEP #$20                                  ;;8C7C|8C7C+8C7C/8C7C\8CA1; Accum (8 bit)
                      LDY.W #$0000                              ;;8C7E|8C7E+8C7E/8C7E\8CA3;
                      LDA.W !ObjectTileset                      ;;8C81|8C81+8C81/8C81\8CA6;
                      CMP.B #$03                                ;;8C84|8C84+8C84/8C84\8CA9;
                      BNE +                                     ;;8C86|8C86+8C86/8C86\8CAB;
                      LDY.W #$1000                              ;;8C88|8C88+8C88/8C88\8CAD;
                    + STY.B !_3                                 ;;8C8B|8C8B+8C8B/8C8B\8CB0;
                      LDA.L Ptrs00BDE8,X                        ;;8C8D|8C8D+8C8D/8C8D\8CB2;
                      STA.B !_A                                 ;;8C91|8C91+8C91/8C91\8CB6;
                      LDA.L Ptrs00BDE8+1,X                      ;;8C93|8C93+8C93/8C93\8CB8;
                      STA.B !_B                                 ;;8C97|8C97+8C97/8C97\8CBC;
                      LDA.L Ptrs00BE68,X                        ;;8C99|8C99+8C99/8C99\8CBE;
                      STA.B !_D                                 ;;8C9D|8C9D+8C9D/8C9D\8CC2;
                      LDA.L Ptrs00BE68+1,X                      ;;8C9F|8C9F+8C9F/8C9F\8CC4;
                      STA.B !_E                                 ;;8CA3|8CA3+8CA3/8CA3\8CC8;
                      LDA.B #$00                                ;;8CA5|8CA5+8CA5/8CA5\8CCA;
                      STA.B !_C                                 ;;8CA7|8CA7+8CA7/8CA7\8CCC;
                      STA.B !_F                                 ;;8CA9|8CA9+8CA9/8CA9\8CCE;
                      LDA.B !Layer2ScrollDir                    ;;8CAB|8CAB+8CAB/8CAB\8CD0;
                      TAX                                       ;;8CAD|8CAD+8CAD/8CAD\8CD2;
                      LDY.W #$0030                              ;;8CAE|8CAE+8CAE/8CAE\8CD3;
                      LDA.B !Layer2TileUp,X                     ;;8CB1|8CB1+8CB1/8CB1\8CD6;
                      AND.B #$10                                ;;8CB3|8CB3+8CB3/8CB3\8CD8;
                      BEQ +                                     ;;8CB5|8CB5+8CB5/8CB5\8CDA;
                      LDY.W #$0038                              ;;8CB7|8CB7+8CB7/8CB7\8CDC;
                    + TYA                                       ;;8CBA|8CBA+8CBA/8CBA\8CDF;
                      STA.B !_0                                 ;;8CBB|8CBB+8CBB/8CBB\8CE0;
                      LDA.B !Layer2TileUp,X                     ;;8CBD|8CBD+8CBD/8CBD\8CE2;
                      LSR A                                     ;;8CBF|8CBF+8CBF/8CBF\8CE4;
                      LSR A                                     ;;8CC0|8CC0+8CC0/8CC0\8CE5;
                      AND.B #$03                                ;;8CC1|8CC1+8CC1/8CC1\8CE6;
                      ORA.B !_0                                 ;;8CC3|8CC3+8CC3/8CC3\8CE8;
                      STA.W !Layer2VramAddr                     ;;8CC5|8CC5+8CC5/8CC5\8CEA;
                      LDA.B !Layer2TileUp,X                     ;;8CC8|8CC8+8CC8/8CC8\8CED;
                      AND.B #$03                                ;;8CCA|8CCA+8CCA/8CCA\8CEF;
                      ASL A                                     ;;8CCC|8CCC+8CCC/8CCC\8CF1;
                      ASL A                                     ;;8CCD|8CCD+8CCD/8CCD\8CF2;
                      ASL A                                     ;;8CCE|8CCE+8CCE/8CCE\8CF3;
                      ASL A                                     ;;8CCF|8CCF+8CCF/8CCF\8CF4;
                      ASL A                                     ;;8CD0|8CD0+8CD0/8CD0\8CF5;
                      ASL A                                     ;;8CD1|8CD1+8CD1/8CD1\8CF6;
                      STA.W !Layer2VramAddr+1                   ;;8CD2|8CD2+8CD2/8CD2\8CF7;
                      REP #$20                                  ;;8CD5|8CD5+8CD5/8CD5\8CFA; Accum (16 bit)
                      LDA.B !Layer2TileUp,X                     ;;8CD7|8CD7+8CD7/8CD7\8CFC;
                      AND.W #$01F0                              ;;8CD9|8CD9+8CD9/8CD9\8CFE;
                      LSR A                                     ;;8CDC|8CDC+8CDC/8CDC\8D01;
                      LSR A                                     ;;8CDD|8CDD+8CDD/8CDD\8D02;
                      LSR A                                     ;;8CDE|8CDE+8CDE/8CDE\8D03;
                      LSR A                                     ;;8CDF|8CDF+8CDF/8CDF\8D04;
                      STA.B !_0                                 ;;8CE0|8CE0+8CE0/8CE0\8D05;
                      ASL A                                     ;;8CE2|8CE2+8CE2/8CE2\8D07;
                      CLC                                       ;;8CE3|8CE3+8CE3/8CE3\8D08;
                      ADC.B !_0                                 ;;8CE4|8CE4+8CE4/8CE4\8D09;
                      TAY                                       ;;8CE6|8CE6+8CE6/8CE6\8D0B;
                      LDA.B [!_A],Y                             ;;8CE7|8CE7+8CE7/8CE7\8D0C;
                      STA.B !Map16LowPtr                        ;;8CE9|8CE9+8CE9/8CE9\8D0E;
                      LDA.B [!_D],Y                             ;;8CEB|8CEB+8CEB/8CEB\8D10;
                      STA.B !Map16HighPtr                       ;;8CED|8CED+8CED/8CED\8D12;
                      SEP #$20                                  ;;8CEF|8CEF+8CEF/8CEF\8D14; Accum (8 bit)
                      INY                                       ;;8CF1|8CF1+8CF1/8CF1\8D16;
                      INY                                       ;;8CF2|8CF2+8CF2/8CF2\8D17;
                      LDA.B [!_A],Y                             ;;8CF3|8CF3+8CF3/8CF3\8D18;
                      STA.B !Map16LowPtr+2                      ;;8CF5|8CF5+8CF5/8CF5\8D1A;
                      LDA.B [!_D],Y                             ;;8CF7|8CF7+8CF7/8CF7\8D1C;
                      STA.B !Map16HighPtr+2                     ;;8CF9|8CF9+8CF9/8CF9\8D1E;
                      SEP #$10                                  ;;8CFB|8CFB+8CFB/8CFB\8D20; Index (8 bit)
                      LDY.B #$0D                                ;;8CFD|8CFD+8CFD/8CFD\8D22;
                      LDA.W !ObjectTileset                      ;;8CFF|8CFF+8CFF/8CFF\8D24;
                      CMP.B #$10                                ;;8D02|8D02+8D02/8D02\8D27;
                      BMI +                                     ;;8D04|8D04+8D04/8D04\8D29;
                      LDY.B #$05                                ;;8D06|8D06+8D06/8D06\8D2B;
                    + STY.B !_C                                 ;;8D08|8D08+8D08/8D08\8D2D;
                      REP #$30                                  ;;8D0A|8D0A+8D0A/8D0A\8D2F; Index (16 bit) Accum (16 bit)
                      LDA.B !Layer2TileUp,X                     ;;8D0C|8D0C+8D0C/8D0C\8D31;
                      AND.W #$000F                              ;;8D0E|8D0E+8D0E/8D0E\8D33;
                      ASL A                                     ;;8D11|8D11+8D11/8D11\8D36;
                      ASL A                                     ;;8D12|8D12+8D12/8D12\8D37;
                      ASL A                                     ;;8D13|8D13+8D13/8D13\8D38;
                      ASL A                                     ;;8D14|8D14+8D14/8D14\8D39;
                      STA.B !_8                                 ;;8D15|8D15+8D15/8D15\8D3A;
                      LDX.W #$0000                              ;;8D17|8D17+8D17/8D17\8D3C;
CODE_058D1A:          LDY.B !_8                                 ;;8D1A|8D1A+8D1A/8D1A\8D3F;
                      LDA.B [!Map16LowPtr],Y                    ;;8D1C|8D1C+8D1C/8D1C\8D41;
                      AND.W #$00FF                              ;;8D1E|8D1E+8D1E/8D1E\8D43;
                      STA.B !_0                                 ;;8D21|8D21+8D21/8D21\8D46;
                      LDA.B [!Map16HighPtr],Y                   ;;8D23|8D23+8D23/8D23\8D48;
                      STA.B !_1                                 ;;8D25|8D25+8D25/8D25\8D4A;
                      LDA.B !_0                                 ;;8D27|8D27+8D27/8D27\8D4C;
                      ASL A                                     ;;8D29|8D29+8D29/8D29\8D4E;
                      TAY                                       ;;8D2A|8D2A+8D2A/8D2A\8D4F;
                      LDA.W !Map16Pointers,Y                    ;;8D2B|8D2B+8D2B/8D2B\8D50;
                      STA.B !_A                                 ;;8D2E|8D2E+8D2E/8D2E\8D53;
                      LDY.W #$0000                              ;;8D30|8D30+8D30/8D30\8D55;
                      LDA.B [!_A],Y                             ;;8D33|8D33+8D33/8D33\8D58;
                      ORA.B !_3                                 ;;8D35|8D35+8D35/8D35\8D5A;
                      STA.W !Layer2VramBuffer,X                 ;;8D37|8D37+8D37/8D37\8D5C;
                      INY                                       ;;8D3A|8D3A+8D3A/8D3A\8D5F;
                      INY                                       ;;8D3B|8D3B+8D3B/8D3B\8D60;
                      LDA.B [!_A],Y                             ;;8D3C|8D3C+8D3C/8D3C\8D61;
                      ORA.B !_3                                 ;;8D3E|8D3E+8D3E/8D3E\8D63;
                      STA.W !Layer2VramBuffer+$80,X             ;;8D40|8D40+8D40/8D40\8D65;
                      INX                                       ;;8D43|8D43+8D43/8D43\8D68;
                      INX                                       ;;8D44|8D44+8D44/8D44\8D69;
                      INY                                       ;;8D45|8D45+8D45/8D45\8D6A;
                      INY                                       ;;8D46|8D46+8D46/8D46\8D6B;
                      LDA.B [!_A],Y                             ;;8D47|8D47+8D47/8D47\8D6C;
                      ORA.B !_3                                 ;;8D49|8D49+8D49/8D49\8D6E;
                      STA.W !Layer2VramBuffer,X                 ;;8D4B|8D4B+8D4B/8D4B\8D70;
                      INY                                       ;;8D4E|8D4E+8D4E/8D4E\8D73;
                      INY                                       ;;8D4F|8D4F+8D4F/8D4F\8D74;
                      LDA.B [!_A],Y                             ;;8D50|8D50+8D50/8D50\8D75;
                      ORA.B !_3                                 ;;8D52|8D52+8D52/8D52\8D77;
                      STA.W !Layer2VramBuffer+$80,X             ;;8D54|8D54+8D54/8D54\8D79;
                      INX                                       ;;8D57|8D57+8D57/8D57\8D7C;
                      INX                                       ;;8D58|8D58+8D58/8D58\8D7D;
                      LDA.B !_8                                 ;;8D59|8D59+8D59/8D59\8D7E;
                      TAY                                       ;;8D5B|8D5B+8D5B/8D5B\8D80;
                      CLC                                       ;;8D5C|8D5C+8D5C/8D5C\8D81;
                      ADC.W #$0001                              ;;8D5D|8D5D+8D5D/8D5D\8D82;
                      STA.B !_8                                 ;;8D60|8D60+8D60/8D60\8D85;
                      AND.W #$000F                              ;;8D62|8D62+8D62/8D62\8D87;
                      BNE +                                     ;;8D65|8D65+8D65/8D65\8D8A;
                      TYA                                       ;;8D67|8D67+8D67/8D67\8D8C;
                      AND.W #$FFF0                              ;;8D68|8D68+8D68/8D68\8D8D;
                      CLC                                       ;;8D6B|8D6B+8D6B/8D6B\8D90;
                      ADC.W #$0100                              ;;8D6C|8D6C+8D6C/8D6C\8D91;
                      STA.B !_8                                 ;;8D6F|8D6F+8D6F/8D6F\8D94;
                    + LDA.B !_8                                 ;;8D71|8D71+8D71/8D71\8D96;
                      AND.W #$010F                              ;;8D73|8D73+8D73/8D73\8D98;
                      BNE CODE_058D1A                           ;;8D76|8D76+8D76/8D76\8D9B;
                      PLP                                       ;;8D78|8D78+8D78/8D78\8D9D;
                      RTL                                       ;;8D79|8D79+8D79/8D79\8D9E; Return
                                                                ;;                        ;
CODE_058D7A:          PHP                                       ;;8D7A|8D7A+8D7A/8D7A\8D9F;
                      SEP #$30                                  ;;8D7B|8D7B+8D7B/8D7B\8DA0; Index (8 bit) Accum (8 bit)
                      LDA.W !LevelLoadObject                    ;;8D7D|8D7D+8D7D/8D7D\8DA2;
                      AND.B #$0F                                ;;8D80|8D80+8D80/8D80\8DA5;
                      ASL A                                     ;;8D82|8D82+8D82/8D82\8DA7;
                      STA.W !Layer2VramAddr+1                   ;;8D83|8D83+8D83/8D83\8DA8;
                      LDY.B #$30                                ;;8D86|8D86+8D86/8D86\8DAB;
                      LDA.W !LevelLoadObject                    ;;8D88|8D88+8D88/8D88\8DAD;
                      AND.B #$10                                ;;8D8B|8D8B+8D8B/8D8B\8DB0;
                      BEQ +                                     ;;8D8D|8D8D+8D8D/8D8D\8DB2;
                      LDY.B #$34                                ;;8D8F|8D8F+8D8F/8D8F\8DB4;
                    + TYA                                       ;;8D91|8D91+8D91/8D91\8DB6;
                      STA.W !Layer2VramAddr                     ;;8D92|8D92+8D92/8D92\8DB7;
                      REP #$20                                  ;;8D95|8D95+8D95/8D95\8DBA; Accum (16 bit)
                      LDA.W #$B900                              ;;8D97|8D97+8D97/8D97\8DBC;
                      STA.B !Map16LowPtr                        ;;8D9A|8D9A+8D9A/8D9A\8DBF;
                      LDA.W #$BD00                              ;;8D9C|8D9C+8D9C/8D9C\8DC1;
                      STA.B !Map16HighPtr                       ;;8D9F|8D9F+8D9F/8D9F\8DC4;
                      LDA.W #Map16BGTiles                       ;;8DA1|8DA1+8DA1/8DA1\8DC6;
                      STA.B !_A                                 ;;8DA4|8DA4+8DA4/8DA4\8DC9;
                      LDA.W !LevelLoadObject                    ;;8DA6|8DA6+8DA6/8DA6\8DCB;
                      AND.W #$00F0                              ;;8DA9|8DA9+8DA9/8DA9\8DCE;
                      BEQ +                                     ;;8DAC|8DAC+8DAC/8DAC\8DD1;
                      LDA.B !Map16LowPtr                        ;;8DAE|8DAE+8DAE/8DAE\8DD3;
                      CLC                                       ;;8DB0|8DB0+8DB0/8DB0\8DD5;
                      ADC.W #$01B0                              ;;8DB1|8DB1+8DB1/8DB1\8DD6;
                      STA.B !Map16LowPtr                        ;;8DB4|8DB4+8DB4/8DB4\8DD9;
                      LDA.B !Map16HighPtr                       ;;8DB6|8DB6+8DB6/8DB6\8DDB;
                      CLC                                       ;;8DB8|8DB8+8DB8/8DB8\8DDD;
                      ADC.W #$01B0                              ;;8DB9|8DB9+8DB9/8DB9\8DDE;
                      STA.B !Map16HighPtr                       ;;8DBC|8DBC+8DBC/8DBC\8DE1;
                    + SEP #$20                                  ;;8DBE|8DBE+8DBE/8DBE\8DE3; Accum (8 bit)
                      LDA.B #$7E                                ;;8DC0|8DC0+8DC0/8DC0\8DE5;
                      STA.B !Map16LowPtr+2                      ;;8DC2|8DC2+8DC2/8DC2\8DE7;
                      LDA.B #$7E                                ;;8DC4|8DC4+8DC4/8DC4\8DE9;
                      STA.B !Map16HighPtr+2                     ;;8DC6|8DC6+8DC6/8DC6\8DEB;
                      LDY.B #Map16BGTiles>>16                   ;;8DC8|8DC8+8DC8/8DC8\8DED;
                      STY.B !_C                                 ;;8DCA|8DCA+8DCA/8DCA\8DEF;
                      REP #$30                                  ;;8DCC|8DCC+8DCC/8DCC\8DF1; Index (16 bit) Accum (16 bit)
                      LDA.W !LevelLoadObject                    ;;8DCE|8DCE+8DCE/8DCE\8DF3;
                      AND.W #$000F                              ;;8DD1|8DD1+8DD1/8DD1\8DF6;
                      STA.B !_8                                 ;;8DD4|8DD4+8DD4/8DD4\8DF9;
                      LDX.W #$0000                              ;;8DD6|8DD6+8DD6/8DD6\8DFB;
                    - LDY.B !_8                                 ;;8DD9|8DD9+8DD9/8DD9\8DFE;
                      LDA.B [!Map16LowPtr],Y                    ;;8DDB|8DDB+8DDB/8DDB\8E00;
                      AND.W #$00FF                              ;;8DDD|8DDD+8DDD/8DDD\8E02;
                      STA.B !_0                                 ;;8DE0|8DE0+8DE0/8DE0\8E05;
                      LDA.B [!Map16HighPtr],Y                   ;;8DE2|8DE2+8DE2/8DE2\8E07;
                      STA.B !_1                                 ;;8DE4|8DE4+8DE4/8DE4\8E09;
                      LDA.B !_0                                 ;;8DE6|8DE6+8DE6/8DE6\8E0B;
                      ASL A                                     ;;8DE8|8DE8+8DE8/8DE8\8E0D;
                      ASL A                                     ;;8DE9|8DE9+8DE9/8DE9\8E0E;
                      ASL A                                     ;;8DEA|8DEA+8DEA/8DEA\8E0F;
                      TAY                                       ;;8DEB|8DEB+8DEB/8DEB\8E10;
                      LDA.B [!_A],Y                             ;;8DEC|8DEC+8DEC/8DEC\8E11;
                      STA.W !Layer2VramBuffer,X                 ;;8DEE|8DEE+8DEE/8DEE\8E13;
                      INY                                       ;;8DF1|8DF1+8DF1/8DF1\8E16;
                      INY                                       ;;8DF2|8DF2+8DF2/8DF2\8E17;
                      LDA.B [!_A],Y                             ;;8DF3|8DF3+8DF3/8DF3\8E18;
                      STA.W !Layer2VramBuffer+2,X               ;;8DF5|8DF5+8DF5/8DF5\8E1A;
                      INY                                       ;;8DF8|8DF8+8DF8/8DF8\8E1D;
                      INY                                       ;;8DF9|8DF9+8DF9/8DF9\8E1E;
                      LDA.B [!_A],Y                             ;;8DFA|8DFA+8DFA/8DFA\8E1F;
                      STA.W !Layer2VramBuffer+$80,X             ;;8DFC|8DFC+8DFC/8DFC\8E21;
                      INY                                       ;;8DFF|8DFF+8DFF/8DFF\8E24;
                      INY                                       ;;8E00|8E00+8E00/8E00\8E25;
                      LDA.B [!_A],Y                             ;;8E01|8E01+8E01/8E01\8E26;
                      STA.W !Layer2VramBuffer+$82,X             ;;8E03|8E03+8E03/8E03\8E28;
                      INX                                       ;;8E06|8E06+8E06/8E06\8E2B;
                      INX                                       ;;8E07|8E07+8E07/8E07\8E2C;
                      INX                                       ;;8E08|8E08+8E08/8E08\8E2D;
                      INX                                       ;;8E09|8E09+8E09/8E09\8E2E;
                      LDA.B !_8                                 ;;8E0A|8E0A+8E0A/8E0A\8E2F;
                      CLC                                       ;;8E0C|8E0C+8E0C/8E0C\8E31;
                      ADC.W #$0010                              ;;8E0D|8E0D+8E0D/8E0D\8E32;
                      STA.B !_8                                 ;;8E10|8E10+8E10/8E10\8E35;
                      CMP.W #$01B0                              ;;8E12|8E12+8E12/8E12\8E37;
                      BCC -                                     ;;8E15|8E15+8E15/8E15\8E3A;
                      PLP                                       ;;8E17|8E17+8E17/8E17\8E3C;
                      RTL                                       ;;8E18|8E18+8E18/8E18\8E3D; Return
                                                                ;;                        ;
                      %insert_empty($1E7,$1E7,$1E7,$1E7,$1C2)   ;;8E19|8E19+8E19/8E19\8E3E;
                                                                ;;                        ;
Layer3Ptr:            dl DATA_059549                            ;;9000|9000+9000/9000\9000;
                      dl DATA_059549                            ;;9003|9003+9003/9003\9003;
                      dl DATA_059087                            ;;9006|9006+9006/9006\9006;
                      dl DATA_059549                            ;;9009|9009+9009/9009\9009;
                      dl DATA_059294                            ;;900C|900C+900C/900C\900C;
                      dl DATA_059AE0                            ;;900F|900F+900F/900F\900F;
                      dl DATA_059549                            ;;9012|9012+9012/9012\9012;
                      dl DATA_059549                            ;;9015|9015+9015/9015\9015;
                      dl DATA_059087                            ;;9018|9018+9018/9018\9018;
                      dl DATA_059549                            ;;901B|901B+901B/901B\901B;
                      dl DATA_059549                            ;;901E|901E+901E/901E\901E;
                      dl DATA_05A221                            ;;9021|9021+9021/9021\9021;
                      dl DATA_059549                            ;;9024|9024+9024/9024\9024;
                      dl DATA_059549                            ;;9027|9027+9027/9027\9027;
                      dl DATA_059087                            ;;902A|902A+902A/902A\902A;
                      dl DATA_059549                            ;;902D|902D+902D/902D\902D;
                      dl DATA_059549                            ;;9030|9030+9030/9030\9030;
                      dl DATA_0595DE                            ;;9033|9033+9033/9033\9033;
                      dl DATA_059549                            ;;9036|9036+9036/9036\9036;
                      dl DATA_059549                            ;;9039|9039+9039/9039\9039;
                      dl DATA_059087                            ;;903C|903C+903C/903C\903C;
                      dl DATA_059549                            ;;903F|903F+903F/903F\903F;
                      dl DATA_059549                            ;;9042|9042+9042/9042\9042;
                      dl DATA_059087                            ;;9045|9045+9045/9045\9045;
                      dl DATA_059549                            ;;9048|9048+9048/9048\9048;
                      dl DATA_059549                            ;;904B|904B+904B/904B\904B;
                      dl DATA_059087                            ;;904E|904E+904E/904E\904E;
                      dl DATA_059549                            ;;9051|9051+9051/9051\9051;
                      dl DATA_059549                            ;;9054|9054+9054/9054\9054;
                      dl DATA_059A17                            ;;9057|9057+9057/9057\9057;
                      dl DATA_059549                            ;;905A|905A+905A/905A\905A;
                      dl DATA_059549                            ;;905D|905D+905D/905D\905D;
                      dl DATA_059087                            ;;9060|9060+9060/9060\9060;
                      dl DATA_059549                            ;;9063|9063+9063/9063\9063;
                      dl DATA_059549                            ;;9066|9066+9066/9066\9066;
                      dl DATA_059087                            ;;9069|9069+9069/9069\9069;
                      dl DATA_059549                            ;;906C|906C+906C/906C\906C;
                      dl DATA_059549                            ;;906F|906F+906F/906F\906F;
                      dl DATA_059087                            ;;9072|9072+9072/9072\9072;
                      dl DATA_059549                            ;;9075|9075+9075/9075\9075;
                      dl DATA_059549                            ;;9078|9078+9078/9078\9078;
                      dl DATA_0595DE                            ;;907B|907B+907B/907B\907B;
                      dl DATA_059549                            ;;907E|907E+907E/907E\907E;
                      dl DATA_059549                            ;;9081|9081+9081/9081\9081;
                      dl DATA_05A221                            ;;9084|9084+9084/9084\9084;
                                                                ;;                        ;
DATA_059087:          db $58,$06,$00,$03,$87,$39,$88,$39        ;;9087|9087+9087/9087\9087;
                      db $58,$12,$00,$03,$87,$39,$88,$39        ;;908F|908F+908F/908F\908F;
                      db $58,$26,$00,$03,$97,$39,$98,$39        ;;9097|9097+9097/9097\9097;
                      db $58,$2C,$00,$03,$87,$39,$88,$39        ;;909F|909F+909F/909F\909F;
                      db $58,$32,$00,$03,$97,$39,$98,$39        ;;90A7|90A7+90A7/90A7\90A7;
                      db $58,$38,$00,$03,$87,$39,$88,$39        ;;90AF|90AF+90AF/90AF\90AF;
                      db $58,$46,$00,$03,$85,$39,$86,$39        ;;90B7|90B7+90B7/90B7\90B7;
                      db $58,$4C,$00,$03,$97,$39,$98,$39        ;;90BF|90BF+90BF/90BF\90BF;
                      db $58,$52,$00,$03,$85,$39,$86,$39        ;;90C7|90C7+90C7/90C7\90C7;
                      db $58,$58,$00,$03,$97,$39,$98,$39        ;;90CF|90CF+90CF/90CF\90CF;
                      db $58,$66,$00,$03,$95,$39,$96,$39        ;;90D7|90D7+90D7/90D7\90D7;
                      db $58,$6C,$00,$03,$95,$39,$96,$39        ;;90DF|90DF+90DF/90DF\90DF;
                      db $58,$72,$00,$03,$95,$39,$96,$39        ;;90E7|90E7+90E7/90E7\90E7;
                      db $58,$78,$00,$03,$95,$39,$96,$39        ;;90EF|90EF+90EF/90EF\90EF;
                      db $58,$84,$00,$2F,$80,$3D,$81,$3D        ;;90F7|90F7+90F7/90F7\90F7;
                      db $82,$3D,$82,$7D,$82,$3D,$82,$7D        ;;90FF|90FF+90FF/90FF\90FF;
                      db $82,$3D,$82,$7D,$82,$3D,$82,$7D        ;;9107|9107+9107/9107\9107;
                      db $82,$3D,$82,$7D,$82,$3D,$82,$7D        ;;910F|910F+910F/910F\910F;
                      db $82,$3D,$82,$7D,$82,$3D,$82,$7D        ;;9117|9117+9117/9117\9117;
                      db $82,$3D,$82,$7D,$82,$3D,$82,$7D        ;;911F|911F+911F/911F\911F;
                      db $81,$7D,$80,$7D,$58,$A4,$00,$2F        ;;9127|9127+9127/9127\9127;
                      db $90,$3D,$91,$3D,$92,$3D,$92,$7D        ;;912F|912F+912F/912F\912F;
                      db $92,$3D,$92,$7D,$92,$3D,$92,$7D        ;;9137|9137+9137/9137\9137;
                      db $92,$3D,$92,$7D,$92,$3D,$92,$7D        ;;913F|913F+913F/913F\913F;
                      db $92,$3D,$92,$7D,$92,$3D,$92,$7D        ;;9147|9147+9147/9147\9147;
                      db $92,$3D,$92,$7D,$92,$3D,$92,$7D        ;;914F|914F+914F/914F\914F;
                      db $92,$3D,$92,$7D,$91,$7D,$90,$7D        ;;9157|9157+9157/9157\9157;
                      db $58,$C4,$80,$13,$83,$3D,$83,$BD        ;;915F|915F+915F/915F\915F;
                      db $83,$3D,$83,$BD,$83,$3D,$83,$BD        ;;9167|9167+9167/9167\9167;
                      db $83,$3D,$83,$BD,$83,$3D,$83,$BD        ;;916F|916F+916F/916F\916F;
                      db $58,$C5,$80,$13,$84,$3D,$84,$BD        ;;9177|9177+9177/9177\9177;
                      db $84,$3D,$84,$BD,$84,$3D,$84,$BD        ;;917F|917F+917F/917F\917F;
                      db $84,$3D,$84,$BD,$84,$3D,$84,$BD        ;;9187|9187+9187/9187\9187;
                      db $58,$C7,$C0,$12,$93,$39,$58,$C8        ;;918F|918F+918F/918F\918F;
                      db $C0,$12,$94,$39,$58,$C9,$C0,$12        ;;9197|9197+9197/9197\9197;
                      db $93,$39,$58,$CA,$C0,$12,$94,$39        ;;919F|919F+919F/919F\919F;
                      db $58,$CB,$C0,$12,$93,$39,$58,$CC        ;;91A7|91A7+91A7/91A7\91A7;
                      db $C0,$12,$94,$39,$58,$CD,$C0,$12        ;;91AF|91AF+91AF/91AF\91AF;
                      db $93,$39,$58,$CE,$C0,$12,$94,$39        ;;91B7|91B7+91B7/91B7\91B7;
                      db $58,$CF,$C0,$12,$93,$39,$58,$D0        ;;91BF|91BF+91BF/91BF\91BF;
                      db $C0,$12,$94,$39,$58,$D1,$C0,$12        ;;91C7|91C7+91C7/91C7\91C7;
                      db $93,$39,$58,$D2,$C0,$12,$94,$39        ;;91CF|91CF+91CF/91CF\91CF;
                      db $58,$D3,$C0,$12,$93,$39,$58,$D4        ;;91D7|91D7+91D7/91D7\91D7;
                      db $C0,$12,$94,$39,$58,$D5,$C0,$12        ;;91DF|91DF+91DF/91DF\91DF;
                      db $93,$39,$58,$D6,$C0,$12,$94,$39        ;;91E7|91E7+91E7/91E7\91E7;
                      db $58,$D7,$C0,$12,$93,$39,$58,$D8        ;;91EF|91EF+91EF/91EF\91EF;
                      db $C0,$12,$94,$39,$58,$DA,$80,$13        ;;91F7|91F7+91F7/91F7\91F7;
                      db $83,$3D,$83,$BD,$83,$3D,$83,$BD        ;;91FF|91FF+91FF/91FF\91FF;
                      db $83,$3D,$83,$BD,$83,$3D,$83,$BD        ;;9207|9207+9207/9207\9207;
                      db $83,$3D,$83,$BD,$58,$DB,$80,$13        ;;920F|920F+920F/920F\920F;
                      db $84,$3D,$84,$BD,$84,$3D,$84,$BD        ;;9217|9217+9217/9217\9217;
                      db $84,$3D,$84,$BD,$84,$3D,$84,$BD        ;;921F|921F+921F/921F\921F;
                      db $84,$3D,$84,$BD,$5A,$04,$00,$2F        ;;9227|9227+9227/9227\9227;
                      db $90,$BD,$91,$BD,$82,$3D,$82,$7D        ;;922F|922F+922F/922F\922F;
                      db $82,$3D,$82,$7D,$82,$3D,$82,$7D        ;;9237|9237+9237/9237\9237;
                      db $82,$3D,$82,$7D,$82,$3D,$82,$7D        ;;923F|923F+923F/923F\923F;
                      db $82,$3D,$82,$7D,$82,$3D,$82,$7D        ;;9247|9247+9247/9247\9247;
                      db $82,$3D,$82,$7D,$82,$3D,$82,$7D        ;;924F|924F+924F/924F\924F;
                      db $82,$3D,$82,$7D,$91,$FD,$90,$FD        ;;9257|9257+9257/9257\9257;
                      db $5A,$24,$00,$2F,$80,$BD,$81,$BD        ;;925F|925F+925F/925F\925F;
                      db $92,$3D,$92,$7D,$92,$3D,$92,$7D        ;;9267|9267+9267/9267\9267;
                      db $92,$3D,$92,$7D,$92,$3D,$92,$7D        ;;926F|926F+926F/926F\926F;
                      db $92,$3D,$92,$7D,$92,$3D,$92,$7D        ;;9277|9277+9277/9277\9277;
                      db $92,$3D,$92,$7D,$92,$3D,$92,$7D        ;;927F|927F+927F/927F\927F;
                      db $92,$3D,$92,$7D,$92,$3D,$92,$7D        ;;9287|9287+9287/9287\9287;
                      db $81,$FD,$80,$FD,$FF                    ;;928F|928F+928F/928F\928F;
                                                                ;;                        ;
DATA_059294:          db $50,$A8,$00,$1F,$99,$3D,$9A,$3D        ;;9294|9294+9294/9294\9294;
                      db $A1,$AD,$B2,$2D,$B3,$2D,$B4,$2D        ;;929C|929C+929C/929C\929C;
                      db $A5,$AD,$B6,$2D,$B7,$2D,$B8,$2D        ;;92A4|92A4+92A4/92A4\92A4;
                      db $B4,$2D,$BA,$2D,$BB,$2D,$BC,$2D        ;;92AC|92AC+92AC/92AC\92AC;
                      db $FE,$2C,$FE,$2C,$50,$C8,$00,$1F        ;;92B4|92B4+92B4/92B4\92B4;
                      db $8B,$3D,$8C,$3D,$C1,$2D,$C2,$2D        ;;92BC|92BC+92BC/92BC\92BC;
                      db $C3,$2D,$B4,$AD,$A3,$2D,$A4,$2D        ;;92C4|92C4+92C4/92C4\92C4;
                      db $C7,$2D,$C8,$2D,$B4,$AD,$BA,$AD        ;;92CC|92CC+92CC/92CC\92CC;
                      db $D5,$2D,$CC,$2D,$FE,$2C,$FE,$2C        ;;92D4|92D4+92D4/92D4\92D4;
                      db $50,$E8,$00,$1F,$9B,$3D,$9C,$3D        ;;92DC|92DC+92DC/92DC\92DC;
                      db $D1,$2D,$D2,$2D,$D3,$2D,$B7,$AD        ;;92E4|92E4+92E4/92E4\92E4;
                      db $D5,$2D,$B4,$2D,$D7,$2D,$C7,$2D        ;;92EC|92EC+92EC/92EC\92EC;
                      db $D9,$2D,$D9,$6D,$DB,$2D,$DC,$2D        ;;92F4|92F4+92F4/92F4\92F4;
                      db $FE,$2C,$FE,$2C,$51,$08,$00,$1F        ;;92FC|92FC+92FC/92FC\92FC;
                      db $89,$3D,$8A,$3D,$A1,$2D,$A2,$2D        ;;9304|9304+9304/9304\9304;
                      db $A3,$2D,$A4,$2D,$A5,$2D,$B4,$AD        ;;930C|930C+930C/930C\930C;
                      db $D5,$2D,$C7,$AD,$FD,$2C,$AA,$2D        ;;9314|9314+9314/9314\9314;
                      db $AB,$2D,$AC,$2D,$FE,$2C,$FE,$2C        ;;931C|931C+931C/931C\931C;
                      db $51,$28,$00,$1F,$99,$3D,$9A,$3D        ;;9324|9324+9324/9324\9324;
                      db $A1,$AD,$B2,$2D,$B3,$2D,$B4,$2D        ;;932C|932C+932C/932C\932C;
                      db $A5,$AD,$B6,$2D,$B7,$2D,$B8,$2D        ;;9334|9334+9334/9334\9334;
                      db $B4,$2D,$BA,$2D,$BB,$2D,$BC,$2D        ;;933C|933C+933C/933C\933C;
                      db $FE,$2C,$FE,$2C,$51,$48,$00,$1F        ;;9344|9344+9344/9344\9344;
                      db $8B,$3D,$8C,$3D,$C1,$2D,$C2,$2D        ;;934C|934C+934C/934C\934C;
                      db $C3,$2D,$B4,$AD,$A3,$2D,$A4,$2D        ;;9354|9354+9354/9354\9354;
                      db $C7,$2D,$C8,$2D,$B4,$AD,$BA,$AD        ;;935C|935C+935C/935C\935C;
                      db $D5,$2D,$CC,$2D,$FE,$2C,$FE,$2C        ;;9364|9364+9364/9364\9364;
                      db $51,$68,$00,$1F,$9B,$3D,$9C,$3D        ;;936C|936C+936C/936C\936C;
                      db $D1,$2D,$D2,$2D,$D3,$2D,$B7,$AD        ;;9374|9374+9374/9374\9374;
                      db $D5,$2D,$B4,$2D,$D7,$2D,$C7,$2D        ;;937C|937C+937C/937C\937C;
                      db $D9,$2D,$D9,$6D,$DB,$2D,$DC,$2D        ;;9384|9384+9384/9384\9384;
                      db $FE,$2C,$FE,$2C,$51,$88,$00,$1F        ;;938C|938C+938C/938C\938C;
                      db $89,$3D,$8A,$3D,$A1,$2D,$A2,$2D        ;;9394|9394+9394/9394\9394;
                      db $A3,$2D,$A4,$2D,$A5,$2D,$B4,$AD        ;;939C|939C+939C/939C\939C;
                      db $D5,$2D,$C7,$AD,$FD,$2C,$AA,$2D        ;;93A4|93A4+93A4/93A4\93A4;
                      db $AB,$2D,$AC,$2D,$FE,$2C,$FE,$2C        ;;93AC|93AC+93AC/93AC\93AC;
                      db $51,$A8,$00,$1F,$99,$3D,$9A,$3D        ;;93B4|93B4+93B4/93B4\93B4;
                      db $A1,$AD,$B2,$2D,$B3,$2D,$B4,$2D        ;;93BC|93BC+93BC/93BC\93BC;
                      db $A5,$AD,$B6,$2D,$B7,$2D,$B8,$2D        ;;93C4|93C4+93C4/93C4\93C4;
                      db $B4,$2D,$BA,$2D,$BB,$2D,$BC,$2D        ;;93CC|93CC+93CC/93CC\93CC;
                      db $FE,$2C,$FE,$2C,$51,$C8,$00,$1F        ;;93D4|93D4+93D4/93D4\93D4;
                      db $8B,$3D,$8C,$3D,$C1,$2D,$C2,$2D        ;;93DC|93DC+93DC/93DC\93DC;
                      db $C3,$2D,$B4,$AD,$A3,$2D,$A4,$2D        ;;93E4|93E4+93E4/93E4\93E4;
                      db $C7,$2D,$C8,$2D,$B4,$AD,$BA,$AD        ;;93EC|93EC+93EC/93EC\93EC;
                      db $D5,$2D,$CC,$2D,$FE,$2C,$FE,$2C        ;;93F4|93F4+93F4/93F4\93F4;
                      db $51,$E8,$00,$1F,$9B,$3D,$9C,$3D        ;;93FC|93FC+93FC/93FC\93FC;
                      db $D1,$2D,$D2,$2D,$D3,$2D,$B7,$AD        ;;9404|9404+9404/9404\9404;
                      db $D5,$2D,$B4,$2D,$D7,$2D,$C7,$2D        ;;940C|940C+940C/940C\940C;
                      db $D9,$2D,$D9,$6D,$DB,$2D,$DC,$2D        ;;9414|9414+9414/9414\9414;
                      db $FE,$2C,$FE,$2C,$52,$08,$00,$1F        ;;941C|941C+941C/941C\941C;
                      db $89,$3D,$8A,$3D,$A1,$2D,$A2,$2D        ;;9424|9424+9424/9424\9424;
                      db $A3,$2D,$A4,$2D,$A5,$2D,$B4,$AD        ;;942C|942C+942C/942C\942C;
                      db $D5,$2D,$C7,$AD,$FD,$2C,$AA,$2D        ;;9434|9434+9434/9434\9434;
                      db $AB,$2D,$AC,$2D,$FE,$2C,$FE,$2C        ;;943C|943C+943C/943C\943C;
                      db $52,$28,$00,$1F,$99,$3D,$9A,$3D        ;;9444|9444+9444/9444\9444;
                      db $A1,$AD,$B2,$2D,$B3,$2D,$B4,$2D        ;;944C|944C+944C/944C\944C;
                      db $A5,$AD,$B6,$2D,$B7,$2D,$B8,$2D        ;;9454|9454+9454/9454\9454;
                      db $B4,$2D,$BA,$2D,$BB,$2D,$BC,$2D        ;;945C|945C+945C/945C\945C;
                      db $FE,$2C,$FE,$2C,$52,$48,$00,$1F        ;;9464|9464+9464/9464\9464;
                      db $8B,$3D,$8C,$3D,$C1,$2D,$C2,$2D        ;;946C|946C+946C/946C\946C;
                      db $C3,$2D,$B4,$AD,$A3,$2D,$A4,$2D        ;;9474|9474+9474/9474\9474;
                      db $C7,$2D,$C8,$2D,$B4,$AD,$BA,$AD        ;;947C|947C+947C/947C\947C;
                      db $D5,$2D,$CC,$2D,$FE,$2C,$FE,$2C        ;;9484|9484+9484/9484\9484;
                      db $52,$68,$00,$1F,$9B,$3D,$9C,$3D        ;;948C|948C+948C/948C\948C;
                      db $D1,$2D,$D2,$2D,$D3,$2D,$B7,$AD        ;;9494|9494+9494/9494\9494;
                      db $D5,$2D,$B4,$2D,$D7,$2D,$C7,$2D        ;;949C|949C+949C/949C\949C;
                      db $D9,$2D,$D9,$6D,$DB,$2D,$DC,$2D        ;;94A4|94A4+94A4/94A4\94A4;
                      db $FE,$2C,$FE,$2C,$52,$88,$00,$1F        ;;94AC|94AC+94AC/94AC\94AC;
                      db $89,$3D,$8A,$3D,$A1,$2D,$A2,$2D        ;;94B4|94B4+94B4/94B4\94B4;
                      db $A3,$2D,$A4,$2D,$A5,$2D,$B4,$AD        ;;94BC|94BC+94BC/94BC\94BC;
                      db $D5,$2D,$C7,$AD,$FD,$2C,$AA,$2D        ;;94C4|94C4+94C4/94C4\94C4;
                      db $AB,$2D,$AC,$2D,$FE,$2C,$FE,$2C        ;;94CC|94CC+94CC/94CC\94CC;
                      db $52,$A8,$00,$1F,$99,$3D,$9A,$3D        ;;94D4|94D4+94D4/94D4\94D4;
                      db $A1,$AD,$B2,$2D,$B3,$2D,$B4,$2D        ;;94DC|94DC+94DC/94DC\94DC;
                      db $A5,$AD,$B6,$2D,$B7,$2D,$B8,$2D        ;;94E4|94E4+94E4/94E4\94E4;
                      db $B4,$2D,$BA,$2D,$BB,$2D,$BC,$2D        ;;94EC|94EC+94EC/94EC\94EC;
                      db $FE,$2C,$FE,$2C,$52,$C7,$00,$23        ;;94F4|94F4+94F4/94F4\94F4;
                      db $CD,$2D,$CE,$2D,$CF,$2D,$E1,$2D        ;;94FC|94FC+94FC/94FC\94FC;
                      db $E2,$2D,$E3,$2D,$E4,$2D,$E5,$2D        ;;9504|9504+9504/9504\9504;
                      db $E6,$2D,$E7,$2D,$E8,$2D,$E9,$2D        ;;950C|950C+950C/950C\950C;
                      db $EA,$2D,$EB,$2D,$EC,$2D,$ED,$2D        ;;9514|9514+9514/9514\9514;
                      db $EE,$2D,$CD,$6D,$52,$E7,$00,$23        ;;951C|951C+951C/951C\951C;
                      db $DD,$2D,$DE,$2D,$DF,$2D,$F1,$2D        ;;9524|9524+9524/9524\9524;
                      db $F2,$2D,$DE,$2D,$DF,$2D,$F1,$2D        ;;952C|952C+952C/952C\952C;
                      db $F2,$2D,$DE,$2D,$DF,$2D,$F1,$2D        ;;9534|9534+9534/9534\9534;
                      db $F2,$2D,$DE,$2D,$DF,$2D,$F1,$2D        ;;953C|953C+953C/953C\953C;
                      db $F2,$2D,$DD,$6D,$FF                    ;;9544|9544+9544/9544\9544;
                                                                ;;                        ;
DATA_059549:          db $58,$00,$00,$3F,$7D,$39,$7E,$39        ;;9549|9549+9549/9549\9549;
                      db $7D,$39,$7E,$39,$7D,$39,$7E,$39        ;;9551|9551+9551/9551\9551;
                      db $7D,$39,$7E,$39,$7D,$39,$7E,$39        ;;9559|9559+9559/9559\9559;
                      db $7D,$39,$7E,$39,$7D,$39,$7E,$39        ;;9561|9561+9561/9561\9561;
                      db $7D,$39,$7E,$39,$7D,$39,$7E,$39        ;;9569|9569+9569/9569\9569;
                      db $7D,$39,$7E,$39,$7D,$39,$7E,$39        ;;9571|9571+9571/9571\9571;
                      db $7D,$39,$7E,$39,$7D,$39,$7E,$39        ;;9579|9579+9579/9579\9579;
                      db $7D,$39,$7E,$39,$7D,$39,$7E,$39        ;;9581|9581+9581/9581\9581;
                      db $7D,$39,$7E,$39,$58,$20,$47,$7E        ;;9589|9589+9589/9589\9589;
                      db $8E,$39,$5C,$00,$00,$3F,$7D,$39        ;;9591|9591+9591/9591\9591;
                      db $7E,$39,$7D,$39,$7E,$39,$7D,$39        ;;9599|9599+9599/9599\9599;
                      db $7E,$39,$7D,$39,$7E,$39,$7D,$39        ;;95A1|95A1+95A1/95A1\95A1;
                      db $7E,$39,$7D,$39,$7E,$39,$7D,$39        ;;95A9|95A9+95A9/95A9\95A9;
                      db $7E,$39,$7D,$39,$7E,$39,$7D,$39        ;;95B1|95B1+95B1/95B1\95B1;
                      db $7E,$39,$7D,$39,$7E,$39,$7D,$39        ;;95B9|95B9+95B9/95B9\95B9;
                      db $7E,$39,$7D,$39,$7E,$39,$7D,$39        ;;95C1|95C1+95C1/95C1\95C1;
                      db $7E,$39,$7D,$39,$7E,$39,$7D,$39        ;;95C9|95C9+95C9/95C9\95C9;
                      db $7E,$39,$7D,$39,$7E,$39,$5C,$20        ;;95D1|95D1+95D1/95D1\95D1;
                      db $47,$7E,$8E,$39,$FF                    ;;95D9|95D9+95D9/95D9\95D9;
                                                                ;;                        ;
DATA_0595DE:          db $53,$A0,$00,$03,$FF,$60,$9E,$61        ;;95DE|95DE+95DE/95DE\95DE;
                      db $53,$B8,$00,$01,$9E,$21,$53,$B9        ;;95E6|95E6+95E6/95E6\95E6;
                      db $40,$0C,$FF,$20,$53,$C0,$00,$03        ;;95EE|95EE+95EE/95EE\95EE;
                      db $FF,$60,$9E,$E1,$53,$D8,$00,$01        ;;95F6|95F6+95F6/95F6\95F6;
                      db $9E,$A1,$53,$D9,$40,$0C,$FF,$20        ;;95FE|95FE+95FE/95FE\95FE;
                      db $53,$E0,$40,$08,$FF,$60,$53,$E5        ;;9606|9606+9606/9606\9606;
                      db $00,$01,$9E,$61,$53,$EA,$00,$0B        ;;960E|960E+960E/960E\960E;
                      db $9E,$21,$FF,$20,$FF,$20,$FF,$20        ;;9616|9616+9616/9616\9616;
                      db $FF,$60,$9E,$61,$53,$FB,$00,$01        ;;961E|961E+961E/961E\961E;
                      db $9E,$21,$53,$FC,$40,$06,$FF,$20        ;;9626|9626+9626/9626\9626;
                      db $58,$00,$40,$08,$FF,$60,$58,$05        ;;962E|962E+962E/962E\962E;
                      db $00,$01,$9E,$E1,$58,$0A,$00,$0B        ;;9636|9636+9636/9636\9636;
                      db $9E,$A1,$FF,$20,$FF,$20,$FF,$20        ;;963E|963E+963E/963E\963E;
                      db $FF,$60,$9E,$E1,$58,$1B,$00,$01        ;;9646|9646+9646/9646\9646;
                      db $9E,$A1,$58,$1C,$40,$06,$FF,$20        ;;964E|964E+964E/964E\964E;
                      db $58,$60,$80,$0F,$FF,$20,$FF,$20        ;;9656|9656+9656/9656\9656;
                      db $8F,$61,$8F,$E1,$FF,$20,$FF,$20        ;;965E|965E+965E/965E\965E;
                      db $FF,$60,$FF,$60,$58,$61,$80,$0F        ;;9666|9666+9666/9666\9666;
                      db $FF,$20,$FF,$20,$FC,$60,$FC,$60        ;;966E|966E+966E/966E\966E;
                      db $FF,$20,$FF,$20,$9E,$61,$9E,$E1        ;;9676|9676+9676/9676\9676;
                      db $58,$62,$00,$03,$FF,$60,$9E,$61        ;;967E|967E+967E/967E\967E;
                      db $58,$82,$00,$03,$FF,$60,$9E,$E1        ;;9686|9686+9686/9686\9686;
                      db $58,$E2,$40,$06,$FF,$20,$58,$E6        ;;968E|968E+968E/968E\968E;
                      db $00,$03,$FF,$60,$9E,$61,$59,$02        ;;9696|9696+9696/9696\9696;
                      db $40,$06,$FF,$20,$59,$06,$00,$03        ;;969E|969E+969E/969E\969E;
                      db $FF,$60,$9E,$E1,$58,$6C,$00,$01        ;;96A6|96A6+96A6/96A6\96A6;
                      db $9E,$21,$58,$6D,$40,$24,$FF,$20        ;;96AE|96AE+96AE/96AE\96AE;
                      db $58,$8C,$00,$01,$9E,$A1,$58,$8D        ;;96B6|96B6+96B6/96B6\96B6;
                      db $40,$24,$FF,$20,$58,$B2,$00,$01        ;;96BE|96BE+96BE/96BE\96BE;
                      db $9E,$21,$58,$B3,$40,$18,$FF,$20        ;;96C6|96C6+96C6/96C6\96C6;
                      db $58,$D2,$00,$01,$9E,$A1,$58,$D3        ;;96CE|96CE+96CE/96CE\96CE;
                      db $40,$18,$FF,$20,$58,$FC,$00,$07        ;;96D6|96D6+96D6/96D6\96D6;
                      db $FC,$20,$8F,$21,$FF,$20,$FF,$20        ;;96DE|96DE+96DE/96DE\96DE;
                      db $59,$1C,$00,$07,$FC,$20,$8F,$A1        ;;96E6|96E6+96E6/96E6\96E6;
                      db $FF,$20,$FF,$20,$59,$2E,$00,$0B        ;;96EE|96EE+96EE/96EE\96EE;
                      db $9E,$21,$FF,$20,$FF,$20,$FF,$20        ;;96F6|96F6+96F6/96F6\96F6;
                      db $FF,$60,$9E,$61,$59,$4E,$00,$0B        ;;96FE|96FE+96FE/96FE\96FE;
                      db $9E,$A1,$FF,$20,$FF,$20,$FF,$20        ;;9706|9706+9706/9706\9706;
                      db $FF,$60,$9E,$E1,$59,$38,$00,$01        ;;970E|970E+970E/970E\970E;
                      db $9E,$21,$59,$39,$40,$0C,$FF,$20        ;;9716|9716+9716/9716\9716;
                      db $59,$58,$00,$01,$9E,$A1,$59,$59        ;;971E|971E+971E/971E\971E;
                      db $40,$0C,$FF,$20,$59,$A4,$00,$01        ;;9726|9726+9726/9726\9726;
                      db $9E,$21,$59,$A5,$40,$0E,$FF,$20        ;;972E|972E+972E/972E\972E;
                      db $59,$AD,$00,$05,$FF,$60,$FF,$60        ;;9736|9736+9736/9736\9736;
                      db $9E,$61,$59,$C4,$00,$01,$9E,$A1        ;;973E|973E+973E/973E\973E;
                      db $59,$C5,$40,$0E,$FF,$20,$59,$CD        ;;9746|9746+9746/9746\9746;
                      db $00,$05,$FF,$60,$FF,$60,$9E,$E1        ;;974E|974E+974E/974E\974E;
                      db $59,$E0,$00,$03,$FF,$60,$9E,$61        ;;9756|9756+9756/9756\9756;
                      db $5A,$00,$00,$03,$FF,$60,$9E,$E1        ;;975E|975E+975E/975E\975E;
                      db $59,$E8,$00,$01,$9E,$21,$59,$E9        ;;9766|9766+9766/9766\9766;
                      db $40,$12,$FF,$20,$59,$F3,$00,$05        ;;976E|976E+976E/976E\976E;
                      db $FF,$60,$FF,$60,$9E,$61,$5A,$08        ;;9776|9776+9776/9776\9776;
                      db $00,$01,$9E,$A1,$5A,$09,$40,$12        ;;977E|977E+977E/977E\977E;
                      db $FF,$20,$5A,$13,$00,$05,$FF,$60        ;;9786|9786+9786/9786\9786;
                      db $FF,$60,$9E,$E1,$59,$FC,$00,$07        ;;978E|978E+978E/978E\978E;
                      db $9E,$21,$FF,$20,$FF,$20,$FF,$20        ;;9796|9796+9796/9796\9796;
                      db $5A,$1C,$00,$07,$9E,$A1,$FF,$20        ;;979E|979E+979E/979E\979E;
                      db $FF,$20,$FF,$20,$5A,$2E,$00,$03        ;;97A6|97A6+97A6/97A6\97A6;
                      db $FC,$20,$8F,$21,$5A,$30,$40,$0C        ;;97AE|97AE+97AE/97AE\97AE;
                      db $FF,$20,$5A,$37,$00,$05,$FF,$60        ;;97B6|97B6+97B6/97B6\97B6;
                      db $FF,$60,$9E,$61,$5A,$4E,$00,$03        ;;97BE|97BE+97BE/97BE\97BE;
                      db $FC,$20,$8F,$A1,$5A,$50,$40,$0C        ;;97C6|97C6+97C6/97C6\97C6;
                      db $FF,$20,$5A,$57,$00,$05,$FF,$60        ;;97CE|97CE+97CE/97CE\97CE;
                      db $FF,$60,$9E,$E1,$5A,$6C,$00,$0B        ;;97D6|97D6+97D6/97D6\97D6;
                      db $9E,$21,$FF,$20,$FF,$20,$FF,$20        ;;97DE|97DE+97DE/97DE\97DE;
                      db $FF,$60,$9E,$61,$5A,$8C,$00,$0B        ;;97E6|97E6+97E6/97E6\97E6;
                      db $9E,$A1,$FF,$20,$FF,$20,$FF,$20        ;;97EE|97EE+97EE/97EE\97EE;
                      db $FF,$60,$9E,$E1,$57,$A0,$00,$03        ;;97F6|97F6+97F6/97F6\97F6;
                      db $FF,$60,$9E,$61,$57,$B8,$00,$01        ;;97FE|97FE+97FE/97FE\97FE;
                      db $9E,$21,$57,$B9,$40,$0C,$FF,$20        ;;9806|9806+9806/9806\9806;
                      db $57,$C0,$00,$03,$FF,$60,$9E,$E1        ;;980E|980E+980E/980E\980E;
                      db $57,$D8,$00,$01,$9E,$A1,$57,$D9        ;;9816|9816+9816/9816\9816;
                      db $40,$0C,$FF,$20,$57,$E0,$40,$08        ;;981E|981E+981E/981E\981E;
                      db $FF,$60,$57,$E5,$00,$01,$9E,$61        ;;9826|9826+9826/9826\9826;
                      db $57,$EA,$00,$0B,$9E,$21,$FF,$20        ;;982E|982E+982E/982E\982E;
                      db $FF,$20,$FF,$20,$FF,$20,$9E,$61        ;;9836|9836+9836/9836\9836;
                      db $57,$FB,$00,$01,$9E,$21,$57,$FC        ;;983E|983E+983E/983E\983E;
                      db $40,$06,$FF,$20,$5C,$00,$40,$08        ;;9846|9846+9846/9846\9846;
                      db $FF,$60,$5C,$05,$00,$01,$9E,$E1        ;;984E|984E+984E/984E\984E;
                      db $5C,$0A,$00,$0B,$9E,$A1,$FF,$20        ;;9856|9856+9856/9856\9856;
                      db $FF,$20,$FF,$20,$FF,$60,$9E,$E1        ;;985E|985E+985E/985E\985E;
                      db $5C,$1B,$00,$01,$9E,$A1,$5C,$1C        ;;9866|9866+9866/9866\9866;
                      db $40,$06,$FF,$20,$5C,$60,$80,$0F        ;;986E|986E+986E/986E\986E;
                      db $FF,$20,$FF,$20,$8F,$61,$8F,$E1        ;;9876|9876+9876/9876\9876;
                      db $FF,$20,$FF,$20,$FF,$60,$FF,$60        ;;987E|987E+987E/987E\987E;
                      db $5C,$61,$80,$0F,$FF,$20,$FF,$20        ;;9886|9886+9886/9886\9886;
                      db $FC,$60,$FC,$60,$FF,$20,$FF,$20        ;;988E|988E+988E/988E\988E;
                      db $9E,$61,$9E,$E1,$5C,$62,$00,$03        ;;9896|9896+9896/9896\9896;
                      db $FF,$60,$9E,$61,$5C,$82,$00,$03        ;;989E|989E+989E/989E\989E;
                      db $FF,$60,$9E,$E1,$5C,$E2,$40,$06        ;;98A6|98A6+98A6/98A6\98A6;
                      db $FF,$20,$5C,$E6,$00,$03,$FF,$60        ;;98AE|98AE+98AE/98AE\98AE;
                      db $9E,$61,$5D,$02,$40,$06,$FF,$20        ;;98B6|98B6+98B6/98B6\98B6;
                      db $5D,$06,$00,$03,$FF,$60,$9E,$E1        ;;98BE|98BE+98BE/98BE\98BE;
                      db $5C,$6C,$00,$01,$9E,$21,$5C,$6D        ;;98C6|98C6+98C6/98C6\98C6;
                      db $40,$24,$FF,$20,$5C,$8C,$00,$01        ;;98CE|98CE+98CE/98CE\98CE;
                      db $9E,$A1,$5C,$8D,$40,$24,$FF,$20        ;;98D6|98D6+98D6/98D6\98D6;
                      db $5C,$B2,$00,$01,$9E,$21,$5C,$B3        ;;98DE|98DE+98DE/98DE\98DE;
                      db $40,$18,$FF,$20,$5C,$D2,$00,$01        ;;98E6|98E6+98E6/98E6\98E6;
                      db $9E,$A1,$5C,$D3,$40,$18,$FF,$20        ;;98EE|98EE+98EE/98EE\98EE;
                      db $5C,$FC,$00,$07,$FC,$20,$8F,$21        ;;98F6|98F6+98F6/98F6\98F6;
                      db $FF,$20,$FF,$20,$5D,$1C,$00,$07        ;;98FE|98FE+98FE/98FE\98FE;
                      db $FC,$20,$8F,$A1,$FF,$20,$FF,$20        ;;9906|9906+9906/9906\9906;
                      db $5D,$2E,$00,$0B,$9E,$21,$FF,$20        ;;990E|990E+990E/990E\990E;
                      db $FF,$20,$FF,$20,$FF,$60,$9E,$61        ;;9916|9916+9916/9916\9916;
                      db $5D,$4E,$00,$0B,$9E,$A1,$FF,$20        ;;991E|991E+991E/991E\991E;
                      db $FF,$20,$FF,$20,$FF,$60,$9E,$E1        ;;9926|9926+9926/9926\9926;
                      db $5D,$38,$00,$01,$9E,$21,$5D,$39        ;;992E|992E+992E/992E\992E;
                      db $40,$0C,$FF,$20,$5D,$58,$00,$01        ;;9936|9936+9936/9936\9936;
                      db $9E,$A1,$5D,$59,$40,$0C,$FF,$20        ;;993E|993E+993E/993E\993E;
                      db $5D,$A4,$00,$01,$9E,$21,$5D,$A5        ;;9946|9946+9946/9946\9946;
                      db $40,$0E,$FF,$20,$5D,$AD,$00,$05        ;;994E|994E+994E/994E\994E;
                      db $FF,$60,$FF,$60,$9E,$61,$5D,$C4        ;;9956|9956+9956/9956\9956;
                      db $00,$01,$9E,$A1,$5D,$C5,$40,$0E        ;;995E|995E+995E/995E\995E;
                      db $FF,$20,$5D,$CD,$00,$05,$FF,$60        ;;9966|9966+9966/9966\9966;
                      db $FF,$60,$9E,$E1,$5D,$E0,$00,$03        ;;996E|996E+996E/996E\996E;
                      db $FF,$60,$9E,$61,$5E,$00,$00,$03        ;;9976|9976+9976/9976\9976;
                      db $FF,$60,$9E,$E1,$5D,$E8,$00,$01        ;;997E|997E+997E/997E\997E;
                      db $9E,$21,$5D,$E9,$40,$12,$FF,$20        ;;9986|9986+9986/9986\9986;
                      db $5D,$F3,$00,$05,$FF,$60,$FF,$60        ;;998E|998E+998E/998E\998E;
                      db $9E,$61,$5E,$08,$00,$01,$9E,$A1        ;;9996|9996+9996/9996\9996;
                      db $5E,$09,$40,$12,$FF,$20,$5E,$13        ;;999E|999E+999E/999E\999E;
                      db $00,$05,$FF,$60,$FF,$60,$9E,$E1        ;;99A6|99A6+99A6/99A6\99A6;
                      db $5D,$FC,$00,$07,$9E,$21,$FF,$20        ;;99AE|99AE+99AE/99AE\99AE;
                      db $FF,$20,$FF,$20,$5E,$1C,$00,$07        ;;99B6|99B6+99B6/99B6\99B6;
                      db $9E,$A1,$FF,$20,$FF,$20,$FF,$20        ;;99BE|99BE+99BE/99BE\99BE;
                      db $5E,$2E,$00,$03,$FC,$20,$8F,$21        ;;99C6|99C6+99C6/99C6\99C6;
                      db $5E,$30,$40,$0C,$FF,$20,$5E,$37        ;;99CE|99CE+99CE/99CE\99CE;
                      db $00,$05,$FF,$60,$FF,$60,$9E,$61        ;;99D6|99D6+99D6/99D6\99D6;
                      db $5E,$4E,$00,$03,$FC,$20,$8F,$A1        ;;99DE|99DE+99DE/99DE\99DE;
                      db $5E,$50,$40,$0C,$FF,$20,$5E,$57        ;;99E6|99E6+99E6/99E6\99E6;
                      db $00,$05,$FF,$60,$FF,$60,$9E,$E1        ;;99EE|99EE+99EE/99EE\99EE;
                      db $5E,$6C,$00,$0B,$9E,$21,$FF,$20        ;;99F6|99F6+99F6/99F6\99F6;
                      db $FF,$20,$FF,$20,$FF,$60,$9E,$61        ;;99FE|99FE+99FE/99FE\99FE;
                      db $5E,$8C,$00,$0B,$9E,$A1,$FF,$20        ;;9A06|9A06+9A06/9A06\9A06;
                      db $FF,$20,$FF,$20,$FF,$60,$9E,$E1        ;;9A0E|9A0E+9A0E/9A0E\9A0E;
                      db $FF                                    ;;9A16|9A16+9A16/9A16\9A16;
                                                                ;;                        ;
DATA_059A17:          db $51,$67,$00,$01,$9F,$39,$51,$93        ;;9A17|9A17+9A17/9A17\9A17;
                      db $00,$01,$9F,$29,$51,$D1,$00,$01        ;;9A1F|9A1F+9A1F/9A1F\9A1F;
                      db $9F,$39,$52,$5A,$00,$01,$9F,$39        ;;9A27|9A27+9A27/9A27\9A27;
                      db $52,$77,$00,$01,$9F,$29,$52,$79        ;;9A2F|9A2F+9A2F/9A2F\9A2F;
                      db $80,$03,$9F,$29,$9F,$39,$52,$8C        ;;9A37|9A37+9A37/9A37\9A37;
                      db $00,$01,$9F,$29,$53,$3D,$00,$01        ;;9A3F|9A3F+9A3F/9A3F\9A3F;
                      db $9F,$39,$55,$67,$00,$01,$9F,$39        ;;9A47|9A47+9A47/9A47\9A47;
                      db $55,$93,$00,$01,$9F,$29,$55,$D1        ;;9A4F|9A4F+9A4F/9A4F\9A4F;
                      db $00,$01,$9F,$39,$56,$5A,$00,$01        ;;9A57|9A57+9A57/9A57\9A57;
                      db $9F,$39,$56,$77,$00,$01,$9F,$29        ;;9A5F|9A5F+9A5F/9A5F\9A5F;
                      db $56,$79,$80,$03,$9F,$29,$9F,$39        ;;9A67|9A67+9A67/9A67\9A67;
                      db $56,$8C,$00,$01,$9F,$29,$57,$3D        ;;9A6F|9A6F+9A6F/9A6F\9A6F;
                      db $00,$01,$9F,$39,$58,$07,$00,$01        ;;9A77|9A77+9A77/9A77\9A77;
                      db $9F,$39,$58,$33,$00,$01,$9F,$29        ;;9A7F|9A7F+9A7F/9A7F\9A7F;
                      db $58,$71,$00,$01,$9F,$39,$58,$FA        ;;9A87|9A87+9A87/9A87\9A87;
                      db $00,$01,$9F,$39,$59,$17,$00,$01        ;;9A8F|9A8F+9A8F/9A8F\9A8F;
                      db $9F,$29,$59,$19,$80,$03,$9F,$29        ;;9A97|9A97+9A97/9A97\9A97;
                      db $9F,$39,$59,$2C,$00,$01,$9F,$29        ;;9A9F|9A9F+9A9F/9A9F\9A9F;
                      db $59,$DD,$00,$01,$9F,$39,$5C,$07        ;;9AA7|9AA7+9AA7/9AA7\9AA7;
                      db $00,$01,$9F,$39,$5C,$33,$00,$01        ;;9AAF|9AAF+9AAF/9AAF\9AAF;
                      db $9F,$29,$5C,$71,$00,$01,$9F,$39        ;;9AB7|9AB7+9AB7/9AB7\9AB7;
                      db $5C,$FA,$00,$01,$9F,$39,$5D,$17        ;;9ABF|9ABF+9ABF/9ABF\9ABF;
                      db $00,$01,$9F,$29,$5D,$19,$80,$03        ;;9AC7|9AC7+9AC7/9AC7\9AC7;
                      db $9F,$29,$9F,$39,$5D,$2C,$00,$01        ;;9ACF|9ACF+9ACF/9ACF\9ACF;
                      db $9F,$29,$5D,$DD,$00,$01,$9F,$39        ;;9AD7|9AD7+9AD7/9AD7\9AD7;
                      db $FF                                    ;;9ADF|9ADF+9ADF/9ADF\9ADF;
                                                                ;;                        ;
DATA_059AE0:          db $58,$03,$00,$03,$80,$01,$81,$01        ;;9AE0|9AE0+9AE0/9AE0\9AE0;
                      db $58,$07,$00,$03,$80,$01,$81,$01        ;;9AE8|9AE8+9AE8/9AE8\9AE8;
                      db $58,$0F,$00,$07,$80,$01,$81,$01        ;;9AF0|9AF0+9AF0/9AF0\9AF0;
                      db $80,$01,$81,$01,$58,$15,$00,$0B        ;;9AF8|9AF8+9AF8/9AF8\9AF8;
                      db $80,$01,$81,$01,$80,$01,$81,$01        ;;9B00|9B00+9B00/9B00\9B00;
                      db $80,$01,$81,$01,$58,$20,$00,$0F        ;;9B08|9B08+9B08/9B08\9B08;
                      db $80,$01,$81,$01,$86,$15,$87,$15        ;;9B10|9B10+9B10/9B10\9B10;
                      db $82,$15,$83,$15,$80,$01,$81,$01        ;;9B18|9B18+9B18/9B18\9B18;
                      db $58,$22,$80,$05,$86,$15,$96,$15        ;;9B20|9B20+9B20/9B20\9B20;
                      db $90,$15,$58,$23,$80,$05,$87,$15        ;;9B28|9B28+9B28/9B28\9B28;
                      db $97,$15,$91,$15,$58,$2C,$80,$05        ;;9B30|9B30+9B30/9B30\9B30;
                      db $86,$15,$96,$15,$90,$15,$58,$2D        ;;9B38|9B38+9B38/9B38\9B38;
                      db $80,$05,$87,$15,$97,$15,$91,$15        ;;9B40|9B40+9B40/9B40\9B40;
                      db $58,$2F,$80,$05,$86,$15,$96,$15        ;;9B48|9B48+9B48/9B48\9B48;
                      db $90,$15,$58,$30,$80,$05,$87,$15        ;;9B50|9B50+9B50/9B50\9B50;
                      db $97,$15,$91,$15,$58,$32,$80,$05        ;;9B58|9B58+9B58/9B58\9B58;
                      db $86,$15,$96,$15,$90,$15,$58,$33        ;;9B60|9B60+9B60/9B60\9B60;
                      db $80,$05,$87,$15,$97,$15,$91,$15        ;;9B68|9B68+9B68/9B68\9B68;
                      db $58,$36,$00,$03,$80,$01,$81,$01        ;;9B70|9B70+9B70/9B70\9B70;
                      db $58,$3A,$00,$03,$80,$01,$81,$01        ;;9B78|9B78+9B78/9B78\9B78;
                      db $58,$3C,$80,$05,$86,$15,$96,$15        ;;9B80|9B80+9B80/9B80\9B80;
                      db $90,$15,$58,$3D,$80,$05,$87,$15        ;;9B88|9B88+9B88/9B88\9B88;
                      db $97,$15,$91,$15,$58,$45,$00,$03        ;;9B90|9B90+9B90/9B90\9B90;
                      db $82,$15,$83,$15,$58,$8D,$00,$03        ;;9B98|9B98+9B98/9B98\9B98;
                      db $80,$01,$81,$01,$58,$9E,$00,$03        ;;9BA0|9BA0+9BA0/9BA0\9BA0;
                      db $80,$01,$81,$01,$58,$BD,$00,$03        ;;9BA8|9BA8+9BA8/9BA8\9BA8;
                      db $80,$01,$81,$01,$58,$C7,$00,$03        ;;9BB0|9BB0+9BB0/9BB0\9BB0;
                      db $80,$01,$81,$01,$58,$D9,$00,$01        ;;9BB8|9BB8+9BB8/9BB8\9BB8;
                      db $81,$01,$58,$DC,$00,$07,$80,$01        ;;9BC0|9BC0+9BC0/9BC0\9BC0;
                      db $81,$01,$82,$15,$83,$15,$58,$E4        ;;9BC8|9BC8+9BC8/9BC8\9BC8;
                      db $00,$03,$80,$01,$81,$01,$58,$E8        ;;9BD0|9BD0+9BD0/9BD0\9BD0;
                      db $00,$07,$80,$01,$81,$01,$80,$01        ;;9BD8|9BD8+9BD8/9BD8\9BD8;
                      db $81,$01,$58,$F9,$00,$0D,$80,$01        ;;9BE0|9BE0+9BE0/9BE0\9BE0;
                      db $81,$01,$80,$01,$81,$01,$82,$15        ;;9BE8|9BE8+9BE8/9BE8\9BE8;
                      db $83,$15,$82,$15,$59,$02,$80,$05        ;;9BF0|9BF0+9BF0/9BF0\9BF0;
                      db $86,$15,$96,$15,$90,$15,$59,$03        ;;9BF8|9BF8+9BF8/9BF8\9BF8;
                      db $80,$05,$87,$15,$97,$15,$91,$15        ;;9C00|9C00+9C00/9C00\9C00;
                      db $59,$05,$00,$0B,$80,$01,$81,$01        ;;9C08|9C08+9C08/9C08\9C08;
                      db $82,$15,$83,$15,$80,$01,$81,$01        ;;9C10|9C10+9C10/9C10\9C10;
                      db $59,$0C,$80,$05,$86,$15,$96,$15        ;;9C18|9C18+9C18/9C18\9C18;
                      db $90,$15,$59,$0D,$80,$05,$87,$15        ;;9C20|9C20+9C20/9C20\9C20;
                      db $97,$15,$91,$15,$59,$0F,$80,$05        ;;9C28|9C28+9C28/9C28\9C28;
                      db $86,$15,$96,$15,$90,$15,$59,$10        ;;9C30|9C30+9C30/9C30\9C30;
                      db $80,$05,$87,$15,$97,$15,$91,$15        ;;9C38|9C38+9C38/9C38\9C38;
                      db $59,$12,$80,$05,$86,$15,$96,$15        ;;9C40|9C40+9C40/9C40\9C40;
                      db $90,$15,$59,$13,$80,$05,$87,$15        ;;9C48|9C48+9C48/9C48\9C48;
                      db $97,$15,$91,$15,$59,$1A,$00,$0B        ;;9C50|9C50+9C50/9C50\9C50;
                      db $80,$01,$81,$01,$86,$15,$87,$15        ;;9C58|9C58+9C58/9C58\9C58;
                      db $82,$15,$83,$15,$59,$1C,$80,$05        ;;9C60|9C60+9C60/9C60\9C60;
                      db $86,$15,$96,$15,$90,$15,$59,$1D        ;;9C68|9C68+9C68/9C68\9C68;
                      db $80,$05,$87,$15,$97,$15,$91,$15        ;;9C70|9C70+9C70/9C70\9C70;
                      db $59,$24,$00,$0F,$80,$01,$81,$01        ;;9C78|9C78+9C78/9C78\9C78;
                      db $82,$15,$83,$15,$82,$15,$83,$15        ;;9C80|9C80+9C80/9C80\9C80;
                      db $80,$01,$81,$01,$59,$39,$00,$03        ;;9C88|9C88+9C88/9C88\9C88;
                      db $80,$01,$81,$01,$59,$47,$00,$07        ;;9C90|9C90+9C90/9C90\9C90;
                      db $80,$01,$81,$01,$82,$15,$83,$15        ;;9C98|9C98+9C98/9C98\9C98;
                      db $59,$5A,$00,$0B,$80,$01,$81,$01        ;;9CA0|9CA0+9CA0/9CA0\9CA0;
                      db $90,$15,$91,$15,$80,$01,$81,$01        ;;9CA8|9CA8+9CA8/9CA8\9CA8;
                      db $59,$64,$00,$17,$80,$01,$81,$01        ;;9CB0|9CB0+9CB0/9CB0\9CB0;
                      db $82,$15,$83,$15,$80,$01,$81,$01        ;;9CB8|9CB8+9CB8/9CB8\9CB8;
                      db $80,$01,$81,$01,$80,$01,$81,$01        ;;9CC0|9CC0+9CC0/9CC0\9CC0;
                      db $80,$01,$81,$01,$59,$87,$00,$03        ;;9CC8|9CC8+9CC8/9CC8\9CC8;
                      db $80,$01,$81,$01,$59,$8B,$00,$07        ;;9CD0|9CD0+9CD0/9CD0\9CD0;
                      db $80,$01,$81,$01,$80,$01,$81,$01        ;;9CD8|9CD8+9CD8/9CD8\9CD8;
                      db $59,$98,$00,$03,$80,$01,$81,$01        ;;9CE0|9CE0+9CE0/9CE0\9CE0;
                      db $59,$A8,$00,$07,$80,$01,$81,$01        ;;9CE8|9CE8+9CE8/9CE8\9CE8;
                      db $82,$15,$83,$15,$59,$B9,$00,$03        ;;9CF0|9CF0+9CF0/9CF0\9CF0;
                      db $80,$01,$81,$01,$59,$C5,$00,$03        ;;9CF8|9CF8+9CF8/9CF8\9CF8;
                      db $80,$01,$81,$01,$59,$C9,$00,$07        ;;9D00|9D00+9D00/9D00\9D00;
                      db $80,$01,$81,$01,$80,$01,$81,$01        ;;9D08|9D08+9D08/9D08\9D08;
                      db $59,$D6,$00,$0F,$80,$01,$81,$01        ;;9D10|9D10+9D10/9D10\9D10;
                      db $82,$15,$83,$15,$80,$01,$81,$01        ;;9D18|9D18+9D18/9D18\9D18;
                      db $80,$01,$81,$01,$59,$E2,$80,$05        ;;9D20|9D20+9D20/9D20\9D20;
                      db $86,$15,$96,$15,$90,$15,$59,$E3        ;;9D28|9D28+9D28/9D28\9D28;
                      db $80,$05,$87,$15,$97,$15,$91,$15        ;;9D30|9D30+9D30/9D30\9D30;
                      db $59,$EA,$00,$0B,$80,$01,$81,$01        ;;9D38|9D38+9D38/9D38\9D38;
                      db $86,$15,$87,$15,$82,$15,$83,$15        ;;9D40|9D40+9D40/9D40\9D40;
                      db $59,$EC,$80,$05,$86,$15,$96,$15        ;;9D48|9D48+9D48/9D48\9D48;
                      db $90,$15,$59,$ED,$80,$05,$87,$15        ;;9D50|9D50+9D50/9D50\9D50;
                      db $97,$15,$91,$15,$59,$EF,$80,$05        ;;9D58|9D58+9D58/9D58\9D58;
                      db $86,$15,$96,$15,$90,$15,$59,$F0        ;;9D60|9D60+9D60/9D60\9D60;
                      db $80,$05,$87,$15,$97,$15,$91,$15        ;;9D68|9D68+9D68/9D68\9D68;
                      db $59,$F2,$80,$05,$86,$15,$96,$15        ;;9D70|9D70+9D70/9D70\9D70;
                      db $90,$15,$59,$F3,$80,$05,$87,$15        ;;9D78|9D78+9D78/9D78\9D78;
                      db $97,$15,$91,$15,$59,$F7,$00,$07        ;;9D80|9D80+9D80/9D80\9D80;
                      db $82,$15,$83,$15,$82,$15,$83,$15        ;;9D88|9D88+9D88/9D88\9D88;
                      db $59,$FC,$80,$05,$86,$15,$96,$15        ;;9D90|9D90+9D90/9D90\9D90;
                      db $90,$15,$59,$FD,$80,$05,$87,$15        ;;9D98|9D98+9D98/9D98\9D98;
                      db $97,$15,$91,$15,$5A,$14,$00,$0F        ;;9DA0|9DA0+9DA0/9DA0\9DA0;
                      db $80,$01,$81,$01,$82,$15,$83,$15        ;;9DA8|9DA8+9DA8/9DA8\9DA8;
                      db $80,$01,$81,$01,$82,$15,$83,$15        ;;9DB0|9DB0+9DB0/9DB0\9DB0;
                      db $5A,$20,$00,$01,$81,$01,$5A,$27        ;;9DB8|9DB8+9DB8/9DB8\9DB8;
                      db $00,$03,$80,$01,$81,$01,$5A,$35        ;;9DC0|9DC0+9DC0/9DC0\9DC0;
                      db $00,$0B,$80,$01,$81,$01,$80,$01        ;;9DC8|9DC8+9DC8/9DC8\9DC8;
                      db $81,$01,$82,$15,$83,$15,$5A,$40        ;;9DD0|9DD0+9DD0/9DD0\9DD0;
                      db $00,$07,$80,$01,$81,$01,$80,$01        ;;9DD8|9DD8+9DD8/9DD8\9DD8;
                      db $81,$01,$5A,$56,$00,$03,$80,$01        ;;9DE0|9DE0+9DE0/9DE0\9DE0;
                      db $81,$01,$5A,$5A,$00,$03,$80,$01        ;;9DE8|9DE8+9DE8/9DE8\9DE8;
                      db $81,$01,$5A,$60,$00,$09,$81,$01        ;;9DF0|9DF0+9DF0/9DF0\9DF0;
                      db $82,$15,$83,$15,$80,$01,$81,$01        ;;9DF8|9DF8+9DF8/9DF8\9DF8;
                      db $5A,$67,$00,$03,$80,$01,$81,$01        ;;9E00|9E00+9E00/9E00\9E00;
                      db $5A,$79,$00,$07,$80,$01,$81,$01        ;;9E08|9E08+9E08/9E08\9E08;
                      db $80,$01,$81,$01,$5A,$80,$00,$0B        ;;9E10|9E10+9E10/9E10\9E10;
                      db $82,$15,$83,$15,$80,$01,$81,$01        ;;9E18|9E18+9E18/9E18\9E18;
                      db $80,$01,$81,$01,$5A,$98,$00,$03        ;;9E20|9E20+9E20/9E20\9E20;
                      db $80,$01,$81,$01,$5A,$9C,$00,$03        ;;9E28|9E28+9E28/9E28\9E28;
                      db $80,$01,$81,$01,$5A,$A0,$00,$05        ;;9E30|9E30+9E30/9E30\9E30;
                      db $83,$15,$80,$01,$81,$01,$5A,$A5        ;;9E38|9E38+9E38/9E38\9E38;
                      db $00,$07,$80,$01,$81,$01,$80,$01        ;;9E40|9E40+9E40/9E40\9E40;
                      db $81,$01,$5A,$C0,$00,$07,$82,$15        ;;9E48|9E48+9E48/9E48\9E48;
                      db $83,$15,$82,$15,$83,$15,$5A,$C6        ;;9E50|9E50+9E50/9E50\9E50;
                      db $00,$03,$80,$01,$81,$01,$5A,$CA        ;;9E58|9E58+9E58/9E58\9E58;
                      db $00,$03,$80,$01,$81,$01,$5A,$E0        ;;9E60|9E60+9E60/9E60\9E60;
                      db $00,$0D,$83,$15,$82,$15,$83,$15        ;;9E68|9E68+9E68/9E68\9E68;
                      db $82,$15,$83,$15,$80,$01,$81,$01        ;;9E70|9E70+9E70/9E70\9E70;
                      db $5A,$E9,$00,$03,$80,$01,$81,$01        ;;9E78|9E78+9E78/9E78\9E78;
                      db $5C,$03,$00,$03,$80,$01,$81,$01        ;;9E80|9E80+9E80/9E80\9E80;
                      db $5C,$07,$00,$03,$80,$01,$81,$01        ;;9E88|9E88+9E88/9E88\9E88;
                      db $5C,$0F,$00,$07,$80,$01,$81,$01        ;;9E90|9E90+9E90/9E90\9E90;
                      db $80,$01,$81,$01,$5C,$15,$00,$0B        ;;9E98|9E98+9E98/9E98\9E98;
                      db $80,$01,$81,$01,$80,$01,$81,$01        ;;9EA0|9EA0+9EA0/9EA0\9EA0;
                      db $80,$01,$81,$01,$5C,$20,$00,$0F        ;;9EA8|9EA8+9EA8/9EA8\9EA8;
                      db $80,$01,$81,$01,$86,$15,$87,$15        ;;9EB0|9EB0+9EB0/9EB0\9EB0;
                      db $82,$15,$83,$15,$80,$01,$81,$01        ;;9EB8|9EB8+9EB8/9EB8\9EB8;
                      db $5C,$22,$80,$05,$86,$15,$96,$15        ;;9EC0|9EC0+9EC0/9EC0\9EC0;
                      db $90,$15,$5C,$23,$80,$05,$87,$15        ;;9EC8|9EC8+9EC8/9EC8\9EC8;
                      db $97,$15,$91,$15,$5C,$2C,$80,$05        ;;9ED0|9ED0+9ED0/9ED0\9ED0;
                      db $86,$15,$96,$15,$90,$15,$5C,$2D        ;;9ED8|9ED8+9ED8/9ED8\9ED8;
                      db $80,$05,$87,$15,$97,$15,$91,$15        ;;9EE0|9EE0+9EE0/9EE0\9EE0;
                      db $5C,$2F,$80,$05,$86,$15,$96,$15        ;;9EE8|9EE8+9EE8/9EE8\9EE8;
                      db $90,$15,$5C,$30,$80,$05,$87,$15        ;;9EF0|9EF0+9EF0/9EF0\9EF0;
                      db $97,$15,$91,$15,$5C,$32,$80,$05        ;;9EF8|9EF8+9EF8/9EF8\9EF8;
                      db $86,$15,$96,$15,$90,$15,$5C,$33        ;;9F00|9F00+9F00/9F00\9F00;
                      db $80,$05,$87,$15,$97,$15,$91,$15        ;;9F08|9F08+9F08/9F08\9F08;
                      db $5C,$36,$00,$03,$80,$01,$81,$01        ;;9F10|9F10+9F10/9F10\9F10;
                      db $5C,$3A,$00,$03,$80,$01,$81,$01        ;;9F18|9F18+9F18/9F18\9F18;
                      db $5C,$3C,$80,$05,$86,$15,$96,$15        ;;9F20|9F20+9F20/9F20\9F20;
                      db $90,$15,$5C,$3D,$80,$05,$87,$15        ;;9F28|9F28+9F28/9F28\9F28;
                      db $97,$15,$91,$15,$5C,$45,$00,$03        ;;9F30|9F30+9F30/9F30\9F30;
                      db $82,$15,$83,$15,$5C,$8D,$00,$03        ;;9F38|9F38+9F38/9F38\9F38;
                      db $80,$01,$81,$01,$5C,$9E,$00,$03        ;;9F40|9F40+9F40/9F40\9F40;
                      db $80,$01,$81,$01,$5C,$BD,$00,$03        ;;9F48|9F48+9F48/9F48\9F48;
                      db $80,$01,$81,$01,$5C,$C7,$00,$03        ;;9F50|9F50+9F50/9F50\9F50;
                      db $80,$01,$81,$01,$5C,$D9,$00,$01        ;;9F58|9F58+9F58/9F58\9F58;
                      db $81,$01,$5C,$DC,$00,$07,$80,$01        ;;9F60|9F60+9F60/9F60\9F60;
                      db $81,$01,$82,$15,$83,$15,$5C,$E4        ;;9F68|9F68+9F68/9F68\9F68;
                      db $00,$03,$80,$01,$81,$01,$5C,$E8        ;;9F70|9F70+9F70/9F70\9F70;
                      db $00,$07,$80,$01,$81,$01,$80,$01        ;;9F78|9F78+9F78/9F78\9F78;
                      db $81,$01,$5C,$F9,$00,$0D,$80,$01        ;;9F80|9F80+9F80/9F80\9F80;
                      db $81,$01,$80,$01,$81,$01,$82,$15        ;;9F88|9F88+9F88/9F88\9F88;
                      db $83,$15,$82,$15,$5D,$02,$80,$05        ;;9F90|9F90+9F90/9F90\9F90;
                      db $86,$15,$96,$15,$90,$15,$5D,$03        ;;9F98|9F98+9F98/9F98\9F98;
                      db $80,$05,$87,$15,$97,$15,$91,$15        ;;9FA0|9FA0+9FA0/9FA0\9FA0;
                      db $5D,$05,$00,$0B,$80,$01,$81,$01        ;;9FA8|9FA8+9FA8/9FA8\9FA8;
                      db $82,$15,$83,$15,$80,$01,$81,$01        ;;9FB0|9FB0+9FB0/9FB0\9FB0;
                      db $5D,$0C,$80,$05,$86,$15,$96,$15        ;;9FB8|9FB8+9FB8/9FB8\9FB8;
                      db $90,$15,$5D,$0D,$80,$05,$87,$15        ;;9FC0|9FC0+9FC0/9FC0\9FC0;
                      db $97,$15,$91,$15,$5D,$0F,$80,$05        ;;9FC8|9FC8+9FC8/9FC8\9FC8;
                      db $86,$15,$96,$15,$90,$15,$5D,$10        ;;9FD0|9FD0+9FD0/9FD0\9FD0;
                      db $80,$05,$87,$15,$97,$15,$91,$15        ;;9FD8|9FD8+9FD8/9FD8\9FD8;
                      db $5D,$12,$80,$05,$86,$15,$96,$15        ;;9FE0|9FE0+9FE0/9FE0\9FE0;
                      db $90,$15,$5D,$13,$80,$05,$87,$15        ;;9FE8|9FE8+9FE8/9FE8\9FE8;
                      db $97,$15,$91,$15,$5D,$1A,$00,$0B        ;;9FF0|9FF0+9FF0/9FF0\9FF0;
                      db $80,$01,$81,$01,$86,$15,$87,$15        ;;9FF8|9FF8+9FF8/9FF8\9FF8;
                      db $82,$15,$83,$15,$5D,$1C,$80,$05        ;;A000|A000+A000/A000\A000;
                      db $86,$15,$96,$15,$90,$15,$5D,$1D        ;;A008|A008+A008/A008\A008;
                      db $80,$05,$87,$15,$97,$15,$91,$15        ;;A010|A010+A010/A010\A010;
                      db $5D,$24,$00,$0F,$80,$01,$81,$01        ;;A018|A018+A018/A018\A018;
                      db $82,$15,$83,$15,$82,$15,$83,$15        ;;A020|A020+A020/A020\A020;
                      db $80,$01,$81,$01,$5D,$39,$00,$03        ;;A028|A028+A028/A028\A028;
                      db $80,$01,$81,$01,$5D,$47,$00,$07        ;;A030|A030+A030/A030\A030;
                      db $80,$01,$81,$01,$82,$15,$83,$15        ;;A038|A038+A038/A038\A038;
                      db $5D,$5A,$00,$0B,$80,$01,$81,$01        ;;A040|A040+A040/A040\A040;
                      db $90,$15,$91,$15,$80,$01,$81,$01        ;;A048|A048+A048/A048\A048;
                      db $5D,$64,$00,$17,$80,$01,$81,$01        ;;A050|A050+A050/A050\A050;
                      db $82,$15,$83,$15,$80,$01,$81,$01        ;;A058|A058+A058/A058\A058;
                      db $80,$01,$81,$01,$80,$01,$81,$01        ;;A060|A060+A060/A060\A060;
                      db $80,$01,$81,$01,$5D,$87,$00,$03        ;;A068|A068+A068/A068\A068;
                      db $80,$01,$81,$01,$5D,$8B,$00,$07        ;;A070|A070+A070/A070\A070;
                      db $80,$01,$81,$01,$80,$01,$81,$01        ;;A078|A078+A078/A078\A078;
                      db $5D,$98,$00,$03,$80,$01,$81,$01        ;;A080|A080+A080/A080\A080;
                      db $5D,$A8,$00,$07,$80,$01,$81,$01        ;;A088|A088+A088/A088\A088;
                      db $82,$15,$83,$15,$5D,$B9,$00,$03        ;;A090|A090+A090/A090\A090;
                      db $80,$01,$81,$01,$5D,$C5,$00,$03        ;;A098|A098+A098/A098\A098;
                      db $80,$01,$81,$01,$5D,$C9,$00,$07        ;;A0A0|A0A0+A0A0/A0A0\A0A0;
                      db $80,$01,$81,$01,$80,$01,$81,$01        ;;A0A8|A0A8+A0A8/A0A8\A0A8;
                      db $5D,$D6,$00,$0F,$80,$01,$81,$01        ;;A0B0|A0B0+A0B0/A0B0\A0B0;
                      db $82,$15,$83,$15,$80,$01,$81,$01        ;;A0B8|A0B8+A0B8/A0B8\A0B8;
                      db $80,$01,$81,$01,$5D,$E2,$80,$05        ;;A0C0|A0C0+A0C0/A0C0\A0C0;
                      db $86,$15,$96,$15,$90,$15,$5D,$E3        ;;A0C8|A0C8+A0C8/A0C8\A0C8;
                      db $80,$05,$87,$15,$97,$15,$91,$15        ;;A0D0|A0D0+A0D0/A0D0\A0D0;
                      db $5D,$EA,$00,$0B,$80,$01,$81,$01        ;;A0D8|A0D8+A0D8/A0D8\A0D8;
                      db $86,$15,$87,$15,$82,$15,$83,$15        ;;A0E0|A0E0+A0E0/A0E0\A0E0;
                      db $5D,$EC,$80,$05,$86,$15,$96,$15        ;;A0E8|A0E8+A0E8/A0E8\A0E8;
                      db $90,$15,$5D,$ED,$80,$05,$87,$15        ;;A0F0|A0F0+A0F0/A0F0\A0F0;
                      db $97,$15,$91,$15,$5D,$EF,$80,$05        ;;A0F8|A0F8+A0F8/A0F8\A0F8;
                      db $86,$15,$96,$15,$90,$15,$5D,$F0        ;;A100|A100+A100/A100\A100;
                      db $80,$05,$87,$15,$97,$15,$91,$15        ;;A108|A108+A108/A108\A108;
                      db $5D,$F2,$80,$05,$86,$15,$96,$15        ;;A110|A110+A110/A110\A110;
                      db $90,$15,$5D,$F3,$80,$05,$87,$15        ;;A118|A118+A118/A118\A118;
                      db $97,$15,$91,$15,$5D,$F7,$00,$07        ;;A120|A120+A120/A120\A120;
                      db $82,$15,$83,$15,$82,$15,$83,$15        ;;A128|A128+A128/A128\A128;
                      db $5D,$FC,$80,$05,$86,$15,$96,$15        ;;A130|A130+A130/A130\A130;
                      db $90,$15,$5D,$FD,$80,$05,$87,$15        ;;A138|A138+A138/A138\A138;
                      db $97,$15,$91,$15,$5E,$14,$00,$0F        ;;A140|A140+A140/A140\A140;
                      db $80,$01,$81,$01,$82,$15,$83,$15        ;;A148|A148+A148/A148\A148;
                      db $80,$01,$81,$01,$82,$15,$83,$15        ;;A150|A150+A150/A150\A150;
                      db $5E,$20,$00,$01,$81,$01,$5E,$27        ;;A158|A158+A158/A158\A158;
                      db $00,$03,$80,$01,$81,$01,$5E,$35        ;;A160|A160+A160/A160\A160;
                      db $00,$0B,$80,$01,$81,$01,$80,$01        ;;A168|A168+A168/A168\A168;
                      db $81,$01,$82,$15,$83,$15,$5E,$40        ;;A170|A170+A170/A170\A170;
                      db $00,$07,$80,$01,$81,$01,$80,$01        ;;A178|A178+A178/A178\A178;
                      db $81,$01,$5E,$56,$00,$03,$80,$01        ;;A180|A180+A180/A180\A180;
                      db $81,$01,$5E,$5A,$00,$03,$80,$01        ;;A188|A188+A188/A188\A188;
                      db $81,$01,$5E,$60,$00,$09,$81,$01        ;;A190|A190+A190/A190\A190;
                      db $82,$15,$83,$15,$80,$01,$81,$01        ;;A198|A198+A198/A198\A198;
                      db $5E,$67,$00,$03,$80,$01,$81,$01        ;;A1A0|A1A0+A1A0/A1A0\A1A0;
                      db $5E,$79,$00,$07,$80,$01,$81,$01        ;;A1A8|A1A8+A1A8/A1A8\A1A8;
                      db $80,$01,$81,$01,$5E,$80,$00,$0B        ;;A1B0|A1B0+A1B0/A1B0\A1B0;
                      db $82,$15,$83,$15,$80,$01,$81,$01        ;;A1B8|A1B8+A1B8/A1B8\A1B8;
                      db $80,$01,$81,$01,$5E,$98,$00,$03        ;;A1C0|A1C0+A1C0/A1C0\A1C0;
                      db $80,$01,$81,$01,$5E,$9C,$00,$03        ;;A1C8|A1C8+A1C8/A1C8\A1C8;
                      db $80,$01,$81,$01,$5E,$A0,$00,$05        ;;A1D0|A1D0+A1D0/A1D0\A1D0;
                      db $83,$15,$80,$01,$81,$01,$5E,$A5        ;;A1D8|A1D8+A1D8/A1D8\A1D8;
                      db $00,$07,$80,$01,$81,$01,$80,$01        ;;A1E0|A1E0+A1E0/A1E0\A1E0;
                      db $81,$01,$5E,$C0,$00,$07,$82,$15        ;;A1E8|A1E8+A1E8/A1E8\A1E8;
                      db $83,$15,$82,$15,$83,$15,$5E,$C6        ;;A1F0|A1F0+A1F0/A1F0\A1F0;
                      db $00,$03,$80,$01,$81,$01,$5E,$CA        ;;A1F8|A1F8+A1F8/A1F8\A1F8;
                      db $00,$03,$80,$01,$81,$01,$5E,$E0        ;;A200|A200+A200/A200\A200;
                      db $00,$0D,$83,$15,$82,$15,$83,$15        ;;A208|A208+A208/A208\A208;
                      db $82,$15,$83,$15,$80,$01,$81,$01        ;;A210|A210+A210/A210\A210;
                      db $5E,$E9,$00,$03,$80,$01,$81,$01        ;;A218|A218+A218/A218\A218;
                      db $FF                                    ;;A220|A220+A220/A220\A220;
                                                                ;;                        ;
DATA_05A221:          db $53,$DA,$00,$05,$F9,$11,$FA,$11        ;;A221|A221+A221/A221\A221;
                      db $FB,$11,$53,$FA,$00,$05,$FC,$11        ;;A229|A229+A229/A229\A229;
                      db $FD,$11,$FE,$11,$58,$3C,$00,$01        ;;A231|A231+A231/A231\A231;
                      db $DA,$11,$58,$6D,$00,$05,$F9,$11        ;;A239|A239+A239/A239\A239;
                      db $FA,$11,$FB,$11,$58,$8D,$00,$05        ;;A241|A241+A241/A241\A241;
                      db $FC,$11,$FD,$11,$FE,$11,$58,$E5        ;;A249|A249+A249/A249\A249;
                      db $00,$07,$92,$11,$95,$11,$98,$11        ;;A251|A251+A251/A251\A251;
                      db $AD,$11,$59,$05,$00,$07,$B1,$11        ;;A259|A259+A259/A259\A259;
                      db $B5,$11,$C4,$51,$B9,$11,$59,$25        ;;A261|A261+A261/A261\A261;
                      db $00,$07,$BD,$11,$C4,$11,$C4,$51        ;;A269|A269+A269/A269\A269;
                      db $D8,$11,$59,$45,$00,$0D,$D6,$11        ;;A271|A271+A271/A271\A271;
                      db $D8,$11,$C9,$11,$CA,$11,$F9,$15        ;;A279|A279+A279/A279\A279;
                      db $FA,$15,$FB,$15,$59,$65,$00,$0D        ;;A281|A281+A281/A281\A281;
                      db $C9,$11,$CA,$11,$CB,$11,$DA,$11        ;;A289|A289+A289/A289\A289;
                      db $FC,$15,$FD,$15,$FE,$15,$59,$85        ;;A291|A291+A291/A291\A291;
                      db $00,$0D,$CB,$11,$DA,$11,$CB,$11        ;;A299|A299+A299/A299\A299;
                      db $92,$11,$95,$11,$98,$11,$AD,$11        ;;A2A1|A2A1+A2A1/A2A1\A2A1;
                      db $59,$A4,$00,$0F,$F3,$11,$F4,$11        ;;A2A9|A2A9+A2A9/A2A9\A2A9;
                      db $F5,$11,$FC,$38,$B1,$11,$B5,$11        ;;A2B1|A2B1+A2B1/A2B1\A2B1;
                      db $C4,$51,$B9,$11,$59,$C4,$00,$0F        ;;A2B9|A2B9+A2B9/A2B9\A2B9;
                      db $F6,$11,$F7,$11,$F8,$11,$DA,$05        ;;A2C1|A2C1+A2C1/A2C1\A2C1;
                      db $BD,$11,$C4,$11,$C4,$51,$D8,$11        ;;A2C9|A2C9+A2C9/A2C9\A2C9;
                      db $59,$CF,$00,$05,$F9,$15,$FA,$15        ;;A2D1|A2D1+A2D1/A2D1\A2D1;
                      db $FB,$15,$59,$E3,$00,$1D,$CB,$15        ;;A2D9|A2D9+A2D9/A2D9\A2D9;
                      db $FC,$11,$FD,$11,$FE,$11,$FC,$38        ;;A2E1|A2E1+A2E1/A2E1\A2E1;
                      db $D6,$11,$D8,$11,$C9,$11,$CA,$11        ;;A2E9|A2E9+A2E9/A2E9\A2E9;
                      db $F3,$15,$F4,$15,$F5,$15,$FC,$15        ;;A2F1|A2F1+A2F1/A2F1\A2F1;
                      db $FD,$15,$FE,$15,$5A,$08,$00,$17        ;;A2F9|A2F9+A2F9/A2F9\A2F9;
                      db $C9,$11,$CA,$11,$CB,$11,$DA,$11        ;;A301|A301+A301/A301\A301;
                      db $F6,$15,$F7,$15,$F8,$15,$F9,$55        ;;A309|A309+A309/A309\A309;
                      db $FC,$0D,$F3,$15,$F4,$15,$F5,$15        ;;A311|A311+A311/A311\A311;
                      db $5A,$28,$00,$19,$CB,$11,$DA,$11        ;;A319|A319+A319/A319\A319;
                      db $CB,$11,$DA,$11,$FD,$15,$FD,$15        ;;A321|A321+A321/A321\A321;
                      db $FE,$15,$DA,$55,$F9,$15,$F6,$15        ;;A329|A329+A329/A329\A329;
                      db $F7,$15,$F8,$15,$FB,$15,$5A,$49        ;;A331|A331+A331/A331\A331;
                      db $00,$17,$DA,$15,$F9,$05,$FA,$05        ;;A339|A339+A339/A339\A339;
                      db $FB,$05,$FC,$38,$FC,$38,$DA,$15        ;;A341|A341+A341/A341\A341;
                      db $FE,$15,$FC,$15,$FD,$15,$FE,$15        ;;A349|A349+A349/A349\A349;
                      db $DA,$55,$5A,$6A,$00,$09,$FC,$05        ;;A351|A351+A351/A351\A351;
                      db $FD,$05,$FE,$05,$FC,$38,$DA,$05        ;;A359|A359+A359/A359\A359;
                      db $58,$F6,$00,$05,$F9,$11,$FA,$11        ;;A361|A361+A361/A361\A361;
                      db $FB,$11,$59,$13,$00,$0B,$F9,$11        ;;A369|A369+A369/A369\A369;
                      db $FA,$11,$FB,$11,$FC,$11,$FD,$11        ;;A371|A371+A371/A371\A371;
                      db $FE,$11,$59,$31,$00,$09,$F9,$15        ;;A379|A379+A379/A379\A379;
                      db $FA,$15,$FB,$15,$FD,$11,$FE,$11        ;;A381|A381+A381/A381\A381;
                      db $59,$51,$00,$11,$FC,$15,$FD,$15        ;;A389|A389+A389/A389\A389;
                      db $FE,$15,$F3,$11,$F4,$11,$F5,$11        ;;A391|A391+A391/A391\A391;
                      db $FC,$11,$FD,$11,$FE,$11,$59,$72        ;;A399|A399+A399/A399\A399;
                      db $00,$0B,$FC,$15,$F9,$15,$F6,$11        ;;A3A1|A3A1+A3A1/A3A1\A3A1;
                      db $F7,$11,$F8,$11,$DA,$51,$59,$92        ;;A3A9|A3A9+A3A9/A3A9\A3A9;
                      db $00,$0D,$DA,$15,$FE,$15,$FC,$11        ;;A3B1|A3B1+A3B1/A3B1\A3B1;
                      db $FD,$11,$FE,$11,$FC,$11,$DA,$55        ;;A3B9|A3B9+A3B9/A3B9\A3B9;
                      db $57,$DA,$00,$05,$F9,$11,$FA,$11        ;;A3C1|A3C1+A3C1/A3C1\A3C1;
                      db $FB,$11,$57,$FA,$00,$05,$FC,$11        ;;A3C9|A3C9+A3C9/A3C9\A3C9;
                      db $FD,$11,$FE,$11,$5C,$3C,$00,$01        ;;A3D1|A3D1+A3D1/A3D1\A3D1;
                      db $DA,$11,$5C,$6D,$00,$05,$F9,$11        ;;A3D9|A3D9+A3D9/A3D9\A3D9;
                      db $FA,$11,$FB,$11,$5C,$8D,$00,$05        ;;A3E1|A3E1+A3E1/A3E1\A3E1;
                      db $FC,$11,$FD,$11,$FE,$11,$5C,$E5        ;;A3E9|A3E9+A3E9/A3E9\A3E9;
                      db $00,$07,$92,$11,$95,$11,$98,$11        ;;A3F1|A3F1+A3F1/A3F1\A3F1;
                      db $AD,$11,$5D,$05,$00,$07,$B1,$11        ;;A3F9|A3F9+A3F9/A3F9\A3F9;
                      db $B5,$11,$C4,$51,$B9,$11,$5D,$25        ;;A401|A401+A401/A401\A401;
                      db $00,$07,$BD,$11,$C4,$11,$C4,$51        ;;A409|A409+A409/A409\A409;
                      db $D8,$11,$5D,$45,$00,$0D,$D6,$11        ;;A411|A411+A411/A411\A411;
                      db $D8,$11,$C9,$11,$CA,$11,$F9,$51        ;;A419|A419+A419/A419\A419;
                      db $FA,$51,$FB,$51,$5D,$65,$00,$0D        ;;A421|A421+A421/A421\A421;
                      db $C9,$11,$CA,$11,$CB,$11,$DA,$11        ;;A429|A429+A429/A429\A429;
                      db $FC,$51,$FD,$51,$FE,$51,$5D,$85        ;;A431|A431+A431/A431\A431;
                      db $00,$0D,$CB,$11,$DA,$11,$CB,$11        ;;A439|A439+A439/A439\A439;
                      db $92,$11,$95,$11,$98,$11,$AD,$11        ;;A441|A441+A441/A441\A441;
                      db $5D,$A4,$00,$0F,$F3,$11,$F4,$11        ;;A449|A449+A449/A449\A449;
                      db $F5,$11,$FC,$38,$B1,$11,$B5,$11        ;;A451|A451+A451/A451\A451;
                      db $C4,$51,$B9,$11,$5D,$C4,$00,$0F        ;;A459|A459+A459/A459\A459;
                      db $F6,$11,$F7,$11,$F8,$11,$DA,$05        ;;A461|A461+A461/A461\A461;
                      db $BD,$11,$C4,$11,$C4,$51,$D8,$11        ;;A469|A469+A469/A469\A469;
                      db $5D,$CF,$00,$05,$F9,$15,$FA,$15        ;;A471|A471+A471/A471\A471;
                      db $FB,$15,$5D,$E3,$00,$1D,$CB,$15        ;;A479|A479+A479/A479\A479;
                      db $FC,$11,$FD,$11,$FE,$11,$FC,$38        ;;A481|A481+A481/A481\A481;
                      db $D6,$11,$D8,$11,$C9,$11,$CA,$11        ;;A489|A489+A489/A489\A489;
                      db $F3,$15,$F4,$15,$F5,$15,$FC,$15        ;;A491|A491+A491/A491\A491;
                      db $FD,$15,$FE,$15,$5E,$08,$00,$17        ;;A499|A499+A499/A499\A499;
                      db $C9,$11,$CA,$11,$CB,$11,$DA,$11        ;;A4A1|A4A1+A4A1/A4A1\A4A1;
                      db $F6,$15,$F7,$15,$F8,$15,$F9,$55        ;;A4A9|A4A9+A4A9/A4A9\A4A9;
                      db $FC,$0D,$F3,$15,$F4,$15,$F5,$15        ;;A4B1|A4B1+A4B1/A4B1\A4B1;
                      db $5E,$28,$00,$19,$CB,$11,$DA,$11        ;;A4B9|A4B9+A4B9/A4B9\A4B9;
                      db $CB,$11,$DA,$11,$FD,$15,$FD,$15        ;;A4C1|A4C1+A4C1/A4C1\A4C1;
                      db $FE,$15,$DA,$55,$F9,$15,$F6,$15        ;;A4C9|A4C9+A4C9/A4C9\A4C9;
                      db $F7,$15,$F8,$15,$FB,$15,$5E,$49        ;;A4D1|A4D1+A4D1/A4D1\A4D1;
                      db $00,$17,$DA,$15,$F9,$05,$FA,$05        ;;A4D9|A4D9+A4D9/A4D9\A4D9;
                      db $FB,$05,$FC,$38,$FC,$38,$DA,$15        ;;A4E1|A4E1+A4E1/A4E1\A4E1;
                      db $FE,$15,$FC,$15,$FD,$15,$FE,$15        ;;A4E9|A4E9+A4E9/A4E9\A4E9;
                      db $DA,$55,$5E,$6A,$00,$09,$FC,$05        ;;A4F1|A4F1+A4F1/A4F1\A4F1;
                      db $FD,$05,$FE,$05,$FC,$38,$DA,$05        ;;A4F9|A4F9+A4F9/A4F9\A4F9;
                      db $5C,$F6,$00,$05,$F9,$11,$FA,$11        ;;A501|A501+A501/A501\A501;
                      db $FB,$11,$5D,$13,$00,$0B,$F9,$11        ;;A509|A509+A509/A509\A509;
                      db $FA,$11,$FB,$11,$FC,$11,$FD,$11        ;;A511|A511+A511/A511\A511;
                      db $FE,$11,$5D,$31,$00,$09,$F9,$15        ;;A519|A519+A519/A519\A519;
                      db $FA,$15,$FB,$15,$FD,$11,$FE,$11        ;;A521|A521+A521/A521\A521;
                      db $5D,$51,$00,$11,$FC,$15,$FD,$15        ;;A529|A529+A529/A529\A529;
                      db $FE,$15,$F3,$11,$F4,$11,$F5,$11        ;;A531|A531+A531/A531\A531;
                      db $FC,$11,$FD,$11,$FE,$11,$5D,$72        ;;A539|A539+A539/A539\A539;
                      db $00,$0B,$FC,$15,$F9,$15,$F6,$11        ;;A541|A541+A541/A541\A541;
                      db $F7,$11,$F8,$11,$DA,$51,$5D,$92        ;;A549|A549+A549/A549\A549;
                      db $00,$0D,$DA,$15,$FE,$15,$FC,$11        ;;A551|A551+A551/A551\A551;
                      db $FD,$11,$FE,$11,$FC,$11,$DA,$55        ;;A559|A559+A559/A559\A559;
                      db $FF                                    ;;A561|A561+A561/A561\A561;
                                                                ;;                        ;
                      %insert_empty($1E,$1E,$1E,$1E,$1E)        ;;A562|A562+A562/A562\A562;
                                                                ;;                        ;
                   if ver_is_japanese(!_VER)          ;\   IF   ;;++++++++++++++++++++++++; J
DATA_05A580:          db $51,$67,$51,$27,$50,$E7,$50,$A7        ;;A580                    ;
                   else                               ;<  ELSE  ;;------------------------; U, SS, E0, & E1
DATA_05A580:          db $51,$A7,$51,$87,$51,$67,$51,$47        ;;    |A580+A580/A580\A580;
                      db $51,$27,$51,$07,$50,$E7,$50,$C7        ;;    |A588+A588/A588\A588;
                   endif                              ;/ ENDIF  ;;++++++++++++++++++++++++;
                                                                ;;                        ;
DATA_05A590:          db $14,$45,$3F,$08,$00,$29,$AA,$27        ;;A588|A590+A590/A590\A590;
                      db $26,$84,$95,$A9,$15,$13,$CE,$A7        ;;A590|A598+A598/A598\A598;
                      db $A4,$25,$A5,$05,$A6,$2A,$28            ;;A598|A5A0+A5A0/A5A0\A5A0;
                                                                ;;                        ;
DATA_05A5A7:          dw SwitchMessage-MessageBoxes             ;;A59F|A5A7+A5A7/A5A7\A5A7;
                      dw SwitchMessage-MessageBoxes             ;;A5A1|A5A9+A5A9/A5A9\A5A9;
                      dw SwitchMessage-MessageBoxes             ;;A5A3|A5AB+A5AB/A5AB\A5AB;
                      dw SwitchMessage-MessageBoxes             ;;A5A5|A5AD+A5AD/A5AD\A5AD;
                      dw IntroMessage-MessageBoxes              ;;A5A7|A5AF+A5AF/A5AF\A5AF;
                      dw ItemBoxMessage-MessageBoxes            ;;A5A9|A5B1+A5B1/A5B1\A5B1;
                      dw MidwayMessage-MessageBoxes             ;;A5AB|A5B3+A5B3/A5B3\A5B3;
                      dw JumpHighMessage-MessageBoxes           ;;A5AD|A5B5+A5B5/A5B5\A5B5;
                      dw BonusStarsMessage-MessageBoxes         ;;A5AF|A5B7+A5B7/A5B7\A5B7;
                      dw GhostHouseMessage-MessageBoxes         ;;A5B1|A5B9+A5B9/A5B9\A5B9;
                      dw CapeMarioMessage-MessageBoxes          ;;A5B3|A5BB+A5BB/A5BB\A5BB;
                      dw HoldItemMessage-MessageBoxes           ;;A5B5|A5BD+A5BD/A5BD\A5BD;
                      dw SecretExitMessage-MessageBoxes         ;;A5B7|A5BF+A5BF/A5BF\A5BF;
                      dw StarWorldMessage-MessageBoxes          ;;A5B9|A5C1+A5C1/A5C1\A5C1;
                      dw SpecialWorldMessage-MessageBoxes       ;;A5BB|A5C3+A5C3/A5C3\A5C3;
                      dw DragonCoinMessage-MessageBoxes         ;;A5BD|A5C5+A5C5/A5C5\A5C5;
                      dw CI2Message-MessageBoxes                ;;A5BF|A5C7+A5C7/A5C7\A5C7;
                      dw ClimbDoorMessage-MessageBoxes          ;;A5C1|A5C9+A5C9/A5C9\A5C9;
                      dw IggyKoopaMessage-MessageBoxes          ;;A5C3|A5CB+A5CB/A5CB\A5CB;
                      dw ScreenScrollMessage-MessageBoxes       ;;A5C5|A5CD+A5CD/A5CD\A5CD;
                      dw StartSelectMessage-MessageBoxes        ;;A5C7|A5CF+A5CF/A5CF\A5CF;
                      dw SpinJumpMessage-MessageBoxes           ;;A5C9|A5D1+A5D1/A5D1\A5D1;
                      dw YoshiGoneMessage-MessageBoxes          ;;A5CB|A5D3+A5D3/A5D3\A5D3;
                      dw FillYellowMessage-MessageBoxes         ;;A5CD|A5D5+A5D5/A5D5\A5D5;
                      dw RescueYoshiMessage-MessageBoxes        ;;A5CF|A5D7+A5D7/A5D7\A5D7;
                                                                ;;                        ;
MessageBoxes:                                                   ;;                        ;
                   if ver_is_japanese(!_VER)          ;\   IF   ;;++++++++++++++++++++++++; J
SwitchMessage:        db $5D,$5D,$5A,$5D,$4A,$48,$65,$7B        ;;A5D1                    ;
                      db $14,$51,$EF,$02,$59,$10,$21,$5D        ;;A5D9                    ;
                      db $5A,$5D,$5D,$00,$52,$0D,$59,$04        ;;A5E1                    ;
                      db $50,$09,$0D,$5D,$4A,$48,$65,$7B        ;;A5E9                    ;
                      db $14,$0E,$04,$20,$59,$10,$5D,$5D        ;;A5F1                    ;
                      db $5D,$5D,$59,$04,$5D,$5D,$5D,$5D        ;;A5F9                    ;
                      db $12,$04,$58,$55,$5D,$07,$07,$19        ;;A601                    ;
                      db $59,$10,$14,$6C,$5A,$4A,$59,$04        ;;A609                    ;
                      db $4D,$3E,$5F,$59,$10,$51,$19,$0A        ;;A611                    ;
                      db $78,$5D,$5D,$5D,$5D,$5D,$5D            ;;A619                    ;
IntroMessage:         db $07                                    ;;A620                    ;
                      db $21,$59,$11,$14,$59,$17,$0D,$01        ;;A621                    ;
                      db $15,$5D,$51,$84,$02,$55,$EF,$02        ;;A629                    ;
                      db $63,$4C,$59,$64,$52,$12,$1E,$20        ;;A631                    ;
                      db $00,$1E,$09,$01,$5D,$07,$14,$09        ;;A639                    ;
                      db $19,$59,$10,$5D,$5D,$5D,$5D,$19        ;;A641                    ;
                      db $0D,$1D,$1E,$5B,$79,$5A,$7B,$59        ;;A649                    ;
                      db $04,$5D,$0A,$59,$04,$0D,$77,$06        ;;A651                    ;
                      db $09,$0D,$78,$5D,$07,$01,$0F,$15        ;;A659                    ;
                      db $51,$7C,$11,$5D,$5F,$65,$5B,$61        ;;A661                    ;
                      db $14,$09,$58,$59,$08,$3F,$5D,$5D        ;;A669                    ;
ItemBoxMessage:       db $5D,$5A,$5D,$A7,$4C,$5B,$A6,$48        ;;A671                    ;
                      db $4C,$64,$5D,$62,$59,$64,$59,$61        ;;A679                    ;
                      db $48,$4A,$5D,$5A,$5D,$1F,$59,$17        ;;A681                    ;
                      db $21,$12,$11,$7C,$10,$5D,$00,$19        ;;A689                    ;
                      db $7C,$0D,$62,$48,$4F,$43,$15,$5D        ;;A691                    ;
                      db $59,$04,$1C,$21,$14,$02,$03,$12        ;;A699                    ;
                      db $5D,$A8,$07,$5D,$50,$01,$10,$50        ;;A6A1                    ;
                      db $06,$19,$0A,$E0,$4E,$5F,$64,$59        ;;A6A9                    ;
                      db $A6,$4B,$4C,$59,$10,$5D,$11,$57        ;;A6B1                    ;
                      db $0D,$55,$1D,$09,$19,$0A,$78            ;;A6B9                    ;
MidwayMessage:        db $5D                                    ;;A6C0                    ;
                      db $5A,$5D,$A7,$4C,$5B,$A6,$48,$4C        ;;A6C1                    ;
                      db $64,$5D,$62,$59,$64,$59,$61,$48        ;;A6C9                    ;
                      db $4A,$5D,$5A,$5D,$07,$07,$12,$00        ;;A6D1                    ;
                      db $56,$14,$15,$5D,$A0,$04,$21,$59        ;;A6D9                    ;
                      db $66,$5A,$64,$5D,$07,$07,$14,$4F        ;;A6E1                    ;
                      db $5A,$5B,$69,$77,$51,$7C,$10,$50        ;;A6E9                    ;
                      db $01,$0D,$20,$5D,$0F,$59,$0F,$51        ;;A6F1                    ;
                      db $15,$5D,$5D,$07,$14,$00,$0D,$55        ;;A6F9                    ;
                      db $04,$20,$5D,$15,$59,$09,$19,$55        ;;A701                    ;
                      db $19,$0A,$78,$5D,$5D,$5D                ;;A709                    ;
JumpHighMessage:      db $10,$51                                ;;A70F                    ;
                      db $77,$17,$21,$59,$0D,$11,$51,$5D        ;;A711                    ;
                      db $59,$6B,$68,$4C,$5B,$69,$59,$A6        ;;A719                    ;
                      db $4B,$4C,$77,$5D,$50,$09,$0F,$59        ;;A721                    ;
                      db $0F,$06,$10,$01,$56,$11,$5D,$0D        ;;A729                    ;
                      db $04,$05,$15,$13,$19,$0A,$78,$0A        ;;A731                    ;
                      db $01,$1C,$21,$59,$10,$15,$5D,$02        ;;A739                    ;
                      db $03,$12,$4D,$5A,$77,$01,$57,$10        ;;A741                    ;
                      db $01,$52,$01,$11,$5D,$0D,$04,$05        ;;A749                    ;
                      db $59,$6B,$68,$4C,$5B,$69,$59,$10        ;;A751                    ;
                      db $51,$19,$0B,$21,$78,$5D,$5D            ;;A759                    ;
BonusStarsMessage:    db $59                                    ;;A760                    ;
                      db $6C,$5A,$FF,$14,$5D,$3E,$5A,$5B        ;;A761                    ;
                      db $69,$77,$51,$7C,$0D,$11,$51,$59        ;;A769                    ;
                      db $A6,$5A,$46,$4A,$4A,$4B,$5A,$59        ;;A771                    ;
                      db $04,$5D,$1D,$20,$03,$19,$0A,$3F        ;;A779                    ;
                      db $5D,$0C,$57,$59,$04,$A8,$A9,$A9        ;;A781                    ;
                      db $00,$0F,$19,$57,$59,$15,$5D,$0D        ;;A789                    ;
                      db $14,$09,$01,$59,$A6,$5A,$46,$4A        ;;A791                    ;
                      db $59,$66,$5A,$43,$59,$04,$15,$59        ;;A799                    ;
                      db $09,$19,$55,$19,$0A,$78,$5D,$5D        ;;A7A1                    ;
                      db $5D,$5D,$5D,$5D,$5D,$5D,$5D,$5D        ;;A7A9                    ;
                      db $5D                                    ;;A7B1                    ;
GhostHouseMessage:    db $07,$07,$15,$5D,$6A,$59,$61            ;;A7B2                    ;
                      db $66,$1E,$09,$51,$78,$78,$78,$5D        ;;A7B9                    ;
                      db $5D,$5D,$5D,$5D,$5D,$5D,$5D,$5D        ;;A7C1                    ;
                      db $5D,$5D,$5D,$5D,$5D,$5D,$5D,$5D        ;;A7C9                    ;
                      db $5D,$5D,$5D,$5D,$5D,$5D,$07,$07        ;;A7D1                    ;
                      db $04,$20,$01,$51,$10,$59,$10,$20        ;;A7D9                    ;
                      db $57,$0D,$1E,$0F,$15,$5D,$01,$52        ;;A7E1                    ;
                      db $01,$88,$3E,$77,$1A,$0F,$06,$10        ;;A7E9                    ;
                      db $59,$07,$20,$21,$5D,$66,$65,$66        ;;A7F1                    ;
                      db $65,$66,$65,$5D                        ;;A7F9                    ;
CapeMarioMessage:     db $67,$4C,$64,$14                        ;;A7FD                    ;
                      db $0C,$02,$08,$15,$5D,$52,$57,$57        ;;A801                    ;
                      db $59,$15,$04,$21,$0D,$21,$3F,$1A        ;;A809                    ;
                      db $59,$11,$55,$14,$59,$A6,$4B,$4C        ;;A811                    ;
                      db $77,$59,$0A,$7C,$11,$50,$09,$10        ;;A819                    ;
                      db $01,$56,$07,$11,$19,$59,$0A,$15        ;;A821                    ;
                      db $5D,$15,$1E,$05,$15,$09,$56,$5D        ;;A829                    ;
                      db $0C,$09,$10,$59,$6B,$68,$4C,$5B        ;;A831                    ;
                      db $69,$00,$11,$15,$5D,$C0,$12,$F0        ;;A839                    ;
                      db $12,$59,$61,$63,$4C,$4A,$77,$11        ;;A841                    ;
                      db $56,$59,$0D,$06,$78                    ;;A849                    ;
HoldItemMessage:      db $00,$50,$59                            ;;A84E                    ;
                      db $A6,$4B,$4C,$5D,$1A,$59,$11,$55        ;;A851                    ;
                      db $59,$A6,$4B,$4C,$15,$5D,$04,$0C        ;;A859                    ;
                      db $05,$3F,$50,$09,$0D,$19,$19,$59        ;;A861                    ;
                      db $10,$5D,$07,$02,$20,$12,$08,$58        ;;A869                    ;
                      db $56,$11,$5D,$5D,$5D,$07,$02,$20        ;;A871                    ;
                      db $59,$04,$1D,$10,$56,$78,$02,$03        ;;A879                    ;
                      db $77,$1B,$01,$10,$15,$52,$0A,$11        ;;A881                    ;
                      db $19,$02,$03,$12,$5D,$52,$59,$06        ;;A889                    ;
                      db $0D,$55,$59,$10,$51,$19,$0A,$78        ;;A891                    ;
                      db $5D,$5D,$5D,$5D                        ;;A899                    ;
SecretExitMessage:    db $5D,$5A,$5D,$A7                        ;;A89D                    ;
                      db $4C,$5B,$A6,$48,$4C,$64,$5D,$62        ;;A8A1                    ;
                      db $59,$64,$59,$61,$48,$4A,$5D,$5A        ;;A8A9                    ;
                      db $5D,$67,$65,$5B,$69,$59,$10,$5D        ;;A8B1                    ;
                      db $00,$04,$01,$67,$5A,$5F,$14,$6C        ;;A8B9                    ;
                      db $5A,$4A,$12,$15,$5D,$1D,$02,$16        ;;A8C1                    ;
                      db $11,$0F,$59,$6C,$5A,$FF,$59,$04        ;;A8C9                    ;
                      db $00,$55,$19,$0A,$78,$1F,$B0,$02        ;;A8D1                    ;
                      db $5D,$14,$00,$56,$16,$11,$15,$5D        ;;A8D9                    ;
                      db $08,$59,$04,$09,$10,$1A,$0D,$20        ;;A8E1                    ;
                      db $59,$11,$02,$3D,$5D                    ;;A8E9                    ;
StarWorldMessage:     db $07,$14,$0B                            ;;A8EE                    ;
                      db $04,$01,$14,$00,$0E,$07,$0E,$12        ;;A8F1                    ;
                      db $5D,$4A,$4B,$5A,$14,$09,$19,$18        ;;A8F9                    ;
                      db $14,$01,$55,$59,$05,$0E,$59,$04        ;;A901                    ;
                      db $00,$56,$20,$09,$01,$78,$5D,$01        ;;A909                    ;
                      db $0F,$0F,$14,$01,$55,$59,$05,$0E        ;;A911                    ;
                      db $77,$5D,$0A,$59,$18,$10,$16,$20        ;;A919                    ;
                      db $05,$11,$5D,$67,$65,$5B,$69,$77        ;;A921                    ;
                      db $01,$51,$51,$0A,$56,$14,$12,$5D        ;;A929                    ;
                      db $11,$10,$1D,$59,$18,$21,$55,$59        ;;A931                    ;
                      db $10,$0A,$78,$5D                        ;;A939                    ;
SpecialWorldMessage:  db $07,$07,$19,$59                        ;;A93D                    ;
                      db $10,$05,$56,$11,$15,$5D,$50,$1D        ;;A941                    ;
                      db $58,$52,$04,$7C,$0D,$3F,$5D,$07        ;;A949                    ;
                      db $07,$04,$20,$08,$51,$15,$5D,$4A        ;;A951                    ;
                      db $5B,$18,$6B,$68,$FF,$6C,$5A,$4A        ;;A959                    ;
                      db $3F,$5D,$5F,$60,$62,$0A,$56,$11        ;;A961                    ;
                      db $5D,$0A,$07,$09,$5D,$00,$0D,$20        ;;A969                    ;
                      db $09,$01,$5D,$5D,$51,$84,$02,$55        ;;A971                    ;
                      db $EF,$02,$63,$4C,$59,$64,$77,$5D        ;;A979                    ;
                      db $0D,$14,$09,$1C,$19,$0A,$78            ;;A981                    ;
DragonCoinMessage:    db $5D                                    ;;A988                    ;
                      db $5A,$5D,$A7,$4C,$5B,$A6,$48,$4C        ;;A989                    ;
                      db $64,$5D,$62,$59,$64,$59,$61,$48        ;;A991                    ;
                      db $4A,$5A,$5D,$5D,$5D,$50,$50,$51        ;;A999                    ;
                      db $52,$6C,$48,$4C,$15,$5D,$59,$64        ;;A9A1                    ;
                      db $63,$59,$6C,$4C,$6C,$48,$4C,$5D        ;;A9A9                    ;
                      db $5D,$A8,$0F,$14,$6C,$5A,$4A,$59        ;;A9B1                    ;
                      db $10,$5D,$59,$07,$19,$01,$5D,$11        ;;A9B9                    ;
                      db $56,$11,$5D,$5D,$5D,$67,$60,$6A        ;;A9C1                    ;
                      db $77,$16,$11,$55,$5D,$5B,$69,$4E        ;;A9C9                    ;
                      db $59,$E0,$4C,$64,$3F,$5D,$5D,$5D        ;;A9D1                    ;
CI2Message:           db $07,$07,$15,$17,$09,$59,$51,$14        ;;A9D9                    ;
                      db $6C,$5A,$4A,$5D,$6C,$48,$4C,$77        ;;A9E1                    ;
                      db $11,$7C,$0D,$19,$01,$0A,$02,$1E        ;;A9E9                    ;
                      db $5D,$04,$04,$7C,$0D,$59,$09,$04        ;;A9F1                    ;
                      db $21,$59,$10,$5D,$0F,$59,$51,$12        ;;A9F9                    ;
                      db $59,$10,$56,$6C,$5A,$4A,$59,$04        ;;AA01                    ;
                      db $04,$58,$56,$3F,$5D,$15,$0D,$09        ;;AA09                    ;
                      db $10,$52,$59,$0C,$14,$59,$6C,$5A        ;;AA11                    ;
                      db $FF,$77,$1A,$0F,$06,$56,$07,$11        ;;AA19                    ;
                      db $59,$04,$59,$10,$51,$56,$04,$3D        ;;AA21                    ;
                      db $5D,$5D                                ;;AA29                    ;
ClimbDoorMessage:     db $5D,$5A,$5D,$A7,$4C,$5B                ;;AA2B                    ;
                      db $A6,$48,$4C,$64,$5D,$62,$59,$64        ;;AA31                    ;
                      db $59,$61,$48,$4A,$5D,$5A,$5D,$59        ;;AA39                    ;
                      db $6B,$68,$4C,$5B,$69,$A0,$12,$5D        ;;AA41                    ;
                      db $02,$03,$12,$4D,$5A,$77,$01,$57        ;;AA49                    ;
                      db $56,$11,$5D,$04,$52,$00,$1A,$12        ;;AA51                    ;
                      db $0F,$04,$19,$56,$07,$11,$59,$04        ;;AA59                    ;
                      db $59,$10,$51,$19,$0A,$78,$5D,$59        ;;AA61                    ;
                      db $64,$62,$12,$15,$01,$56,$14,$1D        ;;AA69                    ;
                      db $02,$03,$4D,$5A,$59,$10,$78,$5D        ;;AA71                    ;
                      db $5D,$5D,$5D                            ;;AA79                    ;
IggyKoopaMessage:     db $50,$09,$5C,$14,$A0                    ;;AA7C                    ;
                      db $12,$15,$5D,$47,$65,$6B,$5A,$14        ;;AA81                    ;
                      db $52,$04,$19,$59,$04,$5D,$0F,$04        ;;AA89                    ;
                      db $19,$7C,$10,$01,$56,$3F,$5D,$5D        ;;AA91                    ;
                      db $5D,$5D,$5D,$5D,$5D,$5D,$5D,$5D        ;;AA99                    ;
                      db $07,$14,$09,$5C,$14,$6C,$5F,$65        ;;AAA1                    ;
                      db $5B,$61,$11,$14,$5D,$0D,$0D,$04        ;;AAA9                    ;
                      db $01,$15,$5D,$1F,$02,$59,$04,$21        ;;AAB1                    ;
                      db $14,$01,$06,$18,$14,$5D,$50,$11        ;;AAB9                    ;
                      db $09,$00,$01,$59,$0D,$3F,$5D            ;;AAC1                    ;
ScreenScrollMessage:  db $5D                                    ;;AAC8                    ;
                      db $5A,$5D,$A7,$4C,$5B,$A6,$48,$4C        ;;AAC9                    ;
                      db $64,$5D,$62,$59,$64,$59,$61,$48        ;;AAD1                    ;
                      db $4A,$5D,$5A,$5D,$5D,$49,$5A,$59        ;;AAD9                    ;
                      db $A6,$4B,$4C,$5D,$7A,$5A,$59,$A6        ;;AAE1                    ;
                      db $4B,$4C,$77,$5D,$50,$0A,$11,$5D        ;;AAE9                    ;
                      db $59,$04,$1C,$21,$77,$5D,$F0,$12        ;;AAF1                    ;
                      db $C0,$12,$59,$0A,$20,$0B,$19,$0A        ;;AAF9                    ;
                      db $78,$5D,$5D,$5D,$0E,$84,$7C,$11        ;;AB01                    ;
                      db $08,$51,$14,$54,$02,$77,$5D,$1A        ;;AB09                    ;
                      db $0D,$55,$59,$10,$51,$19,$0A            ;;AB11                    ;
StartSelectMessage:   db $5D                                    ;;AB18                    ;
                      db $5A,$5D,$A7,$4C,$5B,$A6,$48,$4C        ;;AB19                    ;
                      db $64,$5D,$62,$59,$64,$59,$61,$48        ;;AB21                    ;
                      db $4A,$5D,$5A,$5D,$01,$0E,$59,$11        ;;AB29                    ;
                      db $5F,$60,$62,$09,$0D,$6C,$5A,$4A        ;;AB31                    ;
                      db $52,$20,$5D,$4A,$4B,$5A,$64,$59        ;;AB39                    ;
                      db $A6,$4B,$4C,$77,$5D,$50,$09,$10        ;;AB41                    ;
                      db $5D,$E0,$4E,$5F,$64,$59,$A6,$4B        ;;AB49                    ;
                      db $4C,$77,$5D,$50,$0A,$11,$5D,$67        ;;AB51                    ;
                      db $65,$5B,$69,$12,$1D,$59,$11,$56        ;;AB59                    ;
                      db $07,$11,$59,$04,$59,$10,$51,$19        ;;AB61                    ;
                      db $0A                                    ;;AB69                    ;
SpinJumpMessage:      db $51,$01,$5C,$59,$A6,$4B,$4C            ;;AB6A                    ;
                      db $15,$59,$6B,$68,$4C,$5B,$69,$5D        ;;AB71                    ;
                      db $00,$04,$59,$A6,$4B,$4C,$15,$4A        ;;AB79                    ;
                      db $5B,$79,$4C,$59,$6B,$68,$4C,$5B        ;;AB81                    ;
                      db $69,$78,$17,$1C,$52,$01,$10,$51        ;;AB89                    ;
                      db $1D,$17,$1C,$10,$50,$50,$51,$01        ;;AB91                    ;
                      db $67,$60,$6A,$52,$20,$5D,$59,$69        ;;AB99                    ;
                      db $3E,$65,$5F,$1D,$58,$57,$56,$47        ;;ABA1                    ;
                      db $65,$6B,$5A,$04,$20,$50,$55,$56        ;;ABA9                    ;
                      db $14,$1D,$5D,$00,$04,$59,$A6,$4B        ;;ABB1                    ;
                      db $4C,$3F                                ;;ABB9                    ;
YoshiGoneMessage:     db $5D,$48,$63,$65,$6B,$68                ;;ABBB                    ;
                      db $48,$3F,$5D,$59,$54,$05,$15,$5D        ;;ABC1                    ;
                      db $5F,$65,$5B,$61,$04,$20,$52,$04        ;;ABC9                    ;
                      db $19,$77,$0D,$0A,$06,$56,$5D,$0D        ;;ABD1                    ;
                      db $59,$16,$12,$59,$10,$19,$0A,$78        ;;ABD9                    ;
                      db $5D,$5D,$59,$07,$1F,$02,$14,$04        ;;ABE1                    ;
                      db $0D,$15,$5D,$59,$08,$21,$13,$21        ;;ABE9                    ;
                      db $59,$10,$09,$0D,$78,$5D,$5D,$5D        ;;ABF1                    ;
                      db $5D,$5D,$5D,$4A,$5A,$5B,$61,$5A        ;;ABF9                    ;
                      db $59,$64,$63,$59,$6C,$4C,$5D,$5D        ;;AC01                    ;
                      db $47,$65,$6B,$5A                        ;;AC09                    ;
FillYellowMessage:    db $5D,$5A,$5D,$A7                        ;;AC0D                    ;
                      db $4C,$5B,$A6,$48,$4C,$64,$5D,$62        ;;AC11                    ;
                      db $59,$64,$59,$61,$48,$4A,$5D,$5A        ;;AC19                    ;
                      db $5D,$5D,$5D,$5D,$5D,$5D,$5D,$5D        ;;AC21                    ;
                      db $5D,$5D,$5D,$5D,$5D,$5D,$5D,$5D        ;;AC29                    ;
                      db $5D,$5D,$5D,$10,$21,$0B,$21,$14        ;;AC31                    ;
                      db $59,$69,$3E,$65,$5F,$59,$04,$5D        ;;AC39                    ;
                      db $51,$12,$52,$56,$16,$11,$15,$04        ;;AC41                    ;
                      db $7C,$5B,$15,$1E,$19,$12,$5D,$01        ;;AC49                    ;
                      db $7C,$10,$1A,$19,$09,$84,$02,$78        ;;AC51                    ;
                      db $5D,$5D                                ;;AC59                    ;
RescueYoshiMessage:   db $69,$5A,$65,$3F,$5D,$0D                ;;AC5B                    ;
                      db $0A,$04,$7C,$0D,$78,$5D,$59,$54        ;;AC61                    ;
                      db $05,$47,$65,$6B,$5A,$5F,$65,$5B        ;;AC69                    ;
                      db $61,$12,$0F,$04,$19,$7C,$0D,$5D        ;;AC71                    ;
                      db $52,$04,$19,$77,$0D,$0A,$06,$12        ;;AC79                    ;
                      db $50,$09,$5C,$18,$01,$07,$02,$11        ;;AC81                    ;
                      db $09,$0D,$20,$5D,$1E,$0F,$20,$12        ;;AC89                    ;
                      db $5D,$5D,$0D,$19,$59,$07,$12,$5D        ;;AC91                    ;
                      db $11,$59,$09,$07,$1C,$20,$57,$0D        ;;AC99                    ;
                      db $21,$59,$10,$0A,$78,$5D,$5D            ;;ACA1                    ;
                   else                               ;<  ELSE  ;;------------------------; U, SS, E0, & E1
IntroMessage:         db $16,$44,$4B,$42,$4E,$4C,$44,$1A        ;;    |A5D9+A5D9/A5D9\A5D9;
                      db $1F,$1F,$1F,$13,$47,$48,$52,$1F        ;;    |A5E1+A5E1/A5E1\A5E1;
                      db $48,$D2,$03,$48,$4D,$4E,$52,$40        ;;    |A5E9+A5E9/A5E9\A5E9;
                      db $54,$51,$1F,$0B,$40,$4D,$43,$1B        ;;    |A5F1+A5F1/A5F1\A5F1;
                      db $1F,$1F,$08,$CD,$53,$47,$48,$52        ;;    |A5F9+A5F9/A5F9\A5F9;
                      db $1F,$52,$53,$51,$40,$4D,$46,$44        ;;    |A601+A601/A601\A601;
                      db $1F,$1F,$4B,$40,$4D,$C3,$56,$44        ;;    |A609+A609/A609\A609;
                      db $1F,$1F,$1F,$1F,$45,$48,$4D,$43        ;;    |A611+A611/A611\A611;
                      db $1F,$1F,$1F,$1F,$53,$47,$40,$D3        ;;    |A619+A619/A619\A619;
                      db $0F,$51,$48,$4D,$42,$44,$52,$52        ;;    |A621+A621/A621\A621;
                      db $1F,$13,$4E,$40,$43,$52,$53,$4E        ;;    |A629+A629/A629\A629;
                      db $4E,$CB,$48,$52,$1F,$1F,$4C,$48        ;;    |A631+A631/A631\A631;
                      db $52,$52,$48,$4D,$46,$1F,$40,$46        ;;    |A639+A639/A639\A639;
                      db $40,$48,$4D,$9A,$0B,$4E,$4E,$4A        ;;    |A641+A641/A641\A641;
                      db $52,$1F,$1F,$4B,$48,$4A,$44,$1F        ;;    |A649+A649/A649\A649;
                      db $01,$4E,$56,$52,$44,$D1,$48,$52        ;;    |A651+A651/A651\A651;
                      db $1F,$40,$53,$1F,$48,$53,$1F,$40        ;;    |A659+A659/A659\A659;
                      db $46,$40,$48,$4D,$9A                    ;;    |A661+A661/A661\A661;
                   if ver_is_console(!_VER)           ;\   IF   ;;++++++++++++++++++++++++; U, E0, & E1
SwitchMessage:        db $1C,$1F,$12                            ;;    |A666     /A666\A666;
                      db $16,$08,$13,$02,$07,$1F,$0F,$00        ;;    |A669     /A669\A669;
                      db $0B,$00,$02,$04,$1F,$9C,$13,$47        ;;    |A671     /A671\A671;
                      db $44,$1F,$1F,$4F,$4E,$56,$44,$51        ;;    |A679     /A679\A679;
                      db $1F,$1F,$4E,$45,$1F,$53,$47,$C4        ;;    |A681     /A681\A681;
                      db $52,$56,$48,$53,$42,$47,$1F,$1F        ;;    |A689     /A689\A689;
                      db $58,$4E,$54,$1F,$1F,$1F,$47,$40        ;;    |A691     /A691\A691;
                      db $55,$C4,$4F,$54,$52,$47,$44,$43        ;;    |A699     /A699\A699;
                      db $1F,$1F,$56,$48,$4B,$4B,$1F,$1F        ;;    |A6A1     /A6A1\A6A1;
                      db $53,$54,$51,$CD,$9F,$1F,$1F,$1F        ;;    |A6A9     /A6A9\A6A9;
                      db $1F,$1F,$1F,$48,$4D,$53,$4E,$1F        ;;    |A6B1     /A6B1\A6B1;
                      db $1F,$1F,$1F,$1F,$9B,$18,$4E,$54        ;;    |A6B9     /A6B9\A6B9;
                      db $51,$1F,$4F,$51,$4E,$46,$51,$44        ;;    |A6C1     /A6C1\A6C1;
                      db $52,$52,$1F,$56,$48,$4B,$CB,$40        ;;    |A6C9     /A6C9\A6C9;
                      db $4B,$52,$4E,$1F,$1F,$1F,$41,$44        ;;    |A6D1     /A6D1\A6D1;
                      db $1F,$1F,$1F,$52,$40,$55,$44,$43        ;;    |A6D9     /A6D9\A6D9;
                      db $9B                                    ;;    |A6E1     /A6E1\A6E1;
                   else                               ;<  ELSE  ;;------------------------; SS
SwitchMessage:        db $1C,$1F,$12,$16,$08,$13,$02,$07        ;;         +A666          ;
                      db $1F,$0F,$00,$0B,$00,$02,$04,$1F        ;;         +A66E          ;
                      db $9C,$9F,$13,$47,$44,$1F,$1F,$4F        ;;         +A676          ;
                      db $4E,$56,$44,$51,$1F,$1F,$4E,$45        ;;         +A67E          ;
                      db $1F,$53,$47,$C4,$52,$56,$48,$53        ;;         +A686          ;
                      db $42,$47,$1F,$1F,$58,$4E,$54,$1F        ;;         +A68E          ;
                      db $1F,$1F,$47,$40,$55,$C4,$4F,$54        ;;         +A696          ;
                      db $52,$47,$44,$43,$1F,$1F,$56,$48        ;;         +A69E          ;
                      db $4B,$4B,$1F,$1F,$53,$54,$51,$CD        ;;         +A6A6          ;
                      db $9F,$1F,$1F,$1F,$1F,$1F,$1F,$48        ;;         +A6AE          ;
                      db $4D,$53,$4E,$1F,$1F,$1F,$1F,$1F        ;;         +A6B6          ;
                      db $9B,$9F                                ;;         +A6BE          ;
                   endif                              ;/ ENDIF  ;;++++++++++++++++++++++++;
YoshiGoneMessage:     db $07,$44,$4B,$4B,$4E,$1A,$1F            ;;    |A6E2+A6C0/A6E2\A6E2;
                      db $1F,$1F,$12,$4E,$51,$51,$58,$1F        ;;    |A6E9+A6C7/A6E9\A6E9;
                      db $08,$5D,$CC,$4D,$4E,$53,$1F,$1F        ;;    |A6F1+A6CF/A6F1\A6F1;
                      db $47,$4E,$4C,$44,$1D,$1F,$1F,$41        ;;    |A6F9+A6D7/A6F9\A6F9;
                      db $54,$53,$1F,$1F,$88,$47,$40,$55        ;;    |A701+A6DF/A701\A701;
                      db $44,$1F,$1F,$1F,$1F,$46,$4E,$4D        ;;    |A709+A6E7/A709\A709;
                      db $44,$1F,$1F,$1F,$1F,$53,$CE,$51        ;;    |A711+A6EF/A711\A711;
                      db $44,$52,$42,$54,$44,$1F,$1F,$4C        ;;    |A719+A6F7/A719\A719;
                      db $58,$1F,$45,$51,$48,$44,$4D,$43        ;;    |A721+A6FF/A721\A721;
                      db $D2,$56,$47,$4E,$1F,$56,$44,$51        ;;    |A729+A707/A729\A729;
                      db $44,$1F,$1F,$42,$40,$4F,$53,$54        ;;    |A731+A70F/A731\A731;
                      db $51,$44,$C3,$41,$58,$1F,$01,$4E        ;;    |A739+A717/A739\A739;
                      db $56,$52,$44,$51,$9B,$1F,$1F,$1F        ;;    |A741+A71F/A741\A741;
                      db $1F,$1F,$1F,$1F,$1F,$1F,$1F,$1F        ;;    |A749+A727/A749\A749;
                      db $1F,$1F,$1F,$1F,$1F,$60,$E1,$1F        ;;    |A751+A72F/A751\A751;
                      db $1F,$1F,$1F,$1F,$1F,$1F,$1F,$1F        ;;    |A759+A737/A759\A759;
                      db $1C,$1F,$18,$4E,$52,$47,$48,$62        ;;    |A761+A73F/A761\A761;
                      db $E3                                    ;;    |A769+A747/A769\A769;
RescueYoshiMessage:   db $07,$4E,$4E,$51,$40,$58,$1A            ;;    |A76A+A748/A76A\A76A;
                      db $1F,$1F,$13,$47,$40,$4D,$4A,$1F        ;;    |A771+A74F/A771\A771;
                      db $58,$4E,$D4,$45,$4E,$51,$1F,$51        ;;    |A779+A757/A779\A779;
                      db $44,$52,$42,$54,$48,$4D,$46,$1F        ;;    |A781+A75F/A781\A781;
                      db $1F,$1F,$4C,$44,$9B,$0C,$58,$1F        ;;    |A789+A767/A789\A789;
                      db $4D,$40,$4C,$44,$1F,$1F,$48,$52        ;;    |A791+A76F/A791\A791;
                      db $1F,$18,$4E,$52,$47,$48,$9B,$0E        ;;    |A799+A777/A799\A799;
                      db $4D,$1F,$1F,$1F,$4C,$58,$1F,$1F        ;;    |A7A1+A77F/A7A1\A7A1;
                      db $1F,$56,$40,$58,$1F,$1F,$1F,$53        ;;    |A7A9+A787/A7A9\A7A9;
                      db $CE,$51,$44,$52,$42,$54,$44,$1F        ;;    |A7B1+A78F/A7B1\A7B1;
                      db $4C,$58,$1F,$45,$51,$48,$44,$4D        ;;    |A7B9+A797/A7B9\A7B9;
                      db $43,$52,$9D,$01,$4E,$56,$52,$44        ;;    |A7C1+A79F/A7C1\A7C1;
                      db $51,$1F,$53,$51,$40,$4F,$4F,$44        ;;    |A7C9+A7A7/A7C9\A7C9;
                      db $43,$1F,$1F,$4C,$C4,$48,$4D,$1F        ;;    |A7D1+A7AF/A7D1\A7D1;
                      db $53,$47,$40,$53,$1F,$44,$46,$46        ;;    |A7D9+A7B7/A7D9\A7D9;
                      db $9B,$9F                                ;;    |A7E1+A7BF/A7E1\A7E1;
FillYellowMessage:    db $08,$53,$1F,$48,$52,$1F                ;;    |A7E3+A7C1/A7E3\A7E3;
                      db $4F,$4E,$52,$52,$48,$41,$4B,$44        ;;    |A7E9+A7C7/A7E9\A7E9;
                      db $1F,$1F,$53,$CE,$45,$48,$4B,$4B        ;;    |A7F1+A7CF/A7F1\A7F1;
                      db $1F,$48,$4D,$1F,$53,$47,$44,$1F        ;;    |A7F9+A7D7/A7F9\A7F9;
                      db $43,$4E,$53,$53,$44,$C3,$4B,$48        ;;    |A801+A7DF/A801\A801;
                      db $4D,$44,$1F,$41,$4B,$4E,$42,$4A        ;;    |A809+A7E7/A809\A809;
                      db $52,$1B,$1F,$1F,$1F,$1F,$13,$CE        ;;    |A811+A7EF/A811\A811;
                      db $45,$48,$4B,$4B,$1F,$48,$4D,$1F        ;;    |A819+A7F7/A819\A819;
                      db $53,$47,$44,$1F,$58,$44,$4B,$4B        ;;    |A821+A7FF/A821\A821;
                      db $4E,$D6,$4E,$4D,$44,$52,$1D,$1F        ;;    |A829+A807/A829\A829;
                      db $49,$54,$52,$53,$1F,$46,$4E,$1F        ;;    |A831+A80F/A831\A831;
                      db $56,$44,$52,$D3,$53,$47,$44,$4D        ;;    |A839+A817/A839\A839;
                      db $1F,$4D,$4E,$51,$53,$47,$1F,$1F        ;;    |A841+A81F/A841\A841;
                      db $53,$4E,$1F,$53,$47,$C4,$53,$4E        ;;    |A849+A827/A849\A849;
                      db $4F,$1F,$1F,$1F,$1F,$1F,$4E,$45        ;;    |A851+A82F/A851\A851;
                      db $1F,$1F,$1F,$1F,$1F,$53,$47,$C4        ;;    |A859+A837/A859\A859;
                      db $4C,$4E,$54,$4D,$53,$40,$48,$4D        ;;    |A861+A83F/A861\A861;
                      db $9B                                    ;;    |A869+A847/A869\A869;
ItemBoxMessage:       db $1C,$0F,$0E,$08,$0D,$13,$1F            ;;    |A86A+A848/A86A\A86A;
                      db $0E,$05,$1F,$00,$03,$15,$08,$02        ;;    |A871+A84F/A871\A871;
                      db $04,$9C,$18,$4E,$54,$1F,$1F,$42        ;;    |A879+A857/A879\A879;
                      db $40,$4D,$1F,$1F,$47,$4E,$4B,$43        ;;    |A881+A85F/A881\A881;
                      db $1F,$1F,$40,$CD,$44,$57,$53,$51        ;;    |A889+A867/A889\A889;
                      db $40,$1F,$48,$53,$44,$4C,$1F,$1F        ;;    |A891+A86F/A891\A891;
                      db $48,$4D,$1F,$53,$47,$C4,$41,$4E        ;;    |A899+A877/A899\A899;
                      db $57,$1F,$40,$53,$1F,$1F,$53,$47        ;;    |A8A1+A87F/A8A1\A8A1;
                      db $44,$1F,$53,$4E,$4F,$1F,$4E,$C5        ;;    |A8A9+A887/A8A9\A8A9;
                      db $53,$47,$44,$1F,$52,$42,$51,$44        ;;    |A8B1+A88F/A8B1\A8B1;
                      db $44,$4D,$1B,$1F,$1F,$1F,$1F,$1F        ;;    |A8B9+A897/A8B9\A8B9;
                      db $13,$CE,$54,$52,$44,$1F,$48,$53        ;;    |A8C1+A89F/A8C1\A8C1;
                      db $1D,$1F,$1F,$4F,$51,$44,$52,$52        ;;    |A8C9+A8A7/A8C9\A8C9;
                      db $1F,$53,$47,$C4,$12,$04,$0B,$04        ;;    |A8D1+A8AF/A8D1\A8D1;
                      db $02,$13,$1F,$01,$54,$53,$53,$4E        ;;    |A8D9+A8B7/A8D9\A8D9;
                      db $4D,$9B,$9F                            ;;    |A8E1+A8BF/A8E1\A8E1;
HoldItemMessage:      db $1C,$0F,$0E,$08,$0D                    ;;    |A8E4+A8C2/A8E4\A8E4;
                      db $13,$1F,$0E,$05,$1F,$00,$03,$15        ;;    |A8E9+A8C7/A8E9\A8E9;
                      db $08,$02,$04,$9C,$13,$4E,$1F,$1F        ;;    |A8F1+A8CF/A8F1\A8F1;
                      db $1F,$4F,$48,$42,$4A,$1F,$1F,$1F        ;;    |A8F9+A8D7/A8F9\A8F9;
                      db $54,$4F,$1F,$1F,$1F,$C0,$52,$47        ;;    |A901+A8DF/A901\A901;
                      db $44,$4B,$4B,$1D,$1F,$1F,$54,$52        ;;    |A909+A8E7/A909\A909;
                      db $44,$1F,$1F,$53,$47,$44,$1F,$97        ;;    |A911+A8EF/A911\A911;
                      db $4E,$51,$1F,$1F,$18,$1F,$1F,$01        ;;    |A919+A8F7/A919\A919;
                      db $54,$53,$53,$4E,$4D,$1B,$1F,$1F        ;;    |A921+A8FF/A921\A921;
                      db $13,$CE,$53,$47,$51,$4E,$56,$1F        ;;    |A929+A907/A929\A929;
                      db $1F,$1F,$1F,$40,$1F,$1F,$1F,$52        ;;    |A931+A90F/A931\A931;
                      db $47,$44,$4B,$CB,$54,$4F,$56,$40        ;;    |A939+A917/A939\A939;
                      db $51,$43,$52,$1D,$1F,$1F,$4B,$4E        ;;    |A941+A91F/A941\A941;
                      db $4E,$4A,$1F,$1F,$54,$CF,$40,$4D        ;;    |A949+A927/A949\A949;
                      db $43,$1F,$4B,$44,$53,$1F,$46,$4E        ;;    |A951+A92F/A951\A951;
                      db $1F,$4E,$45,$1F,$1F,$53,$47,$C4        ;;    |A959+A937/A959\A959;
                      db $41,$54,$53,$53,$4E,$4D,$9B            ;;    |A961+A93F/A961\A961;
SpinJumpMessage:      db $13                                    ;;    |A968+A946/A968\A968;
                      db $4E,$1F,$43,$4E,$1F,$40,$1F,$52        ;;    |A969+A947/A969\A969;
                      db $4F,$48,$4D,$1F,$49,$54,$4C,$4F        ;;    |A971+A94F/A971\A971;
                      db $9D,$4F,$51,$44,$52,$52,$1F,$1F        ;;    |A979+A957/A979\A979;
                      db $1F,$1F,$53,$47,$44,$1F,$1F,$1F        ;;    |A981+A95F/A981\A981;
                      db $1F,$1F,$80,$01,$54,$53,$53,$4E        ;;    |A989+A967/A989\A989;
                      db $4D,$1B,$1F,$1F,$1F,$1F,$00,$1F        ;;    |A991+A96F/A991\A991;
                      db $12,$54,$4F,$44,$D1,$0C,$40,$51        ;;    |A999+A977/A999\A999;
                      db $48,$4E,$1F,$1F,$1F,$52,$4F,$48        ;;    |A9A1+A97F/A9A1\A9A1;
                      db $4D,$1F,$1F,$49,$54,$4C,$CF,$42        ;;    |A9A9+A987/A9A9\A9A9;
                      db $40,$4D,$1F,$41,$51,$44,$40,$4A        ;;    |A9B1+A98F/A9B1\A9B1;
                      db $1F,$52,$4E,$4C,$44,$1F,$1F,$4E        ;;    |A9B9+A997/A9B9\A9B9;
                      db $C5,$53,$47,$44,$1F,$1F,$1F,$41        ;;    |A9C1+A99F/A9C1\A9C1;
                      db $4B,$4E,$42,$4A,$52,$1F,$1F,$1F        ;;    |A9C9+A9A7/A9C9\A9C9;
                      db $40,$4D,$C3,$43,$44,$45,$44,$40        ;;    |A9D1+A9AF/A9D1\A9D1;
                      db $53,$1F,$52,$4E,$4C,$44,$1F,$4E        ;;    |A9D9+A9B7/A9D9\A9D9;
                      db $45,$1F,$53,$47,$C4,$53,$4E,$54        ;;    |A9E1+A9BF/A9E1\A9E1;
                      db $46,$47,$44,$51,$1F,$44,$4D,$44        ;;    |A9E9+A9C7/A9E9\A9E9;
                      db $4C,$48,$44,$52,$9B                    ;;    |A9F1+A9CF/A9F1\A9F1;
MidwayMessage:        db $1C,$0F,$0E                            ;;    |A9F6+A9D4/A9F6\A9F6;
                      db $08,$0D,$13,$1F,$0E,$05,$1F,$00        ;;    |A9F9+A9D7/A9F9\A9F9;
                      db $03,$15,$08,$02,$04,$9C,$13,$47        ;;    |AA01+A9DF/AA01\AA01;
                      db $48,$52,$1F,$1F,$1F,$46,$40,$53        ;;    |AA09+A9E7/AA09\AA09;
                      db $44,$1F,$1F,$4C,$40,$51,$4A,$D2        ;;    |AA11+A9EF/AA11\AA11;
                      db $53,$47,$44,$1F,$4C,$48,$43,$43        ;;    |AA19+A9F7/AA19\AA19;
                      db $4B,$44,$1F,$4E,$45,$1F,$53,$47        ;;    |AA21+A9FF/AA21\AA21;
                      db $48,$D2,$40,$51,$44,$40,$1B,$1F        ;;    |AA29+AA07/AA29\AA29;
                      db $1F,$1F,$01,$58,$1F,$42,$54,$53        ;;    |AA31+AA0F/AA31\AA31;
                      db $53,$48,$4D,$C6,$53,$47,$44,$1F        ;;    |AA39+AA17/AA39\AA39;
                      db $53,$40,$4F,$44,$1F,$47,$44,$51        ;;    |AA41+AA1F/AA41\AA41;
                      db $44,$1D,$1F,$58,$4E,$D4,$42,$40        ;;    |AA49+AA27/AA49\AA49;
                      db $4D,$1F,$42,$4E,$4D,$53,$48,$4D        ;;    |AA51+AA2F/AA51\AA51;
                      db $54,$44,$1F,$1F,$45,$51,$4E,$CC        ;;    |AA59+AA37/AA59\AA59;
                      db $42,$4B,$4E,$52,$44,$1F,$1F,$1F        ;;    |AA61+AA3F/AA61\AA61;
                      db $53,$4E,$1F,$1F,$1F,$1F,$53,$47        ;;    |AA69+AA47/AA69\AA69;
                      db $48,$D2,$4F,$4E,$48,$4D,$53,$9B        ;;    |AA71+AA4F/AA71\AA71;
DragonCoinMessage:    db $1C,$0F,$0E,$08,$0D,$13,$1F,$0E        ;;    |AA79+AA57/AA79\AA79;
                      db $05,$1F,$00,$03,$15,$08,$02,$04        ;;    |AA81+AA5F/AA81\AA81;
                      db $9C,$13,$47,$44,$1F,$41,$48,$46        ;;    |AA89+AA67/AA89\AA89;
                      db $1F,$42,$4E,$48,$4D,$52,$1F,$1F        ;;    |AA91+AA6F/AA91\AA91;
                      db $40,$51,$C4,$03,$51,$40,$46,$4E        ;;    |AA99+AA77/AA99\AA99;
                      db $4D,$1F,$02,$4E,$48,$4D,$52,$1B        ;;    |AAA1+AA7F/AAA1\AAA1;
                      db $1F,$1F,$1F,$08,$C5,$58,$4E,$54        ;;    |AAA9+AA87/AAA9\AAA9;
                      db $1F,$1F,$4F,$48,$42,$4A,$1F,$54        ;;    |AAB1+AA8F/AAB1\AAB1;
                      db $4F,$1F,$1F,$45,$48,$55,$C4,$4E        ;;    |AAB9+AA97/AAB9\AAB9;
                      db $45,$1F,$1F,$53,$47,$44,$52,$44        ;;    |AAC1+AA9F/AAC1\AAC1;
                      db $1F,$1F,$48,$4D,$1F,$1F,$4E,$4D        ;;    |AAC9+AAA7/AAC9\AAC9;
                      db $C4,$40,$51,$44,$40,$1D,$1F,$1F        ;;    |AAD1+AAAF/AAD1\AAD1;
                      db $58,$4E,$54,$1F,$1F,$46,$44,$53        ;;    |AAD9+AAB7/AAD9\AAD9;
                      db $1F,$40,$CD,$44,$57,$53,$51,$40        ;;    |AAE1+AABF/AAE1\AAE1;
                      db $1F,$0C,$40,$51,$48,$4E,$9B,$9F        ;;    |AAE9+AAC7/AAE9\AAE9;
JumpHighMessage:      db $16,$47,$44,$4D,$1F,$58,$4E,$54        ;;    |AAF1+AACF/AAF1\AAF1;
                      db $1F,$1F,$52,$53,$4E,$4C,$4F,$1F        ;;    |AAF9+AAD7/AAF9\AAF9;
                      db $4E,$CD,$40,$4D,$1F,$44,$4D,$44        ;;    |AB01+AADF/AB01\AB01;
                      db $4C,$58,$1D,$1F,$1F,$58,$4E,$54        ;;    |AB09+AAE7/AB09\AB09;
                      db $1F,$42,$40,$CD,$49,$54,$4C,$4F        ;;    |AB11+AAEF/AB11\AB11;
                      db $1F,$47,$48,$46,$47,$1F,$1F,$48        ;;    |AB19+AAF7/AB19\AB19;
                      db $45,$1F,$1F,$58,$4E,$D4,$47,$4E        ;;    |AB21+AAFF/AB21\AB21;
                      db $4B,$43,$1F,$1F,$1F,$1F,$53,$47        ;;    |AB29+AB07/AB29\AB29;
                      db $44,$1F,$1F,$1F,$49,$54,$4C,$CF        ;;    |AB31+AB0F/AB31\AB31;
                      db $41,$54,$53,$53,$4E,$4D,$1B,$1F        ;;    |AB39+AB17/AB39\AB39;
                      db $1F,$14,$52,$44,$1F,$14,$4F,$1F        ;;    |AB41+AB1F/AB41\AB41;
                      db $4E,$CD,$53,$47,$44,$1F,$02,$4E        ;;    |AB49+AB27/AB49\AB49;
                      db $4D,$53,$51,$4E,$4B,$1F,$0F,$40        ;;    |AB51+AB2F/AB51\AB51;
                      db $43,$1F,$53,$CE,$49,$54,$4C,$4F        ;;    |AB59+AB37/AB59\AB59;
                      db $1F,$47,$48,$46,$47,$1F,$1F,$48        ;;    |AB61+AB3F/AB61\AB61;
                      db $4D,$1F,$1F,$53,$47,$C4,$52,$47        ;;    |AB69+AB47/AB69\AB69;
                      db $40,$4B,$4B,$4E,$56,$1F,$56,$40        ;;    |AB71+AB4F/AB71\AB71;
                      db $53,$44,$51,$9B                        ;;    |AB79+AB57/AB79\AB79;
StartSelectMessage:   db $08,$45,$1F,$1F                        ;;    |AB7D+AB5B/AB7D\AB7D;
                      db $58,$4E,$54,$1F,$40,$51,$44,$1F        ;;    |AB81+AB5F/AB81\AB81;
                      db $1F,$48,$4D,$1F,$40,$CD,$40,$51        ;;    |AB89+AB67/AB89\AB89;
                      db $44,$40,$1F,$53,$47,$40,$53,$1F        ;;    |AB91+AB6F/AB91\AB91;
                      db $58,$4E,$54,$1F,$47,$40,$55,$C4        ;;    |AB99+AB77/AB99\AB99;
                      db $40,$4B,$51,$44,$40,$43,$58,$1F        ;;    |ABA1+AB7F/ABA1\ABA1;
                      db $1F,$1F,$42,$4B,$44,$40,$51,$44        ;;    |ABA9+AB87/ABA9\ABA9;
                      db $43,$9D,$58,$4E,$54,$1F,$42,$40        ;;    |ABB1+AB8F/ABB1\ABB1;
                      db $4D,$1F,$1F,$51,$44,$53,$54,$51        ;;    |ABB9+AB97/ABB9\ABB9;
                      db $4D,$1F,$53,$CE,$53,$47,$44,$1F        ;;    |ABC1+AB9F/ABC1\ABC1;
                      db $4C,$40,$4F,$1F,$52,$42,$51,$44        ;;    |ABC9+ABA7/ABC9\ABC9;
                      db $44,$4D,$1F,$1F,$41,$D8,$4F,$51        ;;    |ABD1+ABAF/ABD1\ABD1;
                      db $44,$52,$52,$48,$4D,$46,$1F,$1F        ;;    |ABD9+ABB7/ABD9\ABD9;
                      db $1F,$1F,$12,$13,$00,$11,$13,$9D        ;;    |ABE1+ABBF/ABE1\ABE1;
                      db $53,$47,$44,$4D,$1F,$12,$04,$0B        ;;    |ABE9+ABC7/ABE9\ABE9;
                      db $04,$02,$13,$9B,$9F                    ;;    |ABF1+ABCF/ABF1\ABF1;
BonusStarsMessage:    db $18,$4E,$54                            ;;    |ABF6+ABD4/ABF6\ABF6;
                      db $1F,$1F,$1F,$46,$44,$53,$1F,$1F        ;;    |ABF9+ABD7/ABF9\ABF9;
                      db $1F,$1F,$01,$4E,$4D,$54,$D2,$12        ;;    |AC01+ABDF/AC01\AC01;
                      db $53,$40,$51,$52,$1F,$1F,$48,$45        ;;    |AC09+ABE7/AC09\AC09;
                      db $1F,$1F,$58,$4E,$54,$1F,$42,$54        ;;    |AC11+ABEF/AC11\AC11;
                      db $D3,$53,$47,$44,$1F,$1F,$53,$40        ;;    |AC19+ABF7/AC19\AC19;
                      db $4F,$44,$1F,$1F,$40,$53,$1F,$1F        ;;    |AC21+ABFF/AC21\AC21;
                      db $53,$47,$C4,$44,$4D,$43,$1F,$1F        ;;    |AC29+AC07/AC29\AC29;
                      db $4E,$45,$1F,$44,$40,$42,$47,$1F        ;;    |AC31+AC0F/AC31\AC31;
                      db $40,$51,$44,$40,$9B,$08,$45,$1F        ;;    |AC39+AC17/AC39\AC39;
                      db $58,$4E,$54,$1F,$42,$4E,$4B,$4B        ;;    |AC41+AC1F/AC41\AC41;
                      db $44,$42,$53,$1F,$64,$6B,$EB,$01        ;;    |AC49+AC27/AC49\AC49;
                      db $4E,$4D,$54,$52,$1F,$1F,$12,$53        ;;    |AC51+AC2F/AC51\AC51;
                      db $40,$51,$52,$1F,$1F,$1F,$58,$4E        ;;    |AC59+AC37/AC59\AC59;
                      db $D4,$42,$40,$4D,$1F,$1F,$1F,$4F        ;;    |AC61+AC3F/AC61\AC61;
                      db $4B,$40,$58,$1F,$1F,$40,$1F,$1F        ;;    |AC69+AC47/AC69\AC69;
                      db $45,$54,$CD,$41,$4E,$4D,$54,$52        ;;    |AC71+AC4F/AC71\AC71;
                      db $1F,$46,$40,$4C,$44,$9B                ;;    |AC79+AC57/AC79\AC79;
ClimbDoorMessage:     db $0F,$51                                ;;    |AC7F+AC5D/AC7F\AC7F;
                      db $44,$52,$52,$1F,$14,$4F,$1F,$1F        ;;    |AC81+AC5F/AC81\AC81;
                      db $1F,$4E,$4D,$1F,$1F,$53,$47,$C4        ;;    |AC89+AC67/AC89\AC89;
                      db $02,$4E,$4D,$53,$51,$4E,$4B,$1F        ;;    |AC91+AC6F/AC91\AC91;
                      db $0F,$40,$43,$1F,$1F,$56,$47,$48        ;;    |AC99+AC77/AC99\AC99;
                      db $4B,$C4,$49,$54,$4C,$4F,$48,$4D        ;;    |ACA1+AC7F/ACA1\ACA1;
                      db $46,$1F,$1F,$1F,$40,$4D,$43,$1F        ;;    |ACA9+AC87/ACA9\ACA9;
                      db $1F,$58,$4E,$D4,$42,$40,$4D,$1F        ;;    |ACB1+AC8F/ACB1\ACB1;
                      db $1F,$42,$4B,$48,$4D,$46,$1F,$1F        ;;    |ACB9+AC97/ACB9\ACB9;
                      db $53,$4E,$1F,$53,$47,$C4,$45,$44        ;;    |ACC1+AC9F/ACC1\ACC1;
                      db $4D,$42,$44,$1B,$1F,$1F,$1F,$1F        ;;    |ACC9+ACA7/ACC9\ACC9;
                      db $13,$4E,$1F,$46,$4E,$1F,$48,$CD        ;;    |ACD1+ACAF/ACD1\ACD1;
                      db $53,$47,$44,$1F,$1F,$43,$4E,$4E        ;;    |ACD9+ACB7/ACD9\ACD9;
                      db $51,$1F,$1F,$40,$53,$1F,$1F,$53        ;;    |ACE1+ACBF/ACE1\ACE1;
                      db $47,$C4,$44,$4D,$43,$1F,$1F,$4E        ;;    |ACE9+ACC7/ACE9\ACE9;
                      db $45,$1F,$53,$47,$48,$52,$1F,$40        ;;    |ACF1+ACCF/ACF1\ACF1;
                      db $51,$44,$40,$9D,$54,$52,$44,$1F        ;;    |ACF9+ACD7/ACF9\ACF9;
                      db $14,$4F,$1F,$40,$4B,$52,$4E,$9B        ;;    |AD01+ACDF/AD01\AD01;
IggyKoopaMessage:     db $1C,$0F,$0E,$08,$0D,$13,$1F,$0E        ;;    |AD09+ACE7/AD09\AD09;
                      db $05,$1F,$00,$03,$15,$08,$02,$04        ;;    |AD11+ACEF/AD11\AD11;
                      db $9C,$0E,$4D,$44,$1F,$1F,$1F,$4E        ;;    |AD19+ACF7/AD19\AD19;
                      db $45,$1F,$1F,$1F,$18,$4E,$52,$47        ;;    |AD21+ACFF/AD21\AD21;
                      db $48,$5D,$D2,$45,$51,$48,$44,$4D        ;;    |AD29+AD07/AD29\AD29;
                      db $43,$52,$1F,$48,$52,$1F,$53,$51        ;;    |AD31+AD0F/AD31\AD31;
                      db $40,$4F,$4F,$44,$C3,$48,$4D,$1F        ;;    |AD39+AD17/AD39\AD39;
                      db $1F,$53,$47,$44,$1F,$42,$40,$52        ;;    |AD41+AD1F/AD41\AD41;
                      db $53,$4B,$44,$1F,$1F,$41,$D8,$08        ;;    |AD49+AD27/AD49\AD49;
                      db $46,$46,$58,$1F,$0A,$4E,$4E,$4F        ;;    |AD51+AD2F/AD51\AD51;
                      db $40,$1B,$1F,$1F,$1F,$1F,$1F,$13        ;;    |AD59+AD37/AD59\AD59;
                      db $CE,$43,$44,$45,$44,$40,$53,$1F        ;;    |AD61+AD3F/AD61\AD61;
                      db $1F,$47,$48,$4C,$1D,$1F,$1F,$4F        ;;    |AD69+AD47/AD69\AD69;
                      db $54,$52,$C7,$47,$48,$4C,$1F,$48        ;;    |AD71+AD4F/AD71\AD71;
                      db $4D,$53,$4E,$1F,$1F,$53,$47,$44        ;;    |AD79+AD57/AD79\AD79;
                      db $1F,$4B,$40,$55,$C0,$4F,$4E,$4E        ;;    |AD81+AD5F/AD81\AD81;
                      db $4B,$9B                                ;;    |AD89+AD67/AD89\AD89;
CapeMarioMessage:     db $14,$52,$44,$1F,$1F,$0C                ;;    |AD8B+AD69/AD8B\AD8B;
                      db $40,$51,$48,$4E,$5D,$52,$1F,$1F        ;;    |AD91+AD6F/AD91\AD91;
                      db $42,$40,$4F,$C4,$53,$4E,$1F,$1F        ;;    |AD99+AD77/AD99\AD99;
                      db $1F,$52,$4E,$40,$51,$1F,$1F,$53        ;;    |ADA1+AD7F/ADA1\ADA1;
                      db $47,$51,$4E,$54,$46,$C7,$53,$47        ;;    |ADA9+AD87/ADA9\ADA9;
                      db $44,$1F,$40,$48,$51,$1A,$1F,$11        ;;    |ADB1+AD8F/ADB1\ADB1;
                      db $54,$4D,$1F,$45,$40,$52,$53,$9D        ;;    |ADB9+AD97/ADB9\ADB9;
                      db $49,$54,$4C,$4F,$1D,$1F,$40,$4D        ;;    |ADC1+AD9F/ADC1\ADC1;
                      db $43,$1F,$47,$4E,$4B,$43,$1F,$53        ;;    |ADC9+ADA7/ADC9\ADC9;
                      db $47,$C4,$18,$1F,$01,$54,$53,$53        ;;    |ADD1+ADAF/ADD1\ADD1;
                      db $4E,$4D,$1B,$1F,$1F,$13,$4E,$1F        ;;    |ADD9+ADB7/ADD9\ADD9;
                      db $4A,$44,$44,$CF,$41,$40,$4B,$40        ;;    |ADE1+ADBF/ADE1\ADE1;
                      db $4D,$42,$44,$1D,$1F,$1F,$54,$52        ;;    |ADE9+ADC7/ADE9\ADE9;
                      db $44,$1F,$4B,$44,$45,$D3,$40,$4D        ;;    |ADF1+ADCF/ADF1\ADF1;
                      db $43,$1F,$1F,$51,$48,$46,$47,$53        ;;    |ADF9+ADD7/ADF9\ADF9;
                      db $1F,$1F,$4E,$4D,$1F,$53,$47,$C4        ;;    |AE01+ADDF/AE01\AE01;
                      db $02,$4E,$4D,$53,$51,$4E,$4B,$1F        ;;    |AE09+ADE7/AE09\AE09;
                      db $0F,$40,$43,$9B                        ;;    |AE11+ADEF/AE11\AE11;
SecretExitMessage:    db $13,$47,$44,$1F                        ;;    |AE15+ADF3/AE15\AE15;
                      db $51,$44,$43,$1F,$43,$4E,$53,$1F        ;;    |AE19+ADF7/AE19\AE19;
                      db $1F,$40,$51,$44,$40,$D2,$4E,$4D        ;;    |AE21+ADFF/AE21\AE21;
                      db $1F,$1F,$53,$47,$44,$1F,$1F,$4C        ;;    |AE29+AE07/AE29\AE29;
                      db $40,$4F,$1F,$1F,$47,$40,$55,$C4        ;;    |AE31+AE0F/AE31\AE31;
                      db $53,$56,$4E,$1F,$1F,$1F,$1F,$1F        ;;    |AE39+AE17/AE39\AE39;
                      db $1F,$43,$48,$45,$45,$44,$51,$44        ;;    |AE41+AE1F/AE41\AE41;
                      db $4D,$D3,$44,$57,$48,$53,$52,$1B        ;;    |AE49+AE27/AE49\AE49;
                      db $1F,$1F,$1F,$1F,$1F,$1F,$08,$45        ;;    |AE51+AE2F/AE51\AE51;
                      db $1F,$58,$4E,$D4,$47,$40,$55,$44        ;;    |AE59+AE37/AE59\AE59;
                      db $1F,$1F,$53,$47,$44,$1F,$53,$48        ;;    |AE61+AE3F/AE61\AE61;
                      db $4C,$44,$1F,$40,$4D,$C3,$52,$4A        ;;    |AE69+AE47/AE69\AE69;
                      db $48,$4B,$4B,$1D,$1F,$1F,$41,$44        ;;    |AE71+AE4F/AE71\AE71;
                      db $1F,$52,$54,$51,$44,$1F,$53,$CE        ;;    |AE79+AE57/AE79\AE79;
                      db $4B,$4E,$4E,$4A,$1F,$45,$4E,$51        ;;    |AE81+AE5F/AE81\AE81;
                      db $1F,$53,$47,$44,$4C,$9B,$9F            ;;    |AE89+AE67/AE89\AE89;
GhostHouseMessage:    db $13                                    ;;    |AE90+AE6E/AE90\AE90;
                      db $47,$48,$52,$1F,$1F,$48,$52,$1F        ;;    |AE91+AE6F/AE91\AE91;
                      db $1F,$40,$1F,$1F,$06,$47,$4E,$52        ;;    |AE99+AE77/AE99\AE99;
                      db $D3,$07,$4E,$54,$52,$44,$1B,$1F        ;;    |AEA1+AE7F/AEA1\AEA1;
                      db $1F,$1F,$1F,$1F,$02,$40,$4D,$1F        ;;    |AEA9+AE87/AEA9\AEA9;
                      db $58,$4E,$D4,$45,$48,$4D,$43,$1F        ;;    |AEB1+AE8F/AEB1\AEB1;
                      db $1F,$1F,$53,$47,$44,$1F,$1F,$1F        ;;    |AEB9+AE97/AEB9\AEB9;
                      db $44,$57,$48,$53,$9E,$07,$44,$44        ;;    |AEC1+AE9F/AEC1\AEC1;
                      db $1D,$1F,$1F,$47,$44,$44,$1D,$1F        ;;    |AEC9+AEA7/AEC9\AEC9;
                      db $1F,$47,$44,$44,$1B,$1B,$9B,$03        ;;    |AED1+AEAF/AED1\AED1;
                      db $4E,$4D,$5D,$53,$1F,$46,$44,$53        ;;    |AED9+AEB7/AED9\AED9;
                      db $1F,$4B,$4E,$52,$53,$9A,$9F,$9F        ;;    |AEE1+AEBF/AEE1\AEE1;
                      db $9F                                    ;;    |AEE9+AEC7/AEE9\AEE9;
ScreenScrollMessage:  db $18,$4E,$54,$1F,$42,$40,$4D            ;;    |AEEA+AEC8/AEEA\AEEA;
                      db $1F,$1F,$52,$4B,$48,$43,$44,$1F        ;;    |AEF1+AECF/AEF1\AEF1;
                      db $53,$47,$C4,$52,$42,$51,$44,$44        ;;    |AEF9+AED7/AEF9\AEF9;
                      db $4D,$1F,$1F,$1F,$4B,$44,$45,$53        ;;    |AF01+AEDF/AF01\AF01;
                      db $1F,$1F,$1F,$4E,$D1,$51,$48,$46        ;;    |AF09+AEE7/AF09\AF09;
                      db $47,$53,$1F,$1F,$41,$58,$1F,$4F        ;;    |AF11+AEEF/AF11\AF11;
                      db $51,$44,$52,$52,$48,$4D,$C6,$53        ;;    |AF19+AEF7/AF19\AF19;
                      db $47,$44,$1F,$0B,$1F,$4E,$51,$1F        ;;    |AF21+AEFF/AF21\AF21;
                      db $11,$1F,$01,$54,$53,$53,$4E,$4D        ;;    |AF29+AF07/AF29\AF29;
                      db $D2,$4E,$4D,$1F,$1F,$1F,$53,$4E        ;;    |AF31+AF0F/AF31\AF31;
                      db $4F,$1F,$1F,$1F,$4E,$45,$1F,$1F        ;;    |AF39+AF17/AF39\AF39;
                      db $53,$47,$C4,$42,$4E,$4D,$53,$51        ;;    |AF41+AF1F/AF41\AF41;
                      db $4E,$4B,$4B,$44,$51,$1B,$1F,$1F        ;;    |AF49+AF27/AF49\AF49;
                      db $1F,$1F,$18,$4E,$D4,$4C,$40,$58        ;;    |AF51+AF2F/AF51\AF51;
                      db $1F,$41,$44,$1F,$40,$41,$4B,$44        ;;    |AF59+AF37/AF59\AF59;
                      db $1F,$53,$4E,$1F,$52,$44,$C4,$45        ;;    |AF61+AF3F/AF61\AF61;
                      db $54,$51,$53,$47,$44,$51,$1F,$40        ;;    |AF69+AF47/AF69\AF69;
                      db $47,$44,$40,$43,$9B                    ;;    |AF71+AF4F/AF71\AF71;
StarWorldMessage:     db $13,$47,$44                            ;;    |AF76+AF54/AF76\AF76;
                      db $51,$44,$1F,$1F,$1F,$40,$51,$44        ;;    |AF79+AF57/AF79\AF79;
                      db $1F,$1F,$1F,$45,$48,$55,$C4,$44        ;;    |AF81+AF5F/AF81\AF81;
                      db $4D,$53,$51,$40,$4D,$42,$44,$52        ;;    |AF89+AF67/AF89\AF89;
                      db $1F,$1F,$53,$4E,$1F,$1F,$53,$47        ;;    |AF91+AF6F/AF91\AF91;
                      db $C4,$12,$53,$40,$51,$1F,$1F,$1F        ;;    |AF99+AF77/AF99\AF99;
                      db $16,$4E,$51,$4B,$43,$1F,$1F,$1F        ;;    |AFA1+AF7F/AFA1\AFA1;
                      db $1F,$48,$CD,$03,$48,$4D,$4E,$52        ;;    |AFA9+AF87/AFA9\AFA9;
                      db $40,$54,$51,$1F,$1F,$1F,$1F,$1F        ;;    |AFB1+AF8F/AFB1\AFB1;
                      db $0B,$40,$4D,$43,$9B,$05,$48,$4D        ;;    |AFB9+AF97/AFB9\AFB9;
                      db $43,$1F,$1F,$53,$47,$44,$4C,$1F        ;;    |AFC1+AF9F/AFC1\AFC1;
                      db $40,$4B,$4B,$1F,$40,$4D,$C3,$58        ;;    |AFC9+AFA7/AFC9\AFC9;
                      db $4E,$54,$1F,$1F,$1F,$42,$40,$4D        ;;    |AFD1+AFAF/AFD1\AFD1;
                      db $1F,$1F,$1F,$53,$51,$40,$55,$44        ;;    |AFD9+AFB7/AFD9\AFD9;
                      db $CB,$41,$44,$53,$56,$44,$44,$4D        ;;    |AFE1+AFBF/AFE1\AFE1;
                      db $1F,$1F,$1F,$1F,$1F,$1F,$1F,$4C        ;;    |AFE9+AFC7/AFE9\AFE9;
                      db $40,$4D,$D8,$43,$48,$45,$45,$44        ;;    |AFF1+AFCF/AFF1\AFF1;
                      db $51,$44,$4D,$53,$1F,$4F,$4B,$40        ;;    |AFF9+AFD7/AFF9\AFF9;
                      db $42,$44,$52,$9B                        ;;    |B001+AFDF/B001\B001;
CI2Message:           db $07,$44,$51,$44                        ;;    |B005+AFE3/B005\B005;
                      db $1D,$1F,$1F,$1F,$53,$47,$44,$1F        ;;    |B009+AFE7/B009\B009;
                      db $1F,$42,$4E,$48,$4D,$D2,$58,$4E        ;;    |B011+AFEF/B011\B011;
                      db $54,$1F,$1F,$1F,$42,$4E,$4B,$4B        ;;    |B019+AFF7/B019\B019;
                      db $44,$42,$53,$1F,$1F,$1F,$4E,$D1        ;;    |B021+AFFF/B021\B021;
                      db $53,$47,$44,$1F,$53,$48,$4C,$44        ;;    |B029+B007/B029\B029;
                      db $1F,$51,$44,$4C,$40,$48,$4D,$48        ;;    |B031+B00F/B031\B031;
                      db $4D,$C6,$42,$40,$4D,$1F,$1F,$42        ;;    |B039+B017/B039\B039;
                      db $47,$40,$4D,$46,$44,$1F,$1F,$1F        ;;    |B041+B01F/B041\B041;
                      db $58,$4E,$54,$D1,$4F,$51,$4E,$46        ;;    |B049+B027/B049\B049;
                      db $51,$44,$52,$52,$1B,$1F,$1F,$02        ;;    |B051+B02F/B051\B051;
                      db $40,$4D,$1F,$58,$4E,$D4,$45,$48        ;;    |B059+B037/B059\B059;
                      db $4D,$43,$1F,$1F,$53,$47,$44,$1F        ;;    |B061+B03F/B061\B061;
                      db $1F,$52,$4F,$44,$42,$48,$40,$CB        ;;    |B069+B047/B069\B069;
                      db $46,$4E,$40,$4B,$9E,$9F                ;;    |B071+B04F/B071\B071;
SpecialWorldMessage:  db $00,$4C                                ;;    |B077+B055/B077\B077;
                      db $40,$59,$48,$4D,$46,$1A,$1F,$1F        ;;    |B079+B057/B079\B079;
                      db $05,$44,$56,$1F,$47,$40,$55,$C4        ;;    |B081+B05F/B081\B081;
                      db $4C,$40,$43,$44,$1F,$48,$53,$1F        ;;    |B089+B067/B089\B089;
                      db $1F,$53,$47,$48,$52,$1F,$45,$40        ;;    |B091+B06F/B091\B091;
                      db $51,$9B,$01,$44,$58,$4E,$4D,$43        ;;    |B099+B077/B099\B099;
                      db $1F,$1F,$4B,$48,$44,$52,$1F,$1F        ;;    |B0A1+B07F/B0A1\B0A1;
                      db $1F,$53,$47,$C4,$12,$4F,$44,$42        ;;    |B0A9+B087/B0A9\B0A9;
                      db $48,$40,$4B,$1F,$1F,$1F,$1F,$1F        ;;    |B0B1+B08F/B0B1\B0B1;
                      db $1F,$19,$4E,$4D,$44,$9B,$02,$4E        ;;    |B0B9+B097/B0B9\B0B9;
                      db $4C,$4F,$4B,$44,$53,$44,$1F,$1F        ;;    |B0C1+B09F/B0C1\B0C1;
                      db $48,$53,$1F,$1F,$1F,$40,$4D,$C3        ;;    |B0C9+B0A7/B0C9\B0C9;
                      db $58,$4E,$54,$1F,$42,$40,$4D,$1F        ;;    |B0D1+B0AF/B0D1\B0D1;
                      db $44,$57,$4F,$4B,$4E,$51,$44,$1F        ;;    |B0D9+B0B7/B0D9\B0D9;
                      db $1F,$C0,$52,$53,$51,$40,$4D,$46        ;;    |B0E1+B0BF/B0E1\B0E1;
                      db $44,$1F,$4D,$44,$56,$1F,$56,$4E        ;;    |B0E9+B0C7/B0E9\B0E9;
                      db $51,$4B,$43,$9B,$06,$0E,$0E,$03        ;;    |B0F1+B0CF/B0F1\B0F1;
                      db $1F,$0B,$14,$02,$0A,$9A                ;;    |B0F9+B0D7/B0F9\B0F9;
                   endif                              ;/ ENDIF  ;;++++++++++++++++++++++++;
                                                                ;;                        ;
                   if ver_is_japanese(!_VER)          ;\   IF   ;;++++++++++++++++++++++++; J
ClearMessageStripe:   db $50,$A7,$41,$E2,$FC,$38,$FF            ;;ACA8                    ;
                   else                               ;<  ELSE  ;;------------------------; U, SS, E0, & E1
ClearMessageStripe:   db $50,$C7,$41,$E2,$FC,$38,$FF            ;;    |B0FF+B0DD/B0FF\B0FF;
                   endif                              ;/ ENDIF  ;;++++++++++++++++++++++++;
                                                                ;;                        ;
DATA_05B106:          db $4C,$50                                ;;ACAF|B106+B0E4/B106\B106;
                                                                ;;                        ;
DATA_05B108:          db $50,$00                                ;;ACB1|B108+B0E6/B108\B108;
                                                                ;;                        ;
DATA_05B10A:          db $04,$FC                                ;;ACB3|B10A+B0E8/B10A\B10A;
                                                                ;;                        ;
CODE_05B10C:          PHB                                       ;;ACB5|B10C+B0EA/B10C\B10C; Accum (8 bit)
                      PHK                                       ;;ACB6|B10D+B0EB/B10D\B10D;
                      PLB                                       ;;ACB7|B10E+B0EC/B10E\B10E;
                      LDX.W !MessageBoxExpand                   ;;ACB8|B10F+B0ED/B10F\B10F;
                      LDA.W !MessageBoxTimer                    ;;ACBB|B112+B0F0/B112\B112;
                      CMP.W DATA_05B108,X                       ;;ACBE|B115+B0F3/B115\B115;
                      BNE CODE_05B191                           ;;ACC1|B118+B0F6/B118\B118;
                      TXA                                       ;;ACC3|B11A+B0F8/B11A\B11A;
                      BEQ CODE_05B132                           ;;ACC4|B11B+B0F9/B11B\B11B;
                      STZ.W !MessageBoxTrigger                  ;;ACC6|B11D+B0FB/B11D\B11D;
                      STZ.W !MessageBoxExpand                   ;;ACC9|B120+B0FE/B120\B120;
                      STZ.B !Layer12Window                      ;;ACCC|B123+B101/B123\B123;
                      STZ.B !Layer34Window                      ;;ACCE|B125+B103/B125\B125;
                      STZ.B !OBJCWWindow                        ;;ACD0|B127+B105/B127\B127;
                      STZ.W !HDMAEnable                         ;;ACD2|B129+B107/B129\B129;
                      LDA.B #$02                                ;;ACD5|B12C+B10A/B12C\B12C;
                      STA.B !ColorAddition                      ;;ACD7|B12E+B10C/B12E\B12E;
                      BRA CODE_05B18E                           ;;ACD9|B130+B10E/B130\B130;
                                                                ;;                        ;
CODE_05B132:          LDA.W !OverworldOverride                  ;;ACDB|B132+B110/B132\B132;
                      ORA.W !SwitchPalaceColor                  ;;ACDE|B135+B113/B135\B135;
                      BEQ CODE_05B16E                           ;;ACE1|B138+B116/B138\B138;
                   if ver_is_japanese(!_VER)          ;\   IF   ;;++++++++++++++++++++++++; J
                      LDA.B !TrueFrame                          ;;ACE3                    ;
                      AND.B #$03                                ;;ACE5                    ;
                      BNE CODE_05B18E                           ;;ACE7                    ;
                      DEC.W !VariousPromptTimer                 ;;ACE9                    ;
                      BNE CODE_05B18E                           ;;ACEC                    ;
                      PLB                                       ;;ACEE                    ;
                      LDA.W !SwitchPalaceColor                  ;;ACEF                    ;
                      BEQ CODE_05B15B                           ;;ACF2                    ;
                      INC.W !CreditsScreenNumber                ;;ACF4                    ;
                      LDA.B #$01                                ;;ACF7                    ;
                      STA.W !MidwayFlag                         ;;ACF9                    ;
                      BRA +                                     ;;ACFC                    ;
                   else                               ;<  ELSE  ;;------------------------; U, SS, E0, & E1
                   if ver_is_console(!_VER)           ;\   IF   ;;++++++++++++++++++++++++; U, E0, & E1
                      LDA.W !VariousPromptTimer                 ;;    |B13A     /B13A\B13A;
                      BEQ CODE_05B16E                           ;;    |B13D     /B13D\B13D;
                      LDA.B !TrueFrame                          ;;    |B13F     /B13F\B13F;
                      AND.B #$03                                ;;    |B141     /B141\B141;
                      BNE CODE_05B18E                           ;;    |B143     /B143\B143;
                      DEC.W !VariousPromptTimer                 ;;    |B145     /B145\B145;
                      BNE CODE_05B18E                           ;;    |B148     /B148\B148;
                      LDA.W !SwitchPalaceColor                  ;;    |B14A     /B14A\B14A;
                      BEQ CODE_05B16E                           ;;    |B14D     /B14D\B14D;
                   else                               ;<  ELSE  ;;------------------------; SS
                      LDA.B !TrueFrame                          ;;         +B118          ;
                      AND.B #$03                                ;;         +B11A          ;
                      BNE CODE_05B16E                           ;;         +B11C          ;
                      DEC.W !VariousPromptTimer                 ;;         +B11E          ;
                      BNE CODE_05B16E                           ;;         +B121          ;
                      LDA.W !SwitchPalaceColor                  ;;         +B123          ;
                      BEQ CODE_05B15A                           ;;         +B126          ;
                   endif                              ;/ ENDIF  ;;++++++++++++++++++++++++;
CODE_05B14F:          PLB                                       ;;    |B14F+B128/B14F\B14F;
                      INC.W !CreditsScreenNumber                ;;    |B150+B129/B150\B150;
                      LDA.B #$01                                ;;    |B153+B12C/B153\B153;
                      STA.W !MidwayFlag                         ;;    |B155+B12E/B155\B155;
                      BRA +                                     ;;    |B158+B131/B158\B158;
CODE_05B15A:          PLB                                       ;;    |B15A+B133/B15A\B15A;
                   endif                              ;/ ENDIF  ;;++++++++++++++++++++++++;
CODE_05B15B:          LDA.B #$8E                                ;;ACFE|B15B+B134/B15B\B15B;
                      STA.W !OWPlayerYPos                       ;;AD00|B15D+B136/B15D\B15D;
SubSideExit:          STZ.W !OverworldOverride                  ;;AD03|B160+B139/B160\B160;
                      LDA.B #$00                                ;;AD06|B163+B13C/B163\B163;
                    + STA.W !OWLevelExitMode                    ;;AD08|B165+B13E/B165\B165;
                      LDA.B #$0B                                ;;AD0B|B168+B141/B168\B168;
                      STA.W !GameMode                           ;;AD0D|B16A+B143/B16A\B16A;
                      RTL                                       ;;AD10|B16D+B146/B16D\B16D; Return
                                                                ;;                        ;
CODE_05B16E:          LDA.B !byetudlrHold                       ;;AD11|B16E+B147/B16E\B16E; Index (8 bit)
                      AND.B #$F0                                ;;AD13|B170+B149/B170\B170;
                      BEQ CODE_05B18E                           ;;AD15|B172+B14B/B172\B172;
                      EOR.B !byetudlrFrame                      ;;AD17|B174+B14D/B174\B174;
                      AND.B #$F0                                ;;AD19|B176+B14F/B176\B176;
                      BEQ +                                     ;;AD1B|B178+B151/B178\B178;
                      LDA.B !axlr0000Hold                       ;;AD1D|B17A+B153/B17A\B17A;
                      AND.B #$C0                                ;;AD1F|B17C+B155/B17C\B17C;
                      BEQ CODE_05B18E                           ;;AD21|B17E+B157/B17E\B17E;
                      EOR.B !axlr0000Frame                      ;;AD23|B180+B159/B180\B180;
                      AND.B #$C0                                ;;AD25|B182+B15B/B182\B182;
                      BNE CODE_05B18E                           ;;AD27|B184+B15D/B184\B184;
                   if ver_is_arcade(!_VER)            ;\   IF   ;;++++++++++++++++++++++++; SS
                    + LDA.W !SwitchPalaceColor                  ;;         +B15F          ;
                      BNE CODE_05B14F                           ;;         +B162          ;
                   endif                              ;/ ENDIF  ;;++++++++++++++++++++++++;
                   if ver_is_english(!_VER)           ;\   IF   ;;++++++++++++++++++++++++; U, SS, E0, & E1
                    + LDA.W !OverworldOverride                  ;;    |B186+B164/B186\B186;
                      BNE CODE_05B15A                           ;;    |B189+B167/B189\B189;
                   endif                              ;/ ENDIF  ;;++++++++++++++++++++++++;
                    + INC.W !MessageBoxExpand                   ;;AD29|B18B+B169/B18B\B18B;
CODE_05B18E:          JMP CODE_05B299                           ;;AD2C|B18E+B16C/B18E\B18E;
                                                                ;;                        ;
CODE_05B191:          CMP.W DATA_05B106,X                       ;;AD2F|B191+B16F/B191\B191;
                      BNE CODE_05B1A0                           ;;AD32|B194+B172/B194\B194;
                      TXA                                       ;;AD34|B196+B174/B196\B196;
                      BEQ +                                     ;;AD35|B197+B175/B197\B197;
                      JSR CODE_05B31B                           ;;AD37|B199+B177/B199\B199;
                      LDA.B #$09                                ;;AD3A|B19C+B17A/B19C\B19C;
                      STA.B !StripeImage                        ;;AD3C|B19E+B17C/B19E\B19E;
CODE_05B1A0:          JMP CODE_05B250                           ;;AD3E|B1A0+B17E/B1A0\B1A0;
                                                                ;;                        ;
                    + LDX.B #$16                                ;;AD41|B1A3+B181/B1A3\B1A3;
CODE_05B1A5:          LDY.B #$01                                ;;AD43|B1A5+B183/B1A5\B1A5;
                      LDA.W DATA_05A590,X                       ;;AD45|B1A7+B185/B1A7\B1A7;
                      BPL +                                     ;;AD48|B1AA+B188/B1AA\B1AA;
                      INY                                       ;;AD4A|B1AC+B18A/B1AC\B1AC;
                      AND.B #$7F                                ;;AD4B|B1AD+B18B/B1AD\B1AD;
                    + CPY.W !MessageBoxTrigger                  ;;AD4D|B1AF+B18D/B1AF\B1AF;
                      BNE CODE_05B1B9                           ;;AD50|B1B2+B190/B1B2\B1B2;
                      CMP.W !TranslevelNo                       ;;AD52|B1B4+B192/B1B4\B1B4;
                      BEQ CODE_05B1BC                           ;;AD55|B1B7+B195/B1B7\B1B7;
CODE_05B1B9:          DEX                                       ;;AD57|B1B9+B197/B1B9\B1B9;
                      BNE CODE_05B1A5                           ;;AD58|B1BA+B198/B1BA\B1BA;
CODE_05B1BC:          LDY.W !MessageBoxTrigger                  ;;AD5A|B1BC+B19A/B1BC\B1BC;
                      CPY.B #$03                                ;;AD5D|B1BF+B19D/B1BF\B1BF;
                      BNE +                                     ;;AD5F|B1C1+B19F/B1C1\B1C1;
                      LDX.B #$18                                ;;AD61|B1C3+B1A1/B1C3\B1C3;
                    + CPX.B #$04                                ;;AD63|B1C5+B1A3/B1C5\B1C5;
                      BCS +                                     ;;AD65|B1C7+B1A5/B1C7\B1C7;
                      INX                                       ;;AD67|B1C9+B1A7/B1C9\B1C9;
                      STX.W !SwitchPalaceColor                  ;;AD68|B1CA+B1A8/B1CA\B1CA;
                      DEX                                       ;;AD6B|B1CD+B1AB/B1CD\B1CD;
                      JSR CODE_05B2EB                           ;;AD6C|B1CE+B1AC/B1CE\B1CE;
                    + CPX.B #$16                                ;;AD6F|B1D1+B1AF/B1D1\B1D1;
                      BNE +                                     ;;AD71|B1D3+B1B1/B1D3\B1D3;
                      LDA.W !PlayerRidingYoshi                  ;;AD73|B1D5+B1B3/B1D5\B1D5;
                      BEQ +                                     ;;AD76|B1D8+B1B6/B1D8\B1D8;
                      INX                                       ;;AD78|B1DA+B1B8/B1DA\B1DA;
                    + TXA                                       ;;AD79|B1DB+B1B9/B1DB\B1DB;
                      ASL A                                     ;;AD7A|B1DC+B1BA/B1DC\B1DC;
                      TAX                                       ;;AD7B|B1DD+B1BB/B1DD\B1DD;
                      REP #$20                                  ;;AD7C|B1DE+B1BC/B1DE\B1DE; Accum (16 bit)
                      LDA.W DATA_05A5A7,X                       ;;AD7E|B1E0+B1BE/B1E0\B1E0;
                      STA.B !_0                                 ;;AD81|B1E3+B1C1/B1E3\B1E3;
                      REP #$10                                  ;;AD83|B1E5+B1C3/B1E5\B1E5; Index (16 bit)
                      LDA.L !DynStripeImgSize                   ;;AD85|B1E7+B1C5/B1E7\B1E7;
                      TAX                                       ;;AD89|B1EB+B1C9/B1EB\B1EB;
                   if ver_is_japanese(!_VER)          ;\   IF   ;;++++++++++++++++++++++++; J
                      LDY.W #$0006                              ;;AD8A                    ;
CODE_05B1EF:          LDA.W DATA_05A580,Y                       ;;AD8D                    ;
                      STA.L !DynamicStripeImage,X               ;;AD90                    ;
                      XBA                                       ;;AD94                    ;
                      CLC                                       ;;AD95                    ;
                      ADC.W #$0020                              ;;AD96                    ;
                      XBA                                       ;;AD99                    ;
                      STA.L !DynamicStripeImage+$28,X           ;;AD9A                    ;
                      LDA.W #$2300                              ;;AD9E                    ;
                      STA.L !DynamicStripeImage+2,X             ;;ADA1                    ;
                      STA.L !DynamicStripeImage+$2A,X           ;;ADA5                    ;
                      PHY                                       ;;ADA9                    ;
                      SEP #$20                                  ;;ADAA                    ; Accum (8 bit)
                      LDA.B #$12                                ;;ADAC                    ;
                      STA.B !_2                                 ;;ADAE                    ;
                      LDY.B !_0                                 ;;ADB0                    ;
CODE_05B208:          LDA.W MessageBoxes,Y                      ;;ADB2                    ;
                      CMP.B #$59                                ;;ADB5                    ;
                      BEQ +                                     ;;ADB7                    ;
                      CMP.B #$5B                                ;;ADB9                    ;
                      BEQ +                                     ;;ADBB                    ;
                      DEY                                       ;;ADBD                    ;
                      LDA.B #$5D                                ;;ADBE                    ;
                    + STA.L !DynamicStripeImage+4,X             ;;ADC0                    ;
                      INY                                       ;;ADC4                    ;
                      LDA.W MessageBoxes,Y                      ;;ADC5                    ;
                      STA.L !DynamicStripeImage+$2C,X           ;;ADC8                    ;
                      LDA.B #$39                                ;;ADCC                    ;
                      STA.L !DynamicStripeImage+5,X             ;;ADCE                    ;
                      STA.L !DynamicStripeImage+$2D,X           ;;ADD2                    ;
                      INX                                       ;;ADD6                    ;
                      INX                                       ;;ADD7                    ;
                      INY                                       ;;ADD8                    ;
                      DEC.B !_2                                 ;;ADD9                    ;
                      BNE CODE_05B208                           ;;ADDB                    ;
                      STY.B !_0                                 ;;ADDD                    ;
                      REP #$20                                  ;;ADDF                    ;
                      TXA                                       ;;ADE1                    ;
                      CLC                                       ;;ADE2                    ;
                      ADC.W #$002C                              ;;ADE3                    ;
                      TAX                                       ;;ADE6                    ;
                   else                               ;<  ELSE  ;;------------------------; U, SS, E0, & E1
                      LDY.W #$000E                              ;;    |B1EC+B1CA/B1EC\B1EC;
CODE_05B1EF:          LDA.W DATA_05A580,Y                       ;;    |B1EF+B1CD/B1EF\B1EF;
                      STA.L !DynamicStripeImage,X               ;;    |B1F2+B1D0/B1F2\B1F2;
                      LDA.W #$2300                              ;;    |B1F6+B1D4/B1F6\B1F6;
                      STA.L !DynamicStripeImage+2,X             ;;    |B1F9+B1D7/B1F9\B1F9;
                      PHY                                       ;;    |B1FD+B1DB/B1FD\B1FD;
                      SEP #$20                                  ;;    |B1FE+B1DC/B1FE\B1FE; Accum (8 bit)
                      LDA.B #$12                                ;;    |B200+B1DE/B200\B200;
                      STA.B !_2                                 ;;    |B202+B1E0/B202\B202;
                      STZ.B !_3                                 ;;    |B204+B1E2/B204\B204;
                      LDY.B !_0                                 ;;    |B206+B1E4/B206\B206;
CODE_05B208:          LDA.B #$1F                                ;;    |B208+B1E6/B208\B208;
                      BIT.W !_3                                 ;;    |B20A+B1E8/B20A\B20A;
                      BMI +                                     ;;    |B20D+B1EB/B20D\B20D;
                      LDA.W MessageBoxes,Y                      ;;    |B20F+B1ED/B20F\B20F;
                      STA.W !_3                                 ;;    |B212+B1F0/B212\B212;
                      AND.B #$7F                                ;;    |B215+B1F3/B215\B215;
                      INY                                       ;;    |B217+B1F5/B217\B217;
                    + STA.L !DynamicStripeImage+4,X             ;;    |B218+B1F6/B218\B218;
                      LDA.B #$39                                ;;    |B21C+B1FA/B21C\B21C;
                      STA.L !DynamicStripeImage+5,X             ;;    |B21E+B1FC/B21E\B21E;
                      INX                                       ;;    |B222+B200/B222\B222;
                      INX                                       ;;    |B223+B201/B223\B223;
                      DEC.B !_2                                 ;;    |B224+B202/B224\B224;
                      BNE CODE_05B208                           ;;    |B226+B204/B226\B226;
                      STY.B !_0                                 ;;    |B228+B206/B228\B228;
                      REP #$20                                  ;;    |B22A+B208/B22A\B22A; Accum (16 bit)
                      INX                                       ;;    |B22C+B20A/B22C\B22C;
                      INX                                       ;;    |B22D+B20B/B22D\B22D;
                      INX                                       ;;    |B22E+B20C/B22E\B22E;
                      INX                                       ;;    |B22F+B20D/B22F\B22F;
                   endif                              ;/ ENDIF  ;;++++++++++++++++++++++++;
                      PLY                                       ;;ADE7|B230+B20E/B230\B230;
                      DEY                                       ;;ADE8|B231+B20F/B231\B231;
                      DEY                                       ;;ADE9|B232+B210/B232\B232;
                      BPL CODE_05B1EF                           ;;ADEA|B233+B211/B233\B233;
                      LDA.W #$00FF                              ;;ADEC|B235+B213/B235\B235;
                      STA.L !DynamicStripeImage,X               ;;ADEF|B238+B216/B238\B238;
                      TXA                                       ;;ADF3|B23C+B21A/B23C\B23C;
                      STA.L !DynStripeImgSize                   ;;ADF4|B23D+B21B/B23D\B23D;
                      SEP #$30                                  ;;ADF8|B241+B21F/B241\B241; Index (8 bit) Accum (8 bit)
                      LDA.B #$01                                ;;ADFA|B243+B221/B243\B243;
                      STA.W !Layer3ScrollType                   ;;ADFC|B245+B223/B245\B245;
                      STZ.B !Layer3XPos                         ;;ADFF|B248+B226/B248\B248;
                      STZ.B !Layer3XPos+1                       ;;AE01|B24A+B228/B24A\B24A;
                      STZ.B !Layer3YPos                         ;;AE03|B24C+B22A/B24C\B24C;
                      STZ.B !Layer3YPos+1                       ;;AE05|B24E+B22C/B24E\B24E;
CODE_05B250:          LDX.W !MessageBoxExpand                   ;;AE07|B250+B22E/B250\B250;
                      LDA.W !MessageBoxTimer                    ;;AE0A|B253+B231/B253\B253;
                      CLC                                       ;;AE0D|B256+B234/B256\B256;
                      ADC.W DATA_05B10A,X                       ;;AE0E|B257+B235/B257\B257;
                      STA.W !MessageBoxTimer                    ;;AE11|B25A+B238/B25A\B25A;
                      CLC                                       ;;AE14|B25D+B23B/B25D\B25D;
                      ADC.B #$80                                ;;AE15|B25E+B23C/B25E\B25E;
                      XBA                                       ;;AE17|B260+B23E/B260\B260;
                      LDA.B #$80                                ;;AE18|B261+B23F/B261\B261;
                      SEC                                       ;;AE1A|B263+B241/B263\B263;
                      SBC.W !MessageBoxTimer                    ;;AE1B|B264+B242/B264\B264;
                      REP #$20                                  ;;AE1E|B267+B245/B267\B267; Accum (16 bit)
                      LDX.B #$00                                ;;AE20|B269+B247/B269\B269;
                      LDY.B #$50                                ;;AE22|B26B+B249/B26B\B26B;
CODE_05B26D:          CPX.W !MessageBoxTimer                    ;;AE24|B26D+B24B/B26D\B26D;
                      BCC +                                     ;;AE27|B270+B24E/B270\B270;
                      LDA.W #$00FF                              ;;AE29|B272+B250/B272\B272;
                    + STA.W !WindowTable+$4C,Y                  ;;AE2C|B275+B253/B275\B275;
                      STA.W !WindowTable+$9C,X                  ;;AE2F|B278+B256/B278\B278;
                      INX                                       ;;AE32|B27B+B259/B27B\B27B;
                      INX                                       ;;AE33|B27C+B25A/B27C\B27C;
                      DEY                                       ;;AE34|B27D+B25B/B27D\B27D;
                      DEY                                       ;;AE35|B27E+B25C/B27E\B27E;
                      BNE CODE_05B26D                           ;;AE36|B27F+B25D/B27F\B27F;
                      SEP #$20                                  ;;AE38|B281+B25F/B281\B281; Accum (8 bit)
                      LDA.B #$22                                ;;AE3A|B283+B261/B283\B283;
                      STA.B !Layer12Window                      ;;AE3C|B285+B263/B285\B285;
                      LDY.W !SwitchPalaceColor                  ;;AE3E|B287+B265/B287\B287;
                      BEQ +                                     ;;AE41|B28A+B268/B28A\B28A;
                      LDA.B #$20                                ;;AE43|B28C+B26A/B28C\B28C;
                    + STA.B !OBJCWWindow                        ;;AE45|B28E+B26C/B28E\B28E;
                      LDA.B #$22                                ;;AE47|B290+B26E/B290\B290;
                      STA.B !ColorAddition                      ;;AE49|B292+B270/B292\B292;
                      LDA.B #$80                                ;;AE4B|B294+B272/B294\B294;
                      STA.W !HDMAEnable                         ;;AE4D|B296+B274/B296\B296;
CODE_05B299:          PLB                                       ;;AE50|B299+B277/B299\B299;
                      RTL                                       ;;AE51|B29A+B278/B29A\B29A; Return
                                                                ;;                        ;
                                                                ;;                        ;
DATA_05B29B:          db $AD,$35,$AD,$75,$AD,$B5,$AD,$F5        ;;AE52|B29B+B279/B29B\B29B;
                      db $A7,$35,$A7,$75,$B7,$35,$B7,$75        ;;AE5A|B2A3+B281/B2A3\B2A3;
                      db $BD,$37,$BD,$77,$BD,$B7,$BD,$F7        ;;AE62|B2AB+B289/B2AB\B2AB;
                      db $A7,$37,$A7,$77,$B7,$37,$B7,$77        ;;AE6A|B2B3+B291/B2B3\B2B3;
                      db $AD,$39,$AD,$79,$AD,$B9,$AD,$F9        ;;AE72|B2BB+B299/B2BB\B2BB;
                      db $A7,$39,$A7,$79,$B7,$39,$B7,$79        ;;AE7A|B2C3+B2A1/B2C3\B2C3;
                      db $BD,$3B,$BD,$7B,$BD,$BB,$BD,$FB        ;;AE82|B2CB+B2A9/B2CB\B2CB;
                      db $A7,$3B,$A7,$7B,$B7,$3B,$B7,$7B        ;;AE8A|B2D3+B2B1/B2D3\B2D3;
                                                                ;;                        ;
                   if ver_is_japanese(!_VER)          ;\   IF   ;;++++++++++++++++++++++++; J
DATA_05B2DB:          db $38,$4B,$40,$4B,$38,$53,$40,$53        ;;AE92                    ;
                      db $60,$4B,$68,$4B,$60,$53,$68,$53        ;;AE9A                    ;
                   elseif ver_is_arcade(!_VER)        ;< ELSEIF ;;------------------------; SS
DATA_05B2DB:          db $50,$57,$58,$57,$50,$5F,$58,$5F        ;;         +B2B9          ;
                      db $92,$57,$9A,$57,$92,$5F,$9A,$5F        ;;         +B2C1          ;
                   else                               ;<  ELSE  ;;------------------------; U, E0, & E1
DATA_05B2DB:          db $50,$4F,$58,$4F,$50,$57,$58,$57        ;;    |B2DB     /B2DB\B2DB;
                      db $92,$4F,$9A,$4F,$92,$57,$9A,$57        ;;    |B2E3     /B2E3\B2E3;
                   endif                              ;/ ENDIF  ;;++++++++++++++++++++++++;
                                                                ;;                        ;
CODE_05B2EB:          PHX                                       ;;AEA2|B2EB+B2C9/B2EB\B2EB;
                      TXA                                       ;;AEA3|B2EC+B2CA/B2EC\B2EC;
                      ASL A                                     ;;AEA4|B2ED+B2CB/B2ED\B2ED;
                      ASL A                                     ;;AEA5|B2EE+B2CC/B2EE\B2EE;
                      ASL A                                     ;;AEA6|B2EF+B2CD/B2EF\B2EF;
                      ASL A                                     ;;AEA7|B2F0+B2CE/B2F0\B2F0;
                      TAX                                       ;;AEA8|B2F1+B2CF/B2F1\B2F1;
                      STZ.B !_0                                 ;;AEA9|B2F2+B2D0/B2F2\B2F2;
                      REP #$20                                  ;;AEAB|B2F4+B2D2/B2F4\B2F4; Accum (16 bit)
                      LDY.B #$1C                                ;;AEAD|B2F6+B2D4/B2F6\B2F6;
                    - LDA.W DATA_05B29B,X                       ;;AEAF|B2F8+B2D6/B2F8\B2F8;
                      STA.W !OAMTileNo,Y                        ;;AEB2|B2FB+B2D9/B2FB\B2FB;
                      PHX                                       ;;AEB5|B2FE+B2DC/B2FE\B2FE;
                      LDX.B !_0                                 ;;AEB6|B2FF+B2DD/B2FF\B2FF;
                      LDA.W DATA_05B2DB,X                       ;;AEB8|B301+B2DF/B301\B301;
                      STA.W !OAMTileXPos,Y                      ;;AEBB|B304+B2E2/B304\B304;
                      PLX                                       ;;AEBE|B307+B2E5/B307\B307;
                      INX                                       ;;AEBF|B308+B2E6/B308\B308;
                      INX                                       ;;AEC0|B309+B2E7/B309\B309;
                      INC.B !_0                                 ;;AEC1|B30A+B2E8/B30A\B30A;
                      INC.B !_0                                 ;;AEC3|B30C+B2EA/B30C\B30C;
                      DEY                                       ;;AEC5|B30E+B2EC/B30E\B30E;
                      DEY                                       ;;AEC6|B30F+B2ED/B30F\B30F;
                      DEY                                       ;;AEC7|B310+B2EE/B310\B310;
                      DEY                                       ;;AEC8|B311+B2EF/B311\B311;
                      BPL -                                     ;;AEC9|B312+B2F0/B312\B312;
                      STZ.W !OAMTileBitSize                     ;;AECB|B314+B2F2/B314\B314;
                      SEP #$20                                  ;;AECE|B317+B2F5/B317\B317; Accum (8 bit)
                      PLX                                       ;;AED0|B319+B2F7/B319\B319;
                      RTS                                       ;;AED1|B31A+B2F8/B31A\B31A; Return
                                                                ;;                        ;
CODE_05B31B:          LDY.B #$1C                                ;;AED2|B31B+B2F9/B31B\B31B;
                      LDA.B #$F0                                ;;AED4|B31D+B2FB/B31D\B31D;
                    - STA.W !OAMTileYPos,Y                      ;;AED6|B31F+B2FD/B31F\B31F;
                      DEY                                       ;;AED9|B322+B300/B322\B322;
                      DEY                                       ;;AEDA|B323+B301/B323\B323;
                      DEY                                       ;;AEDB|B324+B302/B324\B324;
                      DEY                                       ;;AEDC|B325+B303/B325\B325;
                      BPL -                                     ;;AEDD|B326+B304/B326\B326;
                      RTS                                       ;;AEDF|B328+B306/B328\B328; Return
                                                                ;;                        ;
GiveCoins:            PHA                                       ;;AEE0|B329+B307/B329\B329;
                      LDA.B #!SFX_COIN                          ;;AEE1|B32A+B308/B32A\B32A;
                      STA.W !SPCIO3                             ;;AEE3|B32C+B30A/B32C\B32C; / Play sound effect
                      PLA                                       ;;AEE6|B32F+B30D/B32F\B32F;
CODE_05B330:          STA.B !_0                                 ;;AEE7|B330+B30E/B330\B330;
                      CLC                                       ;;AEE9|B332+B310/B332\B332;
                      ADC.W !CoinAdder                          ;;AEEA|B333+B311/B333\B333;
                      STA.W !CoinAdder                          ;;AEED|B336+B314/B336\B336;
                      LDA.W !GreenStarBlockCoins                ;;AEF0|B339+B317/B339\B339;
                      BEQ Return05B35A                          ;;AEF3|B33C+B31A/B33C\B33C;
                      SEC                                       ;;AEF5|B33E+B31C/B33E\B33E;
                      SBC.B !_0                                 ;;AEF6|B33F+B31D/B33F\B33F;
                      BPL +                                     ;;AEF8|B341+B31F/B341\B341;
                      LDA.B #$00                                ;;AEFA|B343+B321/B343\B343;
                    + STA.W !GreenStarBlockCoins                ;;AEFC|B345+B323/B345\B345;
                      BRA Return05B35A                          ;;AEFF|B348+B326/B348\B348;
                                                                ;;                        ;
CODE_05B34A:          INC.W !CoinAdder                          ;;AF01|B34A+B328/B34A\B34A;
                      LDA.B #!SFX_COIN                          ;;AF04|B34D+B32B/B34D\B34D;
                      STA.W !SPCIO3                             ;;AF06|B34F+B32D/B34F\B34F; / Play sound effect
                      LDA.W !GreenStarBlockCoins                ;;AF09|B352+B330/B352\B352;
                      BEQ Return05B35A                          ;;AF0C|B355+B333/B355\B355;
                      DEC.W !GreenStarBlockCoins                ;;AF0E|B357+B335/B357\B357;
Return05B35A:         RTL                                       ;;AF11|B35A+B338/B35A\B35A; Return
                                                                ;;                        ;
                                                                ;;                        ;
DATA_05B35B:          db $80,$40,$20,$10,$08,$04,$02,$01        ;;AF12|B35B+B339/B35B\B35B;
                                                                ;;                        ;
                      TYA                                       ;;AF1A|B363+B341/B363\B363; \ Unreachable
                      AND.B #$07                                ;;AF1B|B364+B342/B364\B364;
                      PHA                                       ;;AF1D|B366+B344/B366\B366;
                      TYA                                       ;;AF1E|B367+B345/B367\B367;
                      LSR A                                     ;;AF1F|B368+B346/B368\B368;
                      LSR A                                     ;;AF20|B369+B347/B369\B369;
                      LSR A                                     ;;AF21|B36A+B348/B36A\B36A;
                      TAX                                       ;;AF22|B36B+B349/B36B\B36B;
                      LDA.W !OWEventsActivated,X                ;;AF23|B36C+B34A/B36C\B36C;
                      PLX                                       ;;AF26|B36F+B34D/B36F\B36F;
                      AND.L DATA_05B35B,X                       ;;AF27|B370+B34E/B370\B370;
                      RTL                                       ;;AF2B|B374+B352/B374\B374; / Return
                                                                ;;                        ;
                                                                ;;                        ;
                   if ver_is_japanese(!_VER)          ;\   IF   ;;++++++++++++++++++++++++; J
TitleScreenStripe:    db $50,$00,$00,$7F,$58,$2C,$59,$2C        ;;AF2C                    ;
                      db $55,$2C,$56,$2C,$66,$EC,$65,$EC        ;;AF34                    ;
                      db $57,$2C,$58,$2C,$59,$2C,$57,$2C        ;;AF3C                    ;
                      db $58,$2C,$59,$2C,$57,$2C,$58,$2C        ;;AF44                    ;
                      db $59,$2C,$38,$2C,$39,$2C,$66,$EC        ;;AF4C                    ;
                      db $65,$EC,$57,$2C,$58,$2C,$59,$2C        ;;AF54                    ;
                      db $57,$2C,$58,$2C,$59,$2C,$57,$2C        ;;AF5C                    ;
                      db $58,$2C,$59,$2C,$38,$2C,$39,$2C        ;;AF64                    ;
                      db $56,$6C,$55,$2C,$68,$2C,$69,$2C        ;;AF6C                    ;
                      db $65,$2C,$66,$2C,$56,$EC,$55,$AC        ;;AF74                    ;
                      db $67,$2C,$68,$2C,$69,$2C,$67,$2C        ;;AF7C                    ;
                      db $68,$2C,$69,$2C,$67,$2C,$68,$2C        ;;AF84                    ;
                      db $69,$2C,$48,$2C,$49,$2C,$56,$EC        ;;AF8C                    ;
                      db $55,$AC,$67,$2C,$68,$2C,$69,$2C        ;;AF94                    ;
                      db $67,$2C,$68,$2C,$69,$2C,$67,$2C        ;;AF9C                    ;
                      db $68,$2C,$69,$2C,$48,$2C,$49,$2C        ;;AFA4                    ;
                      db $66,$6C,$65,$6C,$50,$40,$80,$33        ;;AFAC                    ;
                      db $55,$2C,$65,$2C,$38,$2C,$48,$2C        ;;AFB4                    ;
                      db $55,$2C,$65,$2C,$38,$2C,$48,$2C        ;;AFBC                    ;
                      db $55,$2C,$65,$2C,$38,$2C,$48,$2C        ;;AFC4                    ;
                      db $55,$2C,$65,$2C,$38,$2C,$48,$2C        ;;AFCC                    ;
                      db $55,$2C,$65,$2C,$38,$2C,$48,$2C        ;;AFD4                    ;
                      db $55,$2C,$65,$2C,$38,$2C,$48,$2C        ;;AFDC                    ;
                      db $55,$2C,$65,$2C,$50,$41,$80,$33        ;;AFE4                    ;
                      db $56,$2C,$66,$2C,$39,$2C,$49,$2C        ;;AFEC                    ;
                      db $56,$2C,$66,$2C,$39,$2C,$49,$2C        ;;AFF4                    ;
                      db $56,$2C,$66,$2C,$39,$2C,$49,$2C        ;;AFFC                    ;
                      db $56,$2C,$66,$2C,$39,$2C,$49,$2C        ;;B004                    ;
                      db $56,$2C,$66,$2C,$39,$2C,$49,$2C        ;;B00C                    ;
                      db $56,$2C,$66,$2C,$39,$2C,$49,$2C        ;;B014                    ;2b8dc
                      db $56,$2C,$66,$2C,$50,$5E,$80,$33        ;;B01C                    ;
                      db $66,$EC,$56,$EC,$39,$6C,$49,$6C        ;;B024                    ;
                      db $56,$6C,$66,$6C,$39,$6C,$49,$6C        ;;B02C                    ;
                      db $56,$6C,$66,$6C,$39,$6C,$49,$6C        ;;B034                    ;
                      db $56,$6C,$66,$6C,$39,$6C,$49,$6C        ;;B03C                    ;
                      db $56,$6C,$66,$6C,$39,$6C,$49,$6C        ;;B044                    ;
                      db $56,$6C,$66,$6C,$39,$6C,$49,$6C        ;;B04C                    ;
                      db $56,$6C,$66,$6C,$50,$5F,$80,$33        ;;B054                    ;
                      db $65,$EC,$55,$EC,$38,$6C,$48,$6C        ;;B05C                    ;
                      db $55,$6C,$65,$6C,$38,$6C,$48,$6C        ;;B064                    ;
                      db $55,$6C,$65,$6C,$38,$6C,$48,$6C        ;;B06C                    ;
                      db $55,$6C,$65,$6C,$38,$6C,$48,$6C        ;;B074                    ;
                      db $55,$6C,$65,$6C,$38,$6C,$48,$6C        ;;B07C                    ;
                      db $55,$6C,$65,$6C,$38,$6C,$48,$6C        ;;B084                    ;
                      db $55,$6C,$65,$6C,$53,$40,$00,$7F        ;;B08C                    ;
                      db $69,$AC,$67,$AC,$68,$AC,$69,$AC        ;;B094                    ;
                      db $67,$AC,$68,$AC,$69,$AC,$48,$AC        ;;B09C                    ;
                      db $49,$AC,$56,$6C,$55,$2C,$67,$AC        ;;B0A4                    ;
                      db $68,$AC,$69,$AC,$67,$AC,$68,$AC        ;;B0AC                    ;
                      db $69,$AC,$67,$AC,$68,$AC,$69,$AC        ;;B0B4                    ;
                      db $48,$AC,$49,$AC,$66,$EC,$65,$EC        ;;B0BC                    ;
                      db $57,$2C,$58,$2C,$59,$2C,$57,$2C        ;;B0C4                    ;
                      db $58,$2C,$57,$2C,$58,$2C,$59,$2C        ;;B0CC                    ;
                      db $59,$AC,$57,$AC,$58,$AC,$59,$AC        ;;B0D4                    ;
                      db $57,$AC,$58,$AC,$59,$AC,$38,$AC        ;;B0DC                    ;
                      db $39,$AC,$66,$6C,$65,$6C,$57,$AC        ;;B0E4                    ;
                      db $58,$AC,$59,$AC,$57,$AC,$58,$AC        ;;B0EC                    ;
                      db $59,$AC,$57,$AC,$58,$AC,$59,$AC        ;;B0F4                    ;
                      db $38,$AC,$39,$AC,$56,$EC,$55,$AC        ;;B0FC                    ;
                      db $67,$2C,$68,$2C,$69,$2C,$67,$2C        ;;B104                    ;
                      db $68,$2C,$67,$2C,$68,$2C,$69,$2C        ;;B10C                    ;
                      db $50,$CA,$00,$13,$98,$3C,$A9,$3C        ;;B114                    ;
                      db $2F,$38,$AE,$28,$E0,$B8,$2C,$38        ;;B11C                    ;
                      db $4B,$28,$F0,$28,$F1,$28,$98,$68        ;;B124                    ;
                      db $50,$EA,$00,$15,$4F,$3C,$8A,$3C        ;;B12C                    ;
                      db $8B,$28,$8C,$28,$8D,$38,$35,$38        ;;B134                    ;
                      db $45,$28,$2A,$28,$2B,$28,$60,$28        ;;B13C                    ;
                      db $C8,$28,$51,$0A,$00,$15,$99,$3C        ;;B144                    ;
                      db $9A,$3C,$9B,$28,$9C,$28,$9D,$38        ;;B14C                    ;
                      db $9E,$38,$9F,$28,$5A,$28,$5B,$28        ;;B154                    ;
                      db $90,$28,$CC,$28,$51,$2B,$00,$13        ;;B15C                    ;
                      db $AA,$28,$AB,$28,$AC,$28,$AD,$28        ;;B164                    ;
                      db $FE,$28,$AF,$28,$70,$28,$71,$28        ;;B16C                    ;
                      db $72,$28,$73,$28,$51,$3C,$00,$01        ;;B174                    ;
                      db $75,$28,$51,$44,$00,$2F,$B0,$28        ;;B17C                    ;
                      db $B1,$28,$B2,$28,$B3,$28,$B4,$28        ;;B184                    ;
                      db $B5,$38,$CA,$38,$2C,$38,$2F,$3C        ;;B18C                    ;
                      db $FC,$28,$FC,$28,$FC,$28,$E0,$B8        ;;B194                    ;
                      db $3C,$38,$3C,$78,$74,$38,$FC,$28        ;;B19C                    ;
                      db $B5,$3C,$CA,$3C,$2C,$3C,$2F,$3C        ;;B1A4                    ;
                      db $B5,$3C,$CA,$3C,$98,$68,$51,$64        ;;B1AC                    ;
                      db $00,$31,$6A,$28,$6B,$28,$6C,$28        ;;B1B4                    ;
                      db $6D,$28,$6E,$28,$6F,$38,$C6,$38        ;;B1BC                    ;
                      db $C7,$38,$D8,$3C,$C9,$3C,$CA,$3C        ;;B1C4                    ;
                      db $CB,$3C,$D0,$B8,$CD,$38,$CE,$38        ;;B1CC                    ;
                      db $CF,$38,$CA,$28,$A1,$28,$C6,$3C        ;;B1D4                    ;
                      db $C7,$3C,$D8,$3C,$A5,$3C,$A3,$3C        ;;B1DC                    ;
                      db $B6,$3C,$C8,$28,$51,$84,$00,$31        ;;B1E4                    ;
                      db $D0,$3C,$D1,$28,$D2,$28,$D3,$28        ;;B1EC                    ;
                      db $61,$28,$62,$38,$63,$38,$D7,$38        ;;B1F4                    ;
                      db $D8,$3C,$D9,$3C,$DA,$3C,$DB,$3C        ;;B1FC                    ;
                      db $DC,$38,$DD,$38,$DE,$38,$DF,$38        ;;B204                    ;
                      db $DA,$28,$29,$28,$63,$3C,$D7,$3C        ;;B20C                    ;
                      db $D8,$3C,$2D,$3C,$4C,$3C,$4D,$3C        ;;B214                    ;
                      db $4E,$28,$51,$A4,$00,$31,$E0,$3C        ;;B21C                    ;
                      db $E1,$28,$E2,$28,$E3,$28,$E4,$28        ;;B224                    ;
                      db $E5,$38,$E6,$38,$E7,$38,$E8,$3C        ;;B22C                    ;
                      db $E9,$3C,$EA,$3C,$EB,$3C,$EC,$38        ;;B234                    ;
                      db $ED,$38,$EE,$38,$EF,$38,$EA,$28        ;;B23C                    ;
                      db $EB,$28,$E6,$3C,$E7,$3C,$5C,$3C        ;;B244                    ;
                      db $5D,$3C,$5E,$3C,$5F,$3C,$FE,$28        ;;B24C                    ;
                      db $51,$C5,$00,$2F,$FE,$28,$F2,$28        ;;B254                    ;
                      db $F3,$28,$F4,$28,$F5,$28,$FE,$28        ;;B25C                    ;
                      db $F7,$28,$F8,$28,$F9,$28,$FA,$28        ;;B264                    ;
                      db $FB,$28,$50,$28,$51,$28,$52,$28        ;;B26C                    ;
                      db $53,$28,$A0,$28,$FB,$28,$A2,$28        ;;B274                    ;
                      db $F7,$28,$F8,$28,$F9,$28,$A6,$28        ;;B27C                    ;
                      db $A7,$28,$A8,$28,$53,$09,$00,$1B        ;;B284                    ;
                      db $F6,$38,$FC,$28,$36,$38,$37,$38        ;;B28C                    ;
                      db $37,$38,$54,$38,$FC,$28,$46,$38        ;;B294                    ;
                      db $47,$38,$AE,$39,$AF,$39,$C5,$39        ;;B29C                    ;
                      db $C6,$39,$BF,$39,$FF                    ;;B2A4                    ;
                   elseif ver_is_hires(!_VER)         ;<  ELSE  ;;------------------------; E1
TitleScreenStripe:    db $50,$00,$00,$7F,$58,$2C,$59,$2C        ;;                   \B375;
                      db $55,$2C,$56,$2C,$66,$EC,$65,$EC        ;;                   \B37D;
                      db $57,$2C,$58,$2C,$59,$2C,$57,$2C        ;;                   \B385;
                      db $58,$2C,$59,$2C,$57,$2C,$58,$2C        ;;                   \B38D;
                      db $59,$2C,$38,$2C,$39,$2C,$66,$EC        ;;                   \B395;
                      db $65,$EC,$57,$2C,$58,$2C,$59,$2C        ;;                   \B39D;
                      db $57,$2C,$58,$2C,$59,$2C,$57,$2C        ;;                   \B3A5;
                      db $58,$2C,$59,$2C,$38,$2C,$39,$2C        ;;                   \B3AD;
                      db $56,$6C,$55,$2C,$68,$2C,$69,$2C        ;;                   \B3B5;
                      db $65,$2C,$66,$2C,$56,$EC,$55,$AC        ;;                   \B3BD;
                      db $67,$2C,$68,$2C,$69,$2C,$67,$2C        ;;                   \B3C5;
                      db $68,$2C,$69,$2C,$67,$2C,$68,$2C        ;;                   \B3CD;
                      db $69,$2C,$48,$2C,$49,$2C,$56,$EC        ;;                   \B3D5;
                      db $55,$AC,$67,$2C,$68,$2C,$69,$2C        ;;                   \B3DD;
                      db $67,$2C,$68,$2C,$69,$2C,$67,$2C        ;;                   \B3E5;
                      db $68,$2C,$69,$2C,$48,$2C,$49,$2C        ;;                   \B3ED;
                      db $66,$6C,$65,$6C,$50,$40,$80,$37        ;;                   \B3F5;
                      db $55,$2C,$65,$2C,$38,$2C,$48,$2C        ;;                   \B3FD;
                      db $55,$2C,$65,$2C,$38,$2C,$48,$2C        ;;                   \B405;
                      db $55,$2C,$65,$2C,$38,$2C,$48,$2C        ;;                   \B40D;
                      db $55,$2C,$65,$2C,$38,$2C,$48,$2C        ;;                   \B415;
                      db $55,$2C,$65,$2C,$38,$2C,$48,$2C        ;;                   \B41D;
                      db $55,$2C,$65,$2C,$38,$2C,$48,$2C        ;;                   \B425;
                      db $55,$2C,$65,$2C,$38,$2C,$48,$2C        ;;                   \B42D;
                      db $50,$41,$80,$37,$56,$2C,$66,$2C        ;;                   \B435;
                      db $39,$2C,$49,$2C,$56,$2C,$66,$2C        ;;                   \B43D;
                      db $39,$2C,$49,$2C,$56,$2C,$66,$2C        ;;                   \B445;
                      db $39,$2C,$49,$2C,$56,$2C,$66,$2C        ;;                   \B44D;
                      db $39,$2C,$49,$2C,$56,$2C,$66,$2C        ;;                   \B455;
                      db $39,$2C,$49,$2C,$56,$2C,$66,$2C        ;;                   \B45D;
                      db $39,$2C,$49,$2C,$56,$2C,$66,$2C        ;;                   \B465;
                      db $39,$2C,$49,$2C,$50,$5E,$80,$37        ;;                   \B46D;
                      db $66,$EC,$56,$EC,$39,$6C,$49,$6C        ;;                   \B475;
                      db $56,$6C,$66,$6C,$39,$6C,$49,$6C        ;;                   \B47D;
                      db $56,$6C,$66,$6C,$39,$6C,$49,$6C        ;;                   \B485;
                      db $56,$6C,$66,$6C,$39,$6C,$49,$6C        ;;                   \B48D;
                      db $56,$6C,$66,$6C,$39,$6C,$49,$6C        ;;                   \B495;
                      db $56,$6C,$66,$6C,$39,$6C,$49,$6C        ;;                   \B49D;
                      db $56,$6C,$66,$6C,$39,$6C,$49,$6C        ;;                   \B4A5;
                      db $50,$5F,$80,$37,$65,$EC,$55,$EC        ;;                   \B4AD;
                      db $38,$6C,$48,$6C,$55,$6C,$65,$6C        ;;                   \B4B5;
                      db $38,$6C,$48,$6C,$55,$6C,$65,$6C        ;;                   \B4BD;
                      db $38,$6C,$48,$6C,$55,$6C,$65,$6C        ;;                   \B4C5;
                      db $38,$6C,$48,$6C,$55,$6C,$65,$6C        ;;                   \B4CD;
                      db $38,$6C,$48,$6C,$55,$6C,$65,$6C        ;;                   \B4D5;
                      db $38,$6C,$48,$6C,$55,$6C,$65,$6C        ;;                   \B4DD;
                      db $38,$6C,$48,$6C,$53,$80,$00,$7F        ;;                   \B4E5;
                      db $69,$AC,$67,$AC,$68,$AC,$69,$AC        ;;                   \B4ED;
                      db $67,$AC,$68,$AC,$69,$AC,$48,$AC        ;;                   \B4F5;
                      db $49,$AC,$56,$6C,$55,$2C,$67,$AC        ;;                   \B4FD;
                      db $68,$AC,$69,$AC,$67,$AC,$68,$AC        ;;                   \B505;
                      db $69,$AC,$67,$AC,$68,$AC,$69,$AC        ;;                   \B50D;
                      db $48,$AC,$49,$AC,$66,$EC,$65,$EC        ;;                   \B515;
                      db $57,$2C,$58,$2C,$59,$2C,$57,$2C        ;;                   \B51D;
                      db $58,$2C,$57,$2C,$58,$2C,$59,$2C        ;;                   \B525;
                      db $59,$AC,$57,$AC,$58,$AC,$59,$AC        ;;                   \B52D;
                      db $57,$AC,$58,$AC,$59,$AC,$38,$AC        ;;                   \B535;
                      db $39,$AC,$66,$6C,$65,$6C,$57,$AC        ;;                   \B53D;
                      db $58,$AC,$59,$AC,$57,$AC,$58,$AC        ;;                   \B545;
                      db $59,$AC,$57,$AC,$58,$AC,$59,$AC        ;;                   \B54D;
                      db $38,$AC,$39,$AC,$56,$EC,$55,$AC        ;;                   \B555;
                      db $67,$2C,$68,$2C,$69,$2C,$67,$2C        ;;                   \B55D;
                      db $68,$2C,$67,$2C,$68,$2C,$69,$2C        ;;                   \B565;
                      db $50,$AA,$00,$13,$98,$3C,$A9,$3C        ;;                   \B56D;
                      db $2F,$38,$AE,$28,$E0,$B8,$2C,$38        ;;                   \B575;
                      db $4B,$28,$F0,$28,$F1,$28,$98,$68        ;;                   \B57D;
                      db $50,$CA,$00,$15,$4F,$3C,$8A,$3C        ;;                   \B585;
                      db $8B,$28,$8C,$28,$8D,$38,$35,$38        ;;                   \B58D;
                      db $45,$28,$2A,$28,$2B,$28,$60,$28        ;;                   \B595;
                      db $A2,$28,$50,$EA,$00,$15,$99,$3C        ;;                   \B59D;
                      db $9A,$3C,$9B,$28,$9C,$28,$9D,$38        ;;                   \B5A5;
                      db $9E,$38,$9F,$28,$5A,$28,$5B,$28        ;;                   \B5AD;
                      db $90,$28,$A0,$28,$51,$0A,$00,$13        ;;                   \B5B5;
                      db $5C,$28,$5C,$68,$71,$28,$71,$68        ;;                   \B5BD;
                      db $5C,$28,$72,$28,$73,$28,$71,$68        ;;                   \B5C5;
                      db $75,$28,$89,$28,$51,$3B,$00,$03        ;;                   \B5CD;
                      db $7B,$39,$7C,$39,$51,$23,$00,$2F        ;;                   \B5D5;
                      db $B0,$28,$B1,$28,$B2,$28,$B3,$28        ;;                   \B5DD;
                      db $B4,$28,$B5,$38,$F5,$38,$2C,$38        ;;                   \B5E5;
                      db $AC,$3C,$F2,$3C,$F3,$3C,$F4,$3C        ;;                   \B5ED;
                      db $E0,$B8,$3C,$38,$FB,$38,$74,$38        ;;                   \B5F5;
                      db $F3,$28,$F8,$28,$F5,$3C,$2C,$3C        ;;                   \B5FD;
                      db $AC,$3C,$B5,$3C,$F5,$3C,$98,$68        ;;                   \B605;
                      db $51,$43,$00,$31,$6A,$28,$6B,$28        ;;                   \B60D;
                      db $6C,$28,$6D,$28,$6E,$28,$6F,$38        ;;                   \B615;
                      db $C6,$38,$C7,$38,$D8,$3C,$C9,$3C        ;;                   \B61D;
                      db $CA,$3C,$CB,$3C,$D0,$B8,$CD,$38        ;;                   \B625;
                      db $CE,$38,$CF,$38,$CA,$28,$A1,$28        ;;                   \B62D;
                      db $C6,$3C,$C7,$3C,$D8,$3C,$A5,$3C        ;;                   \B635;
                      db $A3,$3C,$B6,$3C,$C8,$28,$51,$63        ;;                   \B63D;
                      db $00,$31,$D0,$3C,$D1,$28,$D2,$28        ;;                   \B645;
                      db $D3,$28,$61,$28,$62,$38,$63,$38        ;;                   \B64D;
                      db $D7,$38,$D8,$3C,$D9,$3C,$DA,$3C        ;;                   \B655;
                      db $DB,$3C,$DC,$38,$DD,$38,$DE,$38        ;;                   \B65D;
                      db $DF,$38,$DA,$28,$29,$28,$63,$3C        ;;                   \B665;
                      db $D7,$3C,$D8,$3C,$2D,$3C,$4C,$3C        ;;                   \B66D;
                      db $4D,$3C,$CC,$28,$51,$83,$00,$31        ;;                   \B675;
                      db $E0,$3C,$E1,$28,$E2,$28,$E3,$28        ;;                   \B67D;
                      db $E4,$28,$E5,$38,$E6,$38,$E7,$38        ;;                   \B685;
                      db $E8,$3C,$E9,$3C,$EA,$3C,$EB,$3C        ;;                   \B68D;
                      db $EC,$38,$ED,$38,$EE,$38,$EF,$38        ;;                   \B695;
                      db $EA,$28,$F7,$28,$E6,$3C,$E7,$3C        ;;                   \B69D;
                      db $E8,$3C,$5D,$3C,$5E,$3C,$5F,$3C        ;;                   \B6A5;
                      db $FA,$28,$51,$A3,$00,$2F,$5C,$28        ;;                   \B6AD;
                      db $A4,$28,$FC,$28,$FC,$28,$A6,$38        ;;                   \B6B5;
                      db $75,$28,$A7,$28,$A8,$38,$FC,$28        ;;                   \B6BD;
                      db $FC,$28,$FC,$28,$FC,$28,$AA,$38        ;;                   \B6C5;
                      db $5C,$68,$AB,$38,$71,$68,$FC,$28        ;;                   \B6CD;
                      db $FC,$28,$A7,$28,$A8,$38,$FC,$28        ;;                   \B6D5;
                      db $AD,$3C,$A7,$28,$AF,$3C,$53,$27        ;;                   \B6DD;
                      db $00,$25,$F6,$38,$FC,$28,$36,$38        ;;                   \B6E5;
                      db $37,$38,$37,$38,$54,$38,$20,$39        ;;                   \B6ED;
                      db $36,$38,$37,$38,$37,$38,$36,$38        ;;                   \B6F5;
                      db $FC,$28,$46,$38,$47,$38,$AE,$39        ;;                   \B6FD;
                      db $AF,$39,$C5,$39,$C6,$39,$BF,$39        ;;                   \B705;
                      db $FF                                    ;;                   \B70D;
                   else                               ;<  ELSE  ;;------------------------; U, SS, & E0
TitleScreenStripe:    db $50,$00,$00,$7F,$58,$2C,$59,$2C        ;;    |B375+B353/B375     ;
                      db $55,$2C,$56,$2C,$66,$EC,$65,$EC        ;;    |B37D+B35B/B37D     ;
                      db $57,$2C,$58,$2C,$59,$2C,$57,$2C        ;;    |B385+B363/B385     ;
                      db $58,$2C,$59,$2C,$57,$2C,$58,$2C        ;;    |B38D+B36B/B38D     ;
                      db $59,$2C,$38,$2C,$39,$2C,$66,$EC        ;;    |B395+B373/B395     ;
                      db $65,$EC,$57,$2C,$58,$2C,$59,$2C        ;;    |B39D+B37B/B39D     ;
                      db $57,$2C,$58,$2C,$59,$2C,$57,$2C        ;;    |B3A5+B383/B3A5     ;
                      db $58,$2C,$59,$2C,$38,$2C,$39,$2C        ;;    |B3AD+B38B/B3AD     ;
                      db $56,$6C,$55,$2C,$68,$2C,$69,$2C        ;;    |B3B5+B393/B3B5     ;
                      db $65,$2C,$66,$2C,$56,$EC,$55,$AC        ;;    |B3BD+B39B/B3BD     ;
                      db $67,$2C,$68,$2C,$69,$2C,$67,$2C        ;;    |B3C5+B3A3/B3C5     ;
                      db $68,$2C,$69,$2C,$67,$2C,$68,$2C        ;;    |B3CD+B3AB/B3CD     ;
                      db $69,$2C,$48,$2C,$49,$2C,$56,$EC        ;;    |B3D5+B3B3/B3D5     ;
                      db $55,$AC,$67,$2C,$68,$2C,$69,$2C        ;;    |B3DD+B3BB/B3DD     ;
                      db $67,$2C,$68,$2C,$69,$2C,$67,$2C        ;;    |B3E5+B3C3/B3E5     ;
                      db $68,$2C,$69,$2C,$48,$2C,$49,$2C        ;;    |B3ED+B3CB/B3ED     ;
                      db $66,$6C,$65,$6C,$50,$40,$80,$33        ;;    |B3F5+B3D3/B3F5     ;
                      db $55,$2C,$65,$2C,$38,$2C,$48,$2C        ;;    |B3FD+B3DB/B3FD     ;
                      db $55,$2C,$65,$2C,$38,$2C,$48,$2C        ;;    |B405+B3E3/B405     ;
                      db $55,$2C,$65,$2C,$38,$2C,$48,$2C        ;;    |B40D+B3EB/B40D     ;
                      db $55,$2C,$65,$2C,$38,$2C,$48,$2C        ;;    |B415+B3F3/B415     ;
                      db $55,$2C,$65,$2C,$38,$2C,$48,$2C        ;;    |B41D+B3FB/B41D     ;
                      db $55,$2C,$65,$2C,$38,$2C,$48,$2C        ;;    |B425+B403/B425     ;
                      db $55,$2C,$65,$2C,$50,$41,$80,$33        ;;    |B42D+B40B/B42D     ;
                      db $56,$2C,$66,$2C,$39,$2C,$49,$2C        ;;    |B435+B413/B435     ;
                      db $56,$2C,$66,$2C,$39,$2C,$49,$2C        ;;    |B43D+B41B/B43D     ;
                      db $56,$2C,$66,$2C,$39,$2C,$49,$2C        ;;    |B445+B423/B445     ;
                      db $56,$2C,$66,$2C,$39,$2C,$49,$2C        ;;    |B44D+B42B/B44D     ;
                      db $56,$2C,$66,$2C,$39,$2C,$49,$2C        ;;    |B455+B433/B455     ;
                      db $56,$2C,$66,$2C,$39,$2C,$49,$2C        ;;    |B45D+B43B/B45D     ;
                      db $56,$2C,$66,$2C,$50,$5E,$80,$33        ;;    |B465+B443/B465     ;
                      db $66,$EC,$56,$EC,$39,$6C,$49,$6C        ;;    |B46D+B44B/B46D     ;
                      db $56,$6C,$66,$6C,$39,$6C,$49,$6C        ;;    |B475+B453/B475     ;
                      db $56,$6C,$66,$6C,$39,$6C,$49,$6C        ;;    |B47D+B45B/B47D     ;
                      db $56,$6C,$66,$6C,$39,$6C,$49,$6C        ;;    |B485+B463/B485     ;
                      db $56,$6C,$66,$6C,$39,$6C,$49,$6C        ;;    |B48D+B46B/B48D     ;
                      db $56,$6C,$66,$6C,$39,$6C,$49,$6C        ;;    |B495+B473/B495     ;
                      db $56,$6C,$66,$6C,$50,$5F,$80,$33        ;;    |B49D+B47B/B49D     ;
                      db $65,$EC,$55,$EC,$38,$6C,$48,$6C        ;;    |B4A5+B483/B4A5     ;
                      db $55,$6C,$65,$6C,$38,$6C,$48,$6C        ;;    |B4AD+B48B/B4AD     ;
                      db $55,$6C,$65,$6C,$38,$6C,$48,$6C        ;;    |B4B5+B493/B4B5     ;
                      db $55,$6C,$65,$6C,$38,$6C,$48,$6C        ;;    |B4BD+B49B/B4BD     ;
                      db $55,$6C,$65,$6C,$38,$6C,$48,$6C        ;;    |B4C5+B4A3/B4C5     ;
                      db $55,$6C,$65,$6C,$38,$6C,$48,$6C        ;;    |B4CD+B4AB/B4CD     ;
                      db $55,$6C,$65,$6C,$53,$40,$00,$7F        ;;    |B4D5+B4B3/B4D5     ;
                      db $69,$AC,$67,$AC,$68,$AC,$69,$AC        ;;    |B4DD+B4BB/B4DD     ;
                      db $67,$AC,$68,$AC,$69,$AC,$48,$AC        ;;    |B4E5+B4C3/B4E5     ;
                      db $49,$AC,$56,$6C,$55,$2C,$67,$AC        ;;    |B4ED+B4CB/B4ED     ;
                      db $68,$AC,$69,$AC,$67,$AC,$68,$AC        ;;    |B4F5+B4D3/B4F5     ;
                      db $69,$AC,$67,$AC,$68,$AC,$69,$AC        ;;    |B4FD+B4DB/B4FD     ;
                      db $48,$AC,$49,$AC,$66,$EC,$65,$EC        ;;    |B505+B4E3/B505     ;
                      db $57,$2C,$58,$2C,$59,$2C,$57,$2C        ;;    |B50D+B4EB/B50D     ;
                      db $58,$2C,$57,$2C,$58,$2C,$59,$2C        ;;    |B515+B4F3/B515     ;
                      db $59,$AC,$57,$AC,$58,$AC,$59,$AC        ;;    |B51D+B4FB/B51D     ;
                      db $57,$AC,$58,$AC,$59,$AC,$38,$AC        ;;    |B525+B503/B525     ;
                      db $39,$AC,$66,$6C,$65,$6C,$57,$AC        ;;    |B52D+B50B/B52D     ;
                      db $58,$AC,$59,$AC,$57,$AC,$58,$AC        ;;    |B535+B513/B535     ;
                      db $59,$AC,$57,$AC,$58,$AC,$59,$AC        ;;    |B53D+B51B/B53D     ;
                      db $38,$AC,$39,$AC,$56,$EC,$55,$AC        ;;    |B545+B523/B545     ;
                      db $67,$2C,$68,$2C,$69,$2C,$67,$2C        ;;    |B54D+B52B/B54D     ;
                      db $68,$2C,$67,$2C,$68,$2C,$69,$2C        ;;    |B555+B533/B555     ;
                      db $50,$AA,$00,$13,$98,$3C,$A9,$3C        ;;    |B55D+B53B/B55D     ;
                      db $2F,$38,$AE,$28,$E0,$B8,$2C,$38        ;;    |B565+B543/B565     ;
                      db $4B,$28,$F0,$28,$F1,$28,$98,$68        ;;    |B56D+B54B/B56D     ;
                      db $50,$CA,$00,$15,$4F,$3C,$8A,$3C        ;;    |B575+B553/B575     ;
                      db $8B,$28,$8C,$28,$8D,$38,$35,$38        ;;    |B57D+B55B/B57D     ;
                      db $45,$28,$2A,$28,$2B,$28,$60,$28        ;;    |B585+B563/B585     ;
                      db $A2,$28,$50,$EA,$00,$15,$99,$3C        ;;    |B58D+B56B/B58D     ;
                      db $9A,$3C,$9B,$28,$9C,$28,$9D,$38        ;;    |B595+B573/B595     ;
                      db $9E,$38,$9F,$28,$5A,$28,$5B,$28        ;;    |B59D+B57B/B59D     ;
                      db $90,$28,$A0,$28,$51,$0A,$00,$13        ;;    |B5A5+B583/B5A5     ;
                      db $5C,$28,$5C,$68,$71,$28,$71,$68        ;;    |B5AD+B58B/B5AD     ;
                      db $5C,$28,$72,$28,$73,$28,$71,$68        ;;    |B5B5+B593/B5B5     ;
                      db $75,$28,$89,$28,$51,$3B,$00,$03        ;;    |B5BD+B59B/B5BD     ;
                      db $7B,$39,$7C,$39,$51,$23,$00,$2F        ;;    |B5C5+B5A3/B5C5     ;
                      db $B0,$28,$B1,$28,$B2,$28,$B3,$28        ;;    |B5CD+B5AB/B5CD     ;
                      db $B4,$28,$B5,$38,$F5,$38,$2C,$38        ;;    |B5D5+B5B3/B5D5     ;
                      db $AC,$3C,$F2,$3C,$F3,$3C,$F4,$3C        ;;    |B5DD+B5BB/B5DD     ;
                      db $E0,$B8,$3C,$38,$FB,$38,$74,$38        ;;    |B5E5+B5C3/B5E5     ;
                      db $F3,$28,$F8,$28,$F5,$3C,$2C,$3C        ;;    |B5ED+B5CB/B5ED     ;
                      db $AC,$3C,$B5,$3C,$F5,$3C,$98,$68        ;;    |B5F5+B5D3/B5F5     ;
                      db $51,$43,$00,$31,$6A,$28,$6B,$28        ;;    |B5FD+B5DB/B5FD     ;
                      db $6C,$28,$6D,$28,$6E,$28,$6F,$38        ;;    |B605+B5E3/B605     ;
                      db $C6,$38,$C7,$38,$D8,$3C,$C9,$3C        ;;    |B60D+B5EB/B60D     ;
                      db $CA,$3C,$CB,$3C,$D0,$B8,$CD,$38        ;;    |B615+B5F3/B615     ;
                      db $CE,$38,$CF,$38,$CA,$28,$A1,$28        ;;    |B61D+B5FB/B61D     ;
                      db $C6,$3C,$C7,$3C,$D8,$3C,$A5,$3C        ;;    |B625+B603/B625     ;
                      db $A3,$3C,$B6,$3C,$C8,$28,$51,$63        ;;    |B62D+B60B/B62D     ;
                      db $00,$31,$D0,$3C,$D1,$28,$D2,$28        ;;    |B635+B613/B635     ;
                      db $D3,$28,$61,$28,$62,$38,$63,$38        ;;    |B63D+B61B/B63D     ;
                      db $D7,$38,$D8,$3C,$D9,$3C,$DA,$3C        ;;    |B645+B623/B645     ;
                      db $DB,$3C,$DC,$38,$DD,$38,$DE,$38        ;;    |B64D+B62B/B64D     ;
                      db $DF,$38,$DA,$28,$29,$28,$63,$3C        ;;    |B655+B633/B655     ;
                      db $D7,$3C,$D8,$3C,$2D,$3C,$4C,$3C        ;;    |B65D+B63B/B65D     ;
                      db $4D,$3C,$CC,$28,$51,$83,$00,$31        ;;    |B665+B643/B665     ;
                      db $E0,$3C,$E1,$28,$E2,$28,$E3,$28        ;;    |B66D+B64B/B66D     ;
                      db $E4,$28,$E5,$38,$E6,$38,$E7,$38        ;;    |B675+B653/B675     ;
                      db $E8,$3C,$E9,$3C,$EA,$3C,$EB,$3C        ;;    |B67D+B65B/B67D     ;
                      db $EC,$38,$ED,$38,$EE,$38,$EF,$38        ;;    |B685+B663/B685     ;
                      db $EA,$28,$F7,$28,$E6,$3C,$E7,$3C        ;;    |B68D+B66B/B68D     ;
                      db $E8,$3C,$5D,$3C,$5E,$3C,$5F,$3C        ;;    |B695+B673/B695     ;
                      db $FA,$28,$51,$A3,$00,$2F,$5C,$28        ;;    |B69D+B67B/B69D     ;
                      db $A4,$28,$FC,$28,$FC,$28,$A6,$38        ;;    |B6A5+B683/B6A5     ;
                      db $75,$28,$A7,$28,$A8,$38,$FC,$28        ;;    |B6AD+B68B/B6AD     ;
                      db $FC,$28,$FC,$28,$FC,$28,$AA,$38        ;;    |B6B5+B693/B6B5     ;
                      db $5C,$68,$AB,$38,$71,$68,$FC,$28        ;;    |B6BD+B69B/B6BD     ;
                      db $FC,$28,$A7,$28,$A8,$38,$FC,$28        ;;    |B6C5+B6A3/B6C5     ;
                      db $AD,$3C,$A7,$28,$AF,$3C,$53,$07        ;;    |B6CD+B6AB/B6CD     ;
                      db $00,$25,$F6,$38,$FC,$28,$36,$38        ;;    |B6D5+B6B3/B6D5     ;
                      db $37,$38,$37,$38,$54,$38,$20,$39        ;;    |B6DD+B6BB/B6DD     ;
                      db $36,$38,$37,$38,$37,$38,$36,$38        ;;    |B6E5+B6C3/B6E5     ;
                      db $FC,$28,$46,$38,$47,$38,$AE,$39        ;;    |B6ED+B6CB/B6ED     ;
                      db $AF,$39,$C5,$39,$C6,$39,$BF,$39        ;;    |B6F5+B6D3/B6F5     ;
                      db $FF                                    ;;    |B6FD+B6DB/B6FD     ;
                   endif                              ;/ ENDIF  ;;++++++++++++++++++++++++;
                                                                ;;                        ;
                   if ver_is_japanese(!_VER)          ;\   IF   ;;++++++++++++++++++++++++; J
DATA_05B6FE:          db $52,$28,$40,$1C,$FC,$38,$52,$68        ;;B2A9                    ;
                      db $40,$1C,$FC,$38,$52,$0A,$00,$1F        ;;B2B1                    ;
                      db $84,$30,$85,$30,$86,$30,$FC,$38        ;;B2B9                    ;
                      db $FC,$38,$71,$31,$FC,$38,$24,$38        ;;B2C1                    ;
                      db $24,$38,$24,$38,$30,$31,$3B,$31        ;;B2C9                    ;
                      db $32,$31,$33,$31,$34,$31,$FC,$38        ;;B2D1                    ;
                      db $51,$F5,$00,$01,$35,$31,$52,$4A        ;;B2D9                    ;
                      db $00,$1F,$84,$30,$85,$30,$86,$30        ;;B2E1                    ;
                      db $FC,$38,$FC,$38,$2C,$31,$FC,$38        ;;B2E9                    ;
                      db $24,$38,$24,$38,$24,$38,$30,$31        ;;B2F1                    ;
                      db $3B,$31,$32,$31,$33,$31,$34,$31        ;;B2F9                    ;
                      db $FC,$38,$52,$35,$00,$01,$35,$31        ;;B301                    ;
                      db $52,$8A,$00,$1F,$84,$30,$85,$30        ;;B309                    ;
                      db $86,$30,$FC,$38,$FC,$38,$2D,$31        ;;B311                    ;
                      db $FC,$38,$24,$38,$24,$38,$24,$38        ;;B319                    ;
                      db $30,$31,$3B,$31,$32,$31,$33,$31        ;;B321                    ;
                      db $34,$31,$FC,$38,$52,$75,$00,$01        ;;B329                    ;
                      db $35,$31,$52,$CA,$00,$0D,$38,$31        ;;B331                    ;
                      db $39,$31,$3A,$31,$FC,$38,$8D,$31        ;;B339                    ;
                      db $9D,$31,$D4,$31,$52,$CA,$00,$0D        ;;B341                    ;
                      db $86,$30,$7A,$30,$88,$30,$FC,$38        ;;B349                    ;
                      db $FC,$38,$FC,$38,$FC,$38,$FF            ;;B351                    ;
                                                                ;;                        ;
PlayerSelectStripe:   db $51,$F5,$00,$01,$FC,$38,$52,$08        ;;B358                    ;
                      db $40,$23,$FC,$38,$52,$48,$40,$23        ;;B360                    ;
                      db $FC,$38,$52,$88,$40,$23,$FC,$38        ;;B368                    ;
                      db $52,$C8,$40,$10,$FC,$38,$52,$2A        ;;B370                    ;
                      db $00,$19,$6D,$31,$FC,$38,$6F,$31        ;;B378                    ;
                      db $70,$31,$71,$31,$72,$31,$73,$31        ;;B380                    ;
                      db $74,$31,$FC,$38,$75,$31,$71,$31        ;;B388                    ;
                      db $76,$31,$73,$31,$52,$6A,$00,$19        ;;B390                    ;
                      db $6E,$31,$FC,$38,$6F,$31,$70,$31        ;;B398                    ;
                      db $71,$31,$72,$31,$73,$31,$74,$31        ;;B3A0                    ;
                      db $FC,$38,$75,$31,$71,$31,$76,$31        ;;B3A8                    ;
                      db $73,$31,$FF                            ;;B3B0                    ;
                   elseif ver_is_arcade(!_VER)        ;< ELSEIF ;;------------------------; SS
DATA_05B6FE:          db $52,$05,$40,$2E,$FC,$38,$52,$28        ;;         +B6DC          ;
                      db $40,$1C,$FC,$38,$52,$45,$40,$2E        ;;         +B6E4          ;
                      db $FC,$38,$52,$68,$40,$1C,$FC,$38        ;;         +B6EC          ;
                      db $52,$85,$40,$2E,$FC,$38,$52,$C5        ;;         +B6F4          ;
                      db $40,$1C,$FC,$38,$52,$0D,$00,$1F        ;;         +B6FC          ;
                      db $76,$31,$71,$31,$74,$31,$82,$30        ;;         +B704          ;
                      db $83,$30,$FC,$38,$71,$31,$FC,$38        ;;         +B70C          ;
                      db $24,$38,$24,$38,$24,$38,$73,$31        ;;         +B714          ;
                      db $76,$31,$6F,$31,$2F,$31,$72,$31        ;;         +B71C          ;
                      db $52,$4D,$00,$1F,$76,$31,$71,$31        ;;         +B724          ;
                      db $74,$31,$82,$30,$83,$30,$FC,$38        ;;         +B72C          ;
                      db $2C,$31,$FC,$38,$24,$38,$24,$38        ;;         +B734          ;
                      db $24,$38,$73,$31,$76,$31,$6F,$31        ;;         +B73C          ;
                      db $2F,$31,$72,$31,$52,$8D,$00,$1F        ;;         +B744          ;
                      db $76,$31,$71,$31,$74,$31,$82,$30        ;;         +B74C          ;
                      db $83,$30,$FC,$38,$2D,$31,$FC,$38        ;;         +B754          ;
                      db $24,$38,$24,$38,$24,$38,$73,$31        ;;         +B75C          ;
                      db $76,$31,$6F,$31,$2F,$31,$72,$31        ;;         +B764          ;
                      db $52,$07,$00,$0B,$73,$31,$74,$31        ;;         +B76C          ;
                      db $71,$31,$31,$31,$73,$31,$FC,$38        ;;         +B774          ;
                      db $52,$47,$00,$0B,$73,$31,$74,$31        ;;         +B77C          ;
                      db $71,$31,$31,$31,$73,$31,$FC,$38        ;;         +B784          ;
                      db $52,$87,$00,$0B,$73,$31,$74,$31        ;;         +B78C          ;
                      db $71,$31,$31,$31,$73,$31,$FC,$38        ;;         +B794          ;
                      db $52,$C7,$00,$05,$73,$31,$79,$30        ;;         +B79C          ;
                      db $7C,$30,$FF                            ;;         +B7A4          ;
                                                                ;;                        ;
DATA_05B7C9:          db $52,$05,$40,$2E,$FC,$38,$52,$28        ;;         +B7A7          ;
                      db $40,$1C,$FC,$38,$52,$45,$40,$2E        ;;         +B7AF          ;
                      db $FC,$38,$52,$68,$40,$1C,$FC,$38        ;;         +B7B7          ;
                      db $52,$85,$40,$2E,$FC,$38,$52,$C5        ;;         +B7BF          ;
                      db $40,$1C,$FC,$38,$52,$08,$00,$1F        ;;         +B7C7          ;
                      db $21,$31,$3E,$31,$30,$31,$73,$31        ;;         +B7CF          ;
                      db $FC,$38,$6D,$31,$FC,$38,$FC,$38        ;;         +B7D7          ;
                      db $FC,$38,$FC,$38,$21,$31,$3E,$31        ;;         +B7DF          ;
                      db $30,$31,$73,$31,$FC,$38,$51,$30        ;;         +B7E7          ;
                      db $52,$48,$00,$1F,$21,$31,$3E,$31        ;;         +B7EF          ;
                      db $30,$31,$73,$31,$FC,$38,$6E,$31        ;;         +B7F7          ;
                      db $FC,$38,$FC,$38,$FC,$38,$FC,$38        ;;         +B7FF          ;
                      db $21,$31,$3E,$31,$30,$31,$73,$31        ;;         +B807          ;
                      db $FC,$38,$52,$30,$52,$88,$00,$1F        ;;         +B80F          ;
                      db $21,$31,$3E,$31,$30,$31,$73,$31        ;;         +B817          ;
                      db $FC,$38,$4E,$30,$FC,$38,$FC,$38        ;;         +B81F          ;
                      db $FC,$38,$FC,$38,$21,$31,$3E,$31        ;;         +B827          ;
                      db $30,$31,$73,$31,$FC,$38,$53,$30        ;;         +B82F          ;
                      db $52,$C8,$00,$0B,$21,$31,$3E,$31        ;;         +B837          ;
                      db $30,$31,$73,$31,$FC,$38,$50,$30        ;;         +B83F          ;
                      db $FF                                    ;;         +B847          ;
                                                                ;;                        ;
PlayerSelectStripe:   db $52,$05,$40,$2F,$FC,$38,$52,$45        ;;         +B848          ;
                      db $40,$2F,$FC,$38,$52,$85,$40,$2F        ;;         +B850          ;
                      db $FC,$38,$52,$C5,$40,$1C,$FC,$38        ;;         +B858          ;
                      db $52,$0A,$00,$19,$6D,$31,$FC,$38        ;;         +B860          ;
                      db $6F,$31,$70,$31,$71,$31,$72,$31        ;;         +B868          ;
                      db $73,$31,$74,$31,$FC,$38,$75,$31        ;;         +B870          ;
                      db $71,$31,$76,$31,$73,$31,$52,$4A        ;;         +B878          ;
                      db $00,$19,$6E,$31,$FC,$38,$6F,$31        ;;         +B880          ;
                      db $70,$31,$71,$31,$72,$31,$73,$31        ;;         +B888          ;
                      db $74,$31,$FC,$38,$75,$31,$71,$31        ;;         +B890          ;
                      db $76,$31,$73,$31,$FF                    ;;         +B898          ;
                   else                               ;<  ELSE  ;;------------------------; U, E0, & E1
DATA_05B6FE:          db $51,$E5,$40,$2E,$FC,$38,$52,$08        ;;    |B6FE     /B6FE\B70E;
                      db $40,$1C,$FC,$38,$52,$25,$40,$2E        ;;    |B706     /B706\B716;
                      db $FC,$38,$52,$48,$40,$1C,$FC,$38        ;;    |B70E     /B70E\B71E;
                      db $52,$65,$40,$2E,$FC,$38,$52,$A5        ;;    |B716     /B716\B726;
                      db $40,$1C,$FC,$38,$51,$ED,$00,$1F        ;;    |B71E     /B71E\B72E;
                      db $76,$31,$71,$31,$74,$31,$82,$30        ;;    |B726     /B726\B736;
                      db $83,$30,$FC,$38,$71,$31,$FC,$38        ;;    |B72E     /B72E\B73E;
                      db $24,$38,$24,$38,$24,$38,$73,$31        ;;    |B736     /B736\B746;
                      db $76,$31,$6F,$31,$2F,$31,$72,$31        ;;    |B73E     /B73E\B74E;
                      db $52,$2D,$00,$1F,$76,$31,$71,$31        ;;    |B746     /B746\B756;
                      db $74,$31,$82,$30,$83,$30,$FC,$38        ;;    |B74E     /B74E\B75E;
                      db $2C,$31,$FC,$38,$24,$38,$24,$38        ;;    |B756     /B756\B766;
                      db $24,$38,$73,$31,$76,$31,$6F,$31        ;;    |B75E     /B75E\B76E;
                      db $2F,$31,$72,$31,$52,$6D,$00,$1F        ;;    |B766     /B766\B776;
                      db $76,$31,$71,$31,$74,$31,$82,$30        ;;    |B76E     /B76E\B77E;
                      db $83,$30,$FC,$38,$2D,$31,$FC,$38        ;;    |B776     /B776\B786;
                      db $24,$38,$24,$38,$24,$38,$73,$31        ;;    |B77E     /B77E\B78E;
                      db $76,$31,$6F,$31,$2F,$31,$72,$31        ;;    |B786     /B786\B796;
                      db $51,$E7,$00,$0B,$73,$31,$74,$31        ;;    |B78E     /B78E\B79E;
                      db $71,$31,$31,$31,$73,$31,$FC,$38        ;;    |B796     /B796\B7A6;
                      db $52,$27,$00,$0B,$73,$31,$74,$31        ;;    |B79E     /B79E\B7AE;
                      db $71,$31,$31,$31,$73,$31,$FC,$38        ;;    |B7A6     /B7A6\B7B6;
                      db $52,$67,$00,$0B,$73,$31,$74,$31        ;;    |B7AE     /B7AE\B7BE;
                      db $71,$31,$31,$31,$73,$31,$FC,$38        ;;    |B7B6     /B7B6\B7C6;
                      db $52,$A7,$00,$05,$73,$31,$79,$30        ;;    |B7BE     /B7BE\B7CE;
                      db $7C,$30,$FF                            ;;    |B7C6     /B7C6\B7D6;
                                                                ;;                        ;
DATA_05B7C9:          db $51,$E5,$40,$2E,$FC                    ;;    |B7C9     /B7C9\B7D9;
                      db $38,$52,$08,$40,$1C,$FC,$38,$52        ;;    |B7CE     /B7CE\B7DE;
                      db $25,$40,$2E,$FC,$38,$52,$48,$40        ;;    |B7D6     /B7D6\B7E6;
                      db $1C,$FC,$38,$52,$65,$40,$2E,$FC        ;;    |B7DE     /B7DE\B7EE;
                      db $38,$52,$A5,$40,$1C,$FC,$38,$51        ;;    |B7E6     /B7E6\B7F6;
                      db $EA,$00,$1F,$76,$31,$71,$31,$74        ;;    |B7EE     /B7EE\B7FE;
                      db $31,$82,$30,$83,$30,$FC,$38,$71        ;;    |B7F6     /B7F6\B806;
                      db $31,$FC,$38,$24,$38,$24,$38,$24        ;;    |B7FE     /B7FE\B80E;
                      db $38,$73,$31,$76,$31,$6F,$31,$2F        ;;    |B806     /B806\B816;
                      db $31,$72,$31,$52,$2A,$00,$1F,$76        ;;    |B80E     /B80E\B81E;
                      db $31,$71,$31,$74,$31,$82,$30,$83        ;;    |B816     /B816\B826;
                      db $30,$FC,$38,$2C,$31,$FC,$38,$24        ;;    |B81E     /B81E\B82E;
                      db $38,$24,$38,$24,$38,$73,$31,$76        ;;    |B826     /B826\B836;
                      db $31,$6F,$31,$2F,$31,$72,$31,$52        ;;    |B82E     /B82E\B83E;
                      db $6A,$00,$1F,$76,$31,$71,$31,$74        ;;    |B836     /B836\B846;
                      db $31,$82,$30,$83,$30,$FC,$38,$2D        ;;    |B83E     /B83E\B84E;
                      db $31,$FC,$38,$24,$38,$24,$38,$24        ;;    |B846     /B846\B856;
                      db $38,$73,$31,$76,$31,$6F,$31,$2F        ;;    |B84E     /B84E\B85E;
                      db $31,$72,$31,$52,$AA,$00,$13,$73        ;;    |B856     /B856\B866;
                      db $31,$74,$31,$71,$31,$31,$31,$73        ;;    |B85E     /B85E\B86E;
                      db $31,$FC,$38,$7C,$30,$71,$31,$2F        ;;    |B866     /B866\B876;
                      db $31,$71,$31,$FF                        ;;    |B86E     /B86E\B87E;
                                                                ;;                        ;
PlayerSelectStripe:   db $51,$E5,$40,$2F,$FC,$38,$52,$25        ;;    |B872     /B872\B882;
                      db $40,$2F,$FC,$38,$52,$65,$40,$2F        ;;    |B87A     /B87A\B88A;
                      db $FC,$38,$52,$A5,$40,$1C,$FC,$38        ;;    |B882     /B882\B892;
                      db $52,$0A,$00,$19,$6D,$31,$FC,$38        ;;    |B88A     /B88A\B89A;
                      db $6F,$31,$70,$31,$71,$31,$72,$31        ;;    |B892     /B892\B8A2;
                      db $73,$31,$74,$31,$FC,$38,$75,$31        ;;    |B89A     /B89A\B8AA;
                      db $71,$31,$76,$31,$73,$31,$52,$4A        ;;    |B8A2     /B8A2\B8B2;
                      db $00,$19,$6E,$31,$FC,$38,$6F,$31        ;;    |B8AA     /B8AA\B8BA;
                      db $70,$31,$71,$31,$72,$31,$73,$31        ;;    |B8B2     /B8B2\B8C2;
                      db $74,$31,$FC,$38,$75,$31,$71,$31        ;;    |B8BA     /B8BA\B8CA;
                      db $76,$31,$73,$31,$FF                    ;;    |B8C2     /B8C2\B8D2;
                   endif                              ;/ ENDIF  ;;++++++++++++++++++++++++;
                                                                ;;                        ;
                   if ver_is_japanese(!_VER)          ;\   IF   ;;++++++++++++++++++++++++; J
ContinueSaveStripe:   db $52,$0A,$00,$15,$38,$39,$39,$39        ;;B3B3                    ;
                      db $3A,$39,$3B,$39,$3C,$39,$FC,$38        ;;B3BB                    ;
                      db $80,$38,$81,$38,$36,$39,$37,$39        ;;B3C3                    ;
                      db $88,$38,$52,$30,$00,$01,$35,$39        ;;B3CB                    ;
                      db $52,$4A,$00,$19,$38,$39,$39,$39        ;;B3D3                    ;
                      db $3A,$39,$3B,$39,$89,$38,$7B,$38        ;;B3DB                    ;
                      db $3C,$39,$FC,$38,$80,$38,$81,$38        ;;B3E3                    ;
                      db $36,$39,$37,$39,$88,$38,$FF            ;;B3EB                    ;
                                                                ;;                        ;
ContinueEndStripe:    db $51,$CE,$00,$09,$80,$38,$81,$38        ;;B3F2                    ;
                      db $36,$39,$37,$39,$88,$38,$52,$0E        ;;B3FA                    ;
                      db $00,$05,$86,$38,$7A,$38,$88,$38        ;;B402                    ;
                      db $FF                                    ;;B40A                    ;
                   else                               ;<  ELSE  ;;++++++++++++++++++++++++; U, SS, E0, & E1
ContinueSaveStripe:   db $51,$C6,$00,$21,$2D,$39,$7A,$38        ;;    |B8C7+B89D/B8C7\B8D7;
                      db $79,$38,$2F,$39,$82,$38,$79,$38        ;;    |B8CF+B8A5/B8CF\B8DF;
                      db $7B,$38,$73,$39,$FC,$38,$71,$39        ;;    |B8D7+B8AD/B8D7\B8E7;
                      db $79,$38,$7C,$38,$FC,$38,$31,$39        ;;    |B8DF+B8B5/B8DF\B8EF;
                      db $71,$39,$80,$38,$73,$39,$52,$06        ;;    |B8E7+B8BD/B8E7\B8F7;
                      db $00,$29,$2D,$39,$7A,$38,$79,$38        ;;    |B8EF+B8C5/B8EF\B8FF;
                      db $2F,$39,$82,$38,$79,$38,$7B,$38        ;;    |B8F7+B8CD/B8F7\B907;
                      db $73,$39,$FC,$38,$81,$38,$82,$38        ;;    |B8FF+B8D5/B8FF\B90F;
                      db $2F,$39,$84,$38,$7A,$38,$7B,$38        ;;    |B907+B8DD/B907\B917;
                      db $2F,$39,$FC,$38,$31,$39,$71,$39        ;;    |B90F+B8E5/B90F\B91F;
                      db $80,$38,$73,$39,$FF                    ;;    |B917+B8ED/B917\B927;
                                                                ;;                        ;
ContinueEndStripe:    db $51,$CD,$00,$0F,$2D,$39,$7A,$38        ;;    |B91C+B8F2/B91C\B92C;
                      db $79,$38,$2F,$39,$82,$38,$79,$38        ;;    |B924+B8FA/B924\B934;
                      db $7B,$38,$73,$39,$52,$0D,$00,$05        ;;    |B92C+B902/B92C\B93C;
                      db $73,$39,$79,$38,$7C,$38,$FF            ;;    |B934+B90A/B934\B944;
                   endif                              ;/ ENDIF  ;;++++++++++++++++++++++++;
                                                                ;;                        ;
DATA_05B93B:          db $00,$06                                ;;B40B|B93B+B911/B93B\B94B;
                                                                ;;                        ;
DATA_05B93D:          db $40,$06                                ;;B40D|B93D+B913/B93D\B94D;
                                                                ;;                        ;
DATA_05B93F:          db $80,$06,$40,$07,$A0,$0E,$00,$08        ;;B40F|B93F+B915/B93F\B94F;
                      db $00,$05,$40,$05,$80,$05,$C0,$05        ;;B417|B947+B91D/B947\B957;
                      db $80,$07,$C0,$07,$A0,$0D,$C0,$06        ;;B41F|B94F+B925/B94F\B95F;
                      db $00,$07,$C0,$04,$40,$04,$80,$04        ;;B427|B957+B92D/B957\B967;
                      db $00,$04,$00,$00,$00,$00,$00,$00        ;;B42F|B95F+B935/B95F\B96F;
                      db $00,$00,$00,$00                        ;;B437|B967+B93D/B967\B977;
                                                                ;;                        ;
DATA_05B96B:          db $00,$00,$00,$00,$00,$00,$01,$01        ;;B43B|B96B+B941/B96B\B97B;
                      db $01,$01,$01,$01,$01,$01,$02,$02        ;;B443|B973+B949/B973\B983;
                      db $02,$02                                ;;B44B|B97B+B951/B97B\B98B;
                                                                ;;                        ;
DATA_05B97D:          db $02,$00,$00,$00,$00,$00,$00,$00        ;;B44D|B97D+B953/B97D\B98D;
                      db $00,$01,$00,$02,$02,$00                ;;B455|B985+B95B/B985\B995;
                                                                ;;                        ;
DATA_05B98B:          db $00,$05,$0A,$0F,$14,$14,$19,$14        ;;B45B|B98B+B961/B98B\B99B;
                      db $0A,$14,$00,$05,$00,$14                ;;B463|B993+B969/B993\B9A3;
                                                                ;;                        ;
AnimatedTileData:     dw !AnimatedTiles+$1800                   ;;B469|B999+B96F/B999\B9A9; ? Block frame 1
                      dw !AnimatedTiles+$1A00                   ;;B46B|B99B+B971/B99B\B9AB; ? Block frame 2
                      dw !AnimatedTiles+$1C00                   ;;B46D|B99D+B973/B99D\B9AD; ? Block frame 3
                      dw !AnimatedTiles+$1E00                   ;;B46F|B99F+B975/B99F\B9AF; ? Block frame 4
                      dw !AnimatedTiles+$1880                   ;;B471|B9A1+B977/B9A1\B9B1; Note block frame 1
                      dw !AnimatedTiles+$1A80                   ;;B473|B9A3+B979/B9A3\B9B3; Note block frame 2
                      dw !AnimatedTiles+$1C80                   ;;B475|B9A5+B97B/B9A5\B9B5; Note block frame 3
                      dw !AnimatedTiles+$1E80                   ;;B477|B9A7+B97D/B9A7\B9B7; Note block frame 4
                      dw !AnimatedTiles+$1900                   ;;B479|B9A9+B97F/B9A9\B9B9; Turn block
                      dw !AnimatedTiles+$1900                   ;;B47B|B9AB+B981/B9AB\B9BB; Turn block
                      dw !AnimatedTiles+$1900                   ;;B47D|B9AD+B983/B9AD\B9BD; Turn block
                      dw !AnimatedTiles+$1900                   ;;B47F|B9AF+B985/B9AF\B9BF; Turn block
                      dw !AnimatedTiles+$2080                   ;;B481|B9B1+B987/B9B1\B9C1; Midway point frame 1
                      dw !AnimatedTiles+$2280                   ;;B483|B9B3+B989/B9B3\B9C3; Midway point frame 2
                      dw !AnimatedTiles+$2480                   ;;B485|B9B5+B98B/B9B5\B9C5; Midway point frame 3
                      dw !AnimatedTiles+$2680                   ;;B487|B9B7+B98D/B9B7\B9C7; Midway point frame 4
                      dw !AnimatedTiles+$1900                   ;;B489|B9B9+B98F/B9B9\B9C9; Spinning turn block frame 1
                      dw !AnimatedTiles+$1B00                   ;;B48B|B9BB+B991/B9BB\B9CB; Spinning turn block frame 2
                      dw !AnimatedTiles+$1D00                   ;;B48D|B9BD+B993/B9BD\B9CD; Spinning turn block frame 3
                      dw !AnimatedTiles+$1F00                   ;;B48F|B9BF+B995/B9BF\B9CF; Spinning turn block frame 4
                      dw !AnimatedTiles-$F80                    ;;B491|B9C1+B997/B9C1\B9D1; Berry frame 1
                      dw !AnimatedTiles-$D80                    ;;B493|B9C3+B999/B9C3\B9D3; Berry frame 2
                      dw !AnimatedTiles-$100                    ;;B495|B9C5+B99B/B9C5\B9D5; Berry frame 3
                      dw !AnimatedTiles-$80                     ;;B497|B9C7+B99D/B9C7\B9D7; Berry frame 4
                      dw !AnimatedTiles+$2F20                   ;;B499|B9C9+B99F/B9C9\B9D9; Blank
                      dw !AnimatedTiles+$2F20                   ;;B49B|B9CB+B9A1/B9CB\B9DB; Blank
                      dw !AnimatedTiles+$2F20                   ;;B49D|B9CD+B9A3/B9CD\B9DD; Blank
                      dw !AnimatedTiles+$2F20                   ;;B49F|B9CF+B9A5/B9CF\B9DF; Blank
                      dw !AnimatedTiles+$2F20                   ;;B4A1|B9D1+B9A7/B9D1\B9E1; Blank
                      dw !AnimatedTiles+$2F20                   ;;B4A3|B9D3+B9A9/B9D3\B9E3; Blank
                      dw !AnimatedTiles+$2F20                   ;;B4A5|B9D5+B9AB/B9D5\B9E5; Blank
                      dw !AnimatedTiles+$2F20                   ;;B4A7|B9D7+B9AD/B9D7\B9E7; Blank
                      dw !AnimatedTiles+$1680                   ;;B4A9|B9D9+B9AF/B9D9\B9E9; Used block
                      dw !AnimatedTiles+$1680                   ;;B4AB|B9DB+B9B1/B9DB\B9EB; Used block
                      dw !AnimatedTiles+$1680                   ;;B4AD|B9DD+B9B3/B9DD\B9ED; Used block
                      dw !AnimatedTiles+$1680                   ;;B4AF|B9DF+B9B5/B9DF\B9EF; Used block
                      dw !AnimatedTiles+$2700                   ;;B4B1|B9E1+B9B7/B9E1\B9F1; Muncher frame 1
                      dw !AnimatedTiles+$2780                   ;;B4B3|B9E3+B9B9/B9E3\B9F3; Muncher frame 2
                      dw !AnimatedTiles+$2700                   ;;B4B5|B9E5+B9BB/B9E5\B9F5; Muncher frame 1
                      dw !AnimatedTiles+$2780                   ;;B4B7|B9E7+B9BD/B9E7\B9F7; Muncher frame 2
                      dw !AnimatedTiles+$2F20                   ;;B4B9|B9E9+B9BF/B9E9\B9F9; Blank
                      dw !AnimatedTiles+$2F20                   ;;B4BB|B9EB+B9C1/B9EB\B9FB; Blank
                      dw !AnimatedTiles+$2F20                   ;;B4BD|B9ED+B9C3/B9ED\B9FD; Blank
                      dw !AnimatedTiles+$2F20                   ;;B4BF|B9EF+B9C5/B9EF\B9FF; Blank
                      dw !AnimatedTiles+$2F00                   ;;B4C1|B9F1+B9C7/B9F1\BA01; Line guide top-right bottom-left
                      dw !AnimatedTiles+$2F00                   ;;B4C3|B9F3+B9C9/B9F3\BA03; Line guide top-right bottom-left
                      dw !AnimatedTiles+$2F00                   ;;B4C5|B9F5+B9CB/B9F5\BA05; Line guide top-right bottom-left
                      dw !AnimatedTiles+$2F00                   ;;B4C7|B9F7+B9CD/B9F7\BA07; Line guide top-right bottom-left
                      dw !AnimatedTiles+$1400                   ;;B4C9|B9F9+B9CF/B9F9\BA09; On/Off block ON
                      dw !AnimatedTiles+$1400                   ;;B4CB|B9FB+B9D1/B9FB\BA0B; On/Off block ON
                      dw !AnimatedTiles+$1400                   ;;B4CD|B9FD+B9D3/B9FD\BA0D; On/Off block ON
                      dw !AnimatedTiles+$1400                   ;;B4CF|B9FF+B9D5/B9FF\BA0F; On/Off block ON
                      dw !AnimatedTiles+$1980                   ;;B4D1|BA01+B9D7/BA01\BA11; Coin frame 1
                      dw !AnimatedTiles+$1B80                   ;;B4D3|BA03+B9D9/BA03\BA13; Coin frame 2
                      dw !AnimatedTiles+$1D80                   ;;B4D5|BA05+B9DB/BA05\BA15; Coin frame 3
                      dw !AnimatedTiles+$1F80                   ;;B4D7|BA07+B9DD/BA07\BA17; Coin frame 4
                      dw !AnimatedTiles+$2000                   ;;B4D9|BA09+B9DF/BA09\BA19; Water frame 1
                      dw !AnimatedTiles+$2200                   ;;B4DB|BA0B+B9E1/BA0B\BA1B; Water frame 2
                      dw !AnimatedTiles+$2400                   ;;B4DD|BA0D+B9E3/BA0D\BA1D; Water frame 3
                      dw !AnimatedTiles+$2600                   ;;B4DF|BA0F+B9E5/BA0F\BA1F; Water frame 4
                      dw !AnimatedTiles+$1180                   ;;B4E1|BA11+B9E7/BA11\BA21; Lava frame 1
                      dw !AnimatedTiles+$1380                   ;;B4E3|BA13+B9E9/BA13\BA23; Lava frame 2
                      dw !AnimatedTiles+$1580                   ;;B4E5|BA15+B9EB/BA15\BA25; Lava frame 3
                      dw !AnimatedTiles+$1780                   ;;B4E7|BA17+B9ED/BA17\BA27; Lava frame 4
                      dw !AnimatedTiles+$1800                   ;;B4E9|BA19+B9EF/BA19\BA29; ? Block
                      dw !AnimatedTiles+$1800                   ;;B4EB|BA1B+B9F1/BA1B\BA2B; ? Block
                      dw !AnimatedTiles+$1800                   ;;B4ED|BA1D+B9F3/BA1D\BA2D; ? Block
                      dw !AnimatedTiles+$1800                   ;;B4EF|BA1F+B9F5/BA1F\BA2F; ? Block
                      dw !AnimatedTiles+$1800                   ;;B4F1|BA21+B9F7/BA21\BA31; ? Block
                      dw !AnimatedTiles+$1800                   ;;B4F3|BA23+B9F9/BA23\BA33; ? Block
                      dw !AnimatedTiles+$1800                   ;;B4F5|BA25+B9FB/BA25\BA35; ? Block
                      dw !AnimatedTiles+$1800                   ;;B4F7|BA27+B9FD/BA27\BA37; ? Block
                      dw !AnimatedTiles+$1800                   ;;B4F9|BA29+B9FF/BA29\BA39; ? Block
                      dw !AnimatedTiles+$1800                   ;;B4FB|BA2B+BA01/BA2B\BA3B; ? Block
                      dw !AnimatedTiles+$1800                   ;;B4FD|BA2D+BA03/BA2D\BA3D; ? Block
                      dw !AnimatedTiles+$1800                   ;;B4FF|BA2F+BA05/BA2F\BA3F; ? Block
                      dw !AnimatedTiles+$2000                   ;;B501|BA31+BA07/BA31\BA41; Water frame 1
                      dw !AnimatedTiles+$2200                   ;;B503|BA33+BA09/BA33\BA43; Water frame 2
                      dw !AnimatedTiles+$2400                   ;;B505|BA35+BA0B/BA35\BA45; Water frame 3
                      dw !AnimatedTiles+$2600                   ;;B507|BA37+BA0D/BA37\BA47; Water frame 4
DATA_05BA39:          dw !AnimatedTiles+$1180                   ;;B509|BA39+BA0F/BA39\BA49; Coin frame 1
                      dw !AnimatedTiles+$1380                   ;;B50B|BA3B+BA11/BA3B\BA4B; Coin frame 2
                      dw !AnimatedTiles+$1580                   ;;B50D|BA3D+BA13/BA3D\BA4D; Coin frame 3
                      dw !AnimatedTiles+$1780                   ;;B50F|BA3F+BA15/BA3F\BA4F; Coin frame 4
                      dw !AnimatedTiles                         ;;B511|BA41+BA17/BA41\BA51; Escalator Up frame 1
                      dw !AnimatedTiles+$200                    ;;B513|BA43+BA19/BA43\BA53; Escalator Up frame 2
                      dw !AnimatedTiles+$400                    ;;B515|BA45+BA1B/BA45\BA55; Escalator Up frame 3
                      dw !AnimatedTiles+$600                    ;;B517|BA47+BA1D/BA47\BA57; Escalator Up frame 4
                      dw !AnimatedTiles+$600                    ;;B519|BA49+BA1F/BA49\BA59; Escalator Down frame 1
                      dw !AnimatedTiles+$400                    ;;B51B|BA4B+BA21/BA4B\BA5B; Escalator Down frame 2
                      dw !AnimatedTiles+$200                    ;;B51D|BA4D+BA23/BA4D\BA5D; Escalator Down frame 3
                      dw !AnimatedTiles                         ;;B51F|BA4F+BA25/BA4F\BA5F; Escalator Down frame 4
                      dw !AnimatedTiles+$2100                   ;;B521|BA51+BA27/BA51\BA61; Candle glow frame 1
                      dw !AnimatedTiles+$2300                   ;;B523|BA53+BA29/BA53\BA63; Candle glow frame 2
                      dw !AnimatedTiles+$2500                   ;;B525|BA55+BA2B/BA55\BA65; Candle glow frame 3
                      dw !AnimatedTiles+$2300                   ;;B527|BA57+BA2D/BA57\BA67; Candle glow frame 2
                      dw !AnimatedTiles+$2000                   ;;B529|BA59+BA2F/BA59\BA69; Water frame 1
                      dw !AnimatedTiles+$2200                   ;;B52B|BA5B+BA31/BA5B\BA6B; Water frame 2
                      dw !AnimatedTiles+$2400                   ;;B52D|BA5D+BA33/BA5D\BA6D; Water frame 3
                      dw !AnimatedTiles+$2600                   ;;B52F|BA5F+BA35/BA5F\BA6F; Water frame 4
                      dw !AnimatedTiles+$2800                   ;;B531|BA61+BA37/BA61\BA71; Line guide stopper & Rope frame 1
                      dw !AnimatedTiles+$2A00                   ;;B533|BA63+BA39/BA63\BA73; Line guide stopper & Rope frame 2
                      dw !AnimatedTiles+$2C00                   ;;B535|BA65+BA3B/BA65\BA75; Line guide stopper & Rope frame 3
                      dw !AnimatedTiles+$2E00                   ;;B537|BA67+BA3D/BA67\BA77; Line guide stopper & Rope frame 4
                      dw !AnimatedTiles+$2880                   ;;B539|BA69+BA3F/BA69\BA79; Diagonal rope Up frame 1
                      dw !AnimatedTiles+$2A80                   ;;B53B|BA6B+BA41/BA6B\BA7B; Diagonal rope Up frame 2
                      dw !AnimatedTiles+$2C80                   ;;B53D|BA6D+BA43/BA6D\BA7D; Diagonal rope Up frame 3
                      dw !AnimatedTiles+$2E80                   ;;B53F|BA6F+BA45/BA6F\BA7F; Diagonal rope Up frame 4
                      dw !AnimatedTiles+$2E80                   ;;B541|BA71+BA47/BA71\BA81; Diagonal rope Down frame 1
                      dw !AnimatedTiles+$2C80                   ;;B543|BA73+BA49/BA73\BA83; Diagonal rope Down frame 2
                      dw !AnimatedTiles+$2A80                   ;;B545|BA75+BA4B/BA75\BA85; Diagonal rope Down frame 3
                      dw !AnimatedTiles+$2880                   ;;B547|BA77+BA4D/BA77\BA87; Diagonal rope Down frame 4
                      dw !AnimatedTiles+$1800                   ;;B549|BA79+BA4F/BA79\BA89; ? Block
                      dw !AnimatedTiles+$1800                   ;;B54B|BA7B+BA51/BA7B\BA8B; ? Block
                      dw !AnimatedTiles+$1800                   ;;B54D|BA7D+BA53/BA7D\BA8D; ? Block
                      dw !AnimatedTiles+$1800                   ;;B54F|BA7F+BA55/BA7F\BA8F; ? Block
                      dw !AnimatedTiles+$2180                   ;;B551|BA81+BA57/BA81\BA91; Shining stars frame 1
                      dw !AnimatedTiles+$2380                   ;;B553|BA83+BA59/BA83\BA93; Shining stars frame 2
                      dw !AnimatedTiles+$2580                   ;;B555|BA85+BA5B/BA85\BA95; Shining stars frame 3
                      dw !AnimatedTiles+$2380                   ;;B557|BA87+BA5D/BA87\BA97; Shining stars frame 2
                      dw !AnimatedTiles+$80                     ;;B559|BA89+BA5F/BA89\BA99; Gradual sloped lava frame 1
                      dw !AnimatedTiles+$280                    ;;B55B|BA8B+BA61/BA8B\BA9B; Gradual sloped lava frame 2
                      dw !AnimatedTiles+$480                    ;;B55D|BA8D+BA63/BA8D\BA9D; Gradual sloped lava frame 3
                      dw !AnimatedTiles+$680                    ;;B55F|BA8F+BA65/BA8F\BA9F; Gradual sloped lava frame 4
                      dw !AnimatedTiles+$100                    ;;B561|BA91+BA67/BA91\BAA1; Diagonal sloped lava frame 1
                      dw !AnimatedTiles+$300                    ;;B563|BA93+BA69/BA93\BAA3; Diagonal sloped lava frame 2
                      dw !AnimatedTiles+$500                    ;;B565|BA95+BA6B/BA95\BAA5; Diagonal sloped lava frame 3
                      dw !AnimatedTiles+$700                    ;;B567|BA97+BA6D/BA97\BAA7; Diagonal sloped lava frame 4
                      dw !AnimatedTiles+$180                    ;;B569|BA99+BA6F/BA99\BAA9; Lava wall frame 1
                      dw !AnimatedTiles+$380                    ;;B56B|BA9B+BA71/BA9B\BAAB; Lava wall frame 2
                      dw !AnimatedTiles+$580                    ;;B56D|BA9D+BA73/BA9D\BAAD; Lava wall frame 3
                      dw !AnimatedTiles+$780                    ;;B56F|BA9F+BA75/BA9F\BAAF; Lava wall frame 4
                      dw !AnimatedTiles+$680                    ;;B571|BAA1+BA77/BAA1\BAB1; Gradual sloped lava frame 4
                      dw !AnimatedTiles+$480                    ;;B573|BAA3+BA79/BAA3\BAB3; Gradual sloped lava frame 3
                      dw !AnimatedTiles+$280                    ;;B575|BAA5+BA7B/BAA5\BAB5; Gradual sloped lava frame 2
                      dw !AnimatedTiles+$80                     ;;B577|BAA7+BA7D/BAA7\BAB7; Gradual sloped lava frame 1
                      dw !AnimatedTiles+$1800                   ;;B579|BAA9+BA7F/BAA9\BAB9; ? Block
                      dw !AnimatedTiles+$1800                   ;;B57B|BAAB+BA81/BAAB\BABB; ? Block
                      dw !AnimatedTiles+$1800                   ;;B57D|BAAD+BA83/BAAD\BABD; ? Block
                      dw !AnimatedTiles+$1800                   ;;B57F|BAAF+BA85/BAAF\BABF; ? Block
                      dw !AnimatedTiles+$2980                   ;;B581|BAB1+BA87/BAB1\BAC1; Ghost House lantern frame 1
                      dw !AnimatedTiles+$2B80                   ;;B583|BAB3+BA89/BAB3\BAC3; Ghost House lantern frame 2
                      dw !AnimatedTiles+$2D80                   ;;B585|BAB5+BA8B/BAB5\BAC5; Ghost House lantern frame 3
                      dw !AnimatedTiles+$2B80                   ;;B587|BAB7+BA8D/BAB7\BAC7; Ghost House lantern frame 4
                      dw !AnimatedTiles+$1100                   ;;B589|BAB9+BA8F/BAB9\BAC9; Seaweed frame 1
                      dw !AnimatedTiles+$1300                   ;;B58B|BABB+BA91/BABB\BACB; Seaweed frame 2
                      dw !AnimatedTiles+$1500                   ;;B58D|BABD+BA93/BABD\BACD; Seaweed frame 3
                      dw !AnimatedTiles+$1700                   ;;B58F|BABF+BA95/BABF\BACF; Seaweed frame 4
                      dw !AnimatedTiles+$1800                   ;;B591|BAC1+BA97/BAC1\BAD1; ? Block
                      dw !AnimatedTiles+$1800                   ;;B593|BAC3+BA99/BAC3\BAD3; ? Block
                      dw !AnimatedTiles+$1800                   ;;B595|BAC5+BA9B/BAC5\BAD5; ? Block
                      dw !AnimatedTiles+$1800                   ;;B597|BAC7+BA9D/BAC7\BAD7; ? Block
                      dw !AnimatedTiles+$1800                   ;;B599|BAC9+BA9F/BAC9\BAD9; ? Block
                      dw !AnimatedTiles+$1800                   ;;B59B|BACB+BAA1/BACB\BADB; ? Block
                      dw !AnimatedTiles+$1800                   ;;B59D|BACD+BAA3/BACD\BADD; ? Block
                      dw !AnimatedTiles+$1800                   ;;B59F|BACF+BAA5/BACF\BADF; ? Block
                      dw !AnimatedTiles+$2180                   ;;B5A1|BAD1+BAA7/BAD1\BAE1; Shining stars frame 1
                      dw !AnimatedTiles+$2380                   ;;B5A3|BAD3+BAA9/BAD3\BAE3; Shining stars frame 2
                      dw !AnimatedTiles+$2580                   ;;B5A5|BAD5+BAAB/BAD5\BAE5; Shining stars frame 3
                      dw !AnimatedTiles+$2380                   ;;B5A7|BAD7+BAAD/BAD7\BAE7; Shining stars frame 2
                      dw !AnimatedTiles+$2900                   ;;B5A9|BAD9+BAAF/BAD9\BAE9; Twinkling stars frame 1
                      dw !AnimatedTiles+$2B00                   ;;B5AB|BADB+BAB1/BADB\BAEB; Twinkling stars frame 2
                      dw !AnimatedTiles+$2D00                   ;;B5AD|BADD+BAB3/BADD\BAED; Twinkling stars frame 3
                      dw !AnimatedTiles+$2B00                   ;;B5AF|BADF+BAB5/BADF\BAEF; Twinkling stars frame 2
                      dw !AnimatedTiles+$1800                   ;;B5B1|BAE1+BAB7/BAE1\BAF1; ? Block
                      dw !AnimatedTiles+$1800                   ;;B5B3|BAE3+BAB9/BAE3\BAF3; ? Block
                      dw !AnimatedTiles+$1800                   ;;B5B5|BAE5+BABB/BAE5\BAF5; ? Block
                      dw !AnimatedTiles+$1800                   ;;B5B7|BAE7+BABD/BAE7\BAF7; ? Block
                      dw !AnimatedTiles+$1800                   ;;B5B9|BAE9+BABF/BAE9\BAF9; ? Block
                      dw !AnimatedTiles+$1800                   ;;B5BB|BAEB+BAC1/BAEB\BAFB; ? Block
                      dw !AnimatedTiles+$1800                   ;;B5BD|BAED+BAC3/BAED\BAFD; ? Block
                      dw !AnimatedTiles+$1800                   ;;B5BF|BAEF+BAC5/BAEF\BAFF; ? Block
                      dw !AnimatedTiles+$1800                   ;;B5C1|BAF1+BAC7/BAF1\BB01; ? Block
                      dw !AnimatedTiles+$1800                   ;;B5C3|BAF3+BAC9/BAF3\BB03; ? Block
                      dw !AnimatedTiles+$1800                   ;;B5C5|BAF5+BACB/BAF5\BB05; ? Block
                      dw !AnimatedTiles+$1800                   ;;B5C7|BAF7+BACD/BAF7\BB07; ? Block
                      dw !AnimatedTiles+$1480                   ;;B5C9|BAF9+BACF/BAF9\BB09; Door
                      dw !AnimatedTiles+$1480                   ;;B5CB|BAFB+BAD1/BAFB\BB0B; Door
                      dw !AnimatedTiles+$1480                   ;;B5CD|BAFD+BAD3/BAFD\BB0D; Door
                      dw !AnimatedTiles+$1480                   ;;B5CF|BAFF+BAD5/BAFF\BB0F; Door
                      dw !AnimatedTiles+$1980                   ;;B5D1|BB01+BAD7/BB01\BB11; Coin frame 1
                      dw !AnimatedTiles+$1B80                   ;;B5D3|BB03+BAD9/BB03\BB13; Coin frame 2
                      dw !AnimatedTiles+$1D80                   ;;B5D5|BB05+BADB/BB05\BB15; Coin frame 3
                      dw !AnimatedTiles+$1F80                   ;;B5D7|BB07+BADD/BB07\BB17; Coin frame 4
                      dw !AnimatedTiles+$1980                   ;;B5D9|BB09+BADF/BB09\BB19; Coin frame 1
                      dw !AnimatedTiles+$1B80                   ;;B5DB|BB0B+BAE1/BB0B\BB1B; Coin frame 2
                      dw !AnimatedTiles+$1D80                   ;;B5DD|BB0D+BAE3/BB0D\BB1D; Coin frame 3
                      dw !AnimatedTiles+$1F80                   ;;B5DF|BB0F+BAE5/BB0F\BB1F; Coin frame 4
                      dw !AnimatedTiles+$1980                   ;;B5E1|BB11+BAE7/BB11\BB21; Coin frame 1
                      dw !AnimatedTiles+$1B80                   ;;B5E3|BB13+BAE9/BB13\BB23; Coin frame 2
                      dw !AnimatedTiles+$1D80                   ;;B5E5|BB15+BAEB/BB15\BB25; Coin frame 3
                      dw !AnimatedTiles+$1F80                   ;;B5E7|BB17+BAED/BB17\BB27; Coin frame 4
                      dw !AnimatedTiles+$1800                   ;;B5E9|BB19+BAEF/BB19\BB29; ? Block frame 1
                      dw !AnimatedTiles+$1A00                   ;;B5EB|BB1B+BAF1/BB1B\BB2B; ? Block frame 2
                      dw !AnimatedTiles+$1C00                   ;;B5ED|BB1D+BAF3/BB1D\BB2D; ? Block frame 3
                      dw !AnimatedTiles+$1E00                   ;;B5EF|BB1F+BAF5/BB1F\BB2F; ? Block frame 4
                      dw !AnimatedTiles+$2F80                   ;;B5F1|BB21+BAF7/BB21\BB31; Line guide top-left bottom-right
                      dw !AnimatedTiles+$2F80                   ;;B5F3|BB23+BAF9/BB23\BB33; Line guide top-left bottom-right
                      dw !AnimatedTiles+$2F80                   ;;B5F5|BB25+BAFB/BB25\BB35; Line guide top-left bottom-right
                      dw !AnimatedTiles+$2F80                   ;;B5F7|BB27+BAFD/BB27\BB37; Line guide top-left bottom-right
                      dw !AnimatedTiles+$1600                   ;;B5F9|BB29+BAFF/BB29\BB39; On/Off block OFF
                      dw !AnimatedTiles+$1600                   ;;B5FB|BB2B+BB01/BB2B\BB3B; On/Off block OFF
                      dw !AnimatedTiles+$1600                   ;;B5FD|BB2D+BB03/BB2D\BB3D; On/Off block OFF
                      dw !AnimatedTiles+$1600                   ;;B5FF|BB2F+BB05/BB2F\BB3F; On/Off block OFF
                      dw !AnimatedTiles+$1680                   ;;B601|BB31+BB07/BB31\BB41; Used block
                      dw !AnimatedTiles+$1680                   ;;B603|BB33+BB09/BB33\BB43; Used block
                      dw !AnimatedTiles+$1680                   ;;B605|BB35+BB0B/BB35\BB45; Used block
                      dw !AnimatedTiles+$1680                   ;;B607|BB37+BB0D/BB37\BB47; Used block
                                                                ;;                        ;
CODE_05BB39:          PHB                                       ;;B609|BB39+BB0F/BB39\BB49;
                      PHK                                       ;;B60A|BB3A+BB10/BB3A\BB4A;
                      PLB                                       ;;B60B|BB3B+BB11/BB3B\BB4B;
                      LDA.B !EffFrame                           ;;B60C|BB3C+BB12/BB3C\BB4C;
                      AND.B #$07                                ;;B60E|BB3E+BB14/BB3E\BB4E;
                      STA.B !_0                                 ;;B610|BB40+BB16/BB40\BB50;
                      ASL A                                     ;;B612|BB42+BB18/BB42\BB52;
                      ADC.B !_0                                 ;;B613|BB43+BB19/BB43\BB53;
                      TAY                                       ;;B615|BB45+BB1B/BB45\BB55;
                      ASL A                                     ;;B616|BB46+BB1C/BB46\BB56;
                      TAX                                       ;;B617|BB47+BB1D/BB47\BB57;
                      REP #$20                                  ;;B618|BB48+BB1E/BB48\BB58; Accum (16 bit)
                      LDA.B !EffFrame                           ;;B61A|BB4A+BB20/BB4A\BB5A;
                      AND.W #$0018                              ;;B61C|BB4C+BB22/BB4C\BB5C;
                      LSR A                                     ;;B61F|BB4F+BB25/BB4F\BB5F;
                      LSR A                                     ;;B620|BB50+BB26/BB50\BB60;
                      STA.B !_0                                 ;;B621|BB51+BB27/BB51\BB61;
                      LDA.W DATA_05B93B,X                       ;;B623|BB53+BB29/BB53\BB63;
                      STA.W !Gfx33DestAddrC                     ;;B626|BB56+BB2C/BB56\BB66;
                      LDA.W DATA_05B93D,X                       ;;B629|BB59+BB2F/BB59\BB69;
                      STA.W !Gfx33DestAddrB                     ;;B62C|BB5C+BB32/BB5C\BB6C;
                      LDA.W DATA_05B93F,X                       ;;B62F|BB5F+BB35/BB5F\BB6F;
                      STA.W !Gfx33DestAddrA                     ;;B632|BB62+BB38/BB62\BB72;
                      LDX.B #$04                                ;;B635|BB65+BB3B/BB65\BB75;
CODE_05BB67:          PHY                                       ;;B637|BB67+BB3D/BB67\BB77;
                      PHX                                       ;;B638|BB68+BB3E/BB68\BB78;
                      SEP #$20                                  ;;B639|BB69+BB3F/BB69\BB79; Accum (8 bit)
                      TYA                                       ;;B63B|BB6B+BB41/BB6B\BB7B;
                      LDX.W DATA_05B96B,Y                       ;;B63C|BB6C+BB42/BB6C\BB7C;
                      BEQ CODE_05BB88                           ;;B63F|BB6F+BB45/BB6F\BB7F;
                      DEX                                       ;;B641|BB71+BB47/BB71\BB81;
                      BNE CODE_05BB81                           ;;B642|BB72+BB48/BB72\BB82;
                      LDX.W DATA_05B97D,Y                       ;;B644|BB74+BB4A/BB74\BB84;
                      LDY.W !BluePSwitchTimer,X                 ;;B647|BB77+BB4D/BB77\BB87;
                      BEQ CODE_05BB88                           ;;B64A|BB7A+BB50/BB7A\BB8A;
                      CLC                                       ;;B64C|BB7C+BB52/BB7C\BB8C;
                      ADC.B #$26                                ;;B64D|BB7D+BB53/BB7D\BB8D;
                      BRA CODE_05BB88                           ;;B64F|BB7F+BB55/BB7F\BB8F;
                                                                ;;                        ;
CODE_05BB81:          LDY.W !ObjectTileset                      ;;B651|BB81+BB57/BB81\BB91;
                      CLC                                       ;;B654|BB84+BB5A/BB84\BB94;
                      ADC.W DATA_05B98B,Y                       ;;B655|BB85+BB5B/BB85\BB95;
CODE_05BB88:          REP #$30                                  ;;B658|BB88+BB5E/BB88\BB98; Index (16 bit) Accum (16 bit)
                      AND.W #$00FF                              ;;B65A|BB8A+BB60/BB8A\BB9A;
                      ASL A                                     ;;B65D|BB8D+BB63/BB8D\BB9D;
                      ASL A                                     ;;B65E|BB8E+BB64/BB8E\BB9E;
                      ASL A                                     ;;B65F|BB8F+BB65/BB8F\BB9F;
                      ORA.B !_0                                 ;;B660|BB90+BB66/BB90\BBA0;
                      TAY                                       ;;B662|BB92+BB68/BB92\BBA2;
                      LDA.W AnimatedTileData,Y                  ;;B663|BB93+BB69/BB93\BBA3;
                      SEP #$10                                  ;;B666|BB96+BB6C/BB96\BBA6; Index (8 bit)
                      PLX                                       ;;B668|BB98+BB6E/BB98\BBA8;
                      STA.W !Gfx33SrcAddrA,X                    ;;B669|BB99+BB6F/BB99\BBA9;
                      PLY                                       ;;B66C|BB9C+BB72/BB9C\BBAC;
                      INY                                       ;;B66D|BB9D+BB73/BB9D\BBAD;
                      DEX                                       ;;B66E|BB9E+BB74/BB9E\BBAE;
                      DEX                                       ;;B66F|BB9F+BB75/BB9F\BBAF;
                      BPL CODE_05BB67                           ;;B670|BBA0+BB76/BBA0\BBB0;
                      SEP #$20                                  ;;B672|BBA2+BB78/BBA2\BBB2; Accum (8 bit)
                      PLB                                       ;;B674|BBA4+BB7A/BBA4\BBB4;
                      RTL                                       ;;B675|BBA5+BB7B/BBA5\BBB5; Return
                                                                ;;                        ;
                      %insert_empty($48A,$5A,$84,$5A,$4A)       ;;B676|BBA6+BB7C/BBA6\BBB6;
                                                                ;;                        ;
CODE_05BC00:          PHB                                       ;;BB00|BC00+BC00/BC00\BC00;
                      PHK                                       ;;BB01|BC01+BC01/BC01\BC01;
                      PLB                                       ;;BB02|BC02+BC02/BC02\BC02;
                      JSR CODE_05BC76                           ;;BB03|BC03+BC03/BC03\BC03;
                      JSR CODE_05BCA5                           ;;BB06|BC06+BC06/BC06\BC06;
                      JSR CODE_05BC4A                           ;;BB09|BC09+BC09/BC09\BC09;
                      LDA.W !NextLayer1XPos                     ;;BB0C|BC0C+BC0C/BC0C\BC0C;
                      SEC                                       ;;BB0F|BC0F+BC0F/BC0F\BC0F;
                      SBC.B !Layer1XPos                         ;;BB10|BC10+BC10/BC10\BC10;
                      CLC                                       ;;BB12|BC12+BC12/BC12\BC12;
                      ADC.W !Layer1DXPos                        ;;BB13|BC13+BC13/BC13\BC13;
                      STA.W !Layer1DXPos                        ;;BB16|BC16+BC16/BC16\BC16;
                      LDA.W !NextLayer1YPos                     ;;BB19|BC19+BC19/BC19\BC19;
                      SEC                                       ;;BB1C|BC1C+BC1C/BC1C\BC1C;
                      SBC.B !Layer1YPos                         ;;BB1D|BC1D+BC1D/BC1D\BC1D;
                      CLC                                       ;;BB1F|BC1F+BC1F/BC1F\BC1F;
                      ADC.W !Layer1DYPos                        ;;BB20|BC20+BC20/BC20\BC20;
                      STA.W !Layer1DYPos                        ;;BB23|BC23+BC23/BC23\BC23;
                      LDA.W !NextLayer2XPos                     ;;BB26|BC26+BC26/BC26\BC26;
                      SEC                                       ;;BB29|BC29+BC29/BC29\BC29;
                      SBC.B !Layer2XPos                         ;;BB2A|BC2A+BC2A/BC2A\BC2A;
                      LDY.W !Layer2ScrollCmd                    ;;BB2C|BC2C+BC2C/BC2C\BC2C;
                      DEY                                       ;;BB2F|BC2F+BC2F/BC2F\BC2F;
                      BNE +                                     ;;BB30|BC30+BC30/BC30\BC30;
                      TYA                                       ;;BB32|BC32+BC32/BC32\BC32;
                    + STA.W !Layer2DXPos                        ;;BB33|BC33+BC33/BC33\BC33;
                      LDA.W !NextLayer2YPos                     ;;BB36|BC36+BC36/BC36\BC36;
                      SEC                                       ;;BB39|BC39+BC39/BC39\BC39;
                      SBC.B !Layer2YPos                         ;;BB3A|BC3A+BC3A/BC3A\BC3A;
                      STA.W !Layer2DYPos                        ;;BB3C|BC3C+BC3C/BC3C\BC3C;
                      LDA.W !Layer3ScrollType                   ;;BB3F|BC3F+BC3F/BC3F\BC3F;
                      BNE +                                     ;;BB42|BC42+BC42/BC42\BC42;
                      JSR CODE_05C40C                           ;;BB44|BC44+BC44/BC44\BC44;
                    + PLB                                       ;;BB47|BC47+BC47/BC47\BC47;
                      RTL                                       ;;BB48|BC48+BC48/BC48\BC48; Return
                                                                ;;                        ;
Return05BC49:         RTS                                       ;;BB49|BC49+BC49/BC49\BC49; Return
                                                                ;;                        ;
CODE_05BC4A:          REP #$20                                  ;;BB4A|BC4A+BC4A/BC4A\BC4A; Accum (16 bit)
                      LDY.W !Layer3TideSetting                  ;;BB4C|BC4C+BC4C/BC4C\BC4C;
                      BNE CODE_05BC5F                           ;;BB4F|BC4F+BC4F/BC4F\BC4F;
                      LDA.W !NextLayer2XPos                     ;;BB51|BC51+BC51/BC51\BC51;
                      SEC                                       ;;BB54|BC54+BC54/BC54\BC54;
                      SBC.W !NextLayer1XPos                     ;;BB55|BC55+BC55/BC55\BC55;
                      STA.B !Layer23XRelPos                     ;;BB58|BC58+BC58/BC58\BC58;
                      LDA.W !NextLayer2YPos                     ;;BB5A|BC5A+BC5A/BC5A\BC5A;
                      BRA +                                     ;;BB5D|BC5D+BC5D/BC5D\BC5D;
                                                                ;;                        ;
CODE_05BC5F:          LDA.B !Layer3XPos                         ;;BB5F|BC5F+BC5F/BC5F\BC5F;
                      SEC                                       ;;BB61|BC61+BC61/BC61\BC61;
                      SBC.W !NextLayer1XPos                     ;;BB62|BC62+BC62/BC62\BC62;
                      STA.B !Layer23XRelPos                     ;;BB65|BC65+BC65/BC65\BC65;
                      LDA.B !Layer3YPos                         ;;BB67|BC67+BC67/BC67\BC67;
                    + SEC                                       ;;BB69|BC69+BC69/BC69\BC69;
                      SBC.W !NextLayer1YPos                     ;;BB6A|BC6A+BC6A/BC6A\BC6A;
                      STA.B !Layer23YRelPos                     ;;BB6D|BC6D+BC6D/BC6D\BC6D;
                      SEP #$20                                  ;;BB6F|BC6F+BC6F/BC6F\BC6F; Accum (8 bit)
                      RTS                                       ;;BB71|BC71+BC71/BC71\BC71; Return
                                                                ;;                        ;
CODE_05BC72:          JSR CODE_05BC4A                           ;;BB72|BC72+BC72/BC72\BC72;
                      RTL                                       ;;BB75|BC75+BC75/BC75\BC75; Return
                                                                ;;                        ;
CODE_05BC76:          STZ.W !ScrollLayerIndex                   ;;BB76|BC76+BC76/BC76\BC76;
                      LDA.W !SpriteLock                         ;;BB79|BC79+BC79/BC79\BC79;
                      BNE Return05BC49                          ;;BB7C|BC7C+BC7C/BC7C\BC7C;
                      LDA.W !Layer1ScrollCmd                    ;;BB7E|BC7E+BC7E/BC7E\BC7E;
                      BEQ Return05BC49                          ;;BB81|BC81+BC81/BC81\BC81;
                      JSL ExecutePtr                            ;;BB83|BC83+BC83/BC83\BC83;
                                                                ;;                        ;
                      dw CODE_05C04D                            ;;BB87|BC87+BC87/BC87\BC87; 00 - Auto-Scroll, Unused?
                      dw CODE_05C04D                            ;;BB89|BC89+BC89/BC89\BC89; 01 - Auto-Scroll
                      dw Return05BC49                           ;;BB8B|BC8B+BC8B/BC8B\BC8B; 02 - Layer 2 Smash
                      dw Return05BC49                           ;;BB8D|BC8D+BC8D/BC8D\BC8D; 03 - Layer 2 Scroll
                      dw ADDR_05C283                            ;;BB8F|BC8F+BC8F/BC8F\BC8F; 04 - Unused
                      dw ADDR_05C69E                            ;;BB91|BC91+BC91/BC91\BC91; 05 - Unused
                      dw Return05BC49                           ;;BB93|BC93+BC93/BC93\BC93; 06 - Layer 2 Falls
                      dw Return05BFF5                           ;;BB95|BC95+BC95/BC95\BC95; 07 - Unused
                      dw CODE_05C51F                            ;;BB97|BC97+BC97/BC97\BC97; 08 - Layer 2 Scroll
                      dw Return05BC49                           ;;BB99|BC99+BC99/BC99\BC99; 09 - Unused
                      dw ADDR_05C32E                            ;;BB9B|BC9B+BC9B/BC9B\BC9B; 0A - Unused
                      dw CODE_05C727                            ;;BB9D|BC9D+BC9D/BC9D\BC9D; 0B - Layer 2 On/Off Switch controlled
                      dw CODE_05C787                            ;;BB9F|BC9F+BC9F/BC9F\BC9F; 0C - Auto-Scroll level
                      dw Return05BC49                           ;;BBA1|BCA1+BCA1/BCA1\BCA1; 0D - Fast BG scroll
                      dw Return05BC49                           ;;BBA3|BCA3+BCA3/BCA3\BCA3; 0E - Layer 2 sink/rise
                                                                ;;                        ;
CODE_05BCA5:          LDA.B #$04                                ;;BBA5|BCA5+BCA5/BCA5\BCA5;
                      STA.W !ScrollLayerIndex                   ;;BBA7|BCA7+BCA7/BCA7\BCA7;
                      LDA.W !Layer2ScrollCmd                    ;;BBAA|BCAA+BCAA/BCAA\BCAA;
                      BEQ Return05BC49                          ;;BBAD|BCAD+BCAD/BCAD\BCAD;
                      LDY.W !SpriteLock                         ;;BBAF|BCAF+BCAF/BCAF\BCAF;
                      BNE Return05BC49                          ;;BBB2|BCB2+BCB2/BCB2\BCB2;
                      JSL ExecutePtr                            ;;BBB4|BCB4+BCB4/BCB4\BCB4;
                                                                ;;                        ;
                      dw CODE_05C04D                            ;;BBB8|BCB8+BCB8/BCB8\BCB8;
                      dw CODE_05C198                            ;;BBBA|BCBA+BCBA/BCBA\BCBA;
                      dw CODE_05C955                            ;;BBBC|BCBC+BCBC/BCBC\BCBC;
                      dw CODE_05C5BB                            ;;BBBE|BCBE+BCBE/BCBE\BCBE;
                      dw ADDR_05C283                            ;;BBC0|BCC0+BCC0/BCC0\BCC0;
                      dw Return05BC49                           ;;BBC2|BCC2+BCC2/BCC2\BCC2;
                      dw ADDR_05C659                            ;;BBC4|BCC4+BCC4/BCC4\BCC4;
                      dw Return05BFF5                           ;;BBC6|BCC6+BCC6/BCC6\BCC6;
                      dw CODE_05C51F                            ;;BBC8|BCC8+BCC8/BCC8\BCC8;
                      dw CODE_05C7C1                            ;;BBCA|BCCA+BCCA/BCCA\BCCA;
                      dw ADDR_05C32E                            ;;BBCC|BCCC+BCCC/BCCC\BCCC;
                      dw CODE_05C727                            ;;BBCE|BCCE+BCCE/BCCE\BCCE;
                      dw CODE_05C787                            ;;BBD0|BCD0+BCD0/BCD0\BCD0;
                      dw CODE_05C7BC                            ;;BBD2|BCD2+BCD2/BCD2\BCD2;
                      dw CODE_05C81C                            ;;BBD4|BCD4+BCD4/BCD4\BCD4;
                                                                ;;                        ;
CODE_05BCD6:          PHB                                       ;;BBD6|BCD6+BCD6/BCD6\BCD6;
                      PHK                                       ;;BBD7|BCD7+BCD7/BCD7\BCD7;
                      PLB                                       ;;BBD8|BCD8+BCD8/BCD8\BCD8;
                      STZ.W !ScrollLayerIndex                   ;;BBD9|BCD9+BCD9/BCD9\BCD9;
                      JSR CODE_05BCE9                           ;;BBDC|BCDC+BCDC/BCDC\BCDC;
                      LDA.B #$04                                ;;BBDF|BCDF+BCDF/BCDF\BCDF;
                      STA.W !ScrollLayerIndex                   ;;BBE1|BCE1+BCE1/BCE1\BCE1;
                      JSR CODE_05BD0E                           ;;BBE4|BCE4+BCE4/BCE4\BCE4;
                      PLB                                       ;;BBE7|BCE7+BCE7/BCE7\BCE7;
                      RTL                                       ;;BBE8|BCE8+BCE8/BCE8\BCE8; Return
                                                                ;;                        ;
CODE_05BCE9:          LDA.W !Layer1ScrollCmd                    ;;BBE9|BCE9+BCE9/BCE9\BCE9;
                      JSL ExecutePtr                            ;;BBEC|BCEC+BCEC/BCEC\BCEC;
                                                                ;;                        ;
                      dw CODE_05BD36                            ;;BBF0|BCF0+BCF0/BCF0\BCF0; 00 - Auto-Scroll, Unused?
                      dw CODE_05BD36                            ;;BBF2|BCF2+BCF2/BCF2\BCF2; 01 - Auto-Scroll
                      dw CODE_05BF6A                            ;;BBF4|BCF4+BCF4/BCF4\BCF4; 02 - Layer 2 Smash
                      dw CODE_05BF0A                            ;;BBF6|BCF6+BCF6/BCF6\BCF6; 03 - Layer 2 Scroll
                      dw ADDR_05BDDD                            ;;BBF8|BCF8+BCF8/BCF8\BCF8; 04 - Unused
                      dw ADDR_05BFBA                            ;;BBFA|BCFA+BCFA/BCFA\BCFA; 05 - Unused
                      dw ADDR_05BF97                            ;;BBFC|BCFC+BCFC/BCFC\BCFC; 06 - Layer 2 Falls
                      dw Return05BD35                           ;;BBFE|BCFE+BCFE/BCFE\BCFE; 07 - Unused
                      dw CODE_05BEA6                            ;;BC00|BD00+BD00/BD00\BD00; 08 - Layer 2 Scroll
                      dw Return05BC49                           ;;BC02|BD02+BD02/BD02\BD02; 09 - Unused
                      dw ADDR_05BE3A                            ;;BC04|BD04+BD04/BD04\BD04; 0A - Unused
                      dw CODE_05BFF6                            ;;BC06|BD06+BD06/BD06\BD06; 0B - Layer 2 On/Off Switch controlled
                      dw CODE_05C005                            ;;BC08|BD08+BD08/BD08\BD08; 0C - Auto-Scroll level
                      dw CODE_05C01A                            ;;BC0A|BD0A+BD0A/BD0A\BD0A; 0D - Fast BG scroll
                      dw CODE_05C036                            ;;BC0C|BD0C+BD0C/BD0C\BD0C; 0E - Layer 2 sink/rise
                                                                ;;                        ;
CODE_05BD0E:          LDA.W !Layer2ScrollCmd                    ;;BC0E|BD0E+BD0E/BD0E\BD0E;
                      BEQ Return05BD35                          ;;BC11|BD11+BD11/BD11\BD11;
                      JSL ExecutePtr                            ;;BC13|BD13+BD13/BD13\BD13;
                                                                ;;                        ;
                      dw CODE_05BD4C                            ;;BC17|BD17+BD17/BD17\BD17;
                      dw CODE_05BD4C                            ;;BC19|BD19+BD19/BD19\BD19;
                      dw Return05BC49                           ;;BC1B|BD1B+BD1B/BD1B\BD1B;
                      dw CODE_05BF20                            ;;BC1D|BD1D+BD1D/BD1D\BD1D;
                      dw ADDR_05BDF0                            ;;BC1F|BD1F+BD1F/BD1F\BD1F;
                      dw Return05BC49                           ;;BC21|BD21+BD21/BD21\BD21;
                      dw Return05BC49                           ;;BC23|BD23+BD23/BD23\BD23;
                      dw Return05BD35                           ;;BC25|BD25+BD25/BD25\BD25;
                      dw CODE_05BEC6                            ;;BC27|BD27+BD27/BD27\BD27;
                      dw CODE_05C022                            ;;BC29|BD29+BD29/BD29\BD29;
                      dw ADDR_05BE4D                            ;;BC2B|BD2B+BD2B/BD2B\BD2B;
                      dw Return05BC49                           ;;BC2D|BD2D+BD2D/BD2D\BD2D;
                      dw Return05BC49                           ;;BC2F|BD2F+BD2F/BD2F\BD2F;
                      dw Return05BC49                           ;;BC31|BD31+BD31/BD31\BD31;
                      dw Return05BC49                           ;;BC33|BD33+BD33/BD33\BD33;
                                                                ;;                        ;
Return05BD35:         RTS                                       ;;BC35|BD35+BD35/BD35\BD35; Return
                                                                ;;                        ;
CODE_05BD36:          STZ.W !HorizLayer1Setting                 ;;BC36|BD36+BD36/BD36\BD36;
                      LDA.W !Layer1ScrollBits                   ;;BC39|BD39+BD39/BD39\BD39;
                      ASL A                                     ;;BC3C|BD3C+BD3C/BD3C\BD3C;
                      TAY                                       ;;BC3D|BD3D+BD3D/BD3D\BD3D;
                      REP #$20                                  ;;BC3E|BD3E+BD3E/BD3E\BD3E; Accum (16 bit)
                      LDA.W DATA_05C9D1,Y                       ;;BC40|BD40+BD40/BD40\BD40;
                      STA.W !Layer1ScrollCmd                    ;;BC43|BD43+BD43/BD43\BD43;
                      LDA.W DATA_05C9DB,Y                       ;;BC46|BD46+BD46/BD46\BD46;
                      STA.W !Layer1ScrollBits                   ;;BC49|BD49+BD49/BD49\BD49;
CODE_05BD4C:          LDX.W !ScrollLayerIndex                   ;;BC4C|BD4C+BD4C/BD4C\BD4C;
                      REP #$20                                  ;;BC4F|BD4F+BD4F/BD4F\BD4F; Accum (16 bit)
                      STZ.W !Layer1ScrollXSpeed,X               ;;BC51|BD51+BD51/BD51\BD51;
                      STZ.W !Layer1ScrollYSpeed,X               ;;BC54|BD54+BD54/BD54\BD54;
                      STZ.W !Layer1ScrollXPosUpd,X              ;;BC57|BD57+BD57/BD57\BD57;
                      STZ.W !Layer1ScrollYPosUpd,X              ;;BC5A|BD5A+BD5A/BD5A\BD5A;
                      SEP #$20                                  ;;BC5D|BD5D+BD5D/BD5D\BD5D; Accum (8 bit)
                      TXA                                       ;;BC5F|BD5F+BD5F/BD5F\BD5F;
                      LSR A                                     ;;BC60|BD60+BD60/BD60\BD60;
                      LSR A                                     ;;BC61|BD61+BD61/BD61\BD61;
                      TAX                                       ;;BC62|BD62+BD62/BD62\BD62;
                      LDY.W !Layer1ScrollBits                   ;;BC63|BD63+BD63/BD63\BD63;
                      LDA.W !ScrollLayerIndex                   ;;BC66|BD66+BD66/BD66\BD66;
                      BEQ +                                     ;;BC69|BD69+BD69/BD69\BD69;
                      LDY.W !Layer2ScrollBits                   ;;BC6B|BD6B+BD6B/BD6B\BD6B;
                    + LDA.W DATA_05CA61,Y                       ;;BC6E|BD6E+BD6E/BD6E\BD6E;
                      STA.W !Layer1ScrollType,X                 ;;BC71|BD71+BD71/BD71\BD71;
                      LDA.W DATA_05CA68,Y                       ;;BC74|BD74+BD74/BD74\BD74;
                      STA.W !Layer1ScrollTimer,X                ;;BC77|BD77+BD77/BD77\BD77;
                      RTS                                       ;;BC7A|BD7A+BD7A/BD7A\BD7A; Return
                                                                ;;                        ;
                      LDA.W !Layer1ScrollBits                   ;;BC7B|BD7B+BD7B/BD7B\BD7B; \ Unreachable
                      ASL A                                     ;;BC7E|BD7E+BD7E/BD7E\BD7E;
                      TAY                                       ;;BC7F|BD7F+BD7F/BD7F\BD7F;
                      REP #$20                                  ;;BC80|BD80+BD80/BD80\BD80; Accum (16 bit)
                      LDA.W DATA_05C9E5,Y                       ;;BC82|BD82+BD82/BD82\BD82;
                      STA.W !Layer1ScrollCmd                    ;;BC85|BD85+BD85/BD85\BD85;
                      LDA.W DATA_05C9E7,Y                       ;;BC88|BD88+BD88/BD88\BD88;
                      STA.W !Layer1ScrollBits                   ;;BC8B|BD8B+BD8B/BD8B\BD8B;
                      REP #$20                                  ;;BC8E|BD8E+BD8E/BD8E\BD8E; Accum (16 bit)
                      LDY.W !Layer1ScrollBits                   ;;BC90|BD90+BD90/BD90\BD90;
                      LDA.W !ScrollLayerIndex                   ;;BC93|BD93+BD93/BD93\BD93;
                      AND.W #$00FF                              ;;BC96|BD96+BD96/BD96\BD96;
                      BEQ +                                     ;;BC99|BD99+BD99/BD99\BD99;
                      LDY.W !Layer2ScrollBits                   ;;BC9B|BD9B+BD9B/BD9B\BD9B;
                    + LDA.W !ScrollLayerIndex                   ;;BC9E|BD9E+BD9E/BD9E\BD9E;
                      AND.W #$00FF                              ;;BCA1|BDA1+BDA1/BDA1\BDA1;
                      LSR A                                     ;;BCA4|BDA4+BDA4/BDA4\BDA4;
                      LSR A                                     ;;BCA5|BDA5+BDA5/BDA5\BDA5;
                      TAX                                       ;;BCA6|BDA6+BDA6/BDA6\BDA6;
                      LDA.W DATA_05C9E9,Y                       ;;BCA7|BDA7+BDA7/BDA7\BDA7;
                      STA.W !Layer1ScrollType,X                 ;;BCAA|BDAA+BDAA/BDAA\BDAA;
                      LDA.W DATA_05CBC7,Y                       ;;BCAD|BDAD+BDAD/BDAD\BDAD;
                      AND.W #$00FF                              ;;BCB0|BDB0+BDB0/BDB0\BDB0;
                      BEQ +                                     ;;BCB3|BDB3+BDB3/BDB3\BDB3;
                      EOR.W #$FFFF                              ;;BCB5|BDB5+BDB5/BDB5\BDB5;
                      INC A                                     ;;BCB8|BDB8+BDB8/BDB8\BDB8;
                    + LDX.W !ScrollLayerIndex                   ;;BCB9|BDB9+BDB9/BDB9\BDB9;
                      CLC                                       ;;BCBC|BDBC+BDBC/BDBC\BDBC;
                      ADC.W !NextLayer1YPos,X                   ;;BCBD|BDBD+BDBD/BDBD\BDBD;
                      AND.W #$00FF                              ;;BCC0|BDC0+BDC0/BDC0\BDC0;
                      STA.W !Layer1ScrollXPosUpd,X              ;;BCC3|BDC3+BDC3/BDC3\BDC3;
                      STZ.W !Layer1ScrollYPosUpd,X              ;;BCC6|BDC6+BDC6/BDC6\BDC6;
CODE_05BDC9:          STZ.W !Layer1ScrollXSpeed,X               ;;BCC9|BDC9+BDC9/BDC9\BDC9;
                      STZ.W !Layer1ScrollYSpeed,X               ;;BCCC|BDCC+BDCC/BDCC\BDCC;
CODE_05BDCF:          SEP #$20                                  ;;BCCF|BDCF+BDCF/BDCF\BDCF; Accum (8 bit)
                      TXA                                       ;;BCD1|BDD1+BDD1/BDD1\BDD1;
                      LSR A                                     ;;BCD2|BDD2+BDD2/BDD2\BDD2;
                      LSR A                                     ;;BCD3|BDD3+BDD3/BDD3\BDD3;
                      AND.B #$FF                                ;;BCD4|BDD4+BDD4/BDD4\BDD4;
                      TAX                                       ;;BCD6|BDD6+BDD6/BDD6\BDD6;
                      LDA.B #$FF                                ;;BCD7|BDD7+BDD7/BDD7\BDD7;
                      STA.W !Layer1ScrollTimer,X                ;;BCD9|BDD9+BDD9/BDD9\BDD9;
                      RTS                                       ;;BCDC|BDDC+BDDC/BDDC\BDDC; Return
                                                                ;;                        ;
ADDR_05BDDD:          LDA.W !Layer1ScrollBits                   ;;BCDD|BDDD+BDDD/BDDD\BDDD;
                      ASL A                                     ;;BCE0|BDE0+BDE0/BDE0\BDE0;
                      TAY                                       ;;BCE1|BDE1+BDE1/BDE1\BDE1;
                      REP #$20                                  ;;BCE2|BDE2+BDE2/BDE2\BDE2; Accum (16 bit)
                      LDA.W DATA_05CA08,Y                       ;;BCE4|BDE4+BDE4/BDE4\BDE4;
                      STA.W !Layer1ScrollCmd                    ;;BCE7|BDE7+BDE7/BDE7\BDE7;
                      LDA.W DATA_05CA0C,Y                       ;;BCEA|BDEA+BDEA/BDEA\BDEA;
                      STA.W !Layer1ScrollBits                   ;;BCED|BDED+BDED/BDED\BDED;
ADDR_05BDF0:          REP #$20                                  ;;BCF0|BDF0+BDF0/BDF0\BDF0; Accum (16 bit)
                      LDY.W !Layer1ScrollBits                   ;;BCF2|BDF2+BDF2/BDF2\BDF2;
                      LDA.W !ScrollLayerIndex                   ;;BCF5|BDF5+BDF5/BDF5\BDF5;
                      AND.W #$00FF                              ;;BCF8|BDF8+BDF8/BDF8\BDF8;
                      BEQ +                                     ;;BCFB|BDFB+BDFB/BDFB\BDFB;
                      LDY.W !Layer2ScrollBits                   ;;BCFD|BDFD+BDFD/BDFD\BDFD;
                    + LDA.W !ScrollLayerIndex                   ;;BD00|BE00+BE00/BE00\BE00;
                      AND.W #$00FF                              ;;BD03|BE03+BE03/BE03\BE03;
                      LSR A                                     ;;BD06|BE06+BE06/BE06\BE06;
                      LSR A                                     ;;BD07|BE07+BE07/BE07\BE07;
                      TAX                                       ;;BD08|BE08+BE08/BE08\BE08;
                      LDA.W DATA_05CA10,Y                       ;;BD09|BE09+BE09/BE09\BE09;
                      STA.W !Layer1ScrollType,X                 ;;BD0C|BE0C+BE0C/BE0C\BE0C;
                      PHA                                       ;;BD0F|BE0F+BE0F/BE0F\BE0F;
                      TYA                                       ;;BD10|BE10+BE10/BE10\BE10;
                      ASL A                                     ;;BD11|BE11+BE11/BE11\BE11;
                      TAY                                       ;;BD12|BE12+BE12/BE12\BE12;
                      LDA.W DATA_05CA12,Y                       ;;BD13|BE13+BE13/BE13\BE13;
                      STA.B !_0                                 ;;BD16|BE16+BE16/BE16\BE16;
                      PLA                                       ;;BD18|BE18+BE18/BE18\BE18;
                      TAY                                       ;;BD19|BE19+BE19/BE19\BE19;
                      LDX.W !ScrollLayerIndex                   ;;BD1A|BE1A+BE1A/BE1A\BE1A;
                      LDA.B !_0                                 ;;BD1D|BE1D+BE1D/BE1D\BE1D;
                      CPY.B #$01                                ;;BD1F|BE1F+BE1F/BE1F\BE1F;
                      BEQ +                                     ;;BD21|BE21+BE21/BE21\BE21;
                      EOR.W #$FFFF                              ;;BD23|BE23+BE23/BE23\BE23;
                      INC A                                     ;;BD26|BE26+BE26/BE26\BE26;
                    + CLC                                       ;;BD27|BE27+BE27/BE27\BE27;
                      ADC.W !NextLayer1YPos,X                   ;;BD28|BE28+BE28/BE28\BE28;
                      STA.W !Layer1ScrollXPosUpd,X              ;;BD2B|BE2B+BE2B/BE2B\BE2B;
                      STZ.W !Layer1ScrollXSpeed,X               ;;BD2E|BE2E+BE2E/BE2E\BE2E;
                      STZ.W !Layer1ScrollYSpeed,X               ;;BD31|BE31+BE31/BE31\BE31;
                      STZ.W !Layer1ScrollYPosUpd,X              ;;BD34|BE34+BE34/BE34\BE34;
                      SEP #$20                                  ;;BD37|BE37+BE37/BE37\BE37; Accum (8 bit)
                      RTS                                       ;;BD39|BE39+BE39/BE39\BE39; Return
                                                                ;;                        ;
ADDR_05BE3A:          LDA.W !Layer1ScrollBits                   ;;BD3A|BE3A+BE3A/BE3A\BE3A;
                      ASL A                                     ;;BD3D|BE3D+BE3D/BE3D\BE3D;
                      TAY                                       ;;BD3E|BE3E+BE3E/BE3E\BE3E;
                      REP #$20                                  ;;BD3F|BE3F+BE3F/BE3F\BE3F; Accum (16 bit)
                      LDA.W DATA_05CA16,Y                       ;;BD41|BE41+BE41/BE41\BE41;
                      STA.W !Layer1ScrollCmd                    ;;BD44|BE44+BE44/BE44\BE44;
                      LDA.W DATA_05CA1E,Y                       ;;BD47|BE47+BE47/BE47\BE47;
                      STA.W !Layer1ScrollBits                   ;;BD4A|BE4A+BE4A/BE4A\BE4A;
ADDR_05BE4D:          REP #$20                                  ;;BD4D|BE4D+BE4D/BE4D\BE4D; Accum (16 bit)
                      LDY.W !Layer1ScrollBits                   ;;BD4F|BE4F+BE4F/BE4F\BE4F;
                      LDA.W !ScrollLayerIndex                   ;;BD52|BE52+BE52/BE52\BE52;
                      AND.W #$00FF                              ;;BD55|BE55+BE55/BE55\BE55;
                      BEQ +                                     ;;BD58|BE58+BE58/BE58\BE58;
                      LDY.W !Layer2ScrollBits                   ;;BD5A|BE5A+BE5A/BE5A\BE5A;
                    + LDA.W !ScrollLayerIndex                   ;;BD5D|BE5D+BE5D/BE5D\BE5D;
                      AND.W #$00FF                              ;;BD60|BE60+BE60/BE60\BE60;
                      LSR A                                     ;;BD63|BE63+BE63/BE63\BE63;
                      LSR A                                     ;;BD64|BE64+BE64/BE64\BE64;
                      TAX                                       ;;BD65|BE65+BE65/BE65\BE65;
                      LDA.W DATA_05CA26,Y                       ;;BD66|BE66+BE66/BE66\BE66;
                      STA.W !Layer1ScrollType,X                 ;;BD69|BE69+BE69/BE69\BE69;
                      TAY                                       ;;BD6C|BE6C+BE6C/BE6C\BE6C;
                      LDX.W !ScrollLayerIndex                   ;;BD6D|BE6D+BE6D/BE6D\BE6D;
                      LDA.W #$0F17                              ;;BD70|BE70+BE70/BE70\BE70;
                      CPY.B #$01                                ;;BD73|BE73+BE73/BE73\BE73;
                      BEQ +                                     ;;BD75|BE75+BE75/BE75\BE75;
                      EOR.W #$FFFF                              ;;BD77|BE77+BE77/BE77\BE77;
                      INC A                                     ;;BD7A|BE7A+BE7A/BE7A\BE7A;
                    + STA.W !Layer1ScrollYPosUpd,X              ;;BD7B|BE7B+BE7B/BE7B\BE7B;
                      STZ.W !Layer1ScrollXSpeed,X               ;;BD7E|BE7E+BE7E/BE7E\BE7E;
                      STZ.W !Layer1ScrollYSpeed,X               ;;BD81|BE81+BE81/BE81\BE81;
                      STZ.W !Layer1ScrollXPosUpd,X              ;;BD84|BE84+BE84/BE84\BE84;
                      SEP #$20                                  ;;BD87|BE87+BE87/BE87\BE87; Accum (8 bit)
                      RTS                                       ;;BD89|BE89+BE89/BE89\BE89; Return
                                                                ;;                        ;
CODE_05BE8A:          PHB                                       ;;BD8A|BE8A+BE8A/BE8A\BE8A;
                      PHK                                       ;;BD8B|BE8B+BE8B/BE8B\BE8B;
                      PLB                                       ;;BD8C|BE8C+BE8C/BE8C\BE8C;
                      REP #$20                                  ;;BD8D|BE8D+BE8D/BE8D\BE8D; Accum (16 bit)
                      LDA.W DATA_05CA26                         ;;BD8F|BE8F+BE8F/BE8F\BE8F;
                      STA.W !Layer3ScroolDir                    ;;BD92|BE92+BE92/BE92\BE92;
                      STZ.W !Layer3ScrollXSpeed                 ;;BD95|BE95+BE95/BE95\BE95;
                      STZ.W !Layer3ScrollYSpeed                 ;;BD98|BE98+BE98/BE98\BE98;
                      STZ.W !Layer3ScrollXPosUpd                ;;BD9B|BE9B+BE9B/BE9B\BE9B;
                      LDA.B !Layer1YPos                         ;;BD9E|BE9E+BE9E/BE9E\BE9E;
                      STA.B !Layer3YPos                         ;;BDA0|BEA0+BEA0/BEA0\BEA0;
                      SEP #$20                                  ;;BDA2|BEA2+BEA2/BEA2\BEA2; Accum (8 bit)
                      PLB                                       ;;BDA4|BEA4+BEA4/BEA4\BEA4;
                      RTL                                       ;;BDA5|BEA5+BEA5/BEA5\BEA5; Return
                                                                ;;                        ;
CODE_05BEA6:          STZ.W !HorizLayer1Setting                 ;;BDA6|BEA6+BEA6/BEA6\BEA6;
                      LDA.W !Layer1ScrollBits                   ;;BDA9|BEA9+BEA9/BEA9\BEA9;
                      ASL A                                     ;;BDAC|BEAC+BEAC/BEAC\BEAC;
                      TAY                                       ;;BDAD|BEAD+BEAD/BEAD\BEAD;
                      REP #$20                                  ;;BDAE|BEAE+BEAE/BEAE\BEAE; Accum (16 bit)
                      LDA.W DATA_05CA3E,Y                       ;;BDB0|BEB0+BEB0/BEB0\BEB0;
                      STA.W !Layer1ScrollCmd                    ;;BDB3|BEB3+BEB3/BEB3\BEB3;
                      LDA.W DATA_05CA42,Y                       ;;BDB6|BEB6+BEB6/BEB6\BEB6;
                      STA.W !Layer1ScrollBits                   ;;BDB9|BEB9+BEB9/BEB9\BEB9;
                      STZ.B !Layer1XPos                         ;;BDBC|BEBC+BEBC/BEBC\BEBC;
                      STZ.W !NextLayer1XPos                     ;;BDBE|BEBE+BEBE/BEBE\BEBE;
                      STZ.B !Layer2XPos                         ;;BDC1|BEC1+BEC1/BEC1\BEC1;
                      STZ.W !NextLayer2XPos                     ;;BDC3|BEC3+BEC3/BEC3\BEC3;
CODE_05BEC6:          REP #$20                                  ;;BDC6|BEC6+BEC6/BEC6\BEC6; Accum (16 bit)
                      LDY.W !Layer1ScrollBits                   ;;BDC8|BEC8+BEC8/BEC8\BEC8;
                      LDA.W !ScrollLayerIndex                   ;;BDCB|BECB+BECB/BECB\BECB;
                      AND.W #$00FF                              ;;BDCE|BECE+BECE/BECE\BECE;
                      BEQ +                                     ;;BDD1|BED1+BED1/BED1\BED1;
                      LDY.W !Layer2ScrollBits                   ;;BDD3|BED3+BED3/BED3\BED3;
                    + LDA.W !ScrollLayerIndex                   ;;BDD6|BED6+BED6/BED6\BED6;
                      AND.W #$00FF                              ;;BDD9|BED9+BED9/BED9\BED9;
                      LSR A                                     ;;BDDC|BEDC+BEDC/BEDC\BEDC;
                      LSR A                                     ;;BDDD|BEDD+BEDD/BEDD\BEDD;
                      TAX                                       ;;BDDE|BEDE+BEDE/BEDE\BEDE;
                      LDA.W DATA_05CA46,Y                       ;;BDDF|BEDF+BEDF/BEDF\BEDF;
                      STA.W !Layer1ScrollType,X                 ;;BDE2|BEE2+BEE2/BEE2\BEE2;
                      TAX                                       ;;BDE5|BEE5+BEE5/BEE5\BEE5;
                      TYA                                       ;;BDE6|BEE6+BEE6/BEE6\BEE6;
                      ASL A                                     ;;BDE7|BEE7+BEE7/BEE7\BEE7;
                      TAY                                       ;;BDE8|BEE8+BEE8/BEE8\BEE8;
                      LDA.W DATA_05CBED,Y                       ;;BDE9|BEE9+BEE9/BEE9\BEE9;
                      AND.W #$00FF                              ;;BDEC|BEEC+BEEC/BEEC\BEEC;
                      CPX.B #$01                                ;;BDEF|BEEF+BEEF/BEEF\BEEF;
                      BEQ +                                     ;;BDF1|BEF1+BEF1/BEF1\BEF1;
                      EOR.W #$FFFF                              ;;BDF3|BEF3+BEF3/BEF3\BEF3;
                      INC A                                     ;;BDF6|BEF6+BEF6/BEF6\BEF6;
                    + LDX.W !ScrollLayerIndex                   ;;BDF7|BEF7+BEF7/BEF7\BEF7;
                      CLC                                       ;;BDFA|BEFA+BEFA/BEFA\BEFA;
                      ADC.W !NextLayer1XPos,X                   ;;BDFB|BEFB+BEFB/BEFB\BEFB;
                      AND.W #$00FF                              ;;BDFE|BEFE+BEFE/BEFE\BEFE;
                      STA.W !Layer1ScrollYPosUpd,X              ;;BE01|BF01+BF01/BF01\BF01;
                      STZ.W !Layer1ScrollXPosUpd,X              ;;BE04|BF04+BF04/BF04\BF04;
                      JMP CODE_05BDC9                           ;;BE07|BF07+BF07/BF07\BF07;
                                                                ;;                        ;
CODE_05BF0A:          STZ.W !VertLayer2Setting                  ;;BE0A|BF0A+BF0A/BF0A\BF0A;
                      LDA.W !Layer1ScrollBits                   ;;BE0D|BF0D+BF0D/BF0D\BF0D;
                      ASL A                                     ;;BE10|BF10+BF10/BF10\BF10;
                      TAY                                       ;;BE11|BF11+BF11/BF11\BF11;
                      REP #$20                                  ;;BE12|BF12+BF12/BF12\BF12; Accum (16 bit)
                      LDA.W DATA_05CA48,Y                       ;;BE14|BF14+BF14/BF14\BF14;
                      STA.W !Layer1ScrollCmd                    ;;BE17|BF17+BF17/BF17\BF17;
                      LDA.W DATA_05CA52,Y                       ;;BE1A|BF1A+BF1A/BF1A\BF1A;
                      STA.W !Layer1ScrollBits                   ;;BE1D|BF1D+BF1D/BF1D\BF1D;
CODE_05BF20:          REP #$20                                  ;;BE20|BF20+BF20/BF20\BF20; Accum (16 bit)
                      LDY.W !Layer1ScrollBits                   ;;BE22|BF22+BF22/BF22\BF22;
                      LDA.W !ScrollLayerIndex                   ;;BE25|BF25+BF25/BF25\BF25;
                      AND.W #$00FF                              ;;BE28|BF28+BF28/BF28\BF28;
                      BEQ +                                     ;;BE2B|BF2B+BF2B/BF2B\BF2B;
                      LDY.W !Layer2ScrollBits                   ;;BE2D|BF2D+BF2D/BF2D\BF2D;
                    + LDA.W !ScrollLayerIndex                   ;;BE30|BF30+BF30/BF30\BF30;
                      AND.W #$00FF                              ;;BE33|BF33+BF33/BF33\BF33;
                      LSR A                                     ;;BE36|BF36+BF36/BF36\BF36;
                      LSR A                                     ;;BE37|BF37+BF37/BF37\BF37;
                      TAX                                       ;;BE38|BF38+BF38/BF38\BF38;
                      LDA.W DATA_05CA5C,Y                       ;;BE39|BF39+BF39/BF39\BF39;
                      STA.W !Layer1ScrollType,X                 ;;BE3C|BF3C+BF3C/BF3C\BF3C;
                      TAX                                       ;;BE3F|BF3F+BF3F/BF3F\BF3F;
                      TYA                                       ;;BE40|BF40+BF40/BF40\BF40;
                      ASL A                                     ;;BE41|BF41+BF41/BF41\BF41;
                      TAY                                       ;;BE42|BF42+BF42/BF42\BF42;
                      LDA.W DATA_05CBF5,Y                       ;;BE43|BF43+BF43/BF43\BF43;
                      AND.W #$00FF                              ;;BE46|BF46+BF46/BF46\BF46;
                      CPX.B #$01                                ;;BE49|BF49+BF49/BF49\BF49;
                      BEQ +                                     ;;BE4B|BF4B+BF4B/BF4B\BF4B;
                      EOR.W #$FFFF                              ;;BE4D|BF4D+BF4D/BF4D\BF4D;
                      INC A                                     ;;BE50|BF50+BF50/BF50\BF50;
                    + LDX.W !ScrollLayerIndex                   ;;BE51|BF51+BF51/BF51\BF51;
                      CLC                                       ;;BE54|BF54+BF54/BF54\BF54;
                      ADC.W !NextLayer1YPos,X                   ;;BE55|BF55+BF55/BF55\BF55;
                      AND.W #$00FF                              ;;BE58|BF58+BF58/BF58\BF58;
                      STA.W !Layer1ScrollXPosUpd,X              ;;BE5B|BF5B+BF5B/BF5B\BF5B;
                      STZ.W !Layer1ScrollYPosUpd,X              ;;BE5E|BF5E+BF5E/BF5E\BF5E;
                      STZ.W !Layer1ScrollYSpeed,X               ;;BE61|BF61+BF61/BF61\BF61;
                      STZ.W !Layer1ScrollYSpeed,X               ;;BE64|BF64+BF64/BF64\BF64;
                      JMP CODE_05BDCF                           ;;BE67|BF67+BF67/BF67\BF67;
                                                                ;;                        ;
CODE_05BF6A:          LDY.W !Layer1ScrollBits                   ;;BE6A|BF6A+BF6A/BF6A\BF6A; Accum (8 bit)
                      LDA.W DATA_05C94F,Y                       ;;BE6D|BF6D+BF6D/BF6D\BF6D;
                      STA.W !Layer1ScrollBits                   ;;BE70|BF70+BF70/BF70\BF70;
                      LDA.W DATA_05C952,Y                       ;;BE73|BF73+BF73/BF73\BF73;
                      STA.W !Layer2ScrollBits                   ;;BE76|BF76+BF76/BF76\BF76;
                      REP #$20                                  ;;BE79|BF79+BF79/BF79\BF79; Accum (16 bit)
                      LDA.W #$0200                              ;;BE7B|BF7B+BF7B/BF7B\BF7B;
                      JSR CODE_05BFD2                           ;;BE7E|BF7E+BF7E/BF7E\BF7E;
                      LDA.W !Layer1ScrollBits                   ;;BE81|BF81+BF81/BF81\BF81; Accum (8 bit)
                      CLC                                       ;;BE84|BF84+BF84/BF84\BF84;
                      ADC.B #$0A                                ;;BE85|BF85+BF85/BF85\BF85;
                      TAX                                       ;;BE87|BF87+BF87/BF87\BF87;
                      LDY.B #$01                                ;;BE88|BF88+BF88/BF88\BF88;
                      JSR CODE_05C95B                           ;;BE8A|BF8A+BF8A/BF8A\BF8A;
                      REP #$20                                  ;;BE8D|BF8D+BF8D/BF8D\BF8D; Accum (16 bit)
                      LDA.W !NextLayer2YPos                     ;;BE8F|BF8F+BF8F/BF8F\BF8F;
                      STA.B !Layer2YPos                         ;;BE92|BF92+BF92/BF92\BF92;
                      JMP CODE_05C32B                           ;;BE94|BF94+BF94/BF94\BF94;
                                                                ;;                        ;
ADDR_05BF97:          STZ.W !HorizLayer1Setting                 ;;BE97|BF97+BF97/BF97\BF97;
                      REP #$20                                  ;;BE9A|BF9A+BF9A/BF9A\BF9A; Accum (16 bit)
                      STZ.B !Layer1XPos                         ;;BE9C|BF9C+BF9C/BF9C\BF9C;
                      STZ.W !NextLayer1XPos                     ;;BE9E|BF9E+BF9E/BF9E\BF9E;
                      STZ.B !Layer2XPos                         ;;BEA1|BFA1+BFA1/BFA1\BFA1;
                      STZ.W !NextLayer2XPos                     ;;BEA3|BFA3+BFA3/BFA3\BFA3;
                      LDA.W #$0600                              ;;BEA6|BFA6+BFA6/BFA6\BFA6;
                      STA.W !Layer1ScrollCmd                    ;;BEA9|BFA9+BFA9/BFA9\BFA9;
                      STZ.W !Layer2ScrollYSpeed                 ;;BEAC|BFAC+BFAC/BFAC\BFAC;
                      STZ.W !Layer2ScrollYPosUpd                ;;BEAF|BFAF+BFAF/BFAF\BFAF;
                      SEP #$20                                  ;;BEB2|BFB2+BFB2/BFB2\BFB2; Accum (8 bit)
                      LDA.B #$60                                ;;BEB4|BFB4+BFB4/BFB4\BFB4;
                      STA.W !Layer2ScrollBits                   ;;BEB6|BFB6+BFB6/BFB6\BFB6;
                      RTS                                       ;;BEB9|BFB9+BFB9/BFB9\BFB9; Return
                                                                ;;                        ;
ADDR_05BFBA:          STZ.W !HorizLayer1Setting                 ;;BEBA|BFBA+BFBA/BFBA\BFBA;
                      REP #$20                                  ;;BEBD|BFBD+BFBD/BFBD\BFBD; Accum (16 bit)
                      STZ.B !Layer2XPos                         ;;BEBF|BFBF+BFBF/BFBF\BFBF;
                      STZ.W !NextLayer2XPos                     ;;BEC1|BFC1+BFC1/BFC1\BFC1;
                      LDA.W #$03C0                              ;;BEC4|BFC4+BFC4/BFC4\BFC4;
                      STA.B !Layer2YPos                         ;;BEC7|BFC7+BFC7/BFC7\BFC7;
                      STA.W !NextLayer2YPos                     ;;BEC9|BFC9+BFC9/BFC9\BFC9;
                      STZ.W !Layer1ScrollBits                   ;;BECC|BFCC+BFCC/BFCC\BFCC;
                      LDA.W #$0005                              ;;BECF|BFCF+BFCF/BFCF\BFCF;
CODE_05BFD2:          STZ.W !Layer1ScrollTimer                  ;;BED2|BFD2+BFD2/BFD2\BFD2;
CODE_05BFD5:          STZ.W !Layer1ScrollType                   ;;BED5|BFD5+BFD5/BFD5\BFD5;
                      STA.W !Layer1ScrollCmd                    ;;BED8|BFD8+BFD8/BFD8\BFD8;
                      STZ.W !Layer1ScrollXSpeed                 ;;BEDB|BFDB+BFDB/BFDB\BFDB;
                      STZ.W !Layer1ScrollYSpeed                 ;;BEDE|BFDE+BFDE/BFDE\BFDE;
                      STZ.W !Layer1ScrollXPosUpd                ;;BEE1|BFE1+BFE1/BFE1\BFE1;
                      STZ.W !Layer1ScrollYPosUpd                ;;BEE4|BFE4+BFE4/BFE4\BFE4;
                      STZ.W !Layer2ScrollXSpeed                 ;;BEE7|BFE7+BFE7/BFE7\BFE7;
                      STZ.W !Layer2ScrollYSpeed                 ;;BEEA|BFEA+BFEA/BFEA\BFEA;
                      STZ.W !Layer2ScrollXPosUpd                ;;BEED|BFED+BFED/BFED\BFED;
                      STZ.W !Layer2ScrollYPosUpd                ;;BEF0|BFF0+BFF0/BFF0\BFF0;
                      SEP #$20                                  ;;BEF3|BFF3+BFF3/BFF3\BFF3; Accum (8 bit)
Return05BFF5:         RTS                                       ;;BEF5|BFF5+BFF5/BFF5\BFF5; Return
                                                                ;;                        ;
CODE_05BFF6:          REP #$20                                  ;;BEF6|BFF6+BFF6/BFF6\BFF6; Accum (16 bit)
                      LDA.W #$0B00                              ;;BEF8|BFF8+BFF8/BFF8\BFF8;
                      BRA CODE_05BFD2                           ;;BEFB|BFFB+BFFB/BFFB\BFFB;
                                                                ;;                        ;
                                                                ;;                        ;
DATA_05BFFD:          db $00,$00,$02,$00                        ;;BEFD|BFFD+BFFD/BFFD\BFFD;
                                                                ;;                        ;
DATA_05C001:          db $80,$00,$00,$01                        ;;BF01|C001+C001/C001\C001;
                                                                ;;                        ;
CODE_05C005:          STZ.W !HorizLayer1Setting                 ;;BF05|C005+C005/C005\C005;
                      LDA.W !Layer1ScrollBits                   ;;BF08|C008+C008/C008\C008;
                      ASL A                                     ;;BF0B|C00B+C00B/C00B\C00B;
                      TAY                                       ;;BF0C|C00C+C00C/C00C\C00C;
                      REP #$20                                  ;;BF0D|C00D+C00D/C00D\C00D; Accum (16 bit)
                      LDA.W DATA_05BFFD,Y                       ;;BF0F|C00F+C00F/C00F\C00F;
                      STA.W !Layer1ScrollBits                   ;;BF12|C012+C012/C012\C012;
                      LDA.W #$000C                              ;;BF15|C015+C015/C015\C015;
                      BRA CODE_05BFD2                           ;;BF18|C018+C018/C018\C018;
                                                                ;;                        ;
CODE_05C01A:          REP #$20                                  ;;BF1A|C01A+C01A/C01A\C01A; Accum (16 bit)
                      LDA.W #$0D00                              ;;BF1C|C01C+C01C/C01C\C01C;
                      JSR CODE_05BFD2                           ;;BF1F|C01F+C01F/C01F\C01F;
CODE_05C022:          STZ.W !HorizLayer2Setting                 ;;BF22|C022+C022/C022\C022;
                      REP #$20                                  ;;BF25|C025+C025/C025\C025; Accum (16 bit)
                      STZ.W !Layer2ScrollXSpeed                 ;;BF27|C027+C027/C027\C027;
                      STZ.W !Layer2ScrollYSpeed                 ;;BF2A|C02A+C02A/C02A\C02A;
                      STZ.W !Layer2ScrollXPosUpd                ;;BF2D|C02D+C02D/C02D\C02D;
                      STZ.W !Layer2ScrollYPosUpd                ;;BF30|C030+C030/C030\C030;
                      SEP #$20                                  ;;BF33|C033+C033/C033\C033; Accum (8 bit)
                      RTS                                       ;;BF35|C035+C035/C035\C035; Return
                                                                ;;                        ;
CODE_05C036:          LDY.W !Layer1ScrollBits                   ;;BF36|C036+C036/C036\C036;
                      LDA.W DATA_05C808,Y                       ;;BF39|C039+C039/C039\C039;
                      STA.W !Layer1ScrollTimer                  ;;BF3C|C03C+C03C/C03C\C03C;
                      LDA.W DATA_05C80B,Y                       ;;BF3F|C03F+C03F/C03F\C03F;
                      STA.W !Layer2ScrollTimer                  ;;BF42|C042+C042/C042\C042;
                      REP #$20                                  ;;BF45|C045+C045/C045\C045; Accum (16 bit)
                      LDA.W #$0E00                              ;;BF47|C047+C047/C047\C047;
                      JMP CODE_05BFD5                           ;;BF4A|C04A+C04A/C04A\C04A;
                                                                ;;                        ;
CODE_05C04D:          LDA.W !ScrollLayerIndex                   ;;BF4D|C04D+C04D/C04D\C04D;
                      LSR A                                     ;;BF50|C050+C050/C050\C050;
                      LSR A                                     ;;BF51|C051+C051/C051\C051;
                      TAX                                       ;;BF52|C052+C052/C052\C052;
                      LDA.W !Layer1ScrollTimer,X                ;;BF53|C053+C053/C053\C053;
                      BNE +                                     ;;BF56|C056+C056/C056\C056;
                      LDX.W !ScrollLayerIndex                   ;;BF58|C058+C058/C058\C058;
                      STZ.W !Layer1ScrollXSpeed,X               ;;BF5B|C05B+C05B/C05B\C05B;
                      RTS                                       ;;BF5E|C05E+C05E/C05E\C05E; Return
                                                                ;;                        ;
                    + REP #$20                                  ;;BF5F|C05F+C05F/C05F\C05F; Accum (16 bit)
                      LDA.W !Layer1ScrollType,X                 ;;BF61|C061+C061/C061\C061;
                      TAY                                       ;;BF64|C064+C064/C064\C064;
                      LDA.W DATA_05CA6E,Y                       ;;BF65|C065+C065/C065\C065;
                      AND.W #$00FF                              ;;BF68|C068+C068/C068\C068;
                      STA.B !_4                                 ;;BF6B|C06B+C06B/C06B\C06B;
                      LDA.W DATA_05CABE,Y                       ;;BF6D|C06D+C06D/C06D\C06D;
                      AND.W #$00FF                              ;;BF70|C070+C070/C070\C070;
                      STA.B !_6                                 ;;BF73|C073+C073/C073\C073;
                      LDA.W !ScrollLayerIndex                   ;;BF75|C075+C075/C075\C075;
                      AND.W #$00FF                              ;;BF78|C078+C078/C078\C078;
                      TAX                                       ;;BF7B|C07B+C07B/C07B\C07B;
                      LDA.W !NextLayer1XPos,X                   ;;BF7C|C07C+C07C/C07C\C07C;
                      STA.B !_0                                 ;;BF7F|C07F+C07F/C07F\C07F;
                      LDA.W !NextLayer1YPos,X                   ;;BF81|C081+C081/C081\C081;
                      STA.B !_2                                 ;;BF84|C084+C084/C084\C084;
                      LDX.B #$02                                ;;BF86|C086+C086/C086\C086;
                      LDA.W DATA_05CA6F,Y                       ;;BF88|C088+C088/C088\C088;
                      AND.W #$00FF                              ;;BF8B|C08B+C08B/C08B\C08B;
                      CMP.B !_4                                 ;;BF8E|C08E+C08E/C08E\C08E;
                      BNE CODE_05C098                           ;;BF90|C090+C090/C090\C090;
                      STZ.B !_4                                 ;;BF92|C092+C092/C092\C092;
                      STX.B !_8                                 ;;BF94|C094+C094/C094\C094;
                      BRA CODE_05C0AD                           ;;BF96|C096+C096/C096\C096;
                                                                ;;                        ;
CODE_05C098:          ASL A                                     ;;BF98|C098+C098/C098\C098;
                      ASL A                                     ;;BF99|C099+C099/C099\C099;
                      ASL A                                     ;;BF9A|C09A+C09A/C09A\C09A;
                      ASL A                                     ;;BF9B|C09B+C09B/C09B\C09B;
                      SEC                                       ;;BF9C|C09C+C09C/C09C\C09C;
                      SBC.B !_0                                 ;;BF9D|C09D+C09D/C09D\C09D;
                      STA.B !_0                                 ;;BF9F|C09F+C09F/C09F\C09F;
                      BPL +                                     ;;BFA1|C0A1+C0A1/C0A1\C0A1;
                      LDX.B #$00                                ;;BFA3|C0A3+C0A3/C0A3\C0A3;
                      EOR.W #$FFFF                              ;;BFA5|C0A5+C0A5/C0A5\C0A5;
                      INC A                                     ;;BFA8|C0A8+C0A8/C0A8\C0A8;
                    + STA.B !_4                                 ;;BFA9|C0A9+C0A9/C0A9\C0A9;
                      STX.B !_8                                 ;;BFAB|C0AB+C0AB/C0AB\C0AB;
CODE_05C0AD:          LDX.B #$00                                ;;BFAD|C0AD+C0AD/C0AD\C0AD;
                      LDA.W DATA_05CABF,Y                       ;;BFAF|C0AF+C0AF/C0AF\C0AF;
                      AND.W #$00FF                              ;;BFB2|C0B2+C0B2/C0B2\C0B2;
                      CMP.B !_6                                 ;;BFB5|C0B5+C0B5/C0B5\C0B5;
                      BNE CODE_05C0BD                           ;;BFB7|C0B7+C0B7/C0B7\C0B7;
                      STZ.B !_6                                 ;;BFB9|C0B9+C0B9/C0B9\C0B9;
                      BRA CODE_05C0D0                           ;;BFBB|C0BB+C0BB/C0BB\C0BB;
                                                                ;;                        ;
CODE_05C0BD:          ASL A                                     ;;BFBD|C0BD+C0BD/C0BD\C0BD;
                      ASL A                                     ;;BFBE|C0BE+C0BE/C0BE\C0BE;
                      ASL A                                     ;;BFBF|C0BF+C0BF/C0BF\C0BF;
                      ASL A                                     ;;BFC0|C0C0+C0C0/C0C0\C0C0;
                      SEC                                       ;;BFC1|C0C1+C0C1/C0C1\C0C1;
                      SBC.B !_2                                 ;;BFC2|C0C2+C0C2/C0C2\C0C2;
                      STA.B !_2                                 ;;BFC4|C0C4+C0C4/C0C4\C0C4;
                      BPL +                                     ;;BFC6|C0C6+C0C6/C0C6\C0C6;
                      LDX.B #$02                                ;;BFC8|C0C8+C0C8/C0C8\C0C8;
                      EOR.W #$FFFF                              ;;BFCA|C0CA+C0CA/C0CA\C0CA;
                      INC A                                     ;;BFCD|C0CD+C0CD/C0CD\C0CD;
                    + STA.B !_6                                 ;;BFCE|C0CE+C0CE/C0CE\C0CE;
CODE_05C0D0:          LDA.B !ScreenMode                         ;;BFD0|C0D0+C0D0/C0D0\C0D0;
                      LSR A                                     ;;BFD2|C0D2+C0D2/C0D2\C0D2;
                      BCS +                                     ;;BFD3|C0D3+C0D3/C0D3\C0D3;
                      LDX.B !_8                                 ;;BFD5|C0D5+C0D5/C0D5\C0D5;
                    + STX.B !Layer1ScrollDir                    ;;BFD7|C0D7+C0D7/C0D7\C0D7;
                      LDA.W #$FFFF                              ;;BFD9|C0D9+C0D9/C0D9\C0D9;
                      STA.B !_8                                 ;;BFDC|C0DC+C0DC/C0DC\C0DC;
                      LDA.B !_4                                 ;;BFDE|C0DE+C0DE/C0DE\C0DE;
                      STA.B !_A                                 ;;BFE0|C0E0+C0E0/C0E0\C0E0;
                      LDA.B !_6                                 ;;BFE2|C0E2+C0E2/C0E2\C0E2;
                      STA.B !_C                                 ;;BFE4|C0E4+C0E4/C0E4\C0E4;
                      CMP.B !_4                                 ;;BFE6|C0E6+C0E6/C0E6\C0E6;
                      BCC +                                     ;;BFE8|C0E8+C0E8/C0E8\C0E8;
                      STA.B !_A                                 ;;BFEA|C0EA+C0EA/C0EA\C0EA;
                      LDA.B !_4                                 ;;BFEC|C0EC+C0EC/C0EC\C0EC;
                      STA.B !_C                                 ;;BFEE|C0EE+C0EE/C0EE\C0EE;
                      LDA.W #$0001                              ;;BFF0|C0F0+C0F0/C0F0\C0F0;
                      STA.B !_8                                 ;;BFF3|C0F3+C0F3/C0F3\C0F3;
                    + LDA.B !_A                                 ;;BFF5|C0F5+C0F5/C0F5\C0F5;
                      STA.W !HW_WRDIV                           ;;BFF7|C0F7+C0F7/C0F7\C0F7; Dividend (Low Byte)
                      SEP #$20                                  ;;BFFA|C0FA+C0FA/C0FA\C0FA; Accum (8 bit)
                      LDA.W DATA_05CB0F,Y                       ;;BFFC|C0FC+C0FC/C0FC\C0FC;
                      STA.W !HW_WRDIV+2                         ;;BFFF|C0FF+C0FF/C0FF\C0FF; Divisor B
                      NOP                                       ;;C002|C102+C102/C102\C102;
                      NOP                                       ;;C003|C103+C103/C103\C103;
                      NOP                                       ;;C004|C104+C104/C104\C104;
                      NOP                                       ;;C005|C105+C105/C105\C105;
                      NOP                                       ;;C006|C106+C106/C106\C106;
                      NOP                                       ;;C007|C107+C107/C107\C107;
                      REP #$20                                  ;;C008|C108+C108/C108\C108; Accum (16 bit)
                      LDA.W !HW_RDDIV                           ;;C00A|C10A+C10A/C10A\C10A; Quotient of Divide Result (Low Byte)
                      BNE +                                     ;;C00D|C10D+C10D/C10D\C10D;
                      LDA.W !ScrollLayerIndex                   ;;C00F|C10F+C10F/C10F\C10F;
                      AND.W #$00FF                              ;;C012|C112+C112/C112\C112;
                      LSR A                                     ;;C015|C115+C115/C115\C115;
                      LSR A                                     ;;C016|C116+C116/C116\C116;
                      TAX                                       ;;C017|C117+C117/C117\C117;
                      INC.W !Layer1ScrollType,X                 ;;C018|C118+C118/C118\C118;
                      SEP #$20                                  ;;C01B|C11B+C11B/C11B\C11B; Accum (8 bit)
                      DEC.W !Layer1ScrollTimer,X                ;;C01D|C11D+C11D/C11D\C11D;
                      JMP CODE_05C04D                           ;;C020|C120+C120/C120\C120;
                                                                ;;                        ;
                    + STA.B !_A                                 ;;C023|C123+C123/C123\C123; Accum (16 bit)
                      LDA.B !_C                                 ;;C025|C125+C125/C125\C125;
                      ASL A                                     ;;C027|C127+C127/C127\C127;
                      ASL A                                     ;;C028|C128+C128/C128\C128;
                      ASL A                                     ;;C029|C129+C129/C129\C129;
                      ASL A                                     ;;C02A|C12A+C12A/C12A\C12A;
                      STA.B !_C                                 ;;C02B|C12B+C12B/C12B\C12B;
                      LDY.B #$10                                ;;C02D|C12D+C12D/C12D\C12D;
                      LDA.W #$0000                              ;;C02F|C12F+C12F/C12F\C12F;
                      STA.B !_E                                 ;;C032|C132+C132/C132\C132;
CODE_05C134:          ASL.B !_C                                 ;;C034|C134+C134/C134\C134;
                      ROL A                                     ;;C036|C136+C136/C136\C136;
                      CMP.B !_A                                 ;;C037|C137+C137/C137\C137;
                      BCC +                                     ;;C039|C139+C139/C139\C139;
                      SBC.B !_A                                 ;;C03B|C13B+C13B/C13B\C13B;
                    + ROL.B !_E                                 ;;C03D|C13D+C13D/C13D\C13D;
                      DEY                                       ;;C03F|C13F+C13F/C13F\C13F;
                      BNE CODE_05C134                           ;;C040|C140+C140/C140\C140;
                      LDA.W !ScrollLayerIndex                   ;;C042|C142+C142/C142\C142;
                      AND.W #$00FF                              ;;C045|C145+C145/C145\C145;
                      LSR A                                     ;;C048|C148+C148/C148\C148;
                      LSR A                                     ;;C049|C149+C149/C149\C149;
                      TAX                                       ;;C04A|C14A+C14A/C14A\C14A;
                      LDA.W !Layer1ScrollType,X                 ;;C04B|C14B+C14B/C14B\C14B;
                      TAY                                       ;;C04E|C14E+C14E/C14E\C14E;
                      LDA.W DATA_05CB0F,Y                       ;;C04F|C14F+C14F/C14F\C14F;
                      AND.W #$00FF                              ;;C052|C152+C152/C152\C152;
                      ASL A                                     ;;C055|C155+C155/C155\C155;
                      ASL A                                     ;;C056|C156+C156/C156\C156;
                      ASL A                                     ;;C057|C157+C157/C157\C157;
                      ASL A                                     ;;C058|C158+C158/C158\C158;
                      STA.B !_A                                 ;;C059|C159+C159/C159\C159;
                      LDX.B #$02                                ;;C05B|C15B+C15B/C15B\C15B;
CODE_05C15D:          LDA.B !_8                                 ;;C05D|C15D+C15D/C15D\C15D;
                      BMI CODE_05C165                           ;;C05F|C15F+C15F/C15F\C15F;
                      LDA.B !_A                                 ;;C061|C161+C161/C161\C161;
                      BRA +                                     ;;C063|C163+C163/C163\C163;
                                                                ;;                        ;
CODE_05C165:          LDA.B !_E                                 ;;C065|C165+C165/C165\C165;
                    + BIT.B !_0,X                               ;;C067|C167+C167/C167\C167;
                      BPL +                                     ;;C069|C169+C169/C169\C169;
                      EOR.W #$FFFF                              ;;C06B|C16B+C16B/C16B\C16B;
                      INC A                                     ;;C06E|C16E+C16E/C16E\C16E;
                    + PHX                                       ;;C06F|C16F+C16F/C16F\C16F;
                      PHA                                       ;;C070|C170+C170/C170\C170;
                      TXA                                       ;;C071|C171+C171/C171\C171;
                      CLC                                       ;;C072|C172+C172/C172\C172;
                      ADC.W !ScrollLayerIndex                   ;;C073|C173+C173/C173\C173;
                      TAX                                       ;;C076|C176+C176/C176\C176;
                      PLA                                       ;;C077|C177+C177/C177\C177;
                      LDY.B #$00                                ;;C078|C178+C178/C178\C178;
                      CMP.W !Layer1ScrollXSpeed,X               ;;C07A|C17A+C17A/C17A\C17A;
                      BEQ CODE_05C18D                           ;;C07D|C17D+C17D/C17D\C17D;
                      BPL +                                     ;;C07F|C17F+C17F/C17F\C17F;
                      LDY.B #$02                                ;;C081|C181+C181/C181\C181;
                    + LDA.W !Layer1ScrollXSpeed,X               ;;C083|C183+C183/C183\C183;
                      CLC                                       ;;C086|C186+C186/C186\C186;
                      ADC.W DATA_05CB5F,Y                       ;;C087|C187+C187/C187\C187;
                      STA.W !Layer1ScrollXSpeed,X               ;;C08A|C18A+C18A/C18A\C18A;
CODE_05C18D:          JSR CODE_05C4F9                           ;;C08D|C18D+C18D/C18D\C18D;
                      PLX                                       ;;C090|C190+C190/C190\C190;
                      DEX                                       ;;C091|C191+C191/C191\C191;
                      DEX                                       ;;C092|C192+C192/C192\C192;
                      BPL CODE_05C15D                           ;;C093|C193+C193/C193\C193;
                      SEP #$20                                  ;;C095|C195+C195/C195\C195; Accum (8 bit)
                      RTS                                       ;;C097|C197+C197/C197\C197; Return
                                                                ;;                        ;
CODE_05C198:          JSR CODE_05C04D                           ;;C098|C198+C198/C198\C198;
                      REP #$20                                  ;;C09B|C19B+C19B/C19B\C19B; Accum (16 bit)
                      LDA.W !NextLayer2XPos                     ;;C09D|C19D+C19D/C19D\C19D;
                      STA.W !NextLayer1XPos                     ;;C0A0|C1A0+C1A0/C1A0\C1A0;
                      LDA.B !Layer2YPos                         ;;C0A3|C1A3+C1A3/C1A3\C1A3;
                      CLC                                       ;;C0A5|C1A5+C1A5/C1A5\C1A5;
                      ADC.W !ScreenShakeYOffset                 ;;C0A6|C1A6+C1A6/C1A6\C1A6;
                      STA.B !Layer2YPos                         ;;C0A9|C1A9+C1A9/C1A9\C1A9;
                      SEP #$20                                  ;;C0AB|C1AB+C1AB/C1AB\C1AB; Accum (8 bit)
                      RTS                                       ;;C0AD|C1AD+C1AD/C1AD\C1AD; Return
                                                                ;;                        ;
                      LDA.W !ScrollLayerIndex                   ;;C0AE|C1AE+C1AE/C1AE\C1AE; \ Unreachable
                      LSR A                                     ;;C0B1|C1B1+C1B1/C1B1\C1B1;
                      LSR A                                     ;;C0B2|C1B2+C1B2/C1B2\C1B2;
                      TAX                                       ;;C0B3|C1B3+C1B3/C1B3\C1B3;
                      LDA.W !Layer1ScrollTimer,X                ;;C0B4|C1B4+C1B4/C1B4\C1B4;
                      BMI ADDR_05C1D4                           ;;C0B7|C1B7+C1B7/C1B7\C1B7;
                      DEC.W !Layer1ScrollTimer,X                ;;C0B9|C1B9+C1B9/C1B9\C1B9;
                      LDA.W !Layer1ScrollTimer,X                ;;C0BC|C1BC+C1BC/C1BC\C1BC;
                      CMP.B #$20                                ;;C0BF|C1BF+C1BF/C1BF\C1BF;
                      BCC +                                     ;;C0C1|C1C1+C1C1/C1C1\C1C1;
                      REP #$20                                  ;;C0C3|C1C3+C1C3/C1C3\C1C3; Accum (16 bit)
                      LDX.W !ScrollLayerIndex                   ;;C0C5|C1C5+C1C5/C1C5\C1C5;
                      LDA.W !NextLayer1YPos,X                   ;;C0C8|C1C8+C1C8/C1C8\C1C8;
                      EOR.W #$0001                              ;;C0CB|C1CB+C1CB/C1CB\C1CB;
                      STA.W !NextLayer1YPos,X                   ;;C0CE|C1CE+C1CE/C1CE\C1CE;
                    + JMP CODE_05C32B                           ;;C0D1|C1D1+C1D1/C1D1\C1D1;
                                                                ;;                        ;
ADDR_05C1D4:          REP #$30                                  ;;C0D4|C1D4+C1D4/C1D4\C1D4; Index (16 bit) Accum (16 bit)
                      LDY.W !ScrollLayerIndex                   ;;C0D6|C1D6+C1D6/C1D6\C1D6;
                      LDA.W !Layer1ScrollXPosUpd,Y              ;;C0D9|C1D9+C1D9/C1D9\C1D9;
                      TAX                                       ;;C0DC|C1DC+C1DC/C1DC\C1DC;
                      LDA.W !NextLayer1YPos,Y                   ;;C0DD|C1DD+C1DD/C1DD\C1DD;
                      CMP.W !Layer1ScrollXPosUpd,Y              ;;C0E0|C1E0+C1E0/C1E0\C1E0;
                      BCC ADDR_05C1EB                           ;;C0E3|C1E3+C1E3/C1E3\C1E3;
                      STA.B !_4                                 ;;C0E5|C1E5+C1E5/C1E5\C1E5;
                      STX.B !_2                                 ;;C0E7|C1E7+C1E7/C1E7\C1E7;
                      BRA +                                     ;;C0E9|C1E9+C1E9/C1E9\C1E9;
                                                                ;;                        ;
ADDR_05C1EB:          STA.B !_2                                 ;;C0EB|C1EB+C1EB/C1EB\C1EB;
                      STX.B !_4                                 ;;C0ED|C1ED+C1ED/C1ED\C1ED;
                    + SEP #$10                                  ;;C0EF|C1EF+C1EF/C1EF\C1EF; Index (8 bit)
                      LDA.B !_2                                 ;;C0F1|C1F1+C1F1/C1F1\C1F1;
                      CMP.B !_4                                 ;;C0F3|C1F3+C1F3/C1F3\C1F3;
                      BCC ADDR_05C24D                           ;;C0F5|C1F5+C1F5/C1F5\C1F5;
                      SEP #$20                                  ;;C0F7|C1F7+C1F7/C1F7\C1F7; Accum (8 bit)
                      LDA.W !ScrollLayerIndex                   ;;C0F9|C1F9+C1F9/C1F9\C1F9;
                      AND.B #$FF                                ;;C0FC|C1FC+C1FC/C1FC\C1FC;
                      LSR A                                     ;;C0FE|C1FE+C1FE/C1FE\C1FE;
                      LSR A                                     ;;C0FF|C1FF+C1FF/C1FF\C1FF;
                      TAX                                       ;;C100|C200+C200/C200\C200;
                      LDA.B #$30                                ;;C101|C201+C201/C201\C201;
                      STA.W !Layer1ScrollTimer,X                ;;C103|C203+C203/C203\C203;
                      REP #$20                                  ;;C106|C206+C206/C206\C206; Accum (16 bit)
                      LDX.W !ScrollLayerIndex                   ;;C108|C208+C208/C208\C208;
                      STZ.W !Layer1ScrollYSpeed,X               ;;C10B|C20B+C20B/C20B\C20B;
                      STZ.W !Layer1ScrollYPosUpd,X              ;;C10E|C20E+C20E/C20E\C20E;
                      LDY.W !Layer1ScrollBits                   ;;C111|C211+C211/C211\C211;
                      LDA.W !ScrollLayerIndex                   ;;C114|C214+C214/C214\C214;
                      AND.W #$00FF                              ;;C117|C217+C217/C217\C217;
                      BEQ +                                     ;;C11A|C21A+C21A/C21A\C21A;
                      LDY.W !Layer2ScrollBits                   ;;C11C|C21C+C21C/C21C\C21C;
                    + LDA.W DATA_05CBC7,Y                       ;;C11F|C21F+C21F/C21F\C21F;
                      AND.W #$00FF                              ;;C122|C222+C222/C222\C222;
                      STA.B !_0                                 ;;C125|C225+C225/C225\C225;
                      TXA                                       ;;C127|C227+C227/C227\C227;
                      LSR A                                     ;;C128|C228+C228/C228\C228;
                      LSR A                                     ;;C129|C229+C229/C229\C229;
                      TAX                                       ;;C12A|C22A+C22A/C22A\C22A;
                      LDA.W !Layer1ScrollType,X                 ;;C12B|C22B+C22B/C22B\C22B;
                      EOR.W #$0001                              ;;C12E|C22E+C22E/C22E\C22E;
                      STA.W !Layer1ScrollType,X                 ;;C131|C231+C231/C231\C231;
                      AND.W #$00FF                              ;;C134|C234+C234/C234\C234;
                      BNE +                                     ;;C137|C237+C237/C237\C237;
                      LDA.B !_0                                 ;;C139|C239+C239/C239\C239;
                      EOR.W #$FFFF                              ;;C13B|C23B+C23B/C23B\C23B;
                      INC A                                     ;;C13E|C23E+C23E/C23E\C23E;
                      STA.B !_0                                 ;;C13F|C23F+C23F/C23F\C23F;
                    + LDX.W !ScrollLayerIndex                   ;;C141|C241+C241/C241\C241;
                      LDA.B !_0                                 ;;C144|C244+C244/C244\C244;
                      CLC                                       ;;C146|C246+C246/C246\C246;
                      ADC.W !Layer1ScrollXPosUpd,X              ;;C147|C247+C247/C247\C247;
                      STA.W !Layer1ScrollXPosUpd,X              ;;C14A|C24A+C24A/C24A\C24A;
ADDR_05C24D:          LDA.W !ScrollLayerIndex                   ;;C14D|C24D+C24D/C24D\C24D;
                      AND.W #$00FF                              ;;C150|C250+C250/C250\C250;
                      LSR A                                     ;;C153|C253+C253/C253\C253;
                      LSR A                                     ;;C154|C254+C254/C254\C254;
                      TAY                                       ;;C155|C255+C255/C255\C255;
                      LDA.W !Layer1ScrollType,Y                 ;;C156|C256+C256/C256\C256;
                      TAX                                       ;;C159|C259+C259/C259\C259;
                      LDA.W DATA_05CBC8,X                       ;;C15A|C25A+C25A/C25A\C25A;
                      AND.W #$00FF                              ;;C15D|C25D+C25D/C25D\C25D;
                      CPX.B #$01                                ;;C160|C260+C260/C260\C260;
                      BEQ +                                     ;;C162|C262+C262/C262\C262;
                      EOR.W #$FFFF                              ;;C164|C264+C264/C264\C264;
                      INC A                                     ;;C167|C267+C267/C267\C267;
                    + LDX.W !ScrollLayerIndex                   ;;C168|C268+C268/C268\C268;
                      LDY.B #$00                                ;;C16B|C26B+C26B/C26B\C26B;
                      CMP.W !Layer1ScrollYSpeed,X               ;;C16D|C26D+C26D/C26D\C26D;
                      BEQ ADDR_05C280                           ;;C170|C270+C270/C270\C270;
                      BPL +                                     ;;C172|C272+C272/C272\C272;
                      LDY.B #$02                                ;;C174|C274+C274/C274\C274;
                    + LDA.W !Layer1ScrollYSpeed,X               ;;C176|C276+C276/C276\C276;
                      CLC                                       ;;C179|C279+C279/C279\C279;
                      ADC.W DATA_05CB7B,Y                       ;;C17A|C27A+C27A/C27A\C27A;
                      STA.W !Layer1ScrollYSpeed,X               ;;C17D|C27D+C27D/C27D\C27D;
ADDR_05C280:          JMP ADDR_05C31D                           ;;C180|C280+C280/C280\C280;
                                                                ;;                        ;
ADDR_05C283:          REP #$20                                  ;;C183|C283+C283/C283\C283; Accum (16 bit)
                      LDY.W !ScrollLayerIndex                   ;;C185|C285+C285/C285\C285;
                      LDA.W !Layer1ScrollXPosUpd,Y              ;;C188|C288+C288/C288\C288;
                      SEC                                       ;;C18B|C28B+C28B/C28B\C28B;
                      SBC.W !NextLayer1YPos,Y                   ;;C18C|C28C+C28C/C28C\C28C;
                      BPL +                                     ;;C18F|C28F+C28F/C28F\C28F;
                      EOR.W #$FFFF                              ;;C191|C291+C291/C291\C291;
                      INC A                                     ;;C194|C294+C294/C294\C294;
                    + STA.B !_2                                 ;;C195|C295+C295/C295\C295;
                      LDA.W !ScrollLayerIndex                   ;;C197|C297+C297/C297\C297;
                      AND.W #$00FF                              ;;C19A|C29A+C29A/C29A\C29A;
                      LSR A                                     ;;C19D|C29D+C29D/C29D\C29D;
                      LSR A                                     ;;C19E|C29E+C29E/C29E\C29E;
                      TAX                                       ;;C19F|C29F+C29F/C29F\C29F;
                      LDA.W !Layer1ScrollType,X                 ;;C1A0|C2A0+C2A0/C2A0\C2A0;
                      AND.W #$00FF                              ;;C1A3|C2A3+C2A3/C2A3\C2A3;
                      TAY                                       ;;C1A6|C2A6+C2A6/C2A6\C2A6;
                      LSR A                                     ;;C1A7|C2A7+C2A7/C2A7\C2A7;
                      TAX                                       ;;C1A8|C2A8+C2A8/C2A8\C2A8;
                      LDA.B !_2                                 ;;C1A9|C2A9+C2A9/C2A9\C2A9;
                      STA.W !HW_WRDIV                           ;;C1AB|C2AB+C2AB/C2AB\C2AB; Dividend (Low Byte)
                      SEP #$20                                  ;;C1AE|C2AE+C2AE/C2AE\C2AE; Accum (8 bit)
                      LDA.W DATA_05CBE3,X                       ;;C1B0|C2B0+C2B0/C2B0\C2B0;
                      STA.W !HW_WRDIV+2                         ;;C1B3|C2B3+C2B3/C2B3\C2B3; Divisor B
                      NOP                                       ;;C1B6|C2B6+C2B6/C2B6\C2B6;
                      NOP                                       ;;C1B7|C2B7+C2B7/C2B7\C2B7;
                      NOP                                       ;;C1B8|C2B8+C2B8/C2B8\C2B8;
                      NOP                                       ;;C1B9|C2B9+C2B9/C2B9\C2B9;
                      NOP                                       ;;C1BA|C2BA+C2BA/C2BA\C2BA;
                      NOP                                       ;;C1BB|C2BB+C2BB/C2BB\C2BB;
                      REP #$20                                  ;;C1BC|C2BC+C2BC/C2BC\C2BC; Accum (16 bit)
                      LDA.W !HW_RDDIV                           ;;C1BE|C2BE+C2BE/C2BE\C2BE; Quotient of Divide Result (Low Byte)
                      BNE ADDR_05C2E5                           ;;C1C1|C2C1+C2C1/C2C1\C2C1;
                      LDA.W !ScrollLayerIndex                   ;;C1C3|C2C3+C2C3/C2C3\C2C3;
                      AND.W #$00FF                              ;;C1C6|C2C6+C2C6/C2C6\C2C6;
                      LSR A                                     ;;C1C9|C2C9+C2C9/C2C9\C2C9;
                      LSR A                                     ;;C1CA|C2CA+C2CA/C2CA\C2CA;
                      TAX                                       ;;C1CB|C2CB+C2CB/C2CB\C2CB;
                      LDA.W !Layer1ScrollType,X                 ;;C1CC|C2CC+C2CC/C2CC\C2CC;
                      TAY                                       ;;C1CF|C2CF+C2CF/C2CF\C2CF;
                      LDX.W !ScrollLayerIndex                   ;;C1D0|C2D0+C2D0/C2D0\C2D0;
                      LDA.W #$0200                              ;;C1D3|C2D3+C2D3/C2D3\C2D3;
                      CPY.B #$01                                ;;C1D6|C2D6+C2D6/C2D6\C2D6;
                      BNE +                                     ;;C1D8|C2D8+C2D8/C2D8\C2D8;
                      EOR.W #$FFFF                              ;;C1DA|C2DA+C2DA/C2DA\C2DA;
                      INC A                                     ;;C1DD|C2DD+C2DD/C2DD\C2DD;
                    + CLC                                       ;;C1DE|C2DE+C2DE/C2DE\C2DE;
                      ADC.W !NextLayer1YPos,X                   ;;C1DF|C2DF+C2DF/C2DF\C2DF;
                      STA.W !NextLayer1YPos,X                   ;;C1E2|C2E2+C2E2/C2E2\C2E2;
ADDR_05C2E5:          LDX.W !Layer1ScrollBits                   ;;C1E5|C2E5+C2E5/C2E5\C2E5;
                      LDA.W !ScrollLayerIndex                   ;;C1E8|C2E8+C2E8/C2E8\C2E8;
                      AND.W #$00FF                              ;;C1EB|C2EB+C2EB/C2EB\C2EB;
                      BEQ +                                     ;;C1EE|C2EE+C2EE/C2EE\C2EE;
                      LDX.W !Layer2ScrollBits                   ;;C1F0|C2F0+C2F0/C2F0\C2F0;
                    + LDA.W DATA_05CBE3,X                       ;;C1F3|C2F3+C2F3/C2F3\C2F3;
                      AND.W #$00FF                              ;;C1F6|C2F6+C2F6/C2F6\C2F6;
                      ASL A                                     ;;C1F9|C2F9+C2F9/C2F9\C2F9;
                      ASL A                                     ;;C1FA|C2FA+C2FA/C2FA\C2FA;
                      ASL A                                     ;;C1FB|C2FB+C2FB/C2FB\C2FB;
                      ASL A                                     ;;C1FC|C2FC+C2FC/C2FC\C2FC;
                      CPY.B #$01                                ;;C1FD|C2FD+C2FD/C2FD\C2FD;
                      BEQ +                                     ;;C1FF|C2FF+C2FF/C2FF\C2FF;
                      EOR.W #$FFFF                              ;;C201|C301+C301/C301\C301;
                      INC A                                     ;;C204|C304+C304/C304\C304;
                    + LDX.W !ScrollLayerIndex                   ;;C205|C305+C305/C305\C305;
                      LDY.B #$00                                ;;C208|C308+C308/C308\C308;
                      CMP.W !Layer1ScrollYSpeed,X               ;;C20A|C30A+C30A/C30A\C30A;
                      BEQ ADDR_05C31D                           ;;C20D|C30D+C30D/C30D\C30D;
                      BPL +                                     ;;C20F|C30F+C30F/C30F\C30F;
                      LDY.B #$02                                ;;C211|C311+C311/C311\C311;
                    + LDA.W !Layer1ScrollYSpeed,X               ;;C213|C313+C313/C313\C313;
                      CLC                                       ;;C216|C316+C316/C316\C316;
                      ADC.W DATA_05CB9B,Y                       ;;C217|C317+C317/C317\C317;
                      STA.W !Layer1ScrollYSpeed,X               ;;C21A|C31A+C31A/C31A\C31A;
ADDR_05C31D:          LDA.W !ScrollLayerIndex                   ;;C21D|C31D+C31D/C31D\C31D;
                      AND.W #$00FF                              ;;C220|C320+C320/C320\C320;
                      CLC                                       ;;C223|C323+C323/C323\C323;
                      ADC.W #$0002                              ;;C224|C324+C324/C324\C324;
                      TAX                                       ;;C227|C327+C327/C327\C327;
CODE_05C328:          JSR CODE_05C4F9                           ;;C228|C328+C328/C328\C328;
CODE_05C32B:          SEP #$20                                  ;;C22B|C32B+C32B/C32B\C32B; Accum (8 bit)
                      RTS                                       ;;C22D|C32D+C32D/C32D\C32D; Return
                                                                ;;                        ;
ADDR_05C32E:          REP #$20                                  ;;C22E|C32E+C32E/C32E\C32E; Accum (16 bit)
                      LDY.W !ScrollLayerIndex                   ;;C230|C330+C330/C330\C330;
                      LDA.W !Layer1ScrollYPosUpd,Y              ;;C233|C333+C333/C333\C333;
                      SEC                                       ;;C236|C336+C336/C336\C336;
                      SBC.W !NextLayer1XPos,Y                   ;;C237|C337+C337/C337\C337;
                      BPL +                                     ;;C23A|C33A+C33A/C33A\C33A;
                      EOR.W #$FFFF                              ;;C23C|C33C+C33C/C33C\C33C;
                      INC A                                     ;;C23F|C33F+C33F/C33F\C33F;
                    + STA.B !_2                                 ;;C240|C340+C340/C340\C340;
                      LDA.W !ScrollLayerIndex                   ;;C242|C342+C342/C342\C342;
                      AND.W #$00FF                              ;;C245|C345+C345/C345\C345;
                      LSR A                                     ;;C248|C348+C348/C348\C348;
                      LSR A                                     ;;C249|C349+C349/C349\C349;
                      TAX                                       ;;C24A|C34A+C34A/C34A\C34A;
                      LDA.W !Layer1ScrollType,X                 ;;C24B|C34B+C34B/C34B\C34B;
                      AND.W #$00FF                              ;;C24E|C34E+C34E/C34E\C34E;
                      TAY                                       ;;C251|C351+C351/C351\C351;
                      LSR A                                     ;;C252|C352+C352/C352\C352;
                      TAX                                       ;;C253|C353+C353/C353\C353;
                      LDA.B !_2                                 ;;C254|C354+C354/C354\C354;
                      STA.W !HW_WRDIV                           ;;C256|C356+C356/C356\C356; Dividend (Low Byte)
                      SEP #$20                                  ;;C259|C359+C359/C359\C359; Accum (8 bit)
                      LDA.W DATA_05CBE5,X                       ;;C25B|C35B+C35B/C35B\C35B;
                      STA.W !HW_WRDIV+2                         ;;C25E|C35E+C35E/C35E\C35E; Divisor B
                      NOP                                       ;;C261|C361+C361/C361\C361;
                      NOP                                       ;;C262|C362+C362/C362\C362;
                      NOP                                       ;;C263|C363+C363/C363\C363;
                      NOP                                       ;;C264|C364+C364/C364\C364;
                      NOP                                       ;;C265|C365+C365/C365\C365;
                      NOP                                       ;;C266|C366+C366/C366\C366;
                      REP #$20                                  ;;C267|C367+C367/C367\C367; Accum (16 bit)
                      LDA.W !HW_RDDIV                           ;;C269|C369+C369/C369\C369; Quotient of Divide Result (Low Byte)
                      BNE ADDR_05C39F                           ;;C26C|C36C+C36C/C36C\C36C;
                      LDA.W !ScrollLayerIndex                   ;;C26E|C36E+C36E/C36E\C36E;
                      AND.W #$00FF                              ;;C271|C371+C371/C371\C371;
                      LSR A                                     ;;C274|C374+C374/C374\C374;
                      LSR A                                     ;;C275|C375+C375/C375\C375;
                      TAX                                       ;;C276|C376+C376/C376\C376;
                      LDA.W !Layer1ScrollType,X                 ;;C277|C377+C377/C377\C377;
                      TAY                                       ;;C27A|C37A+C37A/C37A\C37A;
                      LDX.W !ScrollLayerIndex                   ;;C27B|C37B+C37B/C37B\C37B;
                      LDA.W #$0600                              ;;C27E|C37E+C37E/C37E\C37E;
                      CPY.B #$01                                ;;C281|C381+C381/C381\C381;
                      BNE +                                     ;;C283|C383+C383/C383\C383;
                      EOR.W #$FFFF                              ;;C285|C385+C385/C385\C385;
                      INC A                                     ;;C288|C388+C388/C388\C388;
                    + CLC                                       ;;C289|C389+C389/C389\C389;
                      ADC.W !NextLayer1XPos,X                   ;;C28A|C38A+C38A/C38A\C38A;
                      STA.W !NextLayer1XPos,X                   ;;C28D|C38D+C38D/C38D\C38D;
                      LDA.W #$FFF8                              ;;C290|C390+C390/C390\C390;
                      STA.W !Layer1TileUp,X                     ;;C293|C393+C393/C393\C393;
                      LDA.W #$0017                              ;;C296|C396+C396/C396\C396;
                      STA.W !Layer1TileDown,X                   ;;C299|C399+C399/C399\C399;
                      STZ.W !PlayerXPosNext+1                   ;;C29C|C39C+C39C/C39C\C39C;
ADDR_05C39F:          LDA.W !ScrollLayerIndex                   ;;C29F|C39F+C39F/C39F\C39F;
                      AND.W #$00FF                              ;;C2A2|C3A2+C3A2/C3A2\C3A2;
                      LSR A                                     ;;C2A5|C3A5+C3A5/C3A5\C3A5;
                      LSR A                                     ;;C2A6|C3A6+C3A6/C3A6\C3A6;
                      TAX                                       ;;C2A7|C3A7+C3A7/C3A7\C3A7;
                      LDA.W !Layer1ScrollType,X                 ;;C2A8|C3A8+C3A8/C3A8\C3A8;
                      AND.W #$00FF                              ;;C2AB|C3AB+C3AB/C3AB\C3AB;
                      PHA                                       ;;C2AE|C3AE+C3AE/C3AE\C3AE;
                      SEP #$20                                  ;;C2AF|C3AF+C3AF/C3AF\C3AF; Accum (8 bit)
                      LDX.B #$02                                ;;C2B1|C3B1+C3B1/C3B1\C3B1;
                      LDY.B #$00                                ;;C2B3|C3B3+C3B3/C3B3\C3B3;
                      CMP.B #$01                                ;;C2B5|C3B5+C3B5/C3B5\C3B5;
                      BEQ +                                     ;;C2B7|C3B7+C3B7/C3B7\C3B7;
                      LDX.B #$00                                ;;C2B9|C3B9+C3B9/C3B9\C3B9;
                      LDY.B #$01                                ;;C2BB|C3BB+C3BB/C3BB\C3BB;
                    + TXA                                       ;;C2BD|C3BD+C3BD/C3BD\C3BD;
                      STA.W !Layer1ScrollDir,Y                  ;;C2BE|C3BE+C3BE/C3BE\C3BE;
                      REP #$20                                  ;;C2C1|C3C1+C3C1/C3C1\C3C1; Accum (16 bit)
                      PLA                                       ;;C2C3|C3C3+C3C3/C3C3\C3C3;
                      TAY                                       ;;C2C4|C3C4+C3C4/C3C4\C3C4;
                      LDX.W !Layer1ScrollBits                   ;;C2C5|C3C5+C3C5/C3C5\C3C5;
                      LDA.W !ScrollLayerIndex                   ;;C2C8|C3C8+C3C8/C3C8\C3C8;
                      AND.W #$00FF                              ;;C2CB|C3CB+C3CB/C3CB\C3CB;
                      BEQ +                                     ;;C2CE|C3CE+C3CE/C3CE\C3CE;
                      LDX.W !Layer2ScrollBits                   ;;C2D0|C3D0+C3D0/C3D0\C3D0;
                    + LDA.W DATA_05CBE5,X                       ;;C2D3|C3D3+C3D3/C3D3\C3D3;
                      AND.W #$00FF                              ;;C2D6|C3D6+C3D6/C3D6\C3D6;
                      ASL A                                     ;;C2D9|C3D9+C3D9/C3D9\C3D9;
                      ASL A                                     ;;C2DA|C3DA+C3DA/C3DA\C3DA;
                      ASL A                                     ;;C2DB|C3DB+C3DB/C3DB\C3DB;
                      ASL A                                     ;;C2DC|C3DC+C3DC/C3DC\C3DC;
                      CPY.B #$01                                ;;C2DD|C3DD+C3DD/C3DD\C3DD;
                      BEQ +                                     ;;C2DF|C3DF+C3DF/C3DF\C3DF;
                      EOR.W #$FFFF                              ;;C2E1|C3E1+C3E1/C3E1\C3E1;
                      INC A                                     ;;C2E4|C3E4+C3E4/C3E4\C3E4;
                    + LDX.W !ScrollLayerIndex                   ;;C2E5|C3E5+C3E5/C3E5\C3E5;
                      LDY.B #$00                                ;;C2E8|C3E8+C3E8/C3E8\C3E8;
                      CMP.W !Layer1ScrollXSpeed,X               ;;C2EA|C3EA+C3EA/C3EA\C3EA;
                      BEQ ADDR_05C3FD                           ;;C2ED|C3ED+C3ED/C3ED\C3ED;
                      BPL +                                     ;;C2EF|C3EF+C3EF/C3EF\C3EF;
                      LDY.B #$02                                ;;C2F1|C3F1+C3F1/C3F1\C3F1;
                    + LDA.W !Layer1ScrollXSpeed,X               ;;C2F3|C3F3+C3F3/C3F3\C3F3;
                      CLC                                       ;;C2F6|C3F6+C3F6/C3F6\C3F6;
                      ADC.W DATA_05CBA3,Y                       ;;C2F7|C3F7+C3F7/C3F7\C3F7;
                      STA.W !Layer1ScrollXSpeed,X               ;;C2FA|C3FA+C3FA/C3FA\C3FA;
ADDR_05C3FD:          LDX.W !ScrollLayerIndex                   ;;C2FD|C3FD+C3FD/C3FD\C3FD;
                      JSR CODE_05C4F9                           ;;C300|C400+C400/C400\C400;
                      SEP #$20                                  ;;C303|C403+C403/C403\C403; Accum (8 bit)
                      RTS                                       ;;C305|C405+C405/C405\C405; Return
                                                                ;;                        ;
                                                                ;;                        ;
DATA_05C406:          db $FF,$01                                ;;C306|C406+C406/C406\C406;
                                                                ;;                        ;
DATA_05C408:          db $FC,$04                                ;;C308|C408+C408/C408\C408;
                                                                ;;                        ;
DATA_05C40A:          db $30,$A0                                ;;C30A|C40A+C40A/C40A\C40A;
                                                                ;;                        ;
CODE_05C40C:          LDA.W !Layer3TideSetting                  ;;C30C|C40C+C40C/C40C\C40C;
                      BEQ +                                     ;;C30F|C40F+C40F/C40F\C40F;
                      JMP CODE_05C494                           ;;C311|C411+C411/C411\C411;
                                                                ;;                        ;
                    + REP #$20                                  ;;C314|C414+C414/C414\C414; Accum (16 bit)
                      LDY.W !ObjectTileset                      ;;C316|C416+C416/C416\C416;
                      CPY.B #$01                                ;;C319|C419+C419/C419\C419;
                      BEQ CODE_05C421                           ;;C31B|C41B+C41B/C41B\C41B;
                      CPY.B #$03                                ;;C31D|C41D+C41D/C41D\C41D;
                      BNE CODE_05C428                           ;;C31F|C41F+C41F/C41F\C41F;
CODE_05C421:          LDA.B !Layer1XPos                         ;;C321|C421+C421/C421\C421;
                      LSR A                                     ;;C323|C423+C423/C423\C423;
                      STA.B !Layer3XPos                         ;;C324|C424+C424/C424\C424;
                      BRA CODE_05C491                           ;;C326|C426+C426/C426\C426;
                                                                ;;                        ;
CODE_05C428:          LDY.W !SpriteLock                         ;;C328|C428+C428/C428\C428;
                      BNE CODE_05C48D                           ;;C32B|C42B+C42B/C42B\C42B;
                      LDA.W !Layer3ScroolDir                    ;;C32D|C42D+C42D/C42D\C42D;
                      AND.W #$00FF                              ;;C330|C430+C430/C430\C430;
                      TAY                                       ;;C333|C433+C433/C433\C433;
                      LDA.W DATA_05CBEB                         ;;C334|C434+C434/C434\C434;
                      AND.W #$00FF                              ;;C337|C437+C437/C437\C437;
                      ASL A                                     ;;C33A|C43A+C43A/C43A\C43A;
                      ASL A                                     ;;C33B|C43B+C43B/C43B\C43B;
                      ASL A                                     ;;C33C|C43C+C43C/C43C\C43C;
                      ASL A                                     ;;C33D|C43D+C43D/C43D\C43D;
                      CPY.B #$01                                ;;C33E|C43E+C43E/C43E\C43E;
                      BEQ +                                     ;;C340|C440+C440/C440\C440;
                      EOR.W #$FFFF                              ;;C342|C442+C442/C442\C442;
                      INC A                                     ;;C345|C445+C445/C445\C445;
                    + LDY.B #$00                                ;;C346|C446+C446/C446\C446;
                      CMP.W !Layer3ScrollXSpeed                 ;;C348|C448+C448/C448\C448;
                      BEQ CODE_05C45B                           ;;C34B|C44B+C44B/C44B\C44B;
                      BPL +                                     ;;C34D|C44D+C44D/C44D\C44D;
                      LDY.B #$02                                ;;C34F|C44F+C44F/C44F\C44F;
                    + LDA.W !Layer3ScrollXSpeed                 ;;C351|C451+C451/C451\C451;
                      CLC                                       ;;C354|C454+C454/C454\C454;
                      ADC.W DATA_05CBBB,Y                       ;;C355|C455+C455/C455\C455;
                      STA.W !Layer3ScrollXSpeed                 ;;C358|C458+C458/C458\C458;
CODE_05C45B:          LDA.W !Layer3ScrollXPosUpd                ;;C35B|C45B+C45B/C45B\C45B;
                      AND.W #$00FF                              ;;C35E|C45E+C45E/C45E\C45E;
                      CLC                                       ;;C361|C461+C461/C461\C461;
                      ADC.W !Layer3ScrollXSpeed                 ;;C362|C462+C462/C462\C462;
                      STA.W !Layer3ScrollXPosUpd                ;;C365|C465+C465/C465\C465;
                      AND.W #$FF00                              ;;C368|C468+C468/C468\C468;
                      BPL +                                     ;;C36B|C46B+C46B/C46B\C46B;
                      ORA.W #$00FF                              ;;C36D|C46D+C46D/C46D\C46D;
                    + XBA                                       ;;C370|C470+C470/C470\C470;
                      CLC                                       ;;C371|C471+C471/C471\C471;
                      ADC.B !Layer3XPos                         ;;C372|C472+C472/C472\C472;
                      STA.B !Layer3XPos                         ;;C374|C474+C474/C474\C474;
                      LDA.W !Layer1DXPos                        ;;C376|C476+C476/C476\C476;
                      AND.W #$00FF                              ;;C379|C479+C479/C479\C479;
                      CMP.W #$0080                              ;;C37C|C47C+C47C/C47C\C47C;
                      BCC +                                     ;;C37F|C47F+C47F/C47F\C47F;
                      ORA.W #$FF00                              ;;C381|C481+C481/C481\C481;
                    + STA.B !_0                                 ;;C384|C484+C484/C484\C484;
                      LDA.B !Layer3XPos                         ;;C386|C486+C486/C486\C486;
                      CLC                                       ;;C388|C488+C488/C488\C488;
                      ADC.B !_0                                 ;;C389|C489+C489/C489\C489;
                      STA.B !Layer3XPos                         ;;C38B|C48B+C48B/C48B\C48B;
CODE_05C48D:          LDA.B !Layer1YPos                         ;;C38D|C48D+C48D/C48D\C48D;
                      STA.B !Layer3YPos                         ;;C38F|C48F+C48F/C48F\C48F;
CODE_05C491:          SEP #$20                                  ;;C391|C491+C491/C491\C491; Accum (8 bit)
                      RTS                                       ;;C393|C493+C493/C493\C493; Return
                                                                ;;                        ;
CODE_05C494:          DEC A                                     ;;C394|C494+C494/C494\C494;
                      BNE CODE_05C4EC                           ;;C395|C495+C495/C495\C495;
                      LDA.W !SpriteLock                         ;;C397|C497+C497/C497\C497;
                      BNE CODE_05C4EC                           ;;C39A|C49A+C49A/C49A\C49A;
                      LDY.W !Layer3ScroolDir                    ;;C39C|C49C+C49C/C49C\C49C;
                      LDA.B !EffFrame                           ;;C39F|C49F+C49F/C49F\C49F;
                      AND.B #$03                                ;;C3A1|C4A1+C4A1/C4A1\C4A1;
                      BNE CODE_05C4C0                           ;;C3A3|C4A3+C4A3/C4A3\C4A3;
                      LDA.W !Layer3ScrollYSpeed                 ;;C3A5|C4A5+C4A5/C4A5\C4A5;
                      BNE CODE_05C4AF                           ;;C3A8|C4A8+C4A8/C4A8\C4A8;
                      DEC.W !Layer3TideTimer                    ;;C3AA|C4AA+C4AA/C4AA\C4AA;
                      BNE CODE_05C4EC                           ;;C3AD|C4AD+C4AD/C4AD\C4AD;
CODE_05C4AF:          CMP.W DATA_05C408,Y                       ;;C3AF|C4AF+C4AF/C4AF\C4AF;
                      BEQ +                                     ;;C3B2|C4B2+C4B2/C4B2\C4B2;
                      CLC                                       ;;C3B4|C4B4+C4B4/C4B4\C4B4;
                      ADC.W DATA_05C406,Y                       ;;C3B5|C4B5+C4B5/C4B5\C4B5;
                      STA.W !Layer3ScrollYSpeed                 ;;C3B8|C4B8+C4B8/C4B8\C4B8;
                    + LDA.B #$4B                                ;;C3BB|C4BB+C4BB/C4BB\C4BB;
                      STA.W !Layer3TideTimer                    ;;C3BD|C4BD+C4BD/C4BD\C4BD;
CODE_05C4C0:          LDA.B !Layer3YPos                         ;;C3C0|C4C0+C4C0/C4C0\C4C0;
                      CMP.W DATA_05C40A,Y                       ;;C3C2|C4C2+C4C2/C4C2\C4C2;
                      BNE +                                     ;;C3C5|C4C5+C4C5/C4C5\C4C5;
                      TYA                                       ;;C3C7|C4C7+C4C7/C4C7\C4C7;
                      EOR.B #$01                                ;;C3C8|C4C8+C4C8/C4C8\C4C8;
                      STA.W !Layer3ScroolDir                    ;;C3CA|C4CA+C4CA/C4CA\C4CA;
                    + LDA.W !Layer3ScrollYSpeed                 ;;C3CD|C4CD+C4CD/C4CD\C4CD;
                      ASL A                                     ;;C3D0|C4D0+C4D0/C4D0\C4D0;
                      ASL A                                     ;;C3D1|C4D1+C4D1/C4D1\C4D1;
                      ASL A                                     ;;C3D2|C4D2+C4D2/C4D2\C4D2;
                      ASL A                                     ;;C3D3|C4D3+C4D3/C4D3\C4D3;
                      CLC                                       ;;C3D4|C4D4+C4D4/C4D4\C4D4;
                      ADC.W !Layer3ScrollXPosUpd                ;;C3D5|C4D5+C4D5/C4D5\C4D5;
                      STA.W !Layer3ScrollXPosUpd                ;;C3D8|C4D8+C4D8/C4D8\C4D8;
                      LDA.W !Layer3ScrollYSpeed                 ;;C3DB|C4DB+C4DB/C4DB\C4DB;
                      PHP                                       ;;C3DE|C4DE+C4DE/C4DE\C4DE;
                      LSR A                                     ;;C3DF|C4DF+C4DF/C4DF\C4DF;
                      LSR A                                     ;;C3E0|C4E0+C4E0/C4E0\C4E0;
                      LSR A                                     ;;C3E1|C4E1+C4E1/C4E1\C4E1;
                      LSR A                                     ;;C3E2|C4E2+C4E2/C4E2\C4E2;
                      PLP                                       ;;C3E3|C4E3+C4E3/C4E3\C4E3;
                      BPL +                                     ;;C3E4|C4E4+C4E4/C4E4\C4E4;
                      ORA.B #$F0                                ;;C3E6|C4E6+C4E6/C4E6\C4E6;
                    + ADC.B !Layer3YPos                         ;;C3E8|C4E8+C4E8/C4E8\C4E8;
                      STA.B !Layer3YPos                         ;;C3EA|C4EA+C4EA/C4EA\C4EA;
CODE_05C4EC:          LDA.B !Layer3XPos                         ;;C3EC|C4EC+C4EC/C4EC\C4EC;
                      SEC                                       ;;C3EE|C4EE+C4EE/C4EE\C4EE;
                      ADC.W !Layer1DXPos                        ;;C3EF|C4EF+C4EF/C4EF\C4EF;
                      STA.B !Layer3XPos                         ;;C3F2|C4F2+C4F2/C4F2\C4F2;
                      LDA.B #$01                                ;;C3F4|C4F4+C4F4/C4F4\C4F4;
                      STA.B !Layer3XPos+1                       ;;C3F6|C4F6+C4F6/C4F6\C4F6;
                      RTS                                       ;;C3F8|C4F8+C4F8/C4F8\C4F8; Return
                                                                ;;                        ;
CODE_05C4F9:          LDA.W !Layer1ScrollXPosUpd,X              ;;C3F9|C4F9+C4F9/C4F9\C4F9; Accum (16 bit)
                      AND.W #$00FF                              ;;C3FC|C4FC+C4FC/C4FC\C4FC;
                      CLC                                       ;;C3FF|C4FF+C4FF/C4FF\C4FF;
                      ADC.W !Layer1ScrollXSpeed,X               ;;C400|C500+C500/C500\C500;
                      STA.W !Layer1ScrollXPosUpd,X              ;;C403|C503+C503/C503\C503;
                      AND.W #$FF00                              ;;C406|C506+C506/C506\C506;
                      BPL +                                     ;;C409|C509+C509/C509\C509;
                      ORA.W #$00FF                              ;;C40B|C50B+C50B/C50B\C50B;
                    + XBA                                       ;;C40E|C50E+C50E/C50E\C50E;
                      CLC                                       ;;C40F|C50F+C50F/C50F\C50F;
                      ADC.W !NextLayer1XPos,X                   ;;C410|C510+C510/C510\C510;
                      STA.W !NextLayer1XPos,X                   ;;C413|C513+C513/C513\C513;
                      LDA.B !_8                                 ;;C416|C516+C516/C516\C516;
                      EOR.W #$FFFF                              ;;C418|C518+C518/C518\C518;
                      INC A                                     ;;C41B|C51B+C51B/C51B\C51B;
                      STA.B !_8                                 ;;C41C|C51C+C51C/C51C\C51C;
                      RTS                                       ;;C41E|C51E+C51E/C51E\C51E; Return
                                                                ;;                        ;
CODE_05C51F:          REP #$30                                  ;;C41F|C51F+C51F/C51F\C51F; Index (16 bit) Accum (16 bit)
                      LDY.W !ScrollLayerIndex                   ;;C421|C521+C521/C521\C521;
                      REP #$30                                  ;;C424|C524+C524/C524\C524; Index (16 bit) Accum (16 bit)
                      LDA.W !Layer1ScrollYPosUpd,Y              ;;C426|C526+C526/C526\C526;
                      TAX                                       ;;C429|C529+C529/C529\C529;
                      LDA.W !NextLayer1XPos,Y                   ;;C42A|C52A+C52A/C52A\C52A;
                      CMP.W !Layer1ScrollYPosUpd,Y              ;;C42D|C52D+C52D/C52D\C52D;
                      BCC CODE_05C538                           ;;C430|C530+C530/C530\C530;
                      STA.B !_4                                 ;;C432|C532+C532/C532\C532;
                      STX.B !_2                                 ;;C434|C534+C534/C534\C534;
                      BRA +                                     ;;C436|C536+C536/C536\C536;
                                                                ;;                        ;
CODE_05C538:          STA.B !_2                                 ;;C438|C538+C538/C538\C538;
                      STX.B !_4                                 ;;C43A|C53A+C53A/C53A\C53A;
                    + SEP #$10                                  ;;C43C|C53C+C53C/C53C\C53C; Index (8 bit)
                      LDA.B !_2                                 ;;C43E|C53E+C53E/C53E\C53E;
                      CMP.B !_4                                 ;;C440|C540+C540/C540\C540;
                      BCC CODE_05C585                           ;;C442|C542+C542/C542\C542;
                      LDY.W !Layer1ScrollBits                   ;;C444|C544+C544/C544\C544;
                      LDA.W !ScrollLayerIndex                   ;;C447|C547+C547/C547\C547;
                      BEQ +                                     ;;C44A|C54A+C54A/C54A\C54A;
                      LDY.W !Layer2ScrollBits                   ;;C44C|C54C+C54C/C54C\C54C;
                    + TYA                                       ;;C44F|C54F+C54F/C54F\C54F;
                      ASL A                                     ;;C450|C550+C550/C550\C550;
                      TAY                                       ;;C451|C551+C551/C551\C551;
                      LDA.W DATA_05CBEE,Y                       ;;C452|C552+C552/C552\C552;
                      AND.W #$00FF                              ;;C455|C555+C555/C555\C555;
                      STA.B !_0                                 ;;C458|C558+C558/C558\C558;
                      LDA.W !ScrollLayerIndex                   ;;C45A|C55A+C55A/C55A\C55A;
                      AND.W #$00FF                              ;;C45D|C55D+C55D/C55D\C55D;
                      LSR A                                     ;;C460|C560+C560/C560\C560;
                      LSR A                                     ;;C461|C561+C561/C561\C561;
                      TAX                                       ;;C462|C562+C562/C562\C562;
                      LDA.W !Layer1ScrollType,X                 ;;C463|C563+C563/C563\C563;
                      EOR.W #$0001                              ;;C466|C566+C566/C566\C566;
                      STA.W !Layer1ScrollType,X                 ;;C469|C569+C569/C569\C569;
                      AND.W #$00FF                              ;;C46C|C56C+C56C/C56C\C56C;
                      BNE +                                     ;;C46F|C56F+C56F/C56F\C56F;
                      LDA.B !_0                                 ;;C471|C571+C571/C571\C571;
                      EOR.W #$FFFF                              ;;C473|C573+C573/C573\C573;
                      INC A                                     ;;C476|C576+C576/C576\C576;
                      STA.B !_0                                 ;;C477|C577+C577/C577\C577;
                    + LDX.W !ScrollLayerIndex                   ;;C479|C579+C579/C579\C579;
                      LDA.B !_0                                 ;;C47C|C57C+C57C/C57C\C57C;
                      CLC                                       ;;C47E|C57E+C57E/C57E\C57E;
                      ADC.W !Layer1ScrollYPosUpd,X              ;;C47F|C57F+C57F/C57F\C57F;
                      STA.W !Layer1ScrollYPosUpd,X              ;;C482|C582+C582/C582\C582;
CODE_05C585:          LDA.W !ScrollLayerIndex                   ;;C485|C585+C585/C585\C585;
                      AND.W #$00FF                              ;;C488|C588+C588/C588\C588;
                      LSR A                                     ;;C48B|C58B+C58B/C58B\C58B;
                      LSR A                                     ;;C48C|C58C+C58C/C58C\C58C;
                      TAX                                       ;;C48D|C58D+C58D/C58D\C58D;
                      LDA.W !Layer1ScrollType,X                 ;;C48E|C58E+C58E/C58E\C58E;
                      TAX                                       ;;C491|C591+C591/C591\C591;
                      LDA.W DATA_05CBF1,X                       ;;C492|C592+C592/C592\C592;
                      AND.W #$00FF                              ;;C495|C595+C595/C595\C595;
                      CPX.B #$01                                ;;C498|C598+C598/C598\C598;
                      BEQ +                                     ;;C49A|C59A+C59A/C59A\C59A;
                      EOR.W #$FFFF                              ;;C49C|C59C+C59C/C59C\C59C;
                      INC A                                     ;;C49F|C59F+C59F/C59F\C59F;
                    + LDX.W !ScrollLayerIndex                   ;;C4A0|C5A0+C5A0/C5A0\C5A0;
                      LDY.B #$00                                ;;C4A3|C5A3+C5A3/C5A3\C5A3;
                      CMP.W !Layer1ScrollXSpeed,X               ;;C4A5|C5A5+C5A5/C5A5\C5A5;
                      BEQ CODE_05C5B8                           ;;C4A8|C5A8+C5A8/C5A8\C5A8;
                      BPL +                                     ;;C4AA|C5AA+C5AA/C5AA\C5AA;
                      LDY.B #$02                                ;;C4AC|C5AC+C5AC/C5AC\C5AC;
                    + LDA.W !Layer1ScrollXSpeed,X               ;;C4AE|C5AE+C5AE/C5AE\C5AE;
                      CLC                                       ;;C4B1|C5B1+C5B1/C5B1\C5B1;
                      ADC.W DATA_05CBC3,Y                       ;;C4B2|C5B2+C5B2/C5B2\C5B2;
                      STA.W !Layer1ScrollXSpeed,X               ;;C4B5|C5B5+C5B5/C5B5\C5B5;
CODE_05C5B8:          JMP CODE_05C328                           ;;C4B8|C5B8+C5B8/C5B8\C5B8;
                                                                ;;                        ;
CODE_05C5BB:          REP #$30                                  ;;C4BB|C5BB+C5BB/C5BB\C5BB; Index (16 bit) Accum (16 bit)
                      LDY.W !ScrollLayerIndex                   ;;C4BD|C5BD+C5BD/C5BD\C5BD;
                      REP #$30                                  ;;C4C0|C5C0+C5C0/C5C0\C5C0; Index (16 bit) Accum (16 bit)
                      LDA.W !Layer1ScrollXPosUpd,Y              ;;C4C2|C5C2+C5C2/C5C2\C5C2;
                      TAX                                       ;;C4C5|C5C5+C5C5/C5C5\C5C5;
                      LDA.W !NextLayer1YPos,Y                   ;;C4C6|C5C6+C5C6/C5C6\C5C6;
                      CMP.W !Layer1ScrollXPosUpd,Y              ;;C4C9|C5C9+C5C9/C5C9\C5C9;
                      BCC CODE_05C5D4                           ;;C4CC|C5CC+C5CC/C5CC\C5CC;
                      STA.B !_4                                 ;;C4CE|C5CE+C5CE/C5CE\C5CE;
                      STX.B !_2                                 ;;C4D0|C5D0+C5D0/C5D0\C5D0;
                      BRA +                                     ;;C4D2|C5D2+C5D2/C5D2\C5D2;
                                                                ;;                        ;
CODE_05C5D4:          STA.B !_2                                 ;;C4D4|C5D4+C5D4/C5D4\C5D4;
                      STX.B !_4                                 ;;C4D6|C5D6+C5D6/C5D6\C5D6;
                    + SEP #$10                                  ;;C4D8|C5D8+C5D8/C5D8\C5D8; Index (8 bit)
                      LDA.B !_2                                 ;;C4DA|C5DA+C5DA/C5DA\C5DA;
                      CMP.B !_4                                 ;;C4DC|C5DC+C5DC/C5DC\C5DC;
                      BCC CODE_05C621                           ;;C4DE|C5DE+C5DE/C5DE\C5DE;
                      LDY.W !Layer1ScrollBits                   ;;C4E0|C5E0+C5E0/C5E0\C5E0;
                      LDA.W !ScrollLayerIndex                   ;;C4E3|C5E3+C5E3/C5E3\C5E3;
                      BEQ +                                     ;;C4E6|C5E6+C5E6/C5E6\C5E6;
                      LDY.W !Layer2ScrollBits                   ;;C4E8|C5E8+C5E8/C5E8\C5E8;
                    + TYA                                       ;;C4EB|C5EB+C5EB/C5EB\C5EB;
                      ASL A                                     ;;C4EC|C5EC+C5EC/C5EC\C5EC;
                      TAY                                       ;;C4ED|C5ED+C5ED/C5ED\C5ED;
                      LDA.W DATA_05CBF6,Y                       ;;C4EE|C5EE+C5EE/C5EE\C5EE;
                      AND.W #$00FF                              ;;C4F1|C5F1+C5F1/C5F1\C5F1;
                      STA.B !_0                                 ;;C4F4|C5F4+C5F4/C5F4\C5F4;
                      LDA.W !ScrollLayerIndex                   ;;C4F6|C5F6+C5F6/C5F6\C5F6;
                      AND.W #$00FF                              ;;C4F9|C5F9+C5F9/C5F9\C5F9;
                      LSR A                                     ;;C4FC|C5FC+C5FC/C5FC\C5FC;
                      LSR A                                     ;;C4FD|C5FD+C5FD/C5FD\C5FD;
                      TAX                                       ;;C4FE|C5FE+C5FE/C5FE\C5FE;
                      LDA.W !Layer1ScrollType,X                 ;;C4FF|C5FF+C5FF/C5FF\C5FF;
                      EOR.W #$0001                              ;;C502|C602+C602/C602\C602;
                      STA.W !Layer1ScrollType,X                 ;;C505|C605+C605/C605\C605;
                      AND.W #$00FF                              ;;C508|C608+C608/C608\C608;
                      BNE +                                     ;;C50B|C60B+C60B/C60B\C60B;
                      LDA.B !_0                                 ;;C50D|C60D+C60D/C60D\C60D;
                      EOR.W #$FFFF                              ;;C50F|C60F+C60F/C60F\C60F;
                      INC A                                     ;;C512|C612+C612/C612\C612;
                      STA.B !_0                                 ;;C513|C613+C613/C613\C613;
                    + LDX.W !ScrollLayerIndex                   ;;C515|C615+C615/C615\C615;
                      LDA.B !_0                                 ;;C518|C618+C618/C618\C618;
                      CLC                                       ;;C51A|C61A+C61A/C61A\C61A;
                      ADC.W !Layer1ScrollXPosUpd,X              ;;C51B|C61B+C61B/C61B\C61B;
                      STA.W !Layer1ScrollXPosUpd,X              ;;C51E|C61E+C61E/C61E\C61E;
CODE_05C621:          LDA.W !ScrollLayerIndex                   ;;C521|C621+C621/C621\C621;
                      AND.W #$00FF                              ;;C524|C624+C624/C624\C624;
                      LSR A                                     ;;C527|C627+C627/C627\C627;
                      LSR A                                     ;;C528|C628+C628/C628\C628;
                      TAX                                       ;;C529|C629+C629/C629\C629;
                      LDA.W !Layer1ScrollType,X                 ;;C52A|C62A+C62A/C62A\C62A;
                      TAX                                       ;;C52D|C62D+C62D/C62D\C62D;
                      LDA.W DATA_05CBF1,X                       ;;C52E|C62E+C62E/C62E\C62E;
                      AND.W #$00FF                              ;;C531|C631+C631/C631\C631;
                      CPX.B #$01                                ;;C534|C634+C634/C634\C634;
                      BEQ +                                     ;;C536|C636+C636/C636\C636;
                      EOR.W #$FFFF                              ;;C538|C638+C638/C638\C638;
                      INC A                                     ;;C53B|C63B+C63B/C63B\C63B;
                    + LDX.W !ScrollLayerIndex                   ;;C53C|C63C+C63C/C63C\C63C;
                      LDY.B #$00                                ;;C53F|C63F+C63F/C63F\C63F;
                      CMP.W !Layer1ScrollYSpeed,X               ;;C541|C641+C641/C641\C641;
                      BEQ CODE_05C654                           ;;C544|C644+C644/C644\C644;
                      BPL +                                     ;;C546|C646+C646/C646\C646;
                      LDY.B #$02                                ;;C548|C648+C648/C648\C648;
                    + LDA.W !Layer1ScrollYSpeed,X               ;;C54A|C64A+C64A/C64A\C64A;
                      CLC                                       ;;C54D|C64D+C64D/C64D\C64D;
                      ADC.W DATA_05CBC3,Y                       ;;C54E|C64E+C64E/C64E\C64E;
                      STA.W !Layer1ScrollYSpeed,X               ;;C551|C651+C651/C651\C651;
CODE_05C654:          INX                                       ;;C554|C654+C654/C654\C654;
                      INX                                       ;;C555|C655+C655/C655\C655;
                      JMP CODE_05C328                           ;;C556|C656+C656/C656\C656;
                                                                ;;                        ;
ADDR_05C659:          LDA.W !Layer2ScrollBits                   ;;C559|C659+C659/C659\C659;
                      BEQ +                                     ;;C55C|C65C+C65C/C65C\C65C;
                      DEC.W !Layer2ScrollBits                   ;;C55E|C65E+C65E/C65E\C65E;
                      CMP.W #$B020                              ;;C561|C661+C661/C661\C661;
                      ASL.W !CapeFloatTimer                     ;;C564|C664+C664/C664\C664;
                      AND.W #$D001                              ;;C567|C667+C667/C667\C667;
                      PHP                                       ;;C56A|C66A+C66A/C66A\C66A;
                      LDA.W !NextLayer1YPos                     ;;C56B|C66B+C66B/C66B\C66B;
                      EOR.W #$8D01                              ;;C56E|C66E+C66E/C66E\C66E;
                      STZ.B !EffFrame                           ;;C571|C671+C671/C671\C671;
                      RTS                                       ;;C573|C673+C673/C673\C673; Return
                                                                ;;                        ;
                    + STZ.B !Layer2ScrollDir                    ;;C574|C674+C674/C674\C674;
                      REP #$20                                  ;;C576|C676+C676/C676\C676; Accum (16 bit)
                      LDA.W !Layer2ScrollYSpeed                 ;;C578|C678+C678/C678\C678;
                      CMP.W #$FFC0                              ;;C57B|C67B+C67B/C67B\C67B;
                      BEQ +                                     ;;C57E|C67E+C67E/C67E\C67E;
                      DEC A                                     ;;C580|C680+C680/C680\C680;
                      STA.W !Layer2ScrollYSpeed                 ;;C581|C681+C681/C681\C681;
                    + LDA.W !NextLayer2YPos                     ;;C584|C684+C684/C684\C684;
                      CMP.W #$0031                              ;;C587|C687+C687/C687\C687;
                      BPL +                                     ;;C58A|C68A+C68A/C68A\C68A;
                      STZ.W !Layer2ScrollYSpeed                 ;;C58C|C68C+C68C/C68C\C68C;
                    + BNE +                                     ;;C58F|C68F+C68F/C68F\C68F;
                      LDY.B #$20                                ;;C591|C691+C691/C691\C691;
                      STY.W !Layer2ScrollBits                   ;;C593|C693+C693/C693\C693;
                    + LDX.B #$06                                ;;C596|C696+C696/C696\C696;
                      JSR CODE_05C4F9                           ;;C598|C698+C698/C698\C698;
                      JMP CODE_05C32B                           ;;C59B|C69B+C69B/C69B\C69B;
                                                                ;;                        ;
ADDR_05C69E:          LDA.B #$02                                ;;C59E|C69E+C69E/C69E\C69E;
                      STA.B !Layer1ScrollDir                    ;;C5A0|C6A0+C6A0/C6A0\C6A0;
                      STZ.B !Layer2ScrollDir                    ;;C5A2|C6A2+C6A2/C6A2\C6A2;
                      REP #$20                                  ;;C5A4|C6A4+C6A4/C6A4\C6A4;
                      LDX.W !Layer1ScrollBits                   ;;C5A6|C6A6+C6A6/C6A6\C6A6;
                      BNE ADDR_05C6CD                           ;;C5A9|C6A9+C6A9/C6A9\C6A9;
                      LDA.W !Layer1ScrollXSpeed                 ;;C5AB|C6AB+C6AB/C6AB\C6AB;
                      CMP.W #$0080                              ;;C5AE|C6AE+C6AE/C6AE\C6AE;
                      BEQ +                                     ;;C5B1|C6B1+C6B1/C6B1\C6B1;
                      INC A                                     ;;C5B3|C6B3+C6B3/C6B3\C6B3;
                    + STA.W !Layer1ScrollXSpeed                 ;;C5B4|C6B4+C6B4/C6B4\C6B4;
                      LDY.B !LastScreenHoriz                    ;;C5B7|C6B7+C6B7/C6B7\C6B7;
                      DEY                                       ;;C5B9|C6B9+C6B9/C6B9\C6B9;
                      CPY.W !NextLayer1XPos+1                   ;;C5BA|C6BA+C6BA/C6BA\C6BA;
                      BNE ADDR_05C6EC                           ;;C5BD|C6BD+C6BD/C6BD\C6BD;
                      INC.W !Layer1ScrollBits                   ;;C5BF|C6BF+C6BF/C6BF\C6BF;
                      STZ.W !Layer1ScrollXSpeed                 ;;C5C2|C6C2+C6C2/C6C2\C6C2;
                      LDA.W #$FCF0                              ;;C5C5|C6C5+C6C5/C6C5\C6C5;
                      STA.W !Empty1B97                          ;;C5C8|C6C8+C6C8/C6C8\C6C8;
                      BRA ADDR_05C6EC                           ;;C5CB|C6CB+C6CB/C6CB\C6CB;
                                                                ;;                        ;
ADDR_05C6CD:          LDY.B #$16                                ;;C5CD|C6CD+C6CD/C6CD\C6CD; \ Unreachable
                      STY.W !HW_TM                              ;;C5CF|C6CF+C6CF/C6CF\C6CF; Background and Object Enable
                      LDA.W !Layer2ScrollYSpeed                 ;;C5D2|C6D2+C6D2/C6D2\C6D2;
                      CMP.W #$FF80                              ;;C5D5|C6D5+C6D5/C6D5\C6D5;
                      BEQ +                                     ;;C5D8|C6D8+C6D8/C6D8\C6D8;
                      DEC A                                     ;;C5DA|C6DA+C6DA/C6DA\C6DA;
                    + STA.W !Layer2ScrollYSpeed                 ;;C5DB|C6DB+C6DB/C6DB\C6DB;
                      STA.W !Layer1ScrollYSpeed                 ;;C5DE|C6DE+C6DE/C6DE\C6DE;
                      LDA.W !NextLayer2YPos                     ;;C5E1|C6E1+C6E1/C6E1\C6E1;
                      BNE ADDR_05C6EC                           ;;C5E4|C6E4+C6E4/C6E4\C6E4;
                      STZ.W !Layer2ScrollYSpeed                 ;;C5E6|C6E6+C6E6/C6E6\C6E6;
                      STZ.W !Layer1ScrollYSpeed                 ;;C5E9|C6E9+C6E9/C6E9\C6E9;
ADDR_05C6EC:          LDX.B #$06                                ;;C5EC|C6EC+C6EC/C6EC\C6EC;
                    - JSR CODE_05C4F9                           ;;C5EE|C6EE+C6EE/C6EE\C6EE;
                      DEX                                       ;;C5F1|C6F1+C6F1/C6F1\C6F1;
                      DEX                                       ;;C5F2|C6F2+C6F2/C6F2\C6F2;
                      BPL -                                     ;;C5F3|C6F3+C6F3/C6F3\C6F3;
                      SEP #$20                                  ;;C5F5|C6F5+C6F5/C6F5\C6F5; Accum (8 bit)
                      LDA.W !NextLayer1XPos+1                   ;;C5F7|C6F7+C6F7/C6F7\C6F7;
                      SEC                                       ;;C5FA|C6FA+C6FA/C6FA\C6FA;
                      SBC.B !LastScreenHoriz                    ;;C5FB|C6FB+C6FB/C6FB\C6FB;
                      INC A                                     ;;C5FD|C6FD+C6FD/C6FD\C6FD;
                      INC A                                     ;;C5FE|C6FE+C6FE/C6FE\C6FE;
                      XBA                                       ;;C5FF|C6FF+C6FF/C6FF\C6FF;
                      LDA.W !NextLayer1XPos                     ;;C600|C700+C700/C700\C700;
                      REP #$20                                  ;;C603|C703+C703/C703\C703; Accum (16 bit)
                      LDY.B #$82                                ;;C605|C705+C705/C705\C705;
                      CMP.W #$0000                              ;;C607|C707+C707/C707\C707;
                      BPL +                                     ;;C60A|C70A+C70A/C70A\C70A;
                      LDA.W #$0000                              ;;C60C|C70C+C70C/C70C\C70C;
                      LDY.B #$02                                ;;C60F|C70F+C70F/C70F\C70F;
                    + STA.W !NextLayer2XPos                     ;;C611|C711+C711/C711\C711;
                      STA.B !Layer2XPos                         ;;C614|C714+C714/C714\C714;
                      STY.B !ScreenMode                         ;;C616|C716+C716/C716\C716;
                      JMP CODE_05C32B                           ;;C618|C718+C718/C718\C718;
                                                                ;;                        ;
                                                                ;;                        ;
DATA_05C71B:          db $20,$00,$C1,$00                        ;;C61B|C71B+C71B/C71B\C71B;
                                                                ;;                        ;
DATA_05C71F:          db $C0,$FF,$40,$00                        ;;C61F|C71F+C71F/C71F\C71F;
                                                                ;;                        ;
DATA_05C723:          db $FF,$FF,$01,$00                        ;;C623|C723+C723/C723\C723;
                                                                ;;                        ;
CODE_05C727:          LDX.W !OnOffSwitch                        ;;C627|C727+C727/C727\C727; Accum (8 bit)
                      BEQ +                                     ;;C62A|C72A+C72A/C72A\C72A;
                      LDX.B #$02                                ;;C62C|C72C+C72C/C72C\C72C;
                    + CPX.W !Layer2ScrollType                   ;;C62E|C72E+C72E/C72E\C72E;
                      BEQ CODE_05C74A                           ;;C631|C731+C731/C731\C731;
                      DEC.W !Layer2ScrollTimer                  ;;C633|C733+C733/C733\C733;
                      BPL +                                     ;;C636|C736+C736/C736\C736;
                      STX.W !Layer2ScrollType                   ;;C638|C738+C738/C738\C738;
                    + LDA.W !NextLayer2YPos                     ;;C63B|C73B+C73B/C73B\C73B;
                      EOR.B #$01                                ;;C63E|C73E+C73E/C73E\C73E;
                      STA.W !NextLayer2YPos                     ;;C640|C740+C740/C740\C740;
                      STZ.W !Layer2ScrollYSpeed                 ;;C643|C743+C743/C743\C743;
                      STZ.W !Layer2ScrollYSpeed+1               ;;C646|C746+C746/C746\C746;
                      RTS                                       ;;C649|C749+C749/C749\C749; Return
                                                                ;;                        ;
CODE_05C74A:          LDA.B #$10                                ;;C64A|C74A+C74A/C74A\C74A;
                      STA.W !Layer2ScrollTimer                  ;;C64C|C74C+C74C/C74C\C74C;
                      REP #$20                                  ;;C64F|C74F+C74F/C74F\C74F; Accum (16 bit)
                      LDA.W !NextLayer2YPos                     ;;C651|C751+C751/C751\C751;
                      CMP.W DATA_05C71B,X                       ;;C654|C754+C754/C754\C754;
                      BNE CODE_05C770                           ;;C657|C757+C757/C757\C757;
                      CPX.B #$00                                ;;C659|C759+C759/C759\C759;
                      BNE +                                     ;;C65B|C75B+C75B/C75B\C75B;
                      LDA.W #!SFX_KAPOW                         ;;C65D|C75D+C75D/C75D\C75D;
                      STA.W !SPCIO3                             ;;C660|C760+C760/C760\C760; / Play sound effect
                      LDA.W #$0020                              ;;C663|C763+C763/C763\C763; \ Set ground shake timer
                      STA.W !ScreenShakeTimer                   ;;C666|C766+C766/C766\C766; /
                    + LDX.B #$00                                ;;C669|C769+C769/C769\C769;
                      STX.W !OnOffSwitch                        ;;C66B|C76B+C76B/C76B\C76B;
                      BRA CODE_05C784                           ;;C66E|C76E+C76E/C76E\C76E;
                                                                ;;                        ;
CODE_05C770:          LDA.W !Layer2ScrollYSpeed                 ;;C670|C770+C770/C770\C770; Accum (8 bit)
                      CMP.W DATA_05C71F,X                       ;;C673|C773+C773/C773\C773;
                      BEQ +                                     ;;C676|C776+C776/C776\C776;
                      CLC                                       ;;C678|C778+C778/C778\C778;
                      ADC.W DATA_05C723,X                       ;;C679|C779+C779/C779\C779;
                      STA.W !Layer2ScrollYSpeed                 ;;C67C|C77C+C77C/C77C\C77C;
                    + LDX.B #$06                                ;;C67F|C77F+C77F/C77F\C77F;
                      JSR CODE_05C4F9                           ;;C681|C781+C781/C781\C781;
CODE_05C784:          JMP CODE_05C32B                           ;;C684|C784+C784/C784\C784;
                                                                ;;                        ;
CODE_05C787:          LDA.B #$02                                ;;C687|C787+C787/C787\C787;
                      STA.B !Layer1ScrollDir                    ;;C689|C789+C789/C789\C789;
                      STA.B !Layer2ScrollDir                    ;;C68B|C78B+C78B/C78B\C78B;
                      LDA.W !ScrollLayerIndex                   ;;C68D|C78D+C78D/C78D\C78D;
                      LSR A                                     ;;C690|C790+C790/C790\C790;
                      LSR A                                     ;;C691|C791+C791/C791\C791;
                      TAX                                       ;;C692|C792+C792/C792\C792;
                      LDY.W !Layer1ScrollBits,X                 ;;C693|C793+C793/C793\C793;
                      LDX.W !ScrollLayerIndex                   ;;C696|C796+C796/C796\C796;
                      REP #$20                                  ;;C699|C799+C799/C799\C799; Accum (16 bit)
                      LDA.W !Layer1ScrollXSpeed,X               ;;C69B|C79B+C79B/C79B\C79B;
                      CMP.W DATA_05C001,Y                       ;;C69E|C79E+C79E/C79E\C79E;
                      BEQ +                                     ;;C6A1|C7A1+C7A1/C7A1\C7A1;
                      INC A                                     ;;C6A3|C7A3+C7A3/C7A3\C7A3;
                    + STA.W !Layer1ScrollXSpeed,X               ;;C6A4|C7A4+C7A4/C7A4\C7A4;
                      LDA.B !LastScreenHoriz                    ;;C6A7|C7A7+C7A7/C7A7\C7A7;
                      DEC A                                     ;;C6A9|C7A9+C7A9/C7A9\C7A9;
                      XBA                                       ;;C6AA|C7AA+C7AA/C7AA\C7AA;
                      AND.W #$FF00                              ;;C6AB|C7AB+C7AB/C7AB\C7AB;
                      CMP.W !NextLayer1XPos,X                   ;;C6AE|C7AE+C7AE/C7AE\C7AE;
                      BNE +                                     ;;C6B1|C7B1+C7B1/C7B1\C7B1;
                      STZ.W !Layer1ScrollXSpeed,X               ;;C6B3|C7B3+C7B3/C7B3\C7B3;
                    + JSR CODE_05C4F9                           ;;C6B6|C7B6+C7B6/C7B6\C7B6;
                      JMP CODE_05C32B                           ;;C6B9|C7B9+C7B9/C7B9\C7B9;
                                                                ;;                        ;
CODE_05C7BC:          LDA.W !BGFastScrollActive                 ;;C6BC|C7BC+C7BC/C7BC\C7BC; Accum (8 bit)
                      BEQ CODE_05C7ED                           ;;C6BF|C7BF+C7BF/C7BF\C7BF;
CODE_05C7C1:          LDA.B #$02                                ;;C6C1|C7C1+C7C1/C7C1\C7C1;
                      STA.B !Layer2ScrollDir                    ;;C6C3|C7C3+C7C3/C7C3\C7C3;
                      REP #$20                                  ;;C6C5|C7C5+C7C5/C7C5\C7C5; Accum (16 bit)
                      LDA.W !Layer2ScrollXSpeed                 ;;C6C7|C7C7+C7C7/C7C7\C7C7;
                      CMP.W #$0400                              ;;C6CA|C7CA+C7CA/C7CA\C7CA;
                      BEQ +                                     ;;C6CD|C7CD+C7CD/C7CD\C7CD;
                      INC A                                     ;;C6CF|C7CF+C7CF/C7CF\C7CF;
                    + STA.W !Layer2ScrollXSpeed                 ;;C6D0|C7D0+C7D0/C7D0\C7D0;
                      LDX.B #$04                                ;;C6D3|C7D3+C7D3/C7D3\C7D3;
                      JSR CODE_05C4F9                           ;;C6D5|C7D5+C7D5/C7D5\C7D5;
                      LDA.W !Layer1DXPos                        ;;C6D8|C7D8+C7D8/C7D8\C7D8;
                      AND.W #$00FF                              ;;C6DB|C7DB+C7DB/C7DB\C7DB;
                      CMP.W #$0080                              ;;C6DE|C7DE+C7DE/C7DE\C7DE;
                      BCC +                                     ;;C6E1|C7E1+C7E1/C7E1\C7E1;
                      ORA.W #$FF00                              ;;C6E3|C7E3+C7E3/C7E3\C7E3;
                    + CLC                                       ;;C6E6|C7E6+C7E6/C7E6\C7E6;
                      ADC.W !NextLayer2XPos                     ;;C6E7|C7E7+C7E7/C7E7\C7E7;
                      STA.W !NextLayer2XPos                     ;;C6EA|C7EA+C7EA/C7EA\C7EA;
CODE_05C7ED:          JMP CODE_05C32B                           ;;C6ED|C7ED+C7ED/C7ED\C7ED;
                                                                ;;                        ;
                                                                ;;                        ;
DATA_05C7F0:          dw $0000,$02F0,$08B0,$0000                ;;C6F0|C7F0+C7F0/C7F0\C7F0;
                      dw $0000,$0370                            ;;C6F8|C7F8+C7F8/C7F8\C7F8;
                                                                ;;                        ;
DATA_05C7FC:          dw $00D0,$0350,$0A30,$0008                ;;C6FC|C7FC+C7FC/C7FC\C7FC;
                      dw $0040,$0380                            ;;C704|C804+C804/C804\C804;
                                                                ;;                        ;
DATA_05C808:          db $00,$06,$08                            ;;C708|C808+C808/C808\C808;
                                                                ;;                        ;
DATA_05C80B:          db $03,$01,$02                            ;;C70B|C80B+C80B/C80B\C80B;
                                                                ;;                        ;
DATA_05C80E:          dw $00C0                                  ;;C70E|C80E+C80E/C80E\C80E;
                                                                ;;                        ;
DATA_05C810:          dw $0000,$00B0                            ;;C710|C810+C810/C810\C810;
                                                                ;;                        ;
DATA_05C814:          dw $FF80,$00C0                            ;;C714|C814+C814/C814\C814;
                                                                ;;                        ;
                   if ver_is_ntsc(!_VER)              ;\   IF   ;;++++++++++++++++++++++++; J, U, & SS
DATA_05C818:          dw $FFFF,$0001                            ;;C718|C818+C818          ;
                   else                               ;<  ELSE  ;;------------------------; E0 & E1
DATA_05C818:          dw $FFFE,$0002                            ;;              /C818\C818;
                   endif                              ;/ ENDIF  ;;++++++++++++++++++++++++;
                                                                ;;                        ;
CODE_05C81C:          REP #$20                                  ;;C71C|C81C+C81C/C81C\C81C; Accum (16 bit)
                      STZ.B !_0                                 ;;C71E|C81E+C81E/C81E\C81E;
                      LDY.W !Layer2ScrollTimer                  ;;C720|C820+C820/C820\C820;
                      STY.B !_0                                 ;;C723|C823+C823/C823\C823;
                      LDY.B #$00                                ;;C725|C825+C825/C825\C825;
                      LDX.W !Layer1ScrollTimer                  ;;C727|C827+C827/C827\C827;
                      CPX.B #$08                                ;;C72A|C82A+C82A/C82A\C82A;
                      BCC CODE_05C830                           ;;C72C|C82C+C82C/C82C\C82C;
                      LDY.B #$02                                ;;C72E|C82E+C82E/C82E\C82E;
CODE_05C830:          LDA.W !NextLayer2XPos                     ;;C730|C830+C830/C830\C830;
                      CMP.W DATA_05C7F0,X                       ;;C733|C833+C833/C833\C833;
                      BCC +                                     ;;C736|C836+C836/C836\C836;
                      CMP.W DATA_05C7FC,X                       ;;C738|C838+C838/C838\C838;
                      BCS +                                     ;;C73B|C83B+C83B/C83B\C83B;
                      STZ.W !Layer1ScrollType                   ;;C73D|C83D+C83D/C83D\C83D;
                      LDA.W DATA_05C80E,Y                       ;;C740|C840+C840/C840\C840;
                      STA.W !NextLayer2YPos                     ;;C743|C843+C843/C843\C843;
                      STZ.W !Layer2ScrollYSpeed                 ;;C746|C846+C846/C846\C846;
                      STZ.W !Layer2ScrollYPosUpd                ;;C749|C849+C849/C849\C849;
                    + INX                                       ;;C74C|C84C+C84C/C84C\C84C;
                      INX                                       ;;C74D|C84D+C84D/C84D\C84D;
                      DEC.B !_0                                 ;;C74E|C84E+C84E/C84E\C84E;
                      BNE CODE_05C830                           ;;C750|C850+C850/C850\C850;
                      SEP #$20                                  ;;C752|C852+C852/C852\C852; Accum (8 bit)
                      LDA.W !Layer1ScrollType                   ;;C754|C854+C854/C854\C854;
                      ORA.W !Layer2Touched                      ;;C757|C857+C857/C857\C857;
                      STA.W !Layer1ScrollType                   ;;C75A|C85A+C85A/C85A\C85A;
                      BEQ CODE_05C87D                           ;;C75D|C85D+C85D/C85D\C85D;
                      REP #$20                                  ;;C75F|C85F+C85F/C85F\C85F; Accum (16 bit)
                      LDA.W !NextLayer2YPos                     ;;C761|C861+C861/C861\C861;
                      CMP.W DATA_05C810,Y                       ;;C764|C864+C864/C864\C864;
                      BEQ CODE_05C87D                           ;;C767|C867+C867/C867\C867;
                      LDA.W !Layer2ScrollYSpeed                 ;;C769|C869+C869/C869\C869;
                      CMP.W DATA_05C814,Y                       ;;C76C|C86C+C86C/C86C\C86C;
                      BEQ CODE_05C875                           ;;C76F|C86F+C86F/C86F\C86F;
                      CLC                                       ;;C771|C871+C871/C871\C871;
                      ADC.W DATA_05C818,Y                       ;;C772|C872+C872/C872\C872;
CODE_05C875:          STA.W !Layer2ScrollYSpeed                 ;;C775|C875+C875/C875\C875;
                      LDX.B #$06                                ;;C778|C878+C878/C878\C878;
                      JSR CODE_05C4F9                           ;;C77A|C87A+C87A/C87A\C87A;
CODE_05C87D:          SEP #$20                                  ;;C77D|C87D+C87D/C87D\C87D; Accum (8 bit)
                      RTS                                       ;;C77F|C87F+C87F/C87F\C87F; Return
                                                                ;;                        ;
                                                                ;;                        ;
DATA_05C880:          db $00,$00,$C0,$01,$00,$03,$00,$08        ;;C780|C880+C880/C880\C880;
                      db $38,$08,$00,$0A,$00,$00,$80,$03        ;;C788|C888+C888/C888\C888;
                      db $50,$04,$90,$08,$60,$09,$80,$0E        ;;C790|C890+C890/C890\C890;
                      db $00,$40,$00,$40,$00,$40,$00,$40        ;;C798|C898+C898/C898\C898;
                      db $00,$40,$00,$00                        ;;C7A0|C8A0+C8A0/C8A0\C8A0;
                                                                ;;                        ;
DATA_05C8A4:          db $08,$00,$00,$03,$10,$04,$38,$08        ;;C7A4|C8A4+C8A4/C8A4\C8A4;
                      db $70,$08,$00,$0B,$08,$00,$50,$04        ;;C7AC|C8AC+C8AC/C8AC\C8AC;
                      db $A0,$04,$60,$09,$40,$0A,$FF,$0F        ;;C7B4|C8B4+C8B4/C8B4\C8B4;
                      db $00,$50,$00,$50,$00,$50,$00,$50        ;;C7BC|C8BC+C8BC/C8BC\C8BC;
                      db $00,$50,$80,$00                        ;;C7C4|C8C4+C8C4/C8C4\C8C4;
                                                                ;;                        ;
DATA_05C8C8:          db $C0,$00,$B0,$00,$70,$00,$C0,$00        ;;C7C8|C8C8+C8C8/C8C8\C8C8;
                      db $C0,$00,$C0,$00,$00,$00,$00,$00        ;;C7D0|C8D0+C8D0/C8D0\C8D0;
                      db $C0,$00,$B0,$00,$A0,$00,$70,$00        ;;C7D8|C8D8+C8D8/C8D8\C8D8;
                      db $B0,$00,$B0,$00,$B0,$00,$00,$00        ;;C7E0|C8E0+C8E0/C8E0\C8E0;
                      db $00,$00,$B0,$00,$20,$00,$20,$00        ;;C7E8|C8E8+C8E8/C8E8\C8E8;
                      db $20,$00,$10,$00,$10,$00,$10,$00        ;;C7F0|C8F0+C8F0/C8F0\C8F0;
                      db $00,$00,$00,$00,$10,$00                ;;C7F8|C8F8+C8F8/C8F8\C8F8;
                                                                ;;                        ;
DATA_05C8FE:          db $00,$01,$00,$01,$00,$08,$00,$01        ;;C7FE|C8FE+C8FE/C8FE\C8FE;
                      db $00,$01,$00,$08,$00,$00,$00,$00        ;;C806|C906+C906/C906\C906;
                      db $80,$01,$00,$FF,$00,$FF,$00,$00        ;;C80E|C90E+C90E/C90E\C90E;
                      db $00,$FF,$00,$FF,$00,$FF,$00,$FF        ;;C816|C916+C916/C916\C916;
                      db $00,$FF,$00,$FF,$00,$F8,$00,$F8        ;;C81E|C91E+C91E/C91E\C91E;
                      db $00,$F8,$00,$F8,$00,$F8,$00,$F8        ;;C826|C926+C926/C926\C926;
                      db $00,$00,$00,$00,$40,$FE                ;;C82E|C92E+C92E/C92E\C92E;
                                                                ;;                        ;
                   if ver_is_ntsc(!_VER)              ;\   IF   ;;++++++++++++++++++++++++; J, U, & SS
DATA_05C934:          db $80,$40,$01,$80,$00,$00,$80,$00        ;;C834|C934+C934          ;
                      db $40,$00,$00,$20,$40,$00,$20,$00        ;;C83C|C93C+C93C          ;
                      db $00,$20,$80,$80,$20,$80,$80,$20        ;;C844|C944+C944          ;
                      db $00,$00,$A0                            ;;C84C|C94C+C94C          ;
                   else                               ;<  ELSE  ;;------------------------; E0 & E1
DATA_05C934:          db $66,$33,$01,$66,$00,$00,$66,$00        ;;              /C934\C934;
                      db $33,$00,$00,$19,$33,$00,$19,$00        ;;              /C93C\C93C;
                      db $00,$19,$66,$66,$19,$66,$66,$19        ;;              /C944\C944;
                      db $00,$00,$80                            ;;              /C94C\C94C;
                   endif                              ;/ ENDIF  ;;++++++++++++++++++++++++;
                                                                ;;                        ;
DATA_05C94F:          db $00,$0C,$18                            ;;C84F|C94F+C94F/C94F\C94F;
                                                                ;;                        ;
DATA_05C952:          db $05,$05,$05                            ;;C852|C952+C952/C952\C952;
                                                                ;;                        ;
CODE_05C955:          LDX.W !Layer1ScrollBits                   ;;C855|C955+C955/C955\C955;
                      LDY.W !Layer2ScrollBits                   ;;C858|C958+C958/C958\C958;
CODE_05C95B:          REP #$20                                  ;;C85B|C95B+C95B/C95B\C95B; Accum (16 bit)
CODE_05C95D:          LDA.W !NextLayer2XPos                     ;;C85D|C95D+C95D/C95D\C95D;
                      CMP.W DATA_05C880,X                       ;;C860|C960+C960/C960\C960;
                      BCC +                                     ;;C863|C963+C963/C963\C963;
                      CMP.W DATA_05C8A4,X                       ;;C865|C965+C965/C965\C965;
                      BCS +                                     ;;C868|C968+C968/C968\C968;
                      TXA                                       ;;C86A|C96A+C96A/C96A\C96A;
                      LSR A                                     ;;C86B|C96B+C96B/C96B\C96B;
                      AND.W #$00FE                              ;;C86C|C96C+C96C/C96C\C96C;
                      STA.W !Layer1ScrollType                   ;;C86F|C96F+C96F/C96F\C96F;
                      LDA.W #$00C1                              ;;C872|C972+C972/C972\C972;
                      STA.W !NextLayer2YPos                     ;;C875|C975+C975/C975\C975;
                      STZ.W !Layer1ScrollTimer                  ;;C878|C978+C978/C978\C978;
                    + INX                                       ;;C87B|C97B+C97B/C97B\C97B;
                      INX                                       ;;C87C|C97C+C97C/C97C\C97C;
                      DEY                                       ;;C87D|C97D+C97D/C97D\C97D;
                      BNE CODE_05C95D                           ;;C87E|C97E+C97E/C97E\C97E;
                      SEP #$20                                  ;;C880|C980+C980/C980\C980; Accum (8 bit)
                      LDA.W !Layer1ScrollTimer                  ;;C882|C982+C982/C982\C982;
                      BEQ +                                     ;;C885|C985+C985/C985\C985;
                      DEC.W !Layer1ScrollTimer                  ;;C887|C987+C987/C987\C987;
                      RTS                                       ;;C88A|C98A+C98A/C98A\C98A; Return
                                                                ;;                        ;
                    + LDA.W !Layer1ScrollType                   ;;C88B|C98B+C98B/C98B\C98B;
                      CLC                                       ;;C88E|C98E+C98E/C98E\C98E;
                      ADC.W !Layer2ScrollType                   ;;C88F|C98F+C98F/C98F\C98F;
                      TAY                                       ;;C892|C992+C992/C992\C992;
                      LSR A                                     ;;C893|C993+C993/C993\C993;
                      TAX                                       ;;C894|C994+C994/C994\C994;
                      REP #$20                                  ;;C895|C995+C995/C995\C995; Accum (16 bit)
                      LDA.W !NextLayer2YPos                     ;;C897|C997+C997/C997\C997;
                      SEC                                       ;;C89A|C99A+C99A/C99A\C99A;
                      SBC.W DATA_05C8C8,Y                       ;;C89B|C99B+C99B/C99B\C99B;
                      EOR.W DATA_05C8FE,Y                       ;;C89E|C99E+C99E/C99E\C99E;
                      BPL +                                     ;;C8A1|C9A1+C9A1/C9A1\C9A1;
                      LDA.W DATA_05C8FE,Y                       ;;C8A3|C9A3+C9A3/C9A3\C9A3;
                      JMP CODE_05C875                           ;;C8A6|C9A6+C9A6/C9A6\C9A6;
                                                                ;;                        ;
                    + LDA.W DATA_05C8C8,Y                       ;;C8A9|C9A9+C9A9/C9A9\C9A9;
                      STA.W !NextLayer2YPos                     ;;C8AC|C9AC+C9AC/C9AC\C9AC;
                      SEP #$20                                  ;;C8AF|C9AF+C9AF/C9AF\C9AF; Accum (8 bit)
                      LDA.W DATA_05C934,X                       ;;C8B1|C9B1+C9B1/C9B1\C9B1;
                      STA.W !Layer1ScrollTimer                  ;;C8B4|C9B4+C9B4/C9B4\C9B4;
                      LDA.W !Layer2ScrollType                   ;;C8B7|C9B7+C9B7/C9B7\C9B7;
                      CLC                                       ;;C8BA|C9BA+C9BA/C9BA\C9BA;
                      ADC.B #$12                                ;;C8BB|C9BB+C9BB/C9BB\C9BB;
                      CMP.B #$36                                ;;C8BD|C9BD+C9BD/C9BD\C9BD;
                      BCC +                                     ;;C8BF|C9BF+C9BF/C9BF\C9BF;
                      LDA.B #!SFX_KAPOW                         ;;C8C1|C9C1+C9C1/C9C1\C9C1;
                      STA.W !SPCIO3                             ;;C8C3|C9C3+C9C3/C9C3\C9C3; / Play sound effect
                      LDA.B #$20                                ;;C8C6|C9C6+C9C6/C9C6\C9C6; \ Set ground shake timer
                      STA.W !ScreenShakeTimer                   ;;C8C8|C9C8+C9C8/C9C8\C9C8; /
                      LDA.B #$00                                ;;C8CB|C9CB+C9CB/C9CB\C9CB;
                    + STA.W !Layer2ScrollType                   ;;C8CD|C9CD+C9CD/C9CD\C9CD;
                      RTS                                       ;;C8D0|C9D0+C9D0/C9D0\C9D0; Return
                                                                ;;                        ;
                                                                ;;                        ;
DATA_05C9D1:          db $01,$01,$01,$00,$01,$01,$01,$00        ;;C8D1|C9D1+C9D1/C9D1\C9D1;
                      db $01,$09                                ;;C8D9|C9D9+C9D9/C9D9\C9D9;
                                                                ;;                        ;
DATA_05C9DB:          db $01,$00,$02,$00,$04,$03,$05,$00        ;;C8DB|C9DB+C9DB/C9DB\C9DB;
                      db $06,$00                                ;;C8E3|C9E3+C9E3/C9E3\C9E3;
                                                                ;;                        ;
DATA_05C9E5:          db $00,$01                                ;;C8E5|C9E5+C9E5/C9E5\C9E5;
                                                                ;;                        ;
DATA_05C9E7:          db $00,$00                                ;;C8E7|C9E7+C9E7/C9E7\C9E7;
                                                                ;;                        ;
DATA_05C9E9:          db $00,$00,$02,$02,$02,$00,$02,$05        ;;C8E9|C9E9+C9E9/C9E9\C9E9;
                      db $02,$02,$05,$00,$00,$02,$01,$00        ;;C8F1|C9F1+C9F1/C9F1\C9F1;
                      db $03,$02,$03,$04,$03,$01,$00,$01        ;;C8F9|C9F9+C9F9/C9F9\C9F9;
                      db $00,$00,$03,$00,$00,$00,$00            ;;C901|CA01+CA01/CA01\CA01;
                                                                ;;                        ;
DATA_05CA08:          db $00,$04,$00,$04                        ;;C908|CA08+CA08/CA08\CA08;
                                                                ;;                        ;
DATA_05CA0C:          db $00,$00,$00,$01                        ;;C90C|CA0C+CA0C/CA0C\CA0C;
                                                                ;;                        ;
DATA_05CA10:          db $00,$01                                ;;C910|CA10+CA10/CA10\CA10;
                                                                ;;                        ;
DATA_05CA12:          db $40,$01,$E0,$00                        ;;C912|CA12+CA12/CA12\CA12;
                                                                ;;                        ;
DATA_05CA16:          db $05,$00,$00,$05,$05,$02,$02,$05        ;;C916|CA16+CA16/CA16\CA16;
DATA_05CA1E:          db $00,$00,$00,$01,$02,$03,$04,$03        ;;C91E|CA1E+CA1E/CA1E\CA1E;
DATA_05CA26:          db $01,$00,$01,$01,$00,$06,$00,$06        ;;C926|CA26+CA26/CA26\CA26;
                      db $00,$00,$00,$01,$00,$01,$08,$00        ;;C92E|CA2E+CA2E/CA2E\CA2E;
                      db $00,$08,$00,$00,$00,$01,$01,$00        ;;C936|CA36+CA36/CA36\CA36;
DATA_05CA3E:          db $00,$08,$00,$08                        ;;C93E|CA3E+CA3E/CA3E\CA3E;
                                                                ;;                        ;
DATA_05CA42:          db $00,$00,$00,$01                        ;;C942|CA42+CA42/CA42\CA42;
                                                                ;;                        ;
DATA_05CA46:          db $01,$01                                ;;C946|CA46+CA46/CA46\CA46;
                                                                ;;                        ;
DATA_05CA48:          db $00,$03,$00,$03,$00,$03,$00,$03        ;;C948|CA48+CA48/CA48\CA48;
                      db $00,$03                                ;;C950|CA50+CA50/CA50\CA50;
                                                                ;;                        ;
DATA_05CA52:          db $00,$00,$00,$01,$00,$02,$00,$03        ;;C952|CA52+CA52/CA52\CA52;
                      db $00,$04                                ;;C95A|CA5A+CA5A/CA5A\CA5A;
                                                                ;;                        ;
DATA_05CA5C:          db $01,$00,$00,$00,$00                    ;;C95C|CA5C+CA5C/CA5C\CA5C;
                                                                ;;                        ;
DATA_05CA61:          db $01,$18,$1E,$29,$2D,$35,$47            ;;C961|CA61+CA61/CA61\CA61;
                                                                ;;                        ;
DATA_05CA68:          db $16,$05,$0A,$03,$07,$11                ;;C968|CA68+CA68/CA68\CA68;
                                                                ;;                        ;
DATA_05CA6E:          db $09                                    ;;C96E|CA6E+CA6E/CA6E\CA6E;
                                                                ;;                        ;
DATA_05CA6F:          db $00,$09,$14,$1C,$24,$28,$33,$3C        ;;C96F|CA6F+CA6F/CA6F\CA6F;
                      db $43,$4B,$54,$60,$67,$74,$77,$7B        ;;C977|CA77+CA77/CA77\CA77;
                      db $83,$8A,$8D,$90,$99,$A0,$B0,$00        ;;C97F|CA7F+CA7F/CA7F\CA7F;
                      db $09,$14,$2C,$3C,$B0,$00,$09,$11        ;;C987|CA87+CA87/CA87\CA87;
                      db $1D,$2C,$32,$41,$48,$63,$6B,$70        ;;C98F|CA8F+CA8F/CA8F\CA8F;
                      db $00,$27,$37,$70,$00,$07,$12,$27        ;;C997|CA97+CA97/CA97\CA97;
                      db $32,$48,$5B,$70,$00,$20,$28,$3A        ;;C99F|CA9F+CA9F/CA9F\CA9F;
                      db $40,$5F,$66,$6B,$6B,$80,$80,$89        ;;C9A7|CAA7+CAA7/CAA7\CAA7;
                      db $92,$96,$9A,$9E,$A0,$B0,$00,$10        ;;C9AF|CAAF+CAAF/CAAF\CAAF;
                      db $1A,$20,$2B,$30,$3B,$40,$4B            ;;C9B7|CAB7+CAB7/CAB7\CAB7;
                                                                ;;                        ;
DATA_05CABE:          db $50                                    ;;C9BE|CABE+CABE/CABE\CABE;
                                                                ;;                        ;
DATA_05CABF:          db $0C,$0C,$06,$0B,$08,$0C,$03,$02        ;;C9BF|CABF+CABF/CABF\CABF;
                      db $09,$03,$09,$02,$06,$06,$07,$05        ;;C9C7|CAC7+CAC7/CAC7\CAC7;
                      db $08,$05,$0A,$04,$08,$04,$04,$0C        ;;C9CF|CACF+CACF/CACF\CACF;
                      db $0C,$07,$07,$05,$05,$0C,$0C,$08        ;;C9D7|CAD7+CAD7/CAD7\CAD7;
                      db $0C,$0C,$07,$07,$0A,$0A,$0C,$0C        ;;C9DF|CADF+CADF/CADF\CADF;
                      db $00,$00,$0A,$0A,$00,$00,$09,$09        ;;C9E7|CAE7+CAE7/CAE7\CAE7;
                      db $03,$03,$0C,$0C,$0C,$0C,$08,$08        ;;C9EF|CAEF+CAEF/CAEF\CAEF;
                      db $05,$05,$02,$02,$09,$09,$01,$01        ;;C9F7|CAF7+CAF7/CAF7\CAF7;
                      db $01,$02,$03,$07,$08,$08,$0C,$0C        ;;C9FF|CAFF+CAFF/CAFF\CAFF;
                      db $02,$02,$0A,$0A,$02,$02,$0A,$0A        ;;CA07|CB07+CB07/CB07\CB07;
DATA_05CB0F:          db $07,$07,$07,$07,$07,$07,$07,$07        ;;CA0F|CB0F+CB0F/CB0F\CB0F;
                      db $07,$07,$07,$07,$07,$07,$07,$07        ;;CA17|CB17+CB17/CB17\CB17;
                      db $07,$07,$07,$07,$07,$07,$07,$07        ;;CA1F|CB1F+CB1F/CB1F\CB1F;
                      db $07,$07,$07,$07,$07,$07,$07,$07        ;;CA27|CB27+CB27/CB27\CB27;
                      db $07,$07,$07,$07,$07,$07,$07,$07        ;;CA2F|CB2F+CB2F/CB2F\CB2F;
                      db $07,$07,$07,$07,$07,$07,$07,$07        ;;CA37|CB37+CB37/CB37\CB37;
                      db $07,$07,$07,$07,$08,$08,$08,$08        ;;CA3F|CB3F+CB3F/CB3F\CB3F;
                      db $08,$08,$10,$08,$40,$08,$04,$08        ;;CA47|CB47+CB47/CB47\CB47;
                      db $10,$08,$08,$10,$10,$08,$08,$08        ;;CA4F|CB4F+CB4F/CB4F\CB4F;
                      db $08,$08,$08,$08,$08,$08,$08,$08        ;;CA57|CB57+CB57/CB57\CB57;
DATA_05CB5F:          db $01,$00,$FF,$FF,$01,$00,$FF,$FF        ;;CA5F|CB5F+CB5F/CB5F\CB5F;
                      db $01,$00,$FF,$FF,$01,$00,$FF,$FF        ;;CA67|CB67+CB67/CB67\CB67;
                      db $01,$00,$FF,$FF,$01,$00,$FF,$FF        ;;CA6F|CB6F+CB6F/CB6F\CB6F;
                      db $01,$00,$FF,$FF                        ;;CA77|CB77+CB77/CB77\CB77;
                                                                ;;                        ;
DATA_05CB7B:          db $01,$00,$FF,$FF,$01,$00,$FF,$FF        ;;CA7B|CB7B+CB7B/CB7B\CB7B;
                      db $01,$00,$FF,$FF,$01,$00,$FF,$FF        ;;CA83|CB83+CB83/CB83\CB83;
                      db $01,$00,$FF,$FF,$01,$00,$FF,$FF        ;;CA8B|CB8B+CB8B/CB8B\CB8B;
                      db $01,$00,$FF,$FF,$04,$00,$FC,$FF        ;;CA93|CB93+CB93/CB93\CB93;
DATA_05CB9B:          db $01,$00,$FF,$FF,$01,$00,$FF,$FF        ;;CA9B|CB9B+CB9B/CB9B\CB9B;
DATA_05CBA3:          db $04,$00,$FC,$FF,$04,$00,$FC,$FF        ;;CAA3|CBA3+CBA3/CBA3\CBA3;
                      db $04,$00,$FC,$FF,$04,$00,$FC,$FF        ;;CAAB|CBAB+CBAB/CBAB\CBAB;
                      db $01,$00,$FF,$FF,$01,$00,$FF,$FF        ;;CAB3|CBB3+CBB3/CBB3\CBB3;
DATA_05CBBB:          db $04,$00,$FC,$FF,$04,$00,$FC,$FF        ;;CABB|CBBB+CBBB/CBBB\CBBB;
DATA_05CBC3:          db $01,$00,$FF,$FF                        ;;CAC3|CBC3+CBC3/CBC3\CBC3;
                                                                ;;                        ;
DATA_05CBC7:          db $30                                    ;;CAC7|CBC7+CBC7/CBC7\CBC7;
                                                                ;;                        ;
DATA_05CBC8:          db $70,$80,$10,$28,$30,$30,$30,$30        ;;CAC8|CBC8+CBC8/CBC8\CBC8;
                      db $14,$02,$30,$30,$30,$30,$70,$80        ;;CAD0|CBD0+CBD0/CBD0\CBD0;
                      db $70,$80,$70,$80,$70,$80,$70,$80        ;;CAD8|CBD8+CBD8/CBD8\CBD8;
                      db $70,$80,$18                            ;;CAE0|CBE0+CBE0/CBE0\CBE0;
                                                                ;;                        ;
DATA_05CBE3:          db $18,$18                                ;;CAE3|CBE3+CBE3/CBE3\CBE3;
                                                                ;;                        ;
DATA_05CBE5:          db $18,$18,$08,$20,$06,$06                ;;CAE5|CBE5+CBE5/CBE5\CBE5;
                                                                ;;                        ;
DATA_05CBEB:          db $04,$04                                ;;CAEB|CBEB+CBEB/CBEB\CBEB;
                                                                ;;                        ;
DATA_05CBED:          db $60                                    ;;CAED|CBED+CBED/CBED\CBED;
                                                                ;;                        ;
DATA_05CBEE:          db $42,$D0,$B2                            ;;CAEE|CBEE+CBEE/CBEE\CBEE;
                                                                ;;                        ;
DATA_05CBF1:          db $80,$80,$80,$80                        ;;CAF1|CBF1+CBF1/CBF1\CBF1;
                                                                ;;                        ;
                   if ver_is_lores(!_VER)             ;\   IF   ;;++++++++++++++++++++++++; J, U, SS, & E0
DATA_05CBF5:          db $90                                    ;;CAF5|CBF5+CBF5/CBF5     ;
DATA_05CBF6:          db $72,$60,$42,$20,$10,$40,$22,$20        ;;CAF6|CBF6+CBF6/CBF6     ;
                      db $10                                    ;;CAFE|CBFE+CBFE/CBFE     ;
                   else                               ;<  ELSE  ;;------------------------; E1
DATA_05CBF5:          db $90                                    ;;                   \CBF5;
DATA_05CBF6:          db $72,$60,$42,$22,$02,$40,$22,$20        ;;                   \CBF6;
                      db $10                                    ;;                   \CBFE;
                   endif                              ;/ ENDIF  ;;++++++++++++++++++++++++;
                                                                ;;                        ;
CODE_05CBFF:          PHB                                       ;;CAFF|CBFF+CBFF/CBFF\CBFF;
                      PHK                                       ;;CB00|CC00+CC00/CC00\CC00; Wrapper
                      PLB                                       ;;CB01|CC01+CC01/CC01\CC01;
                      JSR CODE_05CC07                           ;;CB02|CC02+CC02/CC02\CC02;
                      PLB                                       ;;CB05|CC05+CC05/CC05\CC05;
                      RTL                                       ;;CB06|CC06+CC06/CC06\CC06; Return
                                                                ;;                        ;
CODE_05CC07:          LDA.W !OverworldProcess                   ;;CB07|CC07+CC07/CC07\CC07;
                      JSL ExecutePtr                            ;;CB0A|CC0A+CC0A/CC0A\CC0A;
                                                                ;;                        ;
                      dw CODE_05CC66                            ;;CB0E|CC0E+CC0E/CC0E\CC0E;
                      dw CODE_05CD76                            ;;CB10|CC10+CC10/CC10\CC10;
                      dw CODE_05CECA                            ;;CB12|CC12+CC12/CC12\CC12;
                      dw Return05CFE9                           ;;CB14|CC14+CC14/CC14\CC14;
                                                                ;;                        ;
DATA_05CC16:          db $51,$0D,$00,$09,$30,$28,$31,$28        ;;CB16|CC16+CC16/CC16\CC16;
                      db $32,$28,$33,$28,$34,$28,$51,$49        ;;CB1E|CC1E+CC1E/CC1E\CC1E;
                      db $00,$19,$0C,$38,$18,$38,$1E,$38        ;;CB26|CC26+CC26/CC26\CC26;
                      db $1B,$38,$1C,$38,$0E,$38,$FC,$38        ;;CB2E|CC2E+CC2E/CC2E\CC2E;
                      db $0C,$38,$15,$38,$0E,$38,$0A,$38        ;;CB36|CC36+CC36/CC36\CC36;
                      db $1B,$38,$28,$38,$51,$A9,$00,$19        ;;CB3E|CC3E+CC3E/CC3E\CC3E;
                      db $76,$38,$FC,$38,$FC,$38,$FC,$38        ;;CB46|CC46+CC46/CC46\CC46;
                      db $26,$38,$05,$38,$00,$38,$77,$38        ;;CB4E|CC4E+CC4E/CC4E\CC4E;
                      db $FC,$38,$FC,$38,$FC,$38,$FC,$38        ;;CB56|CC56+CC56/CC56\CC56;
                      db $FC,$38,$FF                            ;;CB5E|CC5E+CC5E/CC5E\CC5E;
                                                                ;;                        ;
DATA_05CC61:          db $40,$41,$42,$43,$44                    ;;CB61|CC61+CC61/CC61\CC61;
                                                                ;;                        ;
CODE_05CC66:          LDY.B #$00                                ;;CB66|CC66+CC66/CC66\CC66;
                      LDX.W !PlayerTurnLvl                      ;;CB68|CC68+CC68/CC68\CC68;
                      LDA.W !PlayerBonusStars,X                 ;;CB6B|CC6B+CC6B/CC6B\CC6B;
CODE_05CC6E:          CMP.B #$0A                                ;;CB6E|CC6E+CC6E/CC6E\CC6E;
                      BCC CODE_05CC77                           ;;CB70|CC70+CC70/CC70\CC70;
                      SBC.B #$0A                                ;;CB72|CC72+CC72/CC72\CC72;
                      INY                                       ;;CB74|CC74+CC74/CC74\CC74;
                      BRA CODE_05CC6E                           ;;CB75|CC75+CC75/CC75\CC75;
                                                                ;;                        ;
CODE_05CC77:          CPY.W !InGameTimerTens                    ;;CB77|CC77+CC77/CC77\CC77;
                      BNE +                                     ;;CB7A|CC7A+CC7A/CC7A\CC7A;
                      CPY.W !InGameTimerOnes                    ;;CB7C|CC7C+CC7C/CC7C\CC7C;
                      BNE +                                     ;;CB7F|CC7F+CC7F/CC7F\CC7F;
                      INC.W !GivePlayerLives                    ;;CB81|CC81+CC81/CC81\CC81;
                    + LDA.B #$01                                ;;CB84|CC84+CC84/CC84\CC84;
                      STA.W !Layer3ScrollType                   ;;CB86|CC86+CC86/CC86\CC86;
                      LDA.B #$08                                ;;CB89|CC89+CC89/CC89\CC89;
                      TSB.B !MainBGMode                         ;;CB8B|CC8B+CC8B/CC8B\CC8B;
                      REP #$30                                  ;;CB8D|CC8D+CC8D/CC8D\CC8D; Index (16 bit) Accum (16 bit)
                      STZ.B !Layer3XPos                         ;;CB8F|CC8F+CC8F/CC8F\CC8F;
                      STZ.B !Layer3YPos                         ;;CB91|CC91+CC91/CC91\CC91;
                      LDY.W #$004A                              ;;CB93|CC93+CC93/CC93\CC93;
                      TYA                                       ;;CB96|CC96+CC96/CC96\CC96;
                      CLC                                       ;;CB97|CC97+CC97/CC97\CC97;
                      ADC.L !DynStripeImgSize                   ;;CB98|CC98+CC98/CC98\CC98;
                      TAX                                       ;;CB9C|CC9C+CC9C/CC9C\CC9C;
                    - LDA.W DATA_05CC16,Y                       ;;CB9D|CC9D+CC9D/CC9D\CC9D;
                      STA.L !DynamicStripeImage,X               ;;CBA0|CCA0+CCA0/CCA0\CCA0;
                      DEX                                       ;;CBA4|CCA4+CCA4/CCA4\CCA4;
                      DEX                                       ;;CBA5|CCA5+CCA5/CCA5\CCA5;
                      DEY                                       ;;CBA6|CCA6+CCA6/CCA6\CCA6;
                      DEY                                       ;;CBA7|CCA7+CCA7/CCA7\CCA7;
                      BPL -                                     ;;CBA8|CCA8+CCA8/CCA8\CCA8;
                      LDA.L !DynStripeImgSize                   ;;CBAA|CCAA+CCAA/CCAA\CCAA;
                      TAX                                       ;;CBAE|CCAE+CCAE/CCAE\CCAE;
                      SEP #$20                                  ;;CBAF|CCAF+CCAF/CCAF\CCAF; Accum (8 bit)
                      LDA.W !PlayerTurnLvl                      ;;CBB1|CCB1+CCB1/CCB1\CCB1;
                      BEQ CODE_05CCC8                           ;;CBB4|CCB4+CCB4/CCB4\CCB4;
                      LDY.W #$0000                              ;;CBB6|CCB6+CCB6/CCB6\CCB6;
                    - LDA.W DATA_05CC61,Y                       ;;CBB9|CCB9+CCB9/CCB9\CCB9;
                      STA.L !DynamicStripeImage+4,X             ;;CBBC|CCBC+CCBC/CCBC\CCBC;
                      INX                                       ;;CBC0|CCC0+CCC0/CCC0\CCC0;
                      INX                                       ;;CBC1|CCC1+CCC1/CCC1\CCC1;
                      INY                                       ;;CBC2|CCC2+CCC2/CCC2\CCC2;
                      CPY.W #$0005                              ;;CBC3|CCC3+CCC3/CCC3\CCC3;
                      BNE -                                     ;;CBC6|CCC6+CCC6/CCC6\CCC6;
CODE_05CCC8:          LDY.W #$0002                              ;;CBC8|CCC8+CCC8/CCC8\CCC8;
                      LDA.B #$04                                ;;CBCB|CCCB+CCCB/CCCB\CCCB;
                      CLC                                       ;;CBCD|CCCD+CCCD/CCCD\CCCD;
                      ADC.L !DynStripeImgSize                   ;;CBCE|CCCE+CCCE/CCCE\CCCE;
                      TAX                                       ;;CBD2|CCD2+CCD2/CCD2\CCD2;
                    - LDA.W !InGameTimerHundreds,Y              ;;CBD3|CCD3+CCD3/CCD3\CCD3;
                      STA.L !DynamicStripeImage+$32,X           ;;CBD6|CCD6+CCD6/CCD6\CCD6;
                      DEY                                       ;;CBDA|CCDA+CCDA/CCDA\CCDA;
                      DEX                                       ;;CBDB|CCDB+CCDB/CCDB\CCDB;
                      DEX                                       ;;CBDC|CCDC+CCDC/CCDC\CCDC;
                      BPL -                                     ;;CBDD|CCDD+CCDD/CCDD\CCDD;
                      LDA.L !DynStripeImgSize                   ;;CBDF|CCDF+CCDF/CCDF\CCDF;
                      TAX                                       ;;CBE3|CCE3+CCE3/CCE3\CCE3;
CODE_05CCE4:          LDA.L !DynamicStripeImage+$32,X           ;;CBE4|CCE4+CCE4/CCE4\CCE4;
                      AND.B #$0F                                ;;CBE8|CCE8+CCE8/CCE8\CCE8;
                      BNE CODE_05CCF9                           ;;CBEA|CCEA+CCEA/CCEA\CCEA;
                      LDA.B #$FC                                ;;CBEC|CCEC+CCEC/CCEC\CCEC;
                      STA.L !DynamicStripeImage+$32,X           ;;CBEE|CCEE+CCEE/CCEE\CCEE;
                      INX                                       ;;CBF2|CCF2+CCF2/CCF2\CCF2;
                      INX                                       ;;CBF3|CCF3+CCF3/CCF3\CCF3;
                      CPX.W #$0004                              ;;CBF4|CCF4+CCF4/CCF4\CCF4;
                      BNE CODE_05CCE4                           ;;CBF7|CCF7+CCF7/CCF7\CCF7;
CODE_05CCF9:          SEP #$10                                  ;;CBF9|CCF9+CCF9/CCF9\CCF9; Index (8 bit)
                      JSR CODE_05CE4C                           ;;CBFB|CCFB+CCFB/CCFB\CCFB;
                      REP #$20                                  ;;CBFE|CCFE+CCFE/CCFE\CCFE; Accum (16 bit)
                      STZ.B !_0                                 ;;CC00|CD00+CD00/CD00\CD00;
                      LDA.B !_2                                 ;;CC02|CD02+CD02/CD02\CD02;
                      STA.W !ScoreIncrement                     ;;CC04|CD04+CD04/CD04\CD04;
                      LDX.B #$42                                ;;CC07|CD07+CD07/CD07\CD07;
                      LDY.B #$00                                ;;CC09|CD09+CD09/CD09\CD09;
                      JSR CODE_05CDFD                           ;;CC0B|CD0B+CD0B/CD0B\CD0B;
                      LDX.B #$00                                ;;CC0E|CD0E+CD0E/CD0E\CD0E;
CODE_05CD10:          LDA.L !DynamicStripeImage+$40,X           ;;CC10|CD10+CD10/CD10\CD10;
                      AND.W #$000F                              ;;CC14|CD14+CD14/CD14\CD14;
                      BNE CODE_05CD26                           ;;CC17|CD17+CD17/CD17\CD17;
                      LDA.W #$38FC                              ;;CC19|CD19+CD19/CD19\CD19;
                      STA.L !DynamicStripeImage+$40,X           ;;CC1C|CD1C+CD1C/CD1C\CD1C;
                      INX                                       ;;CC20|CD20+CD20/CD20\CD20;
                      INX                                       ;;CC21|CD21+CD21/CD21\CD21;
                      CPX.B #$08                                ;;CC22|CD22+CD22/CD22\CD22;
                      BNE CODE_05CD10                           ;;CC24|CD24+CD24/CD24\CD24;
CODE_05CD26:          SEP #$20                                  ;;CC26|CD26+CD26/CD26\CD26; Accum (8 bit)
                      INC.W !OverworldProcess                   ;;CC28|CD28+CD28/CD28\CD28;
                      LDA.B #$28                                ;;CC2B|CD2B+CD2B/CD2B\CD2B;
                      STA.W !DisplayBonusStars                  ;;CC2D|CD2D+CD2D/CD2D\CD2D;
                      LDA.B #$4A                                ;;CC30|CD30+CD30/CD30\CD30;
                      CLC                                       ;;CC32|CD32+CD32/CD32\CD32;
                      ADC.L !DynStripeImgSize                   ;;CC33|CD33+CD33/CD33\CD33;
                      INC A                                     ;;CC37|CD37+CD37/CD37\CD37;
                      STA.L !DynStripeImgSize                   ;;CC38|CD38+CD38/CD38\CD38;
                      SEP #$30                                  ;;CC3C|CD3C+CD3C/CD3C\CD3C; Index (8 bit) Accum (8 bit)
                      RTS                                       ;;CC3E|CD3E+CD3E/CD3E\CD3E; Return
                                                                ;;                        ;
                                                                ;;                        ;
DATA_05CD3F:          db $52,$0A,$00,$15,$0B,$38,$18,$38        ;;CC3F|CD3F+CD3F/CD3F\CD3F;
                      db $17,$38,$1E,$38,$1C,$38,$28,$38        ;;CC47|CD47+CD47/CD47\CD47;
                      db $FC,$38,$64,$28,$26,$38,$FC,$38        ;;CC4F|CD4F+CD4F/CD4F\CD4F;
                      db $FC,$38,$51,$F3,$00,$03,$FC,$38        ;;CC57|CD57+CD57/CD57\CD57;
                      db $FC,$38,$FF                            ;;CC5F|CD5F+CD5F/CD5F\CD5F;
                                                                ;;                        ;
DATA_05CD62:          db $B7                                    ;;CC62|CD62+CD62/CD62\CD62;
                                                                ;;                        ;
DATA_05CD63:          db $C3,$B8,$B9,$BA,$BB,$BA,$BF,$BC        ;;CC63|CD63+CD63/CD63\CD63;
                      db $BD,$BE,$BF,$C0,$C3,$C1,$B9,$C2        ;;CC6B|CD6B+CD6B/CD6B\CD6B;
                      db $C4,$B7,$C5                            ;;CC73|CD73+CD73/CD73\CD73;
                                                                ;;                        ;
CODE_05CD76:          LDA.W !BonusStarsGained                   ;;CC76|CD76+CD76/CD76\CD76;
                      BEQ CODE_05CDD5                           ;;CC79|CD79+CD79/CD79\CD79;
                      DEC.W !DisplayBonusStars                  ;;CC7B|CD7B+CD7B/CD7B\CD7B;
                      BPL Return05CDE8                          ;;CC7E|CD7E+CD7E/CD7E\CD7E;
                      LDY.B #$22                                ;;CC80|CD80+CD80/CD80\CD80;
                      TYA                                       ;;CC82|CD82+CD82/CD82\CD82;
                      CLC                                       ;;CC83|CD83+CD83/CD83\CD83;
                      ADC.L !DynStripeImgSize                   ;;CC84|CD84+CD84/CD84\CD84;
                      TAX                                       ;;CC88|CD88+CD88/CD88\CD88;
                    - LDA.W DATA_05CD3F,Y                       ;;CC89|CD89+CD89/CD89\CD89;
                      STA.L !DynamicStripeImage,X               ;;CC8C|CD8C+CD8C/CD8C\CD8C;
                      DEX                                       ;;CC90|CD90+CD90/CD90\CD90;
                      DEY                                       ;;CC91|CD91+CD91/CD91\CD91;
                      BPL -                                     ;;CC92|CD92+CD92/CD92\CD92;
                      LDA.L !DynStripeImgSize                   ;;CC94|CD94+CD94/CD94\CD94;
                      TAX                                       ;;CC98|CD98+CD98/CD98\CD98;
                      LDA.W !BonusStarsGained                   ;;CC99|CD99+CD99/CD99\CD99;
                      AND.B #$0F                                ;;CC9C|CD9C+CD9C/CD9C\CD9C;
                      ASL A                                     ;;CC9E|CD9E+CD9E/CD9E\CD9E;
                      TAY                                       ;;CC9F|CD9F+CD9F/CD9F\CD9F;
                      LDA.W DATA_05CD63,Y                       ;;CCA0|CDA0+CDA0/CDA0\CDA0;
                      STA.L !DynamicStripeImage+$18,X           ;;CCA3|CDA3+CDA3/CDA3\CDA3;
                      LDA.W DATA_05CD62,Y                       ;;CCA7|CDA7+CDA7/CDA7\CDA7;
                      STA.L !DynamicStripeImage+$20,X           ;;CCAA|CDAA+CDAA/CDAA\CDAA;
                      LDA.W !BonusStarsGained                   ;;CCAE|CDAE+CDAE/CDAE\CDAE;
                      AND.B #$F0                                ;;CCB1|CDB1+CDB1/CDB1\CDB1;
                      LSR A                                     ;;CCB3|CDB3+CDB3/CDB3\CDB3;
                      LSR A                                     ;;CCB4|CDB4+CDB4/CDB4\CDB4;
                      LSR A                                     ;;CCB5|CDB5+CDB5/CDB5\CDB5;
                      LSR A                                     ;;CCB6|CDB6+CDB6/CDB6\CDB6;
                      BEQ +                                     ;;CCB7|CDB7+CDB7/CDB7\CDB7;
                      ASL A                                     ;;CCB9|CDB9+CDB9/CDB9\CDB9;
                      TAY                                       ;;CCBA|CDBA+CDBA/CDBA\CDBA;
                      LDA.W DATA_05CD63,Y                       ;;CCBB|CDBB+CDBB/CDBB\CDBB;
                      STA.L !DynamicStripeImage+$16,X           ;;CCBE|CDBE+CDBE/CDBE\CDBE;
                      LDA.W DATA_05CD62,Y                       ;;CCC2|CDC2+CDC2/CDC2\CDC2;
                      STA.L !DynamicStripeImage+$1E,X           ;;CCC5|CDC5+CDC5/CDC5\CDC5;
                    + LDA.B #$22                                ;;CCC9|CDC9+CDC9/CDC9\CDC9;
                      CLC                                       ;;CCCB|CDCB+CDCB/CDCB\CDCB;
                      ADC.L !DynStripeImgSize                   ;;CCCC|CDCC+CDCC/CDCC\CDCC;
                      INC A                                     ;;CCD0|CDD0+CDD0/CDD0\CDD0;
                      STA.L !DynStripeImgSize                   ;;CCD1|CDD1+CDD1/CDD1\CDD1;
CODE_05CDD5:          DEC.W !DrumrollTimer                      ;;CCD5|CDD5+CDD5/CDD5\CDD5;
                      BPL Return05CDE8                          ;;CCD8|CDD8+CDD8/CDD8\CDD8;
                      LDA.W !BonusStarsGained                   ;;CCDA|CDDA+CDDA/CDDA\CDDA;
                      STA.W !DisplayBonusStars                  ;;CCDD|CDDD+CDDD/CDDD\CDDD;
                      INC.W !OverworldProcess                   ;;CCE0|CDE0+CDE0/CDE0\CDE0;
                      LDA.B #!SFX_DRUMROLLSTART                 ;;CCE3|CDE3+CDE3/CDE3\CDE3;
                      STA.W !SPCIO3                             ;;CCE5|CDE5+CDE5/CDE5\CDE5; / Play sound effect
Return05CDE8:         RTS                                       ;;CCE8|CDE8+CDE8/CDE8\CDE8; Return
                                                                ;;                        ;
                                                                ;;                        ;
DATA_05CDE9:          db $00,$00                                ;;CCE9|CDE9+CDE9/CDE9\CDE9;
                                                                ;;                        ;
DATA_05CDEB:          db $10,$27,$00,$00,$E8,$03,$00,$00        ;;CCEB|CDEB+CDEB/CDEB\CDEB;
                      db $64,$00,$00,$00,$0A,$00,$00,$00        ;;CCF3|CDF3+CDF3/CDF3\CDF3;
                      db $01,$00                                ;;CCFB|CDFB+CDFB/CDFB\CDFB;
                                                                ;;                        ;
CODE_05CDFD:          LDA.L !DynStripeImgSize,X                 ;;CCFD|CDFD+CDFD/CDFD\CDFD; Accum (16 bit)
                      AND.W #$FF00                              ;;CD01|CE01+CE01/CE01\CE01;
                      STA.L !DynStripeImgSize,X                 ;;CD04|CE04+CE04/CE04\CE04;
CODE_05CE08:          PHX                                       ;;CD08|CE08+CE08/CE08\CE08;
                      TYX                                       ;;CD09|CE09+CE09/CE09\CE09;
                      LDA.B !_2                                 ;;CD0A|CE0A+CE0A/CE0A\CE0A;
                      SEC                                       ;;CD0C|CE0C+CE0C/CE0C\CE0C;
                      %LorW_X(SBC,DATA_05CDEB)                  ;;CD0D|CE0D+CE0D/CE0D\CE0D;
                      STA.B !_6                                 ;;CD11|CE10+CE10/CE10\CE10;
                      LDA.B !_0                                 ;;CD13|CE12+CE12/CE12\CE12;
                      %LorW_X(SBC,DATA_05CDE9)                  ;;CD15|CE14+CE14/CE14\CE14;
                      STA.B !_4                                 ;;CD19|CE17+CE17/CE17\CE17;
                      PLX                                       ;;CD1B|CE19+CE19/CE19\CE19;
                      BCC CODE_05CE2F                           ;;CD1C|CE1A+CE1A/CE1A\CE1A;
                      LDA.B !_6                                 ;;CD1E|CE1C+CE1C/CE1C\CE1C;
                      STA.B !_2                                 ;;CD20|CE1E+CE1E/CE1E\CE1E;
                      LDA.B !_4                                 ;;CD22|CE20+CE20/CE20\CE20;
                      STA.B !_0                                 ;;CD24|CE22+CE22/CE22\CE22;
                      LDA.L !DynStripeImgSize,X                 ;;CD26|CE24+CE24/CE24\CE24;
                      INC A                                     ;;CD2A|CE28+CE28/CE28\CE28;
                      STA.L !DynStripeImgSize,X                 ;;CD2B|CE29+CE29/CE29\CE29;
                      BRA CODE_05CE08                           ;;CD2F|CE2D+CE2D/CE2D\CE2D;
                                                                ;;                        ;
CODE_05CE2F:          INX                                       ;;CD31|CE2F+CE2F/CE2F\CE2F;
                      INX                                       ;;CD32|CE30+CE30/CE30\CE30;
                      INY                                       ;;CD33|CE31+CE31/CE31\CE31;
                      INY                                       ;;CD34|CE32+CE32/CE32\CE32;
                      INY                                       ;;CD35|CE33+CE33/CE33\CE33;
                      INY                                       ;;CD36|CE34+CE34/CE34\CE34;
                      CPY.B #$14                                ;;CD37|CE35+CE35/CE35\CE35;
                      BNE CODE_05CDFD                           ;;CD39|CE37+CE37/CE37\CE37;
                      RTS                                       ;;CD3B|CE39+CE39/CE39\CE39; Return
                                                                ;;                        ;
                                                                ;;                        ;
DATA_05CE3A:          db $00,$00,$64,$00,$C8,$00,$2C,$01        ;;CD3C|CE3A+CE3A/CE3A\CE3A;
DATA_05CE42:          db $00,$0A,$14,$1E,$28,$32,$3C,$46        ;;CD44|CE42+CE42/CE42\CE42;
                      db $50,$5A                                ;;CD4C|CE4A+CE4A/CE4A\CE4A;
                                                                ;;                        ;
CODE_05CE4C:          REP #$20                                  ;;CD4E|CE4C+CE4C/CE4C\CE4C; Accum (16 bit)
                      LDA.W !InGameTimerHundreds                ;;CD50|CE4E+CE4E/CE4E\CE4E;
                      ASL A                                     ;;CD53|CE51+CE51/CE51\CE51;
                      TAX                                       ;;CD54|CE52+CE52/CE52\CE52;
                      LDA.W DATA_05CE3A,X                       ;;CD55|CE53+CE53/CE53\CE53;
                      STA.B !_0                                 ;;CD58|CE56+CE56/CE56\CE56;
                      LDA.W !InGameTimerTens                    ;;CD5A|CE58+CE58/CE58\CE58;
                      TAX                                       ;;CD5D|CE5B+CE5B/CE5B\CE5B;
                      LDA.W DATA_05CE42,X                       ;;CD5E|CE5C+CE5C/CE5C\CE5C;
                      AND.W #$00FF                              ;;CD61|CE5F+CE5F/CE5F\CE5F;
                      CLC                                       ;;CD64|CE62+CE62/CE62\CE62;
                      ADC.B !_0                                 ;;CD65|CE63+CE63/CE63\CE63;
                      STA.B !_0                                 ;;CD67|CE65+CE65/CE65\CE65;
                      LDA.W !InGameTimerOnes                    ;;CD69|CE67+CE67/CE67\CE67;
                      AND.W #$00FF                              ;;CD6C|CE6A+CE6A/CE6A\CE6A;
                      CLC                                       ;;CD6F|CE6D+CE6D/CE6D\CE6D;
                      ADC.B !_0                                 ;;CD70|CE6E+CE6E/CE6E\CE6E;
                      STA.B !_0                                 ;;CD72|CE70+CE70/CE70\CE70;
                      SEP #$20                                  ;;CD74|CE72+CE72/CE72\CE72; Accum (8 bit)
                      LDA.B !_0                                 ;;CD76|CE74+CE74/CE74\CE74;
                      STA.W !HW_WRMPYA                          ;;CD78|CE76+CE76/CE76\CE76; Multiplicand A
                      LDA.B #$32                                ;;CD7B|CE79+CE79/CE79\CE79;
                      STA.W !HW_WRMPYB                          ;;CD7D|CE7B+CE7B/CE7B\CE7B; Multplier B
                      NOP                                       ;;CD80|CE7E+CE7E/CE7E\CE7E;
                      NOP                                       ;;CD81|CE7F+CE7F/CE7F\CE7F;
                      NOP                                       ;;CD82|CE80+CE80/CE80\CE80;
                      NOP                                       ;;CD83|CE81+CE81/CE81\CE81;
                      LDA.W !HW_RDMPY                           ;;CD84|CE82+CE82/CE82\CE82; Product/Remainder Result (Low Byte)
                      STA.B !_2                                 ;;CD87|CE85+CE85/CE85\CE85;
                      LDA.W !HW_RDMPY+1                         ;;CD89|CE87+CE87/CE87\CE87; Product/Remainder Result (High Byte)
                      STA.B !_3                                 ;;CD8C|CE8A+CE8A/CE8A\CE8A;
                      LDA.B !_1                                 ;;CD8E|CE8C+CE8C/CE8C\CE8C;
                      STA.W !HW_WRMPYA                          ;;CD90|CE8E+CE8E/CE8E\CE8E; Multiplicand A
                      LDA.B #$32                                ;;CD93|CE91+CE91/CE91\CE91;
                      STA.W !HW_WRMPYB                          ;;CD95|CE93+CE93/CE93\CE93; Multplier B
                      NOP                                       ;;CD98|CE96+CE96/CE96\CE96;
                      NOP                                       ;;CD99|CE97+CE97/CE97\CE97;
                      NOP                                       ;;CD9A|CE98+CE98/CE98\CE98;
                      NOP                                       ;;CD9B|CE99+CE99/CE99\CE99;
                      LDA.W !HW_RDMPY                           ;;CD9C|CE9A+CE9A/CE9A\CE9A; Product/Remainder Result (Low Byte)
                      CLC                                       ;;CD9F|CE9D+CE9D/CE9D\CE9D;
                      ADC.B !_3                                 ;;CDA0|CE9E+CE9E/CE9E\CE9E;
                      STA.B !_3                                 ;;CDA2|CEA0+CEA0/CEA0\CEA0;
                      RTS                                       ;;CDA4|CEA2+CEA2/CEA2\CEA2; Return
                                                                ;;                        ;
                                                                ;;                        ;
DATA_05CEA3:          db $51,$B1,$00,$09,$FC,$38,$FC,$38        ;;CDA5|CEA3+CEA3/CEA3\CEA3;
                      db $FC,$38,$FC,$38,$00,$38,$51,$F3        ;;CDAD|CEAB+CEAB/CEAB\CEAB;
                      db $00,$03,$FC,$38,$FC,$38,$52,$13        ;;CDB5|CEB3+CEB3/CEB3\CEB3;
                      db $00,$03,$FC,$38,$FC,$38,$FF            ;;CDBD|CEBB+CEBB/CEBB\CEBB;
                                                                ;;                        ;
DATA_05CEC2:          db $0A,$00,$64,$00                        ;;CDC4|CEC2+CEC2/CEC2\CEC2;
                                                                ;;                        ;
DATA_05CEC6:          db $01,$00,$0A,$00                        ;;CDC8|CEC6+CEC6/CEC6\CEC6;
                                                                ;;                        ;
CODE_05CECA:          PHB                                       ;;CDCC|CECA+CECA/CECA\CECA;
                      PHK                                       ;;CDCD|CECB+CECB/CECB\CECB;
                      PLB                                       ;;CDCE|CECC+CECC/CECC\CECC;
                      REP #$20                                  ;;CDCF|CECD+CECD/CECD\CECD; Accum (16 bit)
                      LDX.B #$00                                ;;CDD1|CECF+CECF/CECF\CECF;
                      LDA.W !PlayerTurnLvl                      ;;CDD3|CED1+CED1/CED1\CED1;
                      AND.W #$00FF                              ;;CDD6|CED4+CED4/CED4\CED4;
                      BEQ +                                     ;;CDD9|CED7+CED7/CED7\CED7;
                      LDX.B #$03                                ;;CDDB|CED9+CED9/CED9\CED9;
                    + LDY.B #$02                                ;;CDDD|CEDB+CEDB/CEDB\CEDB;
                      LDA.W !ScoreIncrement                     ;;CDDF|CEDD+CEDD/CEDD\CEDD;
                      BEQ CODE_05CF05                           ;;CDE2|CEE0+CEE0/CEE0\CEE0;
                      CMP.W #$0063                              ;;CDE4|CEE2+CEE2/CEE2\CEE2;
                      BCS +                                     ;;CDE7|CEE5+CEE5/CEE5\CEE5;
                      LDY.B #$00                                ;;CDE9|CEE7+CEE7/CEE7\CEE7;
                    + SEC                                       ;;CDEB|CEE9+CEE9/CEE9\CEE9;
                      SBC.W DATA_05CEC2,Y                       ;;CDEC|CEEA+CEEA/CEEA\CEEA;
                      STA.W !ScoreIncrement                     ;;CDEF|CEED+CEED/CEED\CEED;
                      STA.B !_2                                 ;;CDF2|CEF0+CEF0/CEF0\CEF0;
                      LDA.W DATA_05CEC6,Y                       ;;CDF4|CEF2+CEF2/CEF2\CEF2;
                      CLC                                       ;;CDF7|CEF5+CEF5/CEF5\CEF5;
                      ADC.W !PlayerScore,X                      ;;CDF8|CEF6+CEF6/CEF6\CEF6;
                      STA.W !PlayerScore,X                      ;;CDFB|CEF9+CEF9/CEF9\CEF9;
                      LDA.W !PlayerScore+2,X                    ;;CDFE|CEFC+CEFC/CEFC\CEFC;
                      ADC.W #$0000                              ;;CE01|CEFF+CEFF/CEFF\CEFF;
                      STA.W !PlayerScore+2,X                    ;;CE04|CF02+CF02/CF02\CF02;
CODE_05CF05:          LDX.W !BonusStarsGained                   ;;CE07|CF05+CF05/CF05\CF05;
                      BEQ CODE_05CF36                           ;;CE0A|CF08+CF08/CF08\CF08;
                      SEP #$20                                  ;;CE0C|CF0A+CF0A/CF0A\CF0A; Accum (8 bit)
                      LDA.B !TrueFrame                          ;;CE0E|CF0C+CF0C/CF0C\CF0C;
                      AND.B #$03                                ;;CE10|CF0E+CF0E/CF0E\CF0E;
                      BNE +                                     ;;CE12|CF10+CF10/CF10\CF10;
                      LDX.W !PlayerTurnLvl                      ;;CE14|CF12+CF12/CF12\CF12;
                      LDA.W !PlayerBonusStars,X                 ;;CE17|CF15+CF15/CF15\CF15;
                      CLC                                       ;;CE1A|CF18+CF18/CF18\CF18;
                      ADC.B #$01                                ;;CE1B|CF19+CF19/CF19\CF19;
                      STA.W !PlayerBonusStars,X                 ;;CE1D|CF1B+CF1B/CF1B\CF1B;
                      LDA.W !BonusStarsGained                   ;;CE20|CF1E+CF1E/CF1E\CF1E;
                      DEC A                                     ;;CE23|CF21+CF21/CF21\CF21;
                      STA.W !BonusStarsGained                   ;;CE24|CF22+CF22/CF22\CF22;
                      AND.B #$0F                                ;;CE27|CF25+CF25/CF25\CF25;
                      CMP.B #$0F                                ;;CE29|CF27+CF27/CF27\CF27;
                      BNE +                                     ;;CE2B|CF29+CF29/CF29\CF29;
                      LDA.W !BonusStarsGained                   ;;CE2D|CF2B+CF2B/CF2B\CF2B;
                      SEC                                       ;;CE30|CF2E+CF2E/CF2E\CF2E;
                      SBC.B #$06                                ;;CE31|CF2F+CF2F/CF2F\CF2F;
                      STA.W !BonusStarsGained                   ;;CE33|CF31+CF31/CF31\CF31;
                    + REP #$20                                  ;;CE36|CF34+CF34/CF34\CF34; Accum (16 bit)
CODE_05CF36:          LDA.W !ScoreIncrement                     ;;CE38|CF36+CF36/CF36\CF36;
                      BNE +                                     ;;CE3B|CF39+CF39/CF39\CF39;
                      LDX.W !BonusStarsGained                   ;;CE3D|CF3B+CF3B/CF3B\CF3B;
                      BNE +                                     ;;CE40|CF3E+CF3E/CF3E\CF3E;
                      LDX.B #$30                                ;;CE42|CF40+CF40/CF40\CF40;
                      STX.W !DrumrollTimer                      ;;CE44|CF42+CF42/CF42\CF42;
                      INC.W !OverworldProcess                   ;;CE47|CF45+CF45/CF45\CF45;
                      LDX.B #!SFX_DRUMROLLEND                   ;;CE4A|CF48+CF48/CF48\CF48;
                      STX.W !SPCIO3                             ;;CE4C|CF4A+CF4A/CF4A\CF4A; / Play sound effect
                    + LDY.B #$1E                                ;;CE4F|CF4D+CF4D/CF4D\CF4D;
                      TYA                                       ;;CE51|CF4F+CF4F/CF4F\CF4F;
                      CLC                                       ;;CE52|CF50+CF50/CF50\CF50;
                      ADC.L !DynStripeImgSize                   ;;CE53|CF51+CF51/CF51\CF51;
                      TAX                                       ;;CE57|CF55+CF55/CF55\CF55;
                      INC A                                     ;;CE58|CF56+CF56/CF56\CF56;
                      STA.B !_A                                 ;;CE59|CF57+CF57/CF57\CF57;
                    - LDA.W DATA_05CEA3,Y                       ;;CE5B|CF59+CF59/CF59\CF59;
                      STA.L !DynamicStripeImage,X               ;;CE5E|CF5C+CF5C/CF5C\CF5C;
                      DEX                                       ;;CE62|CF60+CF60/CF60\CF60;
                      DEX                                       ;;CE63|CF61+CF61/CF61\CF61;
                      DEY                                       ;;CE64|CF62+CF62/CF62\CF62;
                      DEY                                       ;;CE65|CF63+CF63/CF63\CF63;
                      BPL -                                     ;;CE66|CF64+CF64/CF64\CF64;
                      LDA.W !ScoreIncrement                     ;;CE68|CF66+CF66/CF66\CF66;
                      BEQ CODE_05CFA0                           ;;CE6B|CF69+CF69/CF69\CF69;
                      STZ.B !_0                                 ;;CE6D|CF6B+CF6B/CF6B\CF6B;
                      LDA.L !DynStripeImgSize                   ;;CE6F|CF6D+CF6D/CF6D\CF6D;
                      CLC                                       ;;CE73|CF71+CF71/CF71\CF71;
                      ADC.W #$0006                              ;;CE74|CF72+CF72/CF72\CF72;
                      TAX                                       ;;CE77|CF75+CF75/CF75\CF75;
                      LDY.B #$00                                ;;CE78|CF76+CF76/CF76\CF76;
                      JSR CODE_05CDFD                           ;;CE7A|CF78+CF78/CF78\CF78;
                      LDA.L !DynStripeImgSize                   ;;CE7D|CF7B+CF7B/CF7B\CF7B;
                      CLC                                       ;;CE81|CF7F+CF7F/CF7F\CF7F;
                      ADC.W #$0008                              ;;CE82|CF80+CF80/CF80\CF80;
                      STA.B !_0                                 ;;CE85|CF83+CF83/CF83\CF83;
                      LDA.L !DynStripeImgSize                   ;;CE87|CF85+CF85/CF85\CF85;
                      TAX                                       ;;CE8B|CF89+CF89/CF89\CF89;
CODE_05CF8A:          LDA.L !DynamicStripeImage+4,X             ;;CE8C|CF8A+CF8A/CF8A\CF8A;
                      AND.W #$000F                              ;;CE90|CF8E+CF8E/CF8E\CF8E;
                      BNE CODE_05CFA0                           ;;CE93|CF91+CF91/CF91\CF91;
                      LDA.W #$38FC                              ;;CE95|CF93+CF93/CF93\CF93;
                      STA.L !DynamicStripeImage+4,X             ;;CE98|CF96+CF96/CF96\CF96;
                      INX                                       ;;CE9C|CF9A+CF9A/CF9A\CF9A;
                      INX                                       ;;CE9D|CF9B+CF9B/CF9B\CF9B;
                      CPX.B !_0                                 ;;CE9E|CF9C+CF9C/CF9C\CF9C;
                      BNE CODE_05CF8A                           ;;CEA0|CF9E+CF9E/CF9E\CF9E;
CODE_05CFA0:          SEP #$20                                  ;;CEA2|CFA0+CFA0/CFA0\CFA0; Accum (8 bit)
                      REP #$10                                  ;;CEA4|CFA2+CFA2/CFA2\CFA2; Index (16 bit)
                      LDA.W !DisplayBonusStars                  ;;CEA6|CFA4+CFA4/CFA4\CFA4;
                      BEQ +                                     ;;CEA9|CFA7+CFA7/CFA7\CFA7;
                      LDA.L !DynStripeImgSize                   ;;CEAB|CFA9+CFA9/CFA9\CFA9;
                      TAX                                       ;;CEAF|CFAD+CFAD/CFAD\CFAD;
                      LDA.W !BonusStarsGained                   ;;CEB0|CFAE+CFAE/CFAE\CFAE;
                      AND.B #$0F                                ;;CEB3|CFB1+CFB1/CFB1\CFB1;
                      ASL A                                     ;;CEB5|CFB3+CFB3/CFB3\CFB3;
                      TAY                                       ;;CEB6|CFB4+CFB4/CFB4\CFB4;
                      LDA.W DATA_05CD62,Y                       ;;CEB7|CFB5+CFB5/CFB5\CFB5;
                      STA.L !DynamicStripeImage+$14,X           ;;CEBA|CFB8+CFB8/CFB8\CFB8;
                      LDA.W DATA_05CD63,Y                       ;;CEBE|CFBC+CFBC/CFBC\CFBC;
                      STA.L !DynamicStripeImage+$1C,X           ;;CEC1|CFBF+CFBF/CFBF\CFBF;
                      LDA.W !BonusStarsGained                   ;;CEC5|CFC3+CFC3/CFC3\CFC3;
                      AND.B #$F0                                ;;CEC8|CFC6+CFC6/CFC6\CFC6;
                      LSR A                                     ;;CECA|CFC8+CFC8/CFC8\CFC8;
                      LSR A                                     ;;CECB|CFC9+CFC9/CFC9\CFC9;
                      LSR A                                     ;;CECC|CFCA+CFCA/CFCA\CFCA;
                      BEQ +                                     ;;CECD|CFCB+CFCB/CFCB\CFCB;
                      TAY                                       ;;CECF|CFCD+CFCD/CFCD\CFCD;
                      LDA.W DATA_05CD62,Y                       ;;CED0|CFCE+CFCE/CFCE\CFCE;
                      STA.L !DynamicStripeImage+$12,X           ;;CED3|CFD1+CFD1/CFD1\CFD1;
                      LDA.W DATA_05CD63,Y                       ;;CED7|CFD5+CFD5/CFD5\CFD5;
                      STA.L !DynamicStripeImage+$1A,X           ;;CEDA|CFD8+CFD8/CFD8\CFD8;
                    + REP #$20                                  ;;CEDE|CFDC+CFDC/CFDC\CFDC; Accum (16 bit)
                      SEP #$10                                  ;;CEE0|CFDE+CFDE/CFDE\CFDE; Index (8 bit)
                      LDA.B !_A                                 ;;CEE2|CFE0+CFE0/CFE0\CFE0;
                      STA.L !DynStripeImgSize                   ;;CEE4|CFE2+CFE2/CFE2\CFE2;
                      SEP #$30                                  ;;CEE8|CFE6+CFE6/CFE6\CFE6; Index (8 bit) Accum (8 bit)
                      PLB                                       ;;CEEA|CFE8+CFE8/CFE8\CFE8;
Return05CFE9:         RTS                                       ;;CEEB|CFE9+CFE9/CFE9\CFE9; Return
                                                                ;;                        ;
                      %insert_empty($114,$16,$16,$16,$16)       ;;CEEC|CFEA+CFEA/CFEA\CFEA;
                                                                ;;                        ;
OWL1CharData:         db $22,$01                                ;;D000|D000+D000/D000\D000;
                      db $22,$01,$22,$01,$22,$01,$D8,$01        ;;D002|D002+D002/D002\D002;
                      db $D9,$C1,$D9,$01,$D8,$C1,$22,$01        ;;D00A|D00A+D00A/D00A\D00A;
                      db $DF,$01,$22,$01,$DF,$01,$EE,$C1        ;;D012|D012+D012/D012\D012;
                      db $DE,$C1,$ED,$C1,$DD,$C1,$DA,$01        ;;D01A|D01A+D01A/D01A\D01A;
                      db $DA,$C1,$DA,$01,$DA,$C1,$DD,$01        ;;D022|D022+D022/D022\D022;
                      db $ED,$01,$DE,$01,$EE,$01,$DF,$01        ;;D02A|D02A+D02A/D02A\D02A;
                      db $22,$01,$DF,$01,$22,$01,$22,$01        ;;D032|D032+D032/D032\D032;
                      db $D8,$01,$22,$01,$D9,$01,$22,$01        ;;D03A|D03A+D03A/D03A\D03A;
                      db $EB,$01,$EB,$01,$EB,$C1,$EB,$C1        ;;D042|D042+D042/D042\D042;
                      db $22,$01,$22,$01,$22,$01,$22,$01        ;;D04A|D04A+D04A/D04A\D04A;
                      db $22,$01,$22,$01,$EB,$01,$EC,$C1        ;;D052|D052+D052/D052\D052;
                      db $DC,$C1,$DC,$01,$EC,$01,$DB,$01        ;;D05A|D05A+D05A/D05A\D05A;
                      db $DB,$01,$22,$01,$22,$01,$22,$01        ;;D062|D062+D062/D062\D062;
                      db $22,$01,$EC,$C1,$DC,$C1,$DC,$01        ;;D06A|D06A+D06A/D06A\D06A;
                      db $EC,$01,$22,$01,$22,$01,$D6,$01        ;;D072|D072+D072/D072\D072;
                      db $E6,$01,$D7,$01,$E7,$01,$EA,$01        ;;D07A|D07A+D07A/D07A\D07A;
                      db $EA,$01,$EA,$C1,$EA,$C1,$D9,$C1        ;;D082|D082+D082/D082\D082;
                      db $22,$01,$D8,$C1,$22,$01,$E7,$C1        ;;D08A|D08A+D08A/D08A\D08A;
                      db $D7,$C1,$E6,$C1,$D6,$C1,$22,$01        ;;D092|D092+D092/D092\D092;
                      db $22,$01,$DB,$01,$DB,$01,$D9,$41        ;;D09A|D09A+D09A/D09A\D09A;
                      db $D8,$81,$D8,$41,$D9,$81,$ED,$81        ;;D0A2|D0A2+D0A2/D0A2\D0A2;
                      db $DD,$81,$EE,$81,$DE,$81,$DE,$41        ;;D0AA|D0AA+D0AA/D0AA\D0AA;
                      db $EE,$41,$DD,$41,$ED,$41,$22,$01        ;;D0B2|D0B2+D0B2/D0B2\D0B2;
                      db $D9,$41,$22,$01,$D8,$41,$EB,$41        ;;D0BA|D0BA+D0BA/D0BA\D0BA;
                      db $EB,$81,$22,$01,$EB,$41,$22,$01        ;;D0C2|D0C2+D0C2/D0C2\D0C2;
                      db $22,$01,$EB,$81,$22,$01,$22,$01        ;;D0CA|D0CA+D0CA/D0CA\D0CA;
                      db $EB,$41,$22,$01,$22,$01,$DC,$41        ;;D0D2|D0D2+D0D2/D0D2\D0D2;
                      db $EC,$41,$EC,$81,$DC,$81,$EC,$81        ;;D0DA|D0DA+D0DA/D0DA\D0DA;
                      db $DC,$81,$22,$01,$22,$01,$22,$01        ;;D0E2|D0E2+D0E2/D0E2\D0E2;
                      db $22,$01,$DC,$41,$EC,$41,$D7,$41        ;;D0EA|D0EA+D0EA/D0EA\D0EA;
                      db $E7,$41,$D6,$41,$E6,$41,$D8,$81        ;;D0F2|D0F2+D0F2/D0F2\D0F2;
                      db $22,$01,$D9,$81,$22,$01,$E6,$81        ;;D0FA|D0FA+D0FA/D0FA\D0FA;
                      db $D6,$81,$E7,$81,$D7,$81,$EB,$81        ;;D102|D102+D102/D102\D102;
                      db $22,$01,$EB,$41,$EB,$81,$EB,$01        ;;D10A|D10A+D10A/D10A\D10A;
                      db $EB,$C1,$EB,$C1,$22,$01,$A8,$11        ;;D112|D112+D112/D112\D112;
                      db $B8,$11,$A9,$11,$B9,$11,$A6,$11        ;;D11A|D11A+D11A/D11A\D11A;
                      db $B6,$11,$A7,$11,$B7,$11,$A6,$11        ;;D122|D122+D122/D122\D122;
                      db $B6,$11,$A7,$11,$B7,$11,$20,$68        ;;D12A|D12A+D12A/D12A\D12A;
                      db $20,$68,$20,$28,$20,$28,$20,$28        ;;D132|D132+D132/D132\D132;
                      db $20,$28,$22,$09,$22,$09,$22,$01        ;;D13A|D13A+D13A/D13A\D13A;
                      db $22,$01,$EC,$C1,$DC,$C1,$DC,$01        ;;D142|D142+D142/D142\D142;
                      db $EC,$01,$22,$01,$22,$01,$EA,$01        ;;D14A|D14A+D14A/D14A\D14A;
                      db $EA,$01,$EA,$C1,$EA,$C1,$EE,$C1        ;;D152|D152+D152/D152\D152;
                      db $DE,$C1,$ED,$C1,$DD,$C1,$DD,$01        ;;D15A|D15A+D15A/D15A\D15A;
                      db $ED,$01,$DE,$01,$EE,$01,$EB,$C1        ;;D162|D162+D162/D162\D162;
                      db $22,$01,$22,$01,$22,$01,$22,$01        ;;D16A|D16A+D16A/D16A\D16A;
                      db $22,$01,$22,$01,$EB,$01,$EC,$C1        ;;D172|D172+D172/D172\D172;
                      db $DC,$C1,$DC,$01,$EC,$01,$DB,$01        ;;D17A|D17A+D17A/D17A\D17A;
                      db $DB,$01,$22,$01,$22,$01,$D6,$01        ;;D182|D182+D182/D182\D182;
                      db $E6,$01,$D7,$01,$E7,$01,$ED,$81        ;;D18A|D18A+D18A/D18A\D18A;
                      db $DD,$81,$EE,$81,$DE,$81,$DF,$01        ;;D192|D192+D192/D192\D192;
                      db $22,$01,$DF,$01,$22,$01,$D7,$41        ;;D19A|D19A+D19A/D19A\D19A;
                      db $E7,$41,$D6,$41,$E6,$41,$22,$01        ;;D1A2|D1A2+D1A2/D1A2\D1A2;
                      db $EB,$41,$22,$01,$22,$01,$EC,$81        ;;D1AA|D1AA+D1AA/D1AA\D1AA;
                      db $DC,$81,$22,$01,$22,$01,$22,$01        ;;D1B2|D1B2+D1B2/D1B2\D1B2;
                      db $22,$01,$EB,$81,$22,$01,$D9,$41        ;;D1BA|D1BA+D1BA/D1BA\D1BA;
                      db $D8,$81,$D8,$41,$D9,$81,$EB,$C1        ;;D1C2|D1C2+D1C2/D1C2\D1C2;
                      db $EB,$C1,$EB,$C1,$22,$01,$22,$01        ;;D1CA|D1CA+D1CA/D1CA\D1CA;
                      db $22,$01,$DB,$01,$DB,$01,$E7,$C1        ;;D1D2|D1D2+D1D2/D1D2\D1D2;
                      db $D7,$C1,$E6,$C1,$D6,$C1,$22,$01        ;;D1DA|D1DA+D1DA/D1DA\D1DA;
                      db $DF,$01,$22,$01,$DF,$01,$E6,$81        ;;D1E2|D1E2+D1E2/D1E2\D1E2;
                      db $D6,$81,$E7,$81,$D7,$81,$D8,$01        ;;D1EA|D1EA+D1EA/D1EA\D1EA;
                      db $D9,$C1,$D9,$01,$D8,$C1,$EA,$01        ;;D1F2|D1F2+D1F2/D1F2\D1F2;
                      db $EA,$01,$EA,$C1,$EA,$C1,$EA,$01        ;;D1FA|D1FA+D1FA/D1FA\D1FA;
                      db $EA,$01,$EA,$C1,$EA,$C1,$D6,$01        ;;D202|D202+D202/D202\D202;
                      db $E6,$01,$D7,$01,$E7,$01,$DA,$01        ;;D20A|D20A+D20A/D20A\D20A;
                      db $DA,$C1,$DA,$01,$DA,$C1,$A4,$11        ;;D212|D212+D212/D212\D212;
                      db $B4,$11,$A5,$11,$B5,$11,$22,$11        ;;D21A|D21A+D21A/D21A\D21A;
                      db $90,$11,$22,$11,$91,$11,$C2,$11        ;;D222|D222+D222/D222\D222;
                      db $D2,$11,$C3,$11,$D3,$11,$23,$38        ;;D22A|D22A+D22A/D22A\D22A;
                      db $71,$38,$23,$38,$71,$38,$23,$28        ;;D232|D232+D232/D232\D232;
                      db $71,$28,$23,$28,$71,$28,$23,$30        ;;D23A|D23A+D23A/D23A\D23A;
                      db $71,$30,$23,$30,$71,$30,$22,$01        ;;D242|D242+D242/D242\D242;
                      db $22,$01,$22,$01,$EB,$01,$22,$01        ;;D24A|D24A+D24A/D24A\D24A;
                      db $EB,$41,$22,$01,$22,$01,$22,$01        ;;D252|D252+D252/D252\D252;
                      db $22,$01,$EB,$81,$22,$01,$22,$15        ;;D25A|D25A+D25A/D25A\D25A;
                      db $AC,$15,$22,$15,$AD,$15,$EA,$01        ;;D262|D262+D262/D262\D262;
                      db $EA,$01,$EA,$C1,$EA,$C1,$DA,$01        ;;D26A|D26A+D26A/D26A\D26A;
                      db $DA,$C1,$DA,$01,$DA,$C1,$DA,$01        ;;D272|D272+D272/D272\D272;
                      db $DA,$C1,$DA,$01,$DA,$C1,$E7,$C1        ;;D27A|D27A+D27A/D27A\D27A;
                      db $D7,$C1,$E6,$C1,$D6,$C1,$EB,$C1        ;;D282|D282+D282/D282\D282;
                      db $22,$01,$22,$01,$22,$01,$22,$01        ;;D28A|D28A+D28A/D28A\D28A;
                      db $22,$01,$22,$01,$22,$01,$22,$01        ;;D292|D292+D292/D292\D292;
                      db $22,$01,$22,$01,$22,$01,$22,$01        ;;D29A|D29A+D29A/D29A\D29A;
                      db $22,$01,$22,$01,$22,$01,$C9,$05        ;;D2A2|D2A2+D2A2/D2A2\D2A2;
                      db $C8,$05,$C9,$05,$C8,$05,$84,$11        ;;D2AA|D2AA+D2AA/D2AA\D2AA;
                      db $94,$11,$85,$11,$95,$11,$22,$01        ;;D2B2|D2B2+D2B2/D2B2\D2B2;
                      db $22,$01,$22,$01,$22,$01,$88,$15        ;;D2BA|D2BA+D2BA/D2BA\D2BA;
                      db $98,$15,$89,$15,$99,$15,$22,$01        ;;D2C2|D2C2+D2C2/D2C2\D2C2;
                      db $22,$01,$22,$01,$22,$01,$22,$01        ;;D2CA|D2CA+D2CA/D2CA\D2CA;
                      db $22,$01,$22,$01,$22,$01,$8C,$15        ;;D2D2|D2D2+D2D2/D2D2\D2D2;
                      db $9C,$15,$8D,$15,$9D,$15,$9E,$10        ;;D2DA|D2DA+D2DA/D2DA\D2DA;
                      db $64,$10,$9F,$10,$65,$10,$BC,$15        ;;D2E2|D2E2+D2E2/D2E2\D2E2;
                      db $AE,$15,$BD,$15,$AF,$15,$82,$19        ;;D2EA|D2EA+D2EA/D2EA\D2EA;
                      db $92,$19,$83,$19,$93,$19,$C8,$19        ;;D2F2|D2F2+D2F2/D2F2\D2F2;
                      db $F8,$19,$C9,$19,$F9,$19,$AA,$11        ;;D2FA|D2FA+D2FA/D2FA\D2FA;
                      db $BA,$11,$AA,$51,$BA,$51,$56,$19        ;;D302|D302+D302/D302\D302;
                      db $EA,$09,$56,$59,$EA,$C9,$A0,$11        ;;D30A|D30A+D30A/D30A\D30A;
                      db $B0,$11,$A1,$11,$B1,$11,$A2,$11        ;;D312|D312+D312/D312\D312;
                      db $B2,$11,$A3,$11,$B3,$11,$CC,$15        ;;D31A|D31A+D31A/D31A\D31A;
                      db $CE,$15,$CD,$15,$CF,$15,$22,$01        ;;D322|D322+D322/D322\D322;
                      db $22,$01,$22,$01,$22,$01,$86,$99        ;;D32A|D32A+D32A/D32A\D32A;
                      db $86,$19,$86,$D9,$86,$59,$96,$99        ;;D332|D332+D332/D332\D332;
                      db $96,$19,$96,$D9,$96,$59,$86,$9D        ;;D33A|D33A+D33A/D33A\D33A;
                      db $86,$1D,$86,$DD,$86,$5D,$96,$9D        ;;D342|D342+D342/D342\D342;
                      db $96,$1D,$96,$DD,$96,$5D,$86,$99        ;;D34A|D34A+D34A/D34A\D34A;
                      db $86,$19,$86,$D9,$86,$59,$96,$99        ;;D352|D352+D352/D352\D352;
                      db $96,$19,$96,$D9,$96,$59,$86,$9D        ;;D35A|D35A+D35A/D35A\D35A;
                      db $86,$1D,$86,$DD,$86,$5D,$96,$9D        ;;D362|D362+D362/D362\D362;
                      db $96,$1D,$96,$DD,$96,$5D,$22,$01        ;;D36A|D36A+D36A/D36A\D36A;
                      db $22,$01,$22,$01,$22,$01,$22,$01        ;;D372|D372+D372/D372\D372;
                      db $22,$01,$22,$01,$22,$01,$22,$01        ;;D37A|D37A+D37A/D37A\D37A;
                      db $22,$01,$22,$01,$22,$01,$22,$01        ;;D382|D382+D382/D382\D382;
                      db $22,$01,$22,$01,$22,$01,$22,$01        ;;D38A|D38A+D38A/D38A\D38A;
                      db $22,$01,$22,$01,$22,$01,$22,$01        ;;D392|D392+D392/D392\D392;
                      db $22,$01,$22,$01,$22,$01,$22,$01        ;;D39A|D39A+D39A/D39A\D39A;
                      db $22,$01,$22,$01,$22,$01,$22,$01        ;;D3A2|D3A2+D3A2/D3A2\D3A2;
                      db $22,$01,$22,$01,$22,$01,$22,$01        ;;D3AA|D3AA+D3AA/D3AA\D3AA;
                      db $22,$01,$22,$01,$22,$01,$80,$1C        ;;D3B2|D3B2+D3B2/D3B2\D3B2;
                      db $90,$1C,$81,$1C,$90,$5C,$22,$01        ;;D3BA|D3BA+D3BA/D3BA\D3BA;
                      db $22,$01,$22,$01,$22,$01,$80,$14        ;;D3C2|D3C2+D3C2/D3C2\D3C2;
                      db $90,$14,$81,$14,$90,$54,$22,$01        ;;D3CA|D3CA+D3CA/D3CA\D3CA;
                      db $22,$01,$22,$01,$22,$01,$22,$01        ;;D3D2|D3D2+D3D2/D3D2\D3D2;
                      db $22,$01,$22,$01,$22,$01,$82,$1D        ;;D3DA|D3DA+D3DA/D3DA\D3DA;
                      db $92,$1D,$83,$1D,$93,$1D,$22,$01        ;;D3E2|D3E2+D3E2/D3E2\D3E2;
                      db $22,$01,$22,$01,$22,$01,$86,$99        ;;D3EA|D3EA+D3EA/D3EA\D3EA;
                      db $86,$19,$86,$D9,$86,$59,$22,$01        ;;D3F2|D3F2+D3F2/D3F2\D3F2;
                      db $22,$01,$22,$01,$22,$01,$86,$99        ;;D3FA|D3FA+D3FA/D3FA\D3FA;
                      db $86,$19,$86,$D9,$86,$59,$8A,$15        ;;D402|D402+D402/D402\D402;
                      db $9A,$15,$8B,$15,$9B,$15,$8C,$15        ;;D40A|D40A+D40A/D40A\D40A;
                      db $9C,$15,$8D,$15,$9D,$15,$C0,$11        ;;D412|D412+D412/D412\D412;
                      db $D0,$11,$C1,$11,$D1,$11,$22,$11        ;;D41A|D41A+D41A/D41A\D41A;
                      db $22,$11,$22,$11,$22,$11,$22,$1D        ;;D422|D422+D422/D422\D422;
                      db $82,$1C,$22,$1D,$83,$1C,$22,$1D        ;;D42A|D42A+D42A/D42A\D42A;
                      db $82,$14,$22,$1D,$83,$14,$80,$19        ;;D432|D432+D432/D432\D432;
                      db $90,$19,$81,$19,$91,$19,$8E,$19        ;;D43A|D43A+D43A/D43A\D43A;
                      db $9E,$19,$8F,$19,$9F,$19,$A0,$19        ;;D442|D442+D442/D442\D442;
                      db $B0,$19,$A1,$19,$B1,$19,$A4,$19        ;;D44A|D44A+D44A/D44A\D44A;
                      db $B4,$19,$A5,$19,$B5,$19,$A8,$19        ;;D452|D452+D452/D452\D452;
                      db $B8,$19,$A9,$19,$B9,$19,$BE,$19        ;;D45A|D45A+D45A/D45A\D45A;
                      db $CE,$19,$BF,$19,$CF,$19,$C4,$19        ;;D462|D462+D462/D462\D462;
                      db $D4,$19,$C5,$19,$D5,$19,$22,$09        ;;D46A|D46A+D46A/D46A\D46A;
                      db $C6,$0D,$22,$09,$C7,$0D,$22,$09        ;;D472|D472+D472/D472\D472;
                      db $FC,$0D,$FE,$0D,$FD,$0D,$CC,$0D        ;;D47A|D47A+D47A/D47A\D47A;
                      db $E4,$0D,$CD,$0D,$E5,$0D,$E0,$0D        ;;D482|D482+D482/D482\D482;
                      db $F0,$0D,$E1,$0D,$F1,$0D,$F4,$0D        ;;D48A|D48A+D48A/D48A\D48A;
                      db $22,$09,$F5,$0D,$22,$09,$E8,$0D        ;;D492|D492+D492/D492\D492;
                      db $22,$09,$22,$09,$22,$09,$00,$00        ;;D49A|D49A+D49A/D49A\D49A;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;D4A2|D4A2+D4A2/D4A2\D4A2;
                      db $00,$00,$00,$00,$00,$00,$75,$3C        ;;D4AA|D4AA+D4AA/D4AA\D4AA;
                      db $75,$3C,$75,$3C,$75,$3C,$22,$09        ;;D4B2|D4B2+D4B2/D4B2\D4B2;
                      db $79,$14,$22,$09,$9D,$14,$22,$09        ;;D4BA|D4BA+D4BA/D4BA\D4BA;
                      db $78,$54,$22,$09,$22,$09,$22,$09        ;;D4C2|D4C2+D4C2/D4C2\D4C2;
                      db $22,$09,$22,$09,$79,$14,$22,$09        ;;D4CA|D4CA+D4CA/D4CA\D4CA;
                      db $9D,$14,$78,$14,$9D,$14,$9D,$14        ;;D4D2|D4D2+D4D2/D4D2\D4D2;
                      db $78,$54,$79,$54,$22,$09,$79,$14        ;;D4DA|D4DA+D4DA/D4DA\D4DA;
                      db $22,$09,$22,$09,$22,$09,$22,$09        ;;D4E2|D4E2+D4E2/D4E2\D4E2;
                      db $22,$09,$78,$54,$22,$09,$22,$09        ;;D4EA|D4EA+D4EA/D4EA\D4EA;
                      db $22,$09,$78,$14,$22,$09,$9D,$14        ;;D4F2|D4F2+D4F2/D4F2\D4F2;
                      db $22,$09,$79,$54,$22,$09,$22,$09        ;;D4FA|D4FA+D4FA/D4FA\D4FA;
                      db $9D,$14,$22,$09,$78,$54,$22,$09        ;;D502|D502+D502/D502\D502;
                      db $78,$14,$22,$09,$22,$09,$22,$09        ;;D50A|D50A+D50A/D50A\D50A;
                      db $22,$09,$22,$09,$79,$54,$78,$14        ;;D512|D512+D512/D512\D512;
                      db $9D,$14,$9D,$14,$9D,$14,$56,$10        ;;D51A|D51A+D51A/D51A\D51A;
                      db $9E,$10,$57,$10,$9F,$10,$9E,$10        ;;D522|D522+D522/D522\D522;
                      db $9E,$10,$9F,$10,$9F,$10,$22,$15        ;;D52A|D52A+D52A/D52A\D52A;
                      db $AC,$15,$22,$15,$AD,$15,$22,$09        ;;D532|D532+D532/D532\D532;
                      db $22,$09,$22,$09,$48,$19,$22,$09        ;;D53A|D53A+D53A/D53A\D53A;
                      db $39,$19,$22,$09,$22,$09,$22,$09        ;;D542|D542+D542/D542\D542;
                      db $22,$09,$37,$15,$47,$15,$38,$15        ;;D54A|D54A+D54A/D54A\D54A;
                      db $48,$19,$58,$19,$49,$19,$49,$59        ;;D552|D552+D552/D552\D552;
                      db $59,$59,$48,$59,$58,$59,$37,$55        ;;D55A|D55A+D55A/D55A\D55A;
                      db $47,$55,$22,$09,$22,$09,$22,$09        ;;D562|D562+D562/D562\D562;
                      db $22,$09,$57,$15,$5A,$1D,$58,$19        ;;D56A|D56A+D56A/D56A\D56A;
                      db $5B,$19,$59,$19,$59,$19,$60,$19        ;;D572|D572+D572/D572\D572;
                      db $70,$19,$60,$59,$70,$59,$3A,$19        ;;D57A|D57A+D57A/D57A\D57A;
                      db $4A,$19,$3B,$19,$4B,$11,$48,$19        ;;D582|D582+D582/D582\D582;
                      db $58,$19,$48,$59,$58,$59,$22,$09        ;;D58A|D58A+D58A/D58A\D58A;
                      db $22,$09,$7A,$1D,$22,$09,$7B,$1D        ;;D592|D592+D592/D592\D592;
                      db $22,$09,$7B,$1D,$22,$09,$7B,$1D        ;;D59A|D59A+D59A/D59A\D59A;
                      db $22,$09,$7A,$5D,$22,$09,$CA,$19        ;;D5A2|D5A2+D5A2/D5A2\D5A2;
                      db $FA,$19,$CB,$19,$FB,$19,$7E,$18        ;;D5AA|D5AA+D5AA/D5AA\D5AA;
                      db $22,$09,$22,$09,$22,$09,$7F,$10        ;;D5B2|D5B2+D5B2/D5B2\D5B2;
                      db $22,$09,$22,$09,$22,$09,$7F,$10        ;;D5BA|D5BA+D5BA/D5BA\D5BA;
                      db $22,$09,$22,$09,$7E,$18,$7E,$18        ;;D5C2|D5C2+D5C2/D5C2\D5C2;
                      db $22,$09,$22,$09,$7F,$10,$22,$09        ;;D5CA|D5CA+D5CA/D5CA\D5CA;
                      db $22,$09,$22,$09,$7E,$18,$22,$09        ;;D5D2|D5D2+D5D2/D5D2\D5D2;
                      db $22,$09,$22,$09,$7F,$10,$3F,$10        ;;D5DA|D5DA+D5DA/D5DA\D5DA;
                      db $3F,$10,$3F,$10,$3F,$10,$6F,$51        ;;D5E2|D5E2+D5E2/D5E2\D5E2;
                      db $7F,$51,$6E,$51,$7E,$51,$F3,$51        ;;D5EA|D5EA+D5EA/D5EA\D5EA;
                      db $FF,$51,$87,$51,$97,$51,$08,$00        ;;D5F2|D5F2+D5F2/D5F2\D5F2;
                      db $09,$00,$0A,$00,$0B,$00,$00,$00        ;;D5FA|D5FA+D5FA/D5FA\D5FA;
                      db $00,$00,$00,$00,$00,$00                ;;D602|D602+D602/D602\D602;
                                                                ;;                        ;
DATA_05D608:          db $FF,$1F,$20,$FF,$0B,$0D,$0E,$0F        ;;D608|D608+D608/D608\D608;
                      db $28,$09,$10,$21,$22,$23,$24,$25        ;;D610|D610+D610/D610\D610;
                      db $27,$60,$FF,$12,$02,$07,$FF,$FF        ;;D618|D618+D618/D618\D618;
                      db $4E,$FF,$4D,$4A,$4C,$4B,$36,$35        ;;D620|D620+D620/D620\D620;
                      db $61,$63,$62,$48,$46,$06,$05,$04        ;;D628|D628+D628/D628\D628;
                      db $00,$01,$03,$19,$FF,$1D,$1A,$14        ;;D630|D630+D630/D630\D630;
                      db $44,$45,$42,$3E,$40,$41,$43,$3D        ;;D638|D638+D638/D638\D638;
                      db $3B,$39,$38,$4F,$17,$1B,$15,$29        ;;D640|D640+D640/D640\D640;
                      db $1C,$30,$2A,$32,$2C,$37,$34,$2E        ;;D648|D648+D648/D648\D648;
                      db $6D,$6C,$6B,$6A,$69,$64,$65,$66        ;;D650|D650+D650/D650\D650;
                      db $67,$68,$56,$53,$54,$5F,$57,$59        ;;D658|D658+D658/D658\D658;
                      db $51,$5A,$5D,$50,$5C                    ;;D660|D660+D660/D660\D660;
                                                                ;;                        ;
                      %insert_empty($A3,$A3,$A3,$A3,$A3)        ;;D665|D665+D665/D665\D665;
                                                                ;;                        ;
DATA_05D708:          db $00,$60,$C0,$00                        ;;D708|D708+D708/D708\D708;
                                                                ;;                        ;
DATA_05D70C:          db $60,$90,$C0,$00                        ;;D70C|D70C+D70C/D70C\D70C;
                                                                ;;                        ;
DATA_05D710:          db $03,$01,$01,$00,$00,$02,$02,$01        ;;D710|D710+D710/D710\D710;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;D718|D718+D718/D718\D718;
DATA_05D720:          db $02,$02,$01,$00,$01,$02,$01,$00        ;;D720|D720+D720/D720\D720;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;D728|D728+D728/D728\D728;
DATA_05D730:          db $00,$30,$60,$80,$A0,$B0,$C0,$E0        ;;D730|D730+D730/D730\D730;
                      db $10,$30,$50,$60,$70,$90,$00,$00        ;;D738|D738+D738/D738\D738;
DATA_05D740:          db $00,$00,$00,$00,$00,$00,$00,$00        ;;D740|D740+D740/D740\D740;
                      db $01,$01,$01,$01,$01,$01,$01,$01        ;;D748|D748+D748/D748\D748;
DATA_05D750:          db $10,$80,$00,$E0,$10,$70,$00,$E0        ;;D750|D750+D750/D750\D750;
DATA_05D758:          db $00,$00,$00,$00,$01,$01,$01,$01        ;;D758|D758+D758/D758\D758;
DATA_05D760:          db $05,$01,$02,$06,$08,$01                ;;D760|D760+D760/D760\D760;
                                                                ;;                        ;
PtrsLong05D766:       dl GhostHouseEntrance                     ;;D766|D766+D766/D766\D766;
                      dl CastleEntrance1                        ;;D769|D769+D769/D769\D769;
                      dl NoYoshiEntrance1                       ;;D76C|D76C+D76C/D76C\D76C;
                      dl NoYoshiEntrance2                       ;;D76F|D76F+D76F/D76F\D76F;
                      dl NoYoshiEntrance3                       ;;D772|D772+D772/D772\D772;
                      dl CastleEntrance2                        ;;D775|D775+D775/D775\D775;
                                                                ;;                        ;
PtrsLong05D778:       dl EmptyLevel                             ;;D778|D778+D778/D778\D778;
                      dw DATA_0CD900 : db $FF                   ;;D77B|D77B+D77B/D77B\D77B;
                      dw DATA_0CD900 : db $FF                   ;;D77E|D77E+D77E/D77E\D77E;
                      dw DATA_0CE684 : db $FF                   ;;D781|D781+D781/D781\D781;
                      dw DATA_0CDF59 : db $FF                   ;;D784|D784+D784/D784\D784;
                      dw DATA_0CE8EE : db $FF                   ;;D787|D787+D787/D787\D787;
                                                                ;;                        ;
DATA_05D78A:          db $03,$00,$00,$00,$00,$00                ;;D78A|D78A+D78A/D78A\D78A;
                                                                ;;                        ;
DATA_05D790:          db $70,$70,$60,$70,$70,$70                ;;D790|D790+D790/D790\D790;
                                                                ;;                        ;
CODE_05D796:          PHB                                       ;;D796|D796+D796/D796\D796;
                      PHK                                       ;;D797|D797+D797/D797\D797;
                      PLB                                       ;;D798|D798+D798/D798\D798;
                      SEP #$30                                  ;;D799|D799+D799/D799\D799; Index (8 bit) Accum (8 bit)
                      STZ.W !SkipMidwayCastleIntro              ;;D79B|D79B+D79B/D79B\D79B;
                      LDA.W !YoshiHeavenFlag                    ;;D79E|D79E+D79E/D79E\D79E;
                      BNE CODE_05D7A8                           ;;D7A1|D7A1+D7A1/D7A1\D7A1;
                      LDY.W !BonusGameActivate                  ;;D7A3|D7A3+D7A3/D7A3\D7A3;
                      BEQ +                                     ;;D7A6|D7A6+D7A6/D7A6\D7A6;
CODE_05D7A8:          JSR CODE_05DBAC                           ;;D7A8|D7A8+D7A8/D7A8\D7A8;
                    + LDA.W !SublevelCount                      ;;D7AB|D7AB+D7AB/D7AB\D7AB;
                      BNE +                                     ;;D7AE|D7AE+D7AE/D7AE\D7AE;
                      JMP CODE_05D83E                           ;;D7B0|D7B0+D7B0/D7B0\D7B0;
                                                                ;;                        ;
                    + LDX.B !PlayerXPosNext+1                   ;;D7B3|D7B3+D7B3/D7B3\D7B3;
                      LDA.B !ScreenMode                         ;;D7B5|D7B5+D7B5/D7B5\D7B5;
                      AND.B #$01                                ;;D7B7|D7B7+D7B7/D7B7\D7B7;
                      BEQ +                                     ;;D7B9|D7B9+D7B9/D7B9\D7B9;
                      LDX.B !PlayerYPosNext+1                   ;;D7BB|D7BB+D7BB/D7BB\D7BB;
                    + LDA.W !ExitTableLow,X                     ;;D7BD|D7BD+D7BD/D7BD\D7BD;
                      STA.W !LoadingLevelNumber                 ;;D7C0|D7C0+D7C0/D7C0\D7C0;
                      STA.B !_E                                 ;;D7C3|D7C3+D7C3/D7C3\D7C3;
                      LDA.W !PlayerTurnOW                       ;;D7C5|D7C5+D7C5/D7C5\D7C5;
                      LSR A                                     ;;D7C8|D7C8+D7C8/D7C8\D7C8;
                      LSR A                                     ;;D7C9|D7C9+D7C9/D7C9\D7C9;
                      TAY                                       ;;D7CA|D7CA+D7CA/D7CA\D7CA;
                      LDA.W !OWPlayerSubmap,Y                   ;;D7CB|D7CB+D7CB/D7CB\D7CB;
                      BEQ +                                     ;;D7CE|D7CE+D7CE/D7CE\D7CE;
                      LDA.B #$01                                ;;D7D0|D7D0+D7D0/D7D0\D7D0;
                    + STA.B !_F                                 ;;D7D2|D7D2+D7D2/D7D2\D7D2;
                      LDA.W !UseSecondaryExit                   ;;D7D4|D7D4+D7D4/D7D4\D7D4;
                      BEQ +                                     ;;D7D7|D7D7+D7D7/D7D7\D7D7;
                      REP #$30                                  ;;D7D9|D7D9+D7D9/D7D9\D7D9; Index (16 bit) Accum (16 bit)
                      LDA.W #$0000                              ;;D7DB|D7DB+D7DB/D7DB\D7DB;
                      SEP #$20                                  ;;D7DE|D7DE+D7DE/D7DE\D7DE; Accum (8 bit)
                      LDY.B !_E                                 ;;D7E0|D7E0+D7E0/D7E0\D7E0;
                      LDA.W DATA_05F800,Y                       ;;D7E2|D7E2+D7E2/D7E2\D7E2;
                      STA.B !_E                                 ;;D7E5|D7E5+D7E5/D7E5\D7E5;
                      STA.W !LoadingLevelNumber                 ;;D7E7|D7E7+D7E7/D7E7\D7E7;
                      LDA.W DATA_05FA00,Y                       ;;D7EA|D7EA+D7EA/D7EA\D7EA;
                      STA.B !_0                                 ;;D7ED|D7ED+D7ED/D7ED\D7ED;
                      AND.B #$0F                                ;;D7EF|D7EF+D7EF/D7EF\D7EF;
                      TAX                                       ;;D7F1|D7F1+D7F1/D7F1\D7F1;
                      LDA.L DATA_05D730,X                       ;;D7F2|D7F2+D7F2/D7F2\D7F2;
                      STA.B !PlayerYPosNext                     ;;D7F6|D7F6+D7F6/D7F6\D7F6;
                      LDA.L DATA_05D740,X                       ;;D7F8|D7F8+D7F8/D7F8\D7F8;
                      STA.B !PlayerYPosNext+1                   ;;D7FC|D7FC+D7FC/D7FC\D7FC;
                      LDA.B !_0                                 ;;D7FE|D7FE+D7FE/D7FE\D7FE;
                      AND.B #$30                                ;;D800|D800+D800/D800\D800;
                      LSR A                                     ;;D802|D802+D802/D802\D802;
                      LSR A                                     ;;D803|D803+D803/D803\D803;
                      LSR A                                     ;;D804|D804+D804/D804\D804;
                      LSR A                                     ;;D805|D805+D805/D805\D805;
                      TAX                                       ;;D806|D806+D806/D806\D806;
                      LDA.L DATA_05D708,X                       ;;D807|D807+D807/D807\D807;
                      STA.B !Layer1YPos                         ;;D80B|D80B+D80B/D80B\D80B;
                      LDA.B !_0                                 ;;D80D|D80D+D80D/D80D\D80D;
                      LSR A                                     ;;D80F|D80F+D80F/D80F\D80F;
                      LSR A                                     ;;D810|D810+D810/D810\D810;
                      LSR A                                     ;;D811|D811+D811/D811\D811;
                      LSR A                                     ;;D812|D812+D812/D812\D812;
                      LSR A                                     ;;D813|D813+D813/D813\D813;
                      LSR A                                     ;;D814|D814+D814/D814\D814;
                      TAX                                       ;;D815|D815+D815/D815\D815;
                      LDA.L DATA_05D70C,X                       ;;D816|D816+D816/D816\D816;
                      STA.B !Layer2YPos                         ;;D81A|D81A+D81A/D81A\D81A;
                      LDA.W DATA_05FC00,Y                       ;;D81C|D81C+D81C/D81C\D81C;
                      STA.B !_1                                 ;;D81F|D81F+D81F/D81F\D81F;
                      LSR A                                     ;;D821|D821+D821/D821\D821;
                      LSR A                                     ;;D822|D822+D822/D822\D822;
                      LSR A                                     ;;D823|D823+D823/D823\D823;
                      LSR A                                     ;;D824|D824+D824/D824\D824;
                      LSR A                                     ;;D825|D825+D825/D825\D825;
                      TAX                                       ;;D826|D826+D826/D826\D826;
                      LDA.L DATA_05D750,X                       ;;D827|D827+D827/D827\D827;
                      STA.B !PlayerXPosNext                     ;;D82B|D82B+D82B/D82B\D82B;
                      LDA.L DATA_05D758,X                       ;;D82D|D82D+D82D/D82D\D82D;
                      STA.B !PlayerXPosNext+1                   ;;D831|D831+D831/D831\D831;
                      LDA.W DATA_05FE00,Y                       ;;D833|D833+D833/D833\D833;
                      AND.B #$07                                ;;D836|D836+D836/D836\D836;
                      STA.W !LevelEntranceType                  ;;D838|D838+D838/D838\D838;
                    + JMP CODE_05D8B7                           ;;D83B|D83B+D83B/D83B\D83B;
                                                                ;;                        ;
CODE_05D83E:          STZ.B !_F                                 ;;D83E|D83E+D83E/D83E\D83E; Index (8 bit)
                      LDY.B #$00                                ;;D840|D840+D840/D840\D840;
                      LDA.W !OverworldOverride                  ;;D842|D842+D842/D842\D842;
                      BNE CODE_05D8A2                           ;;D845|D845+D845/D845\D845;
                      REP #$30                                  ;;D847|D847+D847/D847\D847; 16 bit A,X,Y ; Index (16 bit) Accum (16 bit)
                      STZ.B !Layer1XPos                         ;;D849|D849+D849/D849\D849; Set "X position of screen boundary" to 0
                      STZ.B !Layer2XPos                         ;;D84B|D84B+D84B/D84B\D84B; Set "Layer 2 X position" to 0
                      LDX.W !PlayerTurnOW                       ;;D84D|D84D+D84D/D84D\D84D;
                      LDA.W !OWPlayerXPosPtr,X                  ;;D850|D850+D850/D850\D850;
                      AND.W #$000F                              ;;D853|D853+D853/D853\D853;
                      STA.B !_0                                 ;;D856|D856+D856/D856\D856;
                      LDA.W !OWPlayerYPosPtr,X                  ;;D858|D858+D858/D858\D858;
                      AND.W #$000F                              ;;D85B|D85B+D85B/D85B\D85B;
                      ASL A                                     ;;D85E|D85E+D85E/D85E\D85E;
                      ASL A                                     ;;D85F|D85F+D85F/D85F\D85F;
                      ASL A                                     ;;D860|D860+D860/D860\D860;
                      ASL A                                     ;;D861|D861+D861/D861\D861;
                      STA.B !_2                                 ;;D862|D862+D862/D862\D862;
                      LDA.W !OWPlayerXPosPtr,X                  ;;D864|D864+D864/D864\D864;
                      AND.W #$0010                              ;;D867|D867+D867/D867\D867;
                      ASL A                                     ;;D86A|D86A+D86A/D86A\D86A;
                      ASL A                                     ;;D86B|D86B+D86B/D86B\D86B;
                      ASL A                                     ;;D86C|D86C+D86C/D86C\D86C;
                      ASL A                                     ;;D86D|D86D+D86D/D86D\D86D;
                      ORA.B !_0                                 ;;D86E|D86E+D86E/D86E\D86E;
                      STA.B !_0                                 ;;D870|D870+D870/D870\D870;
                      LDA.W !OWPlayerYPosPtr,X                  ;;D872|D872+D872/D872\D872;
                      AND.W #$0010                              ;;D875|D875+D875/D875\D875;
                      ASL A                                     ;;D878|D878+D878/D878\D878;
                      ASL A                                     ;;D879|D879+D879/D879\D879;
                      ASL A                                     ;;D87A|D87A+D87A/D87A\D87A;
                      ASL A                                     ;;D87B|D87B+D87B/D87B\D87B;
                      ASL A                                     ;;D87C|D87C+D87C/D87C\D87C;
                      ORA.B !_2                                 ;;D87D|D87D+D87D/D87D\D87D;
                      ORA.B !_0                                 ;;D87F|D87F+D87F/D87F\D87F;
                      TAX                                       ;;D881|D881+D881/D881\D881;
                      LDA.W !PlayerTurnOW                       ;;D882|D882+D882/D882\D882; \
                      AND.W #$00FF                              ;;D885|D885+D885/D885\D885;  |
                      LSR A                                     ;;D888|D888+D888/D888\D888;  |Set Y to current player
                      LSR A                                     ;;D889|D889+D889/D889\D889;  |
                      TAY                                       ;;D88A|D88A+D88A/D88A\D88A; /
                      LDA.W !OWPlayerSubmap,Y                   ;;D88B|D88B+D88B/D88B\D88B; \ Get current player's submap
                      AND.W #$000F                              ;;D88E|D88E+D88E/D88E\D88E; /
                      BEQ +                                     ;;D891|D891+D891/D891\D891; \
                      TXA                                       ;;D893|D893+D893/D893\D893;  |
                      CLC                                       ;;D894|D894+D894/D894\D894;  |If on submap, increase X by x400
                      ADC.W #$0400                              ;;D895|D895+D895/D895\D895;  |
                      TAX                                       ;;D898|D898+D898/D898\D898;  |
                    + SEP #$20                                  ;;D899|D899+D899/D899\D899; 8 bit A ; Accum (8 bit)
                      LDA.L !OWLayer1Translevel,X               ;;D89B|D89B+D89B/D89B\D89B;
                      STA.W !TranslevelNo                       ;;D89F|D89F+D89F/D89F\D89F; Store overworld level number
CODE_05D8A2:          CMP.B #$25                                ;;D8A2|D8A2+D8A2/D8A2\D8A2; \
                      BCC +                                     ;;D8A4|D8A4+D8A4/D8A4\D8A4;  |
                      SEC                                       ;;D8A6|D8A6+D8A6/D8A6\D8A6;  |If A>= x25,
                      SBC.B #$24                                ;;D8A7|D8A7+D8A7/D8A7\D8A7;  |subtract x24
                    + STA.W !LoadingLevelNumber                 ;;D8A9|D8A9+D8A9/D8A9\D8A9;
                      STA.B !_E                                 ;;D8AC|D8AC+D8AC/D8AC\D8AC; Store A as lower level number byte
                      LDA.W !OWPlayerSubmap,Y                   ;;D8AE|D8AE+D8AE/D8AE\D8AE; \
                      BEQ +                                     ;;D8B1|D8B1+D8B1/D8B1\D8B1;  |Set higher level number byte to:
                      LDA.B #$01                                ;;D8B3|D8B3+D8B3/D8B3\D8B3;  |0 if on overworld
                    + STA.B !_F                                 ;;D8B5|D8B5+D8B5/D8B5\D8B5; /
CODE_05D8B7:          REP #$30                                  ;;D8B7|D8B7+D8B7/D8B7\D8B7; 16 bit A,X,Y ; Index (16 bit) Accum (16 bit)
                      LDA.B !_E                                 ;;D8B9|D8B9+D8B9/D8B9\D8B9; \
                      ASL A                                     ;;D8BB|D8BB+D8BB/D8BB\D8BB;  |
                      CLC                                       ;;D8BC|D8BC+D8BC/D8BC\D8BC;  |Multiply level number by 3 and store in Y
                      ADC.B !_E                                 ;;D8BD|D8BD+D8BD/D8BD\D8BD;  |(Each L1/2 pointer table entry is 3 bytes long)
                      TAY                                       ;;D8BF|D8BF+D8BF/D8BF\D8BF; /
                      SEP #$20                                  ;;D8C0|D8C0+D8C0/D8C0\D8C0; 8 bit A ; Accum (8 bit)
                      LDA.W Layer1Ptrs,Y                        ;;D8C2|D8C2+D8C2/D8C2\D8C2; \
                      STA.B !Layer1DataPtr                      ;;D8C5|D8C5+D8C5/D8C5\D8C5;  |
                      LDA.W Layer1Ptrs+1,Y                      ;;D8C7|D8C7+D8C7/D8C7\D8C7;  |Load Layer 1 pointer into $65-$67
                      STA.B !Layer1DataPtr+1                    ;;D8CA|D8CA+D8CA/D8CA\D8CA;  |
                      LDA.W Layer1Ptrs+2,Y                      ;;D8CC|D8CC+D8CC/D8CC\D8CC;  |
                      STA.B !Layer1DataPtr+2                    ;;D8CF|D8CF+D8CF/D8CF\D8CF; /
                      LDA.W Layer2Ptrs,Y                        ;;D8D1|D8D1+D8D1/D8D1\D8D1; \
                      STA.B !Layer2DataPtr                      ;;D8D4|D8D4+D8D4/D8D4\D8D4;  |
                      LDA.W Layer2Ptrs+1,Y                      ;;D8D6|D8D6+D8D6/D8D6\D8D6;  |Load Layer 2 pointer into $68-$6A
                      STA.B !Layer2DataPtr+1                    ;;D8D9|D8D9+D8D9/D8D9\D8D9;  |
                      LDA.W Layer2Ptrs+2,Y                      ;;D8DB|D8DB+D8DB/D8DB\D8DB;  |
                      STA.B !Layer2DataPtr+2                    ;;D8DE|D8DE+D8DE/D8DE\D8DE; /
                      REP #$20                                  ;;D8E0|D8E0+D8E0/D8E0\D8E0; 16 bit A ; Accum (16 bit)
                      LDA.B !_E                                 ;;D8E2|D8E2+D8E2/D8E2\D8E2; \
                      ASL A                                     ;;D8E4|D8E4+D8E4/D8E4\D8E4;  |Multiply level number by 2 and store in Y
                      TAY                                       ;;D8E5|D8E5+D8E5/D8E5\D8E5; / (Each sprite pointer table entry is 2 bytes long)
                      LDA.W #$0000                              ;;D8E6|D8E6+D8E6/D8E6\D8E6;
                      SEP #$20                                  ;;D8E9|D8E9+D8E9/D8E9\D8E9; 8 bit A ; Accum (8 bit)
                      LDA.W Ptrs05EC00,Y                        ;;D8EB|D8EB+D8EB/D8EB\D8EB; \
                      STA.B !SpriteDataPtr                      ;;D8EE|D8EE+D8EE/D8EE\D8EE;  |Store location of sprite level Y in $CE-$CF
                      LDA.W Ptrs05EC00+1,Y                      ;;D8F0|D8F0+D8F0/D8F0\D8F0;  |
                      STA.B !SpriteDataPtr+1                    ;;D8F3|D8F3+D8F3/D8F3\D8F3; /
                      LDA.B #$07                                ;;D8F5|D8F5+D8F5/D8F5\D8F5; \ Set highest byte to x07
                      STA.B !SpriteDataPtr+2                    ;;D8F7|D8F7+D8F7/D8F7\D8F7; / (All sprite data is stored in bank 07)
                      LDA.B [!SpriteDataPtr]                    ;;D8F9|D8F9+D8F9/D8F9\D8F9; \ Get first byte of sprite data (header)
                      AND.B #$3F                                ;;D8FB|D8FB+D8FB/D8FB\D8FB;  |Get level's sprite memory
                      STA.W !SpriteMemorySetting                ;;D8FD|D8FD+D8FD/D8FD\D8FD; / Store in $1692
                      LDA.B [!SpriteDataPtr]                    ;;D900|D900+D900/D900\D900; \ Get first byte of sprite data (header) again
                      AND.B #$C0                                ;;D902|D902+D902/D902\D902;  |Get level's sprite buoyancy settings
                      STA.W !SpriteBuoyancy                     ;;D904|D904+D904/D904\D904; / Store in $190E
                      REP #$10                                  ;;D907|D907+D907/D907\D907; 16 bit X,Y ; Index (16 bit)
                      SEP #$20                                  ;;D909|D909+D909/D909\D909; 8 bit A ; Accum (8 bit)
                      LDY.B !_E                                 ;;D90B|D90B+D90B/D90B\D90B;
                      LDA.W DATA_05F000,Y                       ;;D90D|D90D+D90D/D90D\D90D;
                      LSR A                                     ;;D910|D910+D910/D910\D910;
                      LSR A                                     ;;D911|D911+D911/D911\D911;
                      LSR A                                     ;;D912|D912+D912/D912\D912;
                      LSR A                                     ;;D913|D913+D913/D913\D913;
                      TAX                                       ;;D914|D914+D914/D914\D914;
                      LDA.L DATA_05D720,X                       ;;D915|D915+D915/D915\D915;
                      STA.W !HorizLayer2Setting                 ;;D919|D919+D919/D919\D919;
                      LDA.L DATA_05D710,X                       ;;D91C|D91C+D91C/D91C\D91C;
                      STA.W !VertLayer2Setting                  ;;D920|D920+D920/D920\D920;
                      LDA.B #$01                                ;;D923|D923+D923/D923\D923;
                      STA.W !HorizLayer1Setting                 ;;D925|D925+D925/D925\D925;
                      LDA.W Lay3EntranceXPosDat,Y               ;;D928|D928+D928/D928\D928;
                      AND.B #$C0                                ;;D92B|D92B+D92B/D92B\D92B;
                      CLC                                       ;;D92D|D92D+D92D/D92D\D92D;
                      ASL A                                     ;;D92E|D92E+D92E/D92E\D92E;
                      ROL A                                     ;;D92F|D92F+D92F/D92F\D92F;
                      ROL A                                     ;;D930|D930+D930/D930\D930;
                      STA.W !Layer3Setting                      ;;D931|D931+D931/D931\D931;
                      STZ.B !Layer1YPos+1                       ;;D934|D934+D934/D934\D934;
                      STZ.B !Layer2YPos+1                       ;;D936|D936+D936/D936\D936;
                      LDA.W DATA_05F600,Y                       ;;D938|D938+D938/D938\D938;
                      AND.B #$80                                ;;D93B|D93B+D93B/D93B\D93B;
                      STA.W !DisableNoYoshiIntro                ;;D93D|D93D+D93D/D93D\D93D;
                      LDA.W DATA_05F600,Y                       ;;D940|D940+D940/D940\D940;
                      AND.B #$60                                ;;D943|D943+D943/D943\D943;
                      LSR A                                     ;;D945|D945+D945/D945\D945;
                      LSR A                                     ;;D946|D946+D946/D946\D946;
                      LSR A                                     ;;D947|D947+D947/D947\D947;
                      LSR A                                     ;;D948|D948+D948/D948\D948;
                      LSR A                                     ;;D949|D949+D949/D949\D949;
                      STA.B !ScreenMode                         ;;D94A|D94A+D94A/D94A\D94A;
                      LDA.W !UseSecondaryExit                   ;;D94C|D94C+D94C/D94C\D94C;
                      BNE +                                     ;;D94F|D94F+D94F/D94F\D94F;
                      LDA.W DATA_05F000,Y                       ;;D951|D951+D951/D951\D951;
                      AND.B #$0F                                ;;D954|D954+D954/D954\D954;
                      TAX                                       ;;D956|D956+D956/D956\D956;
                      LDA.L DATA_05D730,X                       ;;D957|D957+D957/D957\D957;
                      STA.B !PlayerYPosNext                     ;;D95B|D95B+D95B/D95B\D95B;
                      LDA.L DATA_05D740,X                       ;;D95D|D95D+D95D/D95D\D95D;
                      STA.B !PlayerYPosNext+1                   ;;D961|D961+D961/D961\D961;
                      LDA.W Lay3EntranceXPosDat,Y               ;;D963|D963+D963/D963\D963;
                      STA.B !_2                                 ;;D966|D966+D966/D966\D966;
                      AND.B #$07                                ;;D968|D968+D968/D968\D968;
                      TAX                                       ;;D96A|D96A+D96A/D96A\D96A;
                      LDA.L DATA_05D750,X                       ;;D96B|D96B+D96B/D96B\D96B;
                      STA.B !PlayerXPosNext                     ;;D96F|D96F+D96F/D96F\D96F;
                      LDA.L DATA_05D758,X                       ;;D971|D971+D971/D971\D971;
                      STA.B !PlayerXPosNext+1                   ;;D975|D975+D975/D975\D975;
                      LDA.B !_2                                 ;;D977|D977+D977/D977\D977;
                      AND.B #$38                                ;;D979|D979+D979/D979\D979;
                      LSR A                                     ;;D97B|D97B+D97B/D97B\D97B;
                      LSR A                                     ;;D97C|D97C+D97C/D97C\D97C;
                      LSR A                                     ;;D97D|D97D+D97D/D97D\D97D;
                      STA.W !LevelEntranceType                  ;;D97E|D97E+D97E/D97E\D97E;
                      LDA.W DATA_05F400,Y                       ;;D981|D981+D981/D981\D981;
                      STA.B !_2                                 ;;D984|D984+D984/D984\D984;
                      AND.B #$03                                ;;D986|D986+D986/D986\D986;
                      TAX                                       ;;D988|D988+D988/D988\D988;
                      LDA.L DATA_05D70C,X                       ;;D989|D989+D989/D989\D989;
                      STA.B !Layer2YPos                         ;;D98D|D98D+D98D/D98D\D98D;
                      LDA.B !_2                                 ;;D98F|D98F+D98F/D98F\D98F;
                      AND.B #$0C                                ;;D991|D991+D991/D991\D991;
                      LSR A                                     ;;D993|D993+D993/D993\D993;
                      LSR A                                     ;;D994|D994+D994/D994\D994;
                      TAX                                       ;;D995|D995+D995/D995\D995;
                      LDA.L DATA_05D708,X                       ;;D996|D996+D996/D996\D996;
                      STA.B !Layer1YPos                         ;;D99A|D99A+D99A/D99A\D99A;
                      LDA.W DATA_05F600,Y                       ;;D99C|D99C+D99C/D99C\D99C;
                      STA.B !_1                                 ;;D99F|D99F+D99F/D99F\D99F;
                    + LDA.B !ScreenMode                         ;;D9A1|D9A1+D9A1/D9A1\D9A1;
                      AND.B #$01                                ;;D9A3|D9A3+D9A3/D9A3\D9A3;
                      BEQ +                                     ;;D9A5|D9A5+D9A5/D9A5\D9A5;
                      LDY.W #$0000                              ;;D9A7|D9A7+D9A7/D9A7\D9A7;
                      LDA.B [!Layer1DataPtr],Y                  ;;D9AA|D9AA+D9AA/D9AA\D9AA;
                      AND.B #$1F                                ;;D9AC|D9AC+D9AC/D9AC\D9AC;
                      STA.B !PlayerYPosNext+1                   ;;D9AE|D9AE+D9AE/D9AE\D9AE;
                      INC A                                     ;;D9B0|D9B0+D9B0/D9B0\D9B0;
                      STA.B !LastScreenVert                     ;;D9B1|D9B1+D9B1/D9B1\D9B1;
                      LDA.B #$01                                ;;D9B3|D9B3+D9B3/D9B3\D9B3;
                      STA.W !VertLayer1Setting                  ;;D9B5|D9B5+D9B5/D9B5\D9B5;
                    + LDA.W !SublevelCount                      ;;D9B8|D9B8+D9B8/D9B8\D9B8;
                      BNE +                                     ;;D9BB|D9BB+D9BB/D9BB\D9BB;
                      LDA.B !_2                                 ;;D9BD|D9BD+D9BD/D9BD\D9BD;
                      LSR A                                     ;;D9BF|D9BF+D9BF/D9BF\D9BF;
                      LSR A                                     ;;D9C0|D9C0+D9C0/D9C0\D9C0;
                      LSR A                                     ;;D9C1|D9C1+D9C1/D9C1\D9C1;
                      LSR A                                     ;;D9C2|D9C2+D9C2/D9C2\D9C2;
                      STA.W !DisableMidway                      ;;D9C3|D9C3+D9C3/D9C3\D9C3;
                      STZ.W !MidwayFlag                         ;;D9C6|D9C6+D9C6/D9C6\D9C6;
                      LDY.W !TranslevelNo                       ;;D9C9|D9C9+D9C9/D9C9\D9C9;
                      LDA.W DATA_05D608,Y                       ;;D9CC|D9CC+D9CC/D9CC\D9CC;
                      STA.W !OverworldEvent                     ;;D9CF|D9CF+D9CF/D9CF\D9CF;
                      SEP #$10                                  ;;D9D2|D9D2+D9D2/D9D2\D9D2; Index (8 bit)
                      LDX.W !TranslevelNo                       ;;D9D4|D9D4+D9D4/D9D4\D9D4;
                      LDA.W !OWLevelTileSettings,X              ;;D9D7|D9D7+D9D7/D9D7\D9D7;
                      AND.B #$40                                ;;D9DA|D9DA+D9DA/D9DA\D9DA;
                      BEQ +                                     ;;D9DC|D9DC+D9DC/D9DC\D9DC;
                      STA.W !SkipMidwayCastleIntro              ;;D9DE|D9DE+D9DE/D9DE\D9DE;
                      LDA.B !_2                                 ;;D9E1|D9E1+D9E1/D9E1\D9E1;
                      LSR A                                     ;;D9E3|D9E3+D9E3/D9E3\D9E3;
                      LSR A                                     ;;D9E4|D9E4+D9E4/D9E4\D9E4;
                      LSR A                                     ;;D9E5|D9E5+D9E5/D9E5\D9E5;
                      LSR A                                     ;;D9E6|D9E6+D9E6/D9E6\D9E6;
                      STA.B !PlayerXPosNext+1                   ;;D9E7|D9E7+D9E7/D9E7\D9E7;
                      JMP CODE_05DA17                           ;;D9E9|D9E9+D9E9/D9E9\D9E9;
                                                                ;;                        ;
                    + REP #$10                                  ;;D9EC|D9EC+D9EC/D9EC\D9EC; Index (16 bit)
                      LDA.B !_1                                 ;;D9EE|D9EE+D9EE/D9EE\D9EE;
                      AND.B #$1F                                ;;D9F0|D9F0+D9F0/D9F0\D9F0;
                      STA.B !_1                                 ;;D9F2|D9F2+D9F2/D9F2\D9F2;
                      LDA.B !ScreenMode                         ;;D9F4|D9F4+D9F4/D9F4\D9F4;
                      AND.B #$01                                ;;D9F6|D9F6+D9F6/D9F6\D9F6;
                      BNE +                                     ;;D9F8|D9F8+D9F8/D9F8\D9F8;
                      LDA.B !_1                                 ;;D9FA|D9FA+D9FA/D9FA\D9FA;
                      STA.B !PlayerXPosNext+1                   ;;D9FC|D9FC+D9FC/D9FC\D9FC;
                      JMP CODE_05DA17                           ;;D9FE|D9FE+D9FE/D9FE\D9FE;
                                                                ;;                        ;
                    + LDA.B !_1                                 ;;DA01|DA01+DA01/DA01\DA01;
                      STA.B !PlayerYPosNext+1                   ;;DA03|DA03+DA03/DA03\DA03;
                      STA.B !Layer1YPos+1                       ;;DA05|DA05+DA05/DA05\DA05;
                      SEP #$10                                  ;;DA07|DA07+DA07/DA07\DA07; Index (8 bit)
                      LDY.W !VertLayer2Setting                  ;;DA09|DA09+DA09/DA09\DA09;
                      CPY.B #$03                                ;;DA0C|DA0C+DA0C/DA0C\DA0C;
                      BEQ +                                     ;;DA0E|DA0E+DA0E/DA0E\DA0E;
                      STA.B !Layer2YPos+1                       ;;DA10|DA10+DA10/DA10\DA10;
                    + LDA.B #$01                                ;;DA12|DA12+DA12/DA12\DA12;
                      STA.W !VertLayer1Setting                  ;;DA14|DA14+DA14/DA14\DA14;
CODE_05DA17:          SEP #$30                                  ;;DA17|DA17+DA17/DA17\DA17; Index (8 bit) Accum (8 bit)
                      LDA.W !TranslevelNo                       ;;DA19|DA19+DA19/DA19\DA19;
                      CMP.B #$52                                ;;DA1C|DA1C+DA1C/DA1C\DA1C;
                      BCC CODE_05DA24                           ;;DA1E|DA1E+DA1E/DA1E\DA1E;
                      LDX.B #$03                                ;;DA20|DA20+DA20/DA20\DA20;
                      BRA CODE_05DA38                           ;;DA22|DA22+DA22/DA22\DA22;
                                                                ;;                        ;
CODE_05DA24:          LDX.B #$04                                ;;DA24|DA24+DA24/DA24\DA24;
                      LDY.B #$04                                ;;DA26|DA26+DA26/DA26\DA26;
                      LDA.B [!Layer1DataPtr],Y                  ;;DA28|DA28+DA28/DA28\DA28;
                      AND.B #$0F                                ;;DA2A|DA2A+DA2A/DA2A\DA2A;
CODE_05DA2C:          CMP.L DATA_05D760,X                       ;;DA2C|DA2C+DA2C/DA2C\DA2C;
                      BEQ CODE_05DA38                           ;;DA30|DA30+DA30/DA30\DA30;
                      DEX                                       ;;DA32|DA32+DA32/DA32\DA32;
                      BPL CODE_05DA2C                           ;;DA33|DA33+DA33/DA33\DA33;
                    - JMP CODE_05DAD7                           ;;DA35|DA35+DA35/DA35\DA35;
                                                                ;;                        ;
CODE_05DA38:          LDA.W !SublevelCount                      ;;DA38|DA38+DA38/DA38\DA38;
                      BNE -                                     ;;DA3B|DA3B+DA3B/DA3B\DA3B;
                      LDA.W !ShowMarioStart                     ;;DA3D|DA3D+DA3D/DA3D\DA3D;
                      BNE -                                     ;;DA40|DA40+DA40/DA40\DA40;
                      LDA.W !DisableNoYoshiIntro                ;;DA42|DA42+DA42/DA42\DA42;
                      BNE -                                     ;;DA45|DA45+DA45/DA45\DA45;
                      LDA.W !TranslevelNo                       ;;DA47|DA47+DA47/DA47\DA47;
                      CMP.B #$31                                ;;DA4A|DA4A+DA4A/DA4A\DA4A;
                      BEQ CODE_05DA5E                           ;;DA4C|DA4C+DA4C/DA4C\DA4C;
                      CMP.B #$32                                ;;DA4E|DA4E+DA4E/DA4E\DA4E;
                      BEQ CODE_05DA5E                           ;;DA50|DA50+DA50/DA50\DA50;
                      CMP.B #$34                                ;;DA52|DA52+DA52/DA52\DA52;
                      BEQ CODE_05DA5E                           ;;DA54|DA54+DA54/DA54\DA54;
                      CMP.B #$35                                ;;DA56|DA56+DA56/DA56\DA56;
                      BEQ CODE_05DA5E                           ;;DA58|DA58+DA58/DA58\DA58;
                      CMP.B #$40                                ;;DA5A|DA5A+DA5A/DA5A\DA5A;
                      BNE +                                     ;;DA5C|DA5C+DA5C/DA5C\DA5C;
CODE_05DA5E:          LDX.B #$05                                ;;DA5E|DA5E+DA5E/DA5E\DA5E;
                    + LDA.W !SkipMidwayCastleIntro              ;;DA60|DA60+DA60/DA60\DA60;
                      BNE +                                     ;;DA63|DA63+DA63/DA63\DA63;
                      LDA.L DATA_05D790,X                       ;;DA65|DA65+DA65/DA65\DA65;
                      STA.B !PlayerYPosNext                     ;;DA69|DA69+DA69/DA69\DA69;
                      LDA.B #$01                                ;;DA6B|DA6B+DA6B/DA6B\DA6B;
                      STA.B !PlayerYPosNext+1                   ;;DA6D|DA6D+DA6D/DA6D\DA6D;
                      LDA.B #$30                                ;;DA6F|DA6F+DA6F/DA6F\DA6F;
                      STA.B !PlayerXPosNext                     ;;DA71|DA71+DA71/DA71\DA71;
                      STZ.B !PlayerXPosNext+1                   ;;DA73|DA73+DA73/DA73\DA73;
                      LDA.B #$C0                                ;;DA75|DA75+DA75/DA75\DA75;
                      STA.B !Layer1YPos                         ;;DA77|DA77+DA77/DA77\DA77;
                      STA.B !Layer2YPos                         ;;DA79|DA79+DA79/DA79\DA79;
                      STZ.W !LevelEntranceType                  ;;DA7B|DA7B+DA7B/DA7B\DA7B;
                      LDA.B #$EE                                ;;DA7E|DA7E+DA7E/DA7E\DA7E;
                      STA.B !SpriteDataPtr                      ;;DA80|DA80+DA80/DA80\DA80;
                      LDA.B #$C3                                ;;DA82|DA82+DA82/DA82\DA82;
                      STA.B !SpriteDataPtr+1                    ;;DA84|DA84+DA84/DA84\DA84;
                      LDA.B #$07                                ;;DA86|DA86+DA86/DA86\DA86;
                      STA.B !SpriteDataPtr+2                    ;;DA88|DA88+DA88/DA88\DA88;
                      LDA.B [!SpriteDataPtr]                    ;;DA8A|DA8A+DA8A/DA8A\DA8A;
                      AND.B #$3F                                ;;DA8C|DA8C+DA8C/DA8C\DA8C;
                      STA.W !SpriteMemorySetting                ;;DA8E|DA8E+DA8E/DA8E\DA8E;
                      LDA.B [!SpriteDataPtr]                    ;;DA91|DA91+DA91/DA91\DA91;
                      AND.B #$C0                                ;;DA93|DA93+DA93/DA93\DA93;
                      STA.W !SpriteBuoyancy                     ;;DA95|DA95+DA95/DA95\DA95;
                      STZ.W !HorizLayer2Setting                 ;;DA98|DA98+DA98/DA98\DA98;
                      STZ.W !VertLayer2Setting                  ;;DA9B|DA9B+DA9B/DA9B\DA9B;
                      STZ.W !HorizLayer1Setting                 ;;DA9E|DA9E+DA9E/DA9E\DA9E;
                      STZ.B !ScreenMode                         ;;DAA1|DAA1+DAA1/DAA1\DAA1;
                      LDA.L DATA_05D78A,X                       ;;DAA3|DAA3+DAA3/DAA3\DAA3;
                      STA.W !Layer3Setting                      ;;DAA7|DAA7+DAA7/DAA7\DAA7;
                      STX.B !_0                                 ;;DAAA|DAAA+DAAA/DAAA\DAAA;
                      TXA                                       ;;DAAC|DAAC+DAAC/DAAC\DAAC;
                      ASL A                                     ;;DAAD|DAAD+DAAD/DAAD\DAAD;
                      CLC                                       ;;DAAE|DAAE+DAAE/DAAE\DAAE;
                      ADC.B !_0                                 ;;DAAF|DAAF+DAAF/DAAF\DAAF;
                      TAY                                       ;;DAB1|DAB1+DAB1/DAB1\DAB1;
                      LDA.W PtrsLong05D766,Y                    ;;DAB2|DAB2+DAB2/DAB2\DAB2;
                      STA.B !Layer1DataPtr                      ;;DAB5|DAB5+DAB5/DAB5\DAB5;
                      LDA.W PtrsLong05D766+1,Y                  ;;DAB7|DAB7+DAB7/DAB7\DAB7;
                      STA.B !Layer1DataPtr+1                    ;;DABA|DABA+DABA/DABA\DABA;
                      LDA.W PtrsLong05D766+2,Y                  ;;DABC|DABC+DABC/DABC\DABC;
                      STA.B !Layer1DataPtr+2                    ;;DABF|DABF+DABF/DABF\DABF;
                      LDA.W PtrsLong05D778,Y                    ;;DAC1|DAC1+DAC1/DAC1\DAC1;
                      STA.B !Layer2DataPtr                      ;;DAC4|DAC4+DAC4/DAC4\DAC4;
                      LDA.W PtrsLong05D778+1,Y                  ;;DAC6|DAC6+DAC6/DAC6\DAC6;
                      STA.B !Layer2DataPtr+1                    ;;DAC9|DAC9+DAC9/DAC9\DAC9;
                      LDA.W PtrsLong05D778+2,Y                  ;;DACB|DACB+DACB/DACB\DACB;
                      STA.B !Layer2DataPtr+2                    ;;DACE|DACE+DACE/DACE\DACE;
                    + LDA.L DATA_05D760,X                       ;;DAD0|DAD0+DAD0/DAD0\DAD0;
                      STA.W !ObjectTileset                      ;;DAD4|DAD4+DAD4/DAD4\DAD4;
CODE_05DAD7:          LDA.W !SublevelCount                      ;;DAD7|DAD7+DAD7/DAD7\DAD7;
                      BEQ +                                     ;;DADA|DADA+DADA/DADA\DADA;
                      LDA.W !BonusGameActivate                  ;;DADC|DADC+DADC/DADC\DADC;
                      BNE +                                     ;;DADF|DADF+DADF/DADF\DADF;
                      LDA.W !TranslevelNo                       ;;DAE1|DAE1+DAE1/DAE1\DAE1;
                      CMP.B #$24                                ;;DAE4|DAE4+DAE4/DAE4\DAE4;
                      BNE +                                     ;;DAE6|DAE6+DAE6/DAE6\DAE6;
                      JSR CODE_05DAEF                           ;;DAE8|DAE8+DAE8/DAE8\DAE8;
                    + PLB                                       ;;DAEB|DAEB+DAEB/DAEB\DAEB;
                      SEP #$30                                  ;;DAEC|DAEC+DAEC/DAEC\DAEC; Index (8 bit) Accum (8 bit)
                      RTL                                       ;;DAEE|DAEE+DAEE/DAEE\DAEE; Return
                                                                ;;                        ;
CODE_05DAEF:          SEP #$30                                  ;;DAEF|DAEF+DAEF/DAEF\DAEF; Index (8 bit) Accum (8 bit)
                      LDY.B #$04                                ;;DAF1|DAF1+DAF1/DAF1\DAF1;
                      LDA.B [!Layer1DataPtr],Y                  ;;DAF3|DAF3+DAF3/DAF3\DAF3;
                      AND.B #$C0                                ;;DAF5|DAF5+DAF5/DAF5\DAF5;
                      CLC                                       ;;DAF7|DAF7+DAF7/DAF7\DAF7;
                      ROL A                                     ;;DAF8|DAF8+DAF8/DAF8\DAF8;
                      ROL A                                     ;;DAF9|DAF9+DAF9/DAF9\DAF9;
                      ROL A                                     ;;DAFA|DAFA+DAFA/DAFA\DAFA;
                      JSL ExecutePtrLong                        ;;DAFB|DAFB+DAFB/DAFB\DAFB;
                                                                ;;                        ;
                      dl CODE_05DB3E                            ;;DAFF|DAFF+DAFF/DAFF\DAFF;
                      dl CODE_05DB6E                            ;;DB02|DB02+DB02/DB02\DB02;
                      dl CODE_05DB82                            ;;DB05|DB05+DB05/DB05\DB05;
                                                                ;;                        ;
ChocIsld2Layer1:      dw CI2Sub8Level0CD                        ;;DB08|DB08+DB08/DB08\DB08;
                      dw CI2Sub7Level6EC7E                      ;;DB0A|DB0A+DB0A/DB0A\DB0A;
                      dw CI2Sub7Level6EC7E                      ;;DB0C|DB0C+DB0C/DB0C\DB0C;
                      dw CI2Sub3Level0CF                        ;;DB0E|DB0E+DB0E/DB0E\DB0E;
                      dw CI2Sub2Level6E9FB                      ;;DB10|DB10+DB10/DB10\DB10;
                      dw CI2Sub1Level6EAB0                      ;;DB12|DB12+DB12/DB12\DB12;
                      dw CI2Sub4Level0CE                        ;;DB14|DB14+DB14/DB14\DB14;
                      dw CI2Sub5Level6EB72                      ;;DB16|DB16+DB16/DB16\DB16;
                      dw CI2Sub6Level6EBBE                      ;;DB18|DB18+DB18/DB18\DB18;
                                                                ;;                        ;
ChocIsld2Sprites:     dw CI2Sub8Sprites0CD                      ;;DB1A|DB1A+DB1A/DB1A\DB1A;
                      dw CI2Sub7Sprites6EC7E                    ;;DB1C|DB1C+DB1C/DB1C\DB1C;
                      dw CI2Sub7Sprites6EC7E                    ;;DB1E|DB1E+DB1E/DB1E\DB1E;
                      dw CI2Sub3Sprites0CF                      ;;DB20|DB20+DB20/DB20\DB20;
                      dw CI2Sub2Sprites6E9FB                    ;;DB22|DB22+DB22/DB22\DB22;
                      dw CI2Sub1Sprites6EAB0                    ;;DB24|DB24+DB24/DB24\DB24;
                      dw CI2Sub4Sprites0CE                      ;;DB26|DB26+DB26/DB26\DB26;
                      dw CI2Sub5Sprites6EB72                    ;;DB28|DB28+DB28/DB28\DB28;
                      dw CI2Sub6SPrites6EBBE                    ;;DB2A|DB2A+DB2A/DB2A\DB2A;
                                                                ;;                        ;
ChocIsld2Layer2:      dw DATA_0CDF59                            ;;DB2C|DB2C+DB2C/DB2C\DB2C;
                      dw DATA_0CDF59                            ;;DB2E|DB2E+DB2E/DB2E\DB2E;
                      dw DATA_0CDF59                            ;;DB30|DB30+DB30/DB30\DB30;
                      dw DATA_0CDF59                            ;;DB32|DB32+DB32/DB32\DB32;
                      dw DATA_0CDF59                            ;;DB34|DB34+DB34/DB34\DB34;
                      dw DATA_0CDF59                            ;;DB36|DB36+DB36/DB36\DB36;
                      dw DATA_0CDF59                            ;;DB38|DB38+DB38/DB38\DB38;
                      dw DATA_0CDF59                            ;;DB3A|DB3A+DB3A/DB3A\DB3A;
                      dw DATA_0CDF59                            ;;DB3C|DB3C+DB3C/DB3C\DB3C;
                                                                ;;                        ;
CODE_05DB3E:          LDX.B #$00                                ;;DB3E|DB3E+DB3E/DB3E\DB3E;
                      LDA.W !DragonCoinsShown                   ;;DB40|DB40+DB40/DB40\DB40;
                      CMP.B #$04                                ;;DB43|DB43+DB43/DB43\DB43;
                      BEQ CODE_05DB49                           ;;DB45|DB45+DB45/DB45\DB45;
                      LDX.B #$02                                ;;DB47|DB47+DB47/DB47\DB47;
CODE_05DB49:          REP #$20                                  ;;DB49|DB49+DB49/DB49\DB49; Accum (16 bit)
                      LDA.L ChocIsld2Layer1,X                   ;;DB4B|DB4B+DB4B/DB4B\DB4B;
                      STA.B !Layer1DataPtr                      ;;DB4F|DB4F+DB4F/DB4F\DB4F;
                      LDA.L ChocIsld2Sprites,X                  ;;DB51|DB51+DB51/DB51\DB51;
                      STA.B !SpriteDataPtr                      ;;DB55|DB55+DB55/DB55\DB55;
                      LDA.L ChocIsld2Layer2,X                   ;;DB57|DB57+DB57/DB57\DB57;
                      STA.B !Layer2DataPtr                      ;;DB5B|DB5B+DB5B/DB5B\DB5B;
                      SEP #$20                                  ;;DB5D|DB5D+DB5D/DB5D\DB5D; Accum (8 bit)
                      LDA.B [!SpriteDataPtr]                    ;;DB5F|DB5F+DB5F/DB5F\DB5F;
                      AND.B #$7F                                ;;DB61|DB61+DB61/DB61\DB61;
                      STA.W !SpriteMemorySetting                ;;DB63|DB63+DB63/DB63\DB63;
                      LDA.B [!SpriteDataPtr]                    ;;DB66|DB66+DB66/DB66\DB66;
                      AND.B #$80                                ;;DB68|DB68+DB68/DB68\DB68;
                      STA.W !SpriteBuoyancy                     ;;DB6A|DB6A+DB6A/DB6A\DB6A;
                      RTS                                       ;;DB6D|DB6D+DB6D/DB6D\DB6D; Return
                                                                ;;                        ;
CODE_05DB6E:          LDX.B #$0A                                ;;DB6E|DB6E+DB6E/DB6E\DB6E;
                      LDA.W !GreenStarBlockCoins                ;;DB70|DB70+DB70/DB70\DB70;
                      CMP.B #$16                                ;;DB73|DB73+DB73/DB73\DB73;
                      BPL +                                     ;;DB75|DB75+DB75/DB75\DB75;
                      LDX.B #$08                                ;;DB77|DB77+DB77/DB77\DB77;
                      CMP.B #$0A                                ;;DB79|DB79+DB79/DB79\DB79;
                      BPL +                                     ;;DB7B|DB7B+DB7B/DB7B\DB7B;
                      LDX.B #$06                                ;;DB7D|DB7D+DB7D/DB7D\DB7D;
                    + JMP CODE_05DB49                           ;;DB7F|DB7F+DB7F/DB7F\DB7F;
                                                                ;;                        ;
CODE_05DB82:          LDX.B #$0C                                ;;DB82|DB82+DB82/DB82\DB82;
                      LDA.W !InGameTimerHundreds                ;;DB84|DB84+DB84/DB84\DB84;
                      CMP.B #$02                                ;;DB87|DB87+DB87/DB87\DB87;
                      BMI CODE_05DBA6                           ;;DB89|DB89+DB89/DB89\DB89;
                      LDA.W !InGameTimerTens                    ;;DB8B|DB8B+DB8B/DB8B\DB8B;
                      CMP.B #$03                                ;;DB8E|DB8E+DB8E/DB8E\DB8E;
                      BMI CODE_05DBA6                           ;;DB90|DB90+DB90/DB90\DB90;
                      BNE CODE_05DB9B                           ;;DB92|DB92+DB92/DB92\DB92;
                      LDA.W !InGameTimerOnes                    ;;DB94|DB94+DB94/DB94\DB94;
                      CMP.B #$05                                ;;DB97|DB97+DB97/DB97\DB97;
                      BMI CODE_05DBA6                           ;;DB99|DB99+DB99/DB99\DB99;
CODE_05DB9B:          LDX.B #$0E                                ;;DB9B|DB9B+DB9B/DB9B\DB9B;
                      LDA.W !InGameTimerTens                    ;;DB9D|DB9D+DB9D/DB9D\DB9D;
                      CMP.B #$05                                ;;DBA0|DBA0+DBA0/DBA0\DBA0;
                      BMI CODE_05DBA6                           ;;DBA2|DBA2+DBA2/DBA2\DBA2;
                      LDX.B #$10                                ;;DBA4|DBA4+DBA4/DBA4\DBA4;
CODE_05DBA6:          JMP CODE_05DB49                           ;;DBA6|DBA6+DBA6/DBA6\DBA6;
                                                                ;;                        ;
                                                                ;;                        ;
DATA_05DBA9:          db $00,$C8,$00                            ;;DBA9|DBA9+DBA9/DBA9\DBA9;
                                                                ;;                        ;
CODE_05DBAC:          LDY.B #$00                                ;;DBAC|DBAC+DBAC/DBAC\DBAC;
                      LDA.W !YoshiHeavenFlag                    ;;DBAE|DBAE+DBAE/DBAE\DBAE;
                      BEQ +                                     ;;DBB1|DBB1+DBB1/DBB1\DBB1;
                      LDY.B #$01                                ;;DBB3|DBB3+DBB3/DBB3\DBB3;
                    + LDX.B !PlayerXPosNext+1                   ;;DBB5|DBB5+DBB5/DBB5\DBB5;
                      LDA.B !ScreenMode                         ;;DBB7|DBB7+DBB7/DBB7\DBB7;
                      AND.B #$01                                ;;DBB9|DBB9+DBB9/DBB9\DBB9;
                      BEQ +                                     ;;DBBB|DBBB+DBBB/DBBB\DBBB;
                      LDX.B !PlayerYPosNext+1                   ;;DBBD|DBBD+DBBD/DBBD\DBBD;
                    + LDA.W DATA_05DBA9,Y                       ;;DBBF|DBBF+DBBF/DBBF\DBBF;
                      STA.W !ExitTableLow,X                     ;;DBC2|DBC2+DBC2/DBC2\DBC2;
                      INC.W !SublevelCount                      ;;DBC5|DBC5+DBC5/DBC5\DBC5;
                      RTS                                       ;;DBC8|DBC8+DBC8/DBC8\DBC8; Return
                                                                ;;                        ;
                                                                ;;                        ;
DATA_05DBC9:          db $50,$88,$00,$03,$FE,$38,$FE,$38        ;;DBC9|DBC9+DBC9/DBC9\DBC9;
                      db $FF,$B8,$3C,$B9,$3C,$BA,$3C,$BB        ;;DBD1|DBD1+DBD1/DBD1\DBD1;
                      db $3C,$BA,$3C,$BA,$BC,$BC,$3C,$BD        ;;DBD9|DBD9+DBD9/DBD9\DBD9;
                      db $3C,$BE,$3C,$BF,$3C,$C0,$3C,$B7        ;;DBE1|DBE1+DBE1/DBE1\DBE1;
                      db $BC,$C1,$3C,$B9,$3C,$C2,$3C,$C2        ;;DBE9|DBE9+DBE9/DBE9\DBE9;
                      db $BC                                    ;;DBF1|DBF1+DBF1/DBF1\DBF1;
                                                                ;;                        ;
CODE_05DBF2:          PHB                                       ;;DBF2|DBF2+DBF2/DBF2\DBF2;
                      PHK                                       ;;DBF3|DBF3+DBF3/DBF3\DBF3;
                      PLB                                       ;;DBF4|DBF4+DBF4/DBF4\DBF4;
                      LDX.B #$08                                ;;DBF5|DBF5+DBF5/DBF5\DBF5;
                    - LDA.W DATA_05DBC9,X                       ;;DBF7|DBF7+DBF7/DBF7\DBF7;
                      STA.L !DynamicStripeImage,X               ;;DBFA|DBFA+DBFA/DBFA\DBFA;
                      DEX                                       ;;DBFE|DBFE+DBFE/DBFE\DBFE;
                      BPL -                                     ;;DBFF|DBFF+DBFF/DBFF\DBFF;
                      LDX.B #$00                                ;;DC01|DC01+DC01/DC01\DC01;
                      LDA.W !PlayerTurnLvl                      ;;DC03|DC03+DC03/DC03\DC03;
                      BEQ +                                     ;;DC06|DC06+DC06/DC06\DC06;
                      LDX.B #$01                                ;;DC08|DC08+DC08/DC08\DC08;
                    + LDA.W !SavedPlayerLives,X                 ;;DC0A|DC0A+DC0A/DC0A\DC0A;
                      INC A                                     ;;DC0D|DC0D+DC0D/DC0D\DC0D;
                      JSR CODE_05DC3A                           ;;DC0E|DC0E+DC0E/DC0E\DC0E;
                      CPX.B #$00                                ;;DC11|DC11+DC11/DC11\DC11;
                      BEQ +                                     ;;DC13|DC13+DC13/DC13\DC13;
                      CLC                                       ;;DC15|DC15+DC15/DC15\DC15;
                      ADC.B #$22                                ;;DC16|DC16+DC16/DC16\DC16;
                      STA.L !DynamicStripeImage+6               ;;DC18|DC18+DC18/DC18\DC18;
                      LDA.B #$39                                ;;DC1C|DC1C+DC1C/DC1C\DC1C;
                      STA.L !DynamicStripeImage+7               ;;DC1E|DC1E+DC1E/DC1E\DC1E;
                      TXA                                       ;;DC22|DC22+DC22/DC22\DC22;
                    + CLC                                       ;;DC23|DC23+DC23/DC23\DC23;
                      ADC.B #$22                                ;;DC24|DC24+DC24/DC24\DC24;
                      STA.L !DynamicStripeImage+4               ;;DC26|DC26+DC26/DC26\DC26;
                      LDA.B #$39                                ;;DC2A|DC2A+DC2A/DC2A\DC2A;
                      STA.L !DynamicStripeImage+5               ;;DC2C|DC2C+DC2C/DC2C\DC2C;
                      LDA.B #$08                                ;;DC30|DC30+DC30/DC30\DC30;
                      STA.L !DynStripeImgSize                   ;;DC32|DC32+DC32/DC32\DC32;
                      SEP #$20                                  ;;DC36|DC36+DC36/DC36\DC36; Accum (8 bit)
                      PLB                                       ;;DC38|DC38+DC38/DC38\DC38;
                      RTL                                       ;;DC39|DC39+DC39/DC39\DC39; Return
                                                                ;;                        ;
CODE_05DC3A:          LDX.B #$00                                ;;DC3A|DC3A+DC3A/DC3A\DC3A;
CODE_05DC3C:          CMP.B #$0A                                ;;DC3C|DC3C+DC3C/DC3C\DC3C;
                      BCC Return05DC45                          ;;DC3E|DC3E+DC3E/DC3E\DC3E;
                      SBC.B #$0A                                ;;DC40|DC40+DC40/DC40\DC40;
                      INX                                       ;;DC42|DC42+DC42/DC42\DC42;
                      BRA CODE_05DC3C                           ;;DC43|DC43+DC43/DC43\DC43;
                                                                ;;                        ;
Return05DC45:         RTS                                       ;;DC45|DC45+DC45/DC45\DC45; Return
                                                                ;;                        ;
                      %insert_empty($3BA,$3BA,$3BA,$3BA,$3BA)   ;;DC46|DC46+DC46/DC46\DC46;
                                                                ;;                        ;
Layer1Ptrs:           dl BonusGameLevel                         ;;E000|E000+E000/E000\E000;
                      dl VS2Level001                            ;;E003|E003+E003/E003\E003;
                      dl VS3Level002                            ;;E006|E006+E006/E006\E006;
                      dl TSALevel003                            ;;E009|E009+E009/E009\E009;
                      dl DGHLevel004                            ;;E00C|E00C+E00C/E00C\E00C;
                      dl DP3Level005                            ;;E00F|E00F+E00F/E00F\E00F;
                      dl DP4Level006                            ;;E012|E012+E012/E012\E012;
                      dl C2Level007                             ;;E015|E015+E015/E015\E015;
                      dl GSPLevel008                            ;;E018|E018+E018/E018\E018;
                      dl DP2Level009                            ;;E01B|E01B+E01B/E01B\E01B;
                      dl DS1Level00A                            ;;E01E|E01E+E01E/E01E\E01E;
                      dl VFLevel00B                             ;;E021|E021+E021/E021\E021;
                      dl BB1Level00C                            ;;E024|E024+E024/E024\E024;
                      dl BB2Level00D                            ;;E027|E027+E027/E027\E027;
                      dl C4Level00E                             ;;E02A|E02A+E02A/E02A\E02A;
                      dl CBALevel00F                            ;;E02D|E02D+E02D/E02D\E02D;
                      dl CMLevel010                             ;;E030|E030+E030/E030\E030;
                      dl SLLevel011                             ;;E033|E033+E033/E033\E033;
                      dl TestLevel                              ;;E036|E036+E036/E036\E036;
                      dl DSHLevel013                            ;;E039|E039+E039/E039\E039;
                      dl YSPLevel014                            ;;E03C|E03C+E03C/E03C\E03C;
                      dl DP1Level015                            ;;E03F|E03F+E03F/E03F\E03F;
                      dl DP1Level015                            ;;E042|E042+E042/E042\E042;
                      dl DP1Level015                            ;;E045|E045+E045/E045\E045;
                      dl SGSLevel018                            ;;E048|E048+E048/E048\E048;
                      dl TestLevel                              ;;E04B|E04B+E04B/E04B\E04B;
                      dl C6Level01A                             ;;E04E|E04E+E04E/E04E\E04E;
                      dl CFLevel01B                             ;;E051|E051+E051/E051\E051;
                      dl CI5Level01C                            ;;E054|E054+E054/E054\E054;
                      dl CI4Level01D                            ;;E057|E057+E057/E057\E057;
                      dl TestLevel                              ;;E05A|E05A+E05A/E05A\E05A;
                      dl FFLevel01F                             ;;E05D|E05D+E05D/E05D\E05D;
                      dl C5Level020                             ;;E060|E060+E060/E060\E060;
                      dl CGHLevel021                            ;;E063|E063+E063/E063\E063;
                      dl CI1Level022                            ;;E066|E066+E066/E066\E066;
                      dl CI3Level023                            ;;E069|E069+E069/E069\E069;
                      dl CI2Level024                            ;;E06C|E06C+E06C/E06C\E06C;
                      dl TestLevel                              ;;E06F|E06F+E06F/E06F\E06F;
                      dl TestLevel                              ;;E072|E072+E072/E072\E072;
                      dl TestLevel                              ;;E075|E075+E075/E075\E075;
                      dl TestLevel                              ;;E078|E078+E078/E078\E078;
                      dl TestLevel                              ;;E07B|E07B+E07B/E07B\E07B;
                      dl TestLevel                              ;;E07E|E07E+E07E/E07E\E07E;
                      dl TestLevel                              ;;E081|E081+E081/E081\E081;
                      dl TestLevel                              ;;E084|E084+E084/E084\E084;
                      dl TestLevel                              ;;E087|E087+E087/E087\E087;
                      dl TestLevel                              ;;E08A|E08A+E08A/E08A\E08A;
                      dl TestLevel                              ;;E08D|E08D+E08D/E08D\E08D;
                      dl TestLevel                              ;;E090|E090+E090/E090\E090;
                      dl TestLevel                              ;;E093|E093+E093/E093\E093;
                      dl TestLevel                              ;;E096|E096+E096/E096\E096;
                      dl TestLevel                              ;;E099|E099+E099/E099\E099;
                      dl TestLevel                              ;;E09C|E09C+E09C/E09C\E09C;
                      dl TestLevel                              ;;E09F|E09F+E09F/E09F\E09F;
                      dl TestLevel                              ;;E0A2|E0A2+E0A2/E0A2\E0A2;
                      dl TestLevel                              ;;E0A5|E0A5+E0A5/E0A5\E0A5;
                      dl TestLevel                              ;;E0A8|E0A8+E0A8/E0A8\E0A8;
                      dl TestLevel                              ;;E0AB|E0AB+E0AB/E0AB\E0AB;
                      dl TestLevel                              ;;E0AE|E0AE+E0AE/E0AE\E0AE;
                      dl TestLevel                              ;;E0B1|E0B1+E0B1/E0B1\E0B1;
                      dl TestLevel                              ;;E0B4|E0B4+E0B4/E0B4\E0B4;
                      dl TestLevel                              ;;E0B7|E0B7+E0B7/E0B7\E0B7;
                      dl TestLevel                              ;;E0BA|E0BA+E0BA/E0BA\E0BA;
                      dl TestLevel                              ;;E0BD|E0BD+E0BD/E0BD\E0BD;
                      dl TestLevel                              ;;E0C0|E0C0+E0C0/E0C0\E0C0;
                      dl TestLevel                              ;;E0C3|E0C3+E0C3/E0C3\E0C3;
                      dl TestLevel                              ;;E0C6|E0C6+E0C6/E0C6\E0C6;
                      dl TestLevel                              ;;E0C9|E0C9+E0C9/E0C9\E0C9;
                      dl TestLevel                              ;;E0CC|E0CC+E0CC/E0CC\E0CC;
                      dl TestLevel                              ;;E0CF|E0CF+E0CF/E0CF\E0CF;
                      dl TestLevel                              ;;E0D2|E0D2+E0D2/E0D2\E0D2;
                      dl TestLevel                              ;;E0D5|E0D5+E0D5/E0D5\E0D5;
                      dl TestLevel                              ;;E0D8|E0D8+E0D8/E0D8\E0D8;
                      dl TestLevel                              ;;E0DB|E0DB+E0DB/E0DB\E0DB;
                      dl TestLevel                              ;;E0DE|E0DE+E0DE/E0DE\E0DE;
                      dl TestLevel                              ;;E0E1|E0E1+E0E1/E0E1\E0E1;
                      dl TestLevel                              ;;E0E4|E0E4+E0E4/E0E4\E0E4;
                      dl TestLevel                              ;;E0E7|E0E7+E0E7/E0E7\E0E7;
                      dl TestLevel                              ;;E0EA|E0EA+E0EA/E0EA\E0EA;
                      dl TestLevel                              ;;E0ED|E0ED+E0ED/E0ED\E0ED;
                      dl TestLevel                              ;;E0F0|E0F0+E0F0/E0F0\E0F0;
                      dl TestLevel                              ;;E0F3|E0F3+E0F3/E0F3\E0F3;
                      dl TestLevel                              ;;E0F6|E0F6+E0F6/E0F6\E0F6;
                      dl TestLevel                              ;;E0F9|E0F9+E0F9/E0F9\E0F9;
                      dl TestLevel                              ;;E0FC|E0FC+E0FC/E0FC\E0FC;
                      dl TestLevel                              ;;E0FF|E0FF+E0FF/E0FF\E0FF;
                      dl TestLevel                              ;;E102|E102+E102/E102\E102;
                      dl TestLevel                              ;;E105|E105+E105/E105\E105;
                      dl TestLevel                              ;;E108|E108+E108/E108\E108;
                      dl TestLevel                              ;;E10B|E10B+E10B/E10B\E10B;
                      dl TestLevel                              ;;E10E|E10E+E10E/E10E\E10E;
                      dl TestLevel                              ;;E111|E111+E111/E111\E111;
                      dl TestLevel                              ;;E114|E114+E114/E114\E114;
                      dl TestLevel                              ;;E117|E117+E117/E117\E117;
                      dl TestLevel                              ;;E11A|E11A+E11A/E11A\E11A;
                      dl TestLevel                              ;;E11D|E11D+E11D/E11D\E11D;
                      dl TestLevel                              ;;E120|E120+E120/E120\E120;
                      dl TestLevel                              ;;E123|E123+E123/E123\E123;
                      dl TestLevel                              ;;E126|E126+E126/E126\E126;
                      dl TestLevel                              ;;E129|E129+E129/E129\E129;
                      dl TestLevel                              ;;E12C|E12C+E12C/E12C\E12C;
                      dl TestLevel                              ;;E12F|E12F+E12F/E12F\E12F;
                      dl TestLevel                              ;;E132|E132+E132/E132\E132;
                      dl TestLevel                              ;;E135|E135+E135/E135\E135;
                      dl TestLevel                              ;;E138|E138+E138/E138\E138;
                      dl TestLevel                              ;;E13B|E13B+E13B/E13B\E13B;
                      dl TestLevel                              ;;E13E|E13E+E13E/E13E\E13E;
                      dl TestLevel                              ;;E141|E141+E141/E141\E141;
                      dl TestLevel                              ;;E144|E144+E144/E144\E144;
                      dl TestLevel                              ;;E147|E147+E147/E147\E147;
                      dl TestLevel                              ;;E14A|E14A+E14A/E14A\E14A;
                      dl TestLevel                              ;;E14D|E14D+E14D/E14D\E14D;
                      dl TestLevel                              ;;E150|E150+E150/E150\E150;
                      dl TestLevel                              ;;E153|E153+E153/E153\E153;
                      dl TestLevel                              ;;E156|E156+E156/E156\E156;
                      dl TestLevel                              ;;E159|E159+E159/E159\E159;
                      dl TestLevel                              ;;E15C|E15C+E15C/E15C\E15C;
                      dl TestLevel                              ;;E15F|E15F+E15F/E15F\E15F;
                      dl TestLevel                              ;;E162|E162+E162/E162\E162;
                      dl TestLevel                              ;;E165|E165+E165/E165\E165;
                      dl TestLevel                              ;;E168|E168+E168/E168\E168;
                      dl TestLevel                              ;;E16B|E16B+E16B/E16B\E16B;
                      dl TestLevel                              ;;E16E|E16E+E16E/E16E\E16E;
                      dl TestLevel                              ;;E171|E171+E171/E171\E171;
                      dl TestLevel                              ;;E174|E174+E174/E174\E174;
                      dl TestLevel                              ;;E177|E177+E177/E177\E177;
                      dl TestLevel                              ;;E17A|E17A+E17A/E17A\E17A;
                      dl TestLevel                              ;;E17D|E17D+E17D/E17D\E17D;
                      dl TestLevel                              ;;E180|E180+E180/E180\E180;
                      dl TestLevel                              ;;E183|E183+E183/E183\E183;
                      dl TestLevel                              ;;E186|E186+E186/E186\E186;
                      dl TestLevel                              ;;E189|E189+E189/E189\E189;
                      dl TestLevel                              ;;E18C|E18C+E18C/E18C\E18C;
                      dl TestLevel                              ;;E18F|E18F+E18F/E18F\E18F;
                      dl TestLevel                              ;;E192|E192+E192/E192\E192;
                      dl TestLevel                              ;;E195|E195+E195/E195\E195;
                      dl TestLevel                              ;;E198|E198+E198/E198\E198;
                      dl TestLevel                              ;;E19B|E19B+E19B/E19B\E19B;
                      dl TestLevel                              ;;E19E|E19E+E19E/E19E\E19E;
                      dl TestLevel                              ;;E1A1|E1A1+E1A1/E1A1\E1A1;
                      dl TestLevel                              ;;E1A4|E1A4+E1A4/E1A4\E1A4;
                      dl TestLevel                              ;;E1A7|E1A7+E1A7/E1A7\E1A7;
                      dl TestLevel                              ;;E1AA|E1AA+E1AA/E1AA\E1AA;
                      dl TestLevel                              ;;E1AD|E1AD+E1AD/E1AD\E1AD;
                      dl TestLevel                              ;;E1B0|E1B0+E1B0/E1B0\E1B0;
                      dl TestLevel                              ;;E1B3|E1B3+E1B3/E1B3\E1B3;
                      dl TestLevel                              ;;E1B6|E1B6+E1B6/E1B6\E1B6;
                      dl LemmyCopyLevel                         ;;E1B9|E1B9+E1B9/E1B9\E1B9;
                      dl WendyCopyLevel                         ;;E1BC|E1BC+E1BC/E1BC\E1BC;
                      dl Mode7BossCopyLevel                     ;;E1BF|E1BF+E1BF/E1BF\E1BF;
                      dl LarryIggyCopyLevel                     ;;E1C2|E1C2+E1C2/E1C2\E1C2;
                      dl LarryIggyCopyLevel                     ;;E1C5|E1C5+E1C5/E1C5\E1C5;
                      dl Mode7BossCopyLevel                     ;;E1C8|E1C8+E1C8/E1C8\E1C8;
                      dl Mode7BossCopyLevel                     ;;E1CB|E1CB+E1CB/E1CB\E1CB;
                      dl Mode7BossCopyLevel                     ;;E1CE|E1CE+E1CE/E1CE\E1CE;
                      dl BowserCopyLevel                        ;;E1D1|E1D1+E1D1/E1D1\E1D1;
                      dl TestLevel                              ;;E1D4|E1D4+E1D4/E1D4\E1D4;
                      dl TestLevel                              ;;E1D7|E1D7+E1D7/E1D7\E1D7;
                      dl TestLevel                              ;;E1DA|E1DA+E1DA/E1DA\E1DA;
                      dl TestLevel                              ;;E1DD|E1DD+E1DD/E1DD\E1DD;
                      dl TestLevel                              ;;E1E0|E1E0+E1E0/E1E0\E1E0;
                      dl TestLevel                              ;;E1E3|E1E3+E1E3/E1E3\E1E3;
                      dl TestLevel                              ;;E1E6|E1E6+E1E6/E1E6\E1E6;
                      dl TestLevel                              ;;E1E9|E1E9+E1E9/E1E9\E1E9;
                      dl TestLevel                              ;;E1EC|E1EC+E1EC/E1EC\E1EC;
                      dl TestLevel                              ;;E1EF|E1EF+E1EF/E1EF\E1EF;
                      dl TestLevel                              ;;E1F2|E1F2+E1F2/E1F2\E1F2;
                      dl TestLevel                              ;;E1F5|E1F5+E1F5/E1F5\E1F5;
                      dl TestLevel                              ;;E1F8|E1F8+E1F8/E1F8\E1F8;
                      dl TestLevel                              ;;E1FB|E1FB+E1FB/E1FB\E1FB;
                      dl TestLevel                              ;;E1FE|E1FE+E1FE/E1FE\E1FE;
                      dl TestLevel                              ;;E201|E201+E201/E201\E201;
                      dl TestLevel                              ;;E204|E204+E204/E204\E204;
                      dl TestLevel                              ;;E207|E207+E207/E207\E207;
                      dl TestLevel                              ;;E20A|E20A+E20A/E20A\E20A;
                      dl TestLevel                              ;;E20D|E20D+E20D/E20D\E20D;
                      dl TestLevel                              ;;E210|E210+E210/E210\E210;
                      dl TestLevel                              ;;E213|E213+E213/E213\E213;
                      dl TestLevel                              ;;E216|E216+E216/E216\E216;
                      dl TestLevel                              ;;E219|E219+E219/E219\E219;
                      dl TestLevel                              ;;E21C|E21C+E21C/E21C\E21C;
                      dl TestLevel                              ;;E21F|E21F+E21F/E21F\E21F;
                      dl TestLevel                              ;;E222|E222+E222/E222\E222;
                      dl TestLevel                              ;;E225|E225+E225/E225\E225;
                      dl TestLevel                              ;;E228|E228+E228/E228\E228;
                      dl TestLevel                              ;;E22B|E22B+E22B/E22B\E22B;
                      dl TestLevel                              ;;E22E|E22E+E22E/E22E\E22E;
                      dl TestLevel                              ;;E231|E231+E231/E231\E231;
                      dl TestLevel                              ;;E234|E234+E234/E234\E234;
                      dl CI5Sub1Level0BD                        ;;E237|E237+E237/E237\E237;
                      dl CI1Sub2Level0BE                        ;;E23A|E23A+E23A/E23A\E23A;
                      dl CBASub1Level0BF                        ;;E23D|E23D+E23D/E23D\E23D;
                      dl CI5Sub2Level0C0                        ;;E240|E240+E240/E240\E240;
                      dl CMSub1Level0C1                         ;;E243|E243+E243/E243\E243;
                      dl DS1Sub1Level0C2                        ;;E246|E246+E246/E246\E246;
                      dl DP4Sub1Level0C3                        ;;E249|E249+E249/E249\E249;
                      dl DGHSub4Level0C4                        ;;E24C|E24C+E24C/E24C\E24C;
                      dl IntroLevel0C5                          ;;E24F|E24F+E24F/E24F\E24F;
                      dl SLSub1Level0C6                         ;;E252|E252+E252/E252\E252;
                      dl TitleScrLevel0C7                       ;;E255|E255+E255/E255\E255;
                      dl YoshiWingsLevel0C8                     ;;E258|E258+E258/E258\E258;
                      dl GSPSub1Level0C9                        ;;E25B|E25B+E25B/E25B\E25B;
                      dl YSPSub1Level0CA                        ;;E25E|E25E+E25E/E25E\E25E;
                      dl VS3Sub1Level0CB                        ;;E261|E261+E261/E261\E261;
                      dl Mode7BossLayer1                        ;;E264|E264+E264/E264\E264;
                      dl CI2Sub8Level0CD                        ;;E267|E267+E267/E267\E267;
                      dl CI2Sub4Level0CE                        ;;E26A|E26A+E26A/E26A\E26A;
                      dl CI2Sub3Level0CF                        ;;E26D|E26D+E26D/E26D\E26D;
                      dl CI1Level022                            ;;E270|E270+E270/E270\E270;
                      dl CI1Level022                            ;;E273|E273+E273/E273\E273;
                      dl DP4Sub1Level0D2                        ;;E276|E276+E276/E276\E276;
                      dl C6Sub2Level0D3                         ;;E279|E279+E279/E279\E279;
                      dl C6Sub1Level0D4                         ;;E27C|E27C+E27C/E27C\E27C;
                      dl Mode7BossLayer1                        ;;E27F|E27F+E27F/E27F\E27F;
                      dl FFSub1Level0D6                         ;;E282|E282+E282/E282\E282;
                      dl CI3Sub1Level0D7                        ;;E285|E285+E285/E285\E285;
                      dl VS2Sub1Level0D8                        ;;E288|E288+E288/E288\E288;
                      dl Mode7BossLayer1                        ;;E28B|E28B+E28B/E28B\E28B;
                      dl C4Sub1Level0DA                         ;;E28E|E28E+E28E/E28E\E28E;
                      dl C4Sub3Level0DB                         ;;E291|E291+E291/E291\E291;
                      dl C4Sub2Level0DC                         ;;E294|E294+E294/E294\E294;
                      dl BB2Sub1Level0DD                        ;;E297|E297+E297/E297\E297;
                      dl DGHSub1Level0F9                        ;;E29A|E29A+E29A/E29A\E29A;
                      dl Mode7BossLayer1                        ;;E29D|E29D+E29D/E29D\E29D;
                      dl VFSub1Level0E0                         ;;E2A0|E2A0+E2A0/E2A0\E2A0;
                      dl VFSub1Level0E0                         ;;E2A3|E2A3+E2A3/E2A3\E2A3;
                      dl Mode7BossLayer1                        ;;E2A6|E2A6+E2A6/E2A6\E2A6;
                      dl DP1Sub2Level0E3                        ;;E2A9|E2A9+E2A9/E2A9\E2A9;
                      dl DSHSub4Level0E4                        ;;E2AC|E2AC+E2AC/E2AC\E2AC;
                      dl Mode7BossLayer1                        ;;E2AF|E2AF+E2AF/E2AF\E2AF;
                      dl C2Sub1Level0E6                         ;;E2B2|E2B2+E2B2/E2B2\E2B2;
                      dl C2Sub3Level0E7                         ;;E2B5|E2B5+E2B5/E2B5\E2B5;
                      dl C2Sub2Level0E8                         ;;E2B8|E2B8+E2B8/E2B8\E2B8;
                      dl DP2Sub1Level0E9                        ;;E2BB|E2BB+E2BB/E2BB\E2BB;
                      dl CI4Sub1Level0EA                        ;;E2BE|E2BE+E2BE/E2BE\E2BE;
                      dl GhostHouseExitLevel                    ;;E2C1|E2C1+E2C1/E2C1\E2C1;
                      dl DSHLevel013                            ;;E2C4|E2C4+E2C4/E2C4\E2C4;
                      dl DSHSub1Level0ED                        ;;E2C7|E2C7+E2C7/E2C7\E2C7;
                      dl DSHLevel013                            ;;E2CA|E2CA+E2CA/E2CA\E2CA;
                      dl CFSub1Level0EF                         ;;E2CD|E2CD+E2CD/E2CD\E2CD;
                      dl GhostHouseExitLevel                    ;;E2D0|E2D0+E2D0/E2D0\E2D0;
                      dl DSHSub2Level0F1                        ;;E2D3|E2D3+E2D3/E2D3\E2D3;
                      dl DSHSub1Level0ED                        ;;E2D6|E2D6+E2D6/E2D6\E2D6;
                      dl BB1Sub1Level0F3                        ;;E2D9|E2D9+E2D9/E2D9\E2D9;
                      dl DP3Sub1Level0F4                        ;;E2DC|E2DC+E2DC/E2DC\E2DC;
                      dl CI1Sub1Level0F5                        ;;E2DF|E2DF+E2DF/E2DF\E2DF;
                      dl CI1Sub1Level0F5                        ;;E2E2|E2E2+E2E2/E2E2\E2E2;
                      dl SGSSub2Level0F7                        ;;E2E5|E2E5+E2E5/E2E5\E2E5;
                      dl SGSSub1Level0F8                        ;;E2E8|E2E8+E2E8/E2E8\E2E8;
                      dl DGHSub1Level0F9                        ;;E2EB|E2EB+E2EB/E2EB\E2EB;
                      dl DGHSub3Level0FA                        ;;E2EE|E2EE+E2EE/E2EE\E2EE;
                      dl GhostHouseExitLevel                    ;;E2F1|E2F1+E2F1/E2F1\E2F1;
                      dl CGHSub1Level0FC                        ;;E2F4|E2F4+E2F4/E2F4\E2F4;
                      dl DP1Sub1Level0FD                        ;;E2F7|E2F7+E2F7/E2F7\E2F7;
                      dl DGHSub2Level0FE                        ;;E2FA|E2FA+E2FA/E2FA\E2FA;
                      dl DP2Sub2Level0FF                        ;;E2FD|E2FD+E2FD/E2FD\E2FD;
                      dl BonusGameLevel                         ;;E300|E300+E300/E300\E300;
                      dl C1Level101                             ;;E303|E303+E303/E303\E303;
                      dl YI4Level102                            ;;E306|E306+E306/E306\E306;
                      dl YI3Level103                            ;;E309|E309+E309/E309\E309;
                      dl YHLevel104                             ;;E30C|E30C+E30C/E30C\E30C;
                      dl YI1Level105                            ;;E30F|E30F+E30F/E30F\E30F;
                      dl YI2Level106                            ;;E312|E312+E312/E312\E312;
                      dl VGHLevel107                            ;;E315|E315+E315/E315\E315;
                      dl SlopeTestLevel108                      ;;E318|E318+E318/E318\E318;
                      dl VS1Level109                            ;;E31B|E31B+E31B/E31B\E31B;
                      dl VD3Level10A                            ;;E31E|E31E+E31E/E31E\E31E;
                      dl DS2Level10B                            ;;E321|E321+E321/E321\E321;
                      dl TestLevel                              ;;E324|E324+E324/E324\E324;
                      dl FDLevel10D                             ;;E327|E327+E327/E327\E327;
                      dl BDLevel10E                             ;;E32A|E32A+E32A/E32A\E32A;
                      dl VoB4Level10F                           ;;E32D|E32D+E32D/E32D\E32D;
                      dl C7Level110                             ;;E330|E330+E330/E330\E330;
                      dl VoBFLevel111                           ;;E333|E333+E333/E333\E333;
                      dl TestLevel                              ;;E336|E336+E336/E336\E336;
                      dl VoB3Level113                           ;;E339|E339+E339/E339\E339;
                      dl VoBGHLevel114                          ;;E33C|E33C+E33C/E33C\E33C;
                      dl VoB2Level115                           ;;E33F|E33F+E33F/E33F\E33F;
                      dl VoB1Level116                           ;;E342|E342+E342/E342\E342;
                      dl CSLevel117                             ;;E345|E345+E345/E345\E345;
                      dl VD2Level118                            ;;E348|E348+E348/E348\E348;
                      dl VD4Level119                            ;;E34B|E34B+E34B/E34B\E34B;
                      dl VD1Level11A                            ;;E34E|E34E+E34E/E34E\E34E;
                      dl RSPLevel11B                            ;;E351|E351+E351/E351\E351;
                      dl C3Level11C                             ;;E354|E354+E354/E354\E354;
                      dl FGHLevel11D                            ;;E357|E357+E357/E357\E357;
                      dl FoI1Level11E                           ;;E35A|E35A+E35A/E35A\E35A;
                      dl FoI4Level11F                           ;;E35D|E35D+E35D/E35D\E35D;
                      dl FoI2Level120                           ;;E360|E360+E360/E360\E360;
                      dl BSPLevel121                            ;;E363|E363+E363/E363\E363;
                      dl FSALevel122                            ;;E366|E366+E366/E366\E366;
                      dl FoI3Level123                           ;;E369|E369+E369/E369\E369;
                      dl TestLevel                              ;;E36C|E36C+E36C/E36C\E36C;
                      dl FunkyLevel125                          ;;E36F|E36F+E36F/E36F\E36F;
                      dl OutrageousLevel126                     ;;E372|E372+E372/E372\E372;
                      dl MondoLevel127                          ;;E375|E375+E375/E375\E375;
                      dl GroovyLevel128                         ;;E378|E378+E378/E378\E378;
                      dl TestLevel                              ;;E37B|E37B+E37B/E37B\E37B;
                      dl GnarlyLevel12A                         ;;E37E|E37E+E37E/E37E\E37E;
                      dl TubularLevel12B                        ;;E381|E381+E381/E381\E381;
                      dl WayCoolLevel12C                        ;;E384|E384+E384/E384\E384;
                      dl AwesomeLevel12D                        ;;E387|E387+E387/E387\E387;
                      dl TestLevel                              ;;E38A|E38A+E38A/E38A\E38A;
                      dl TestLevel                              ;;E38D|E38D+E38D/E38D\E38D;
                      dl SW2Level130                            ;;E390|E390+E390/E390\E390;
                      dl TestLevel                              ;;E393|E393+E393/E393\E393;
                      dl SW3Level132                            ;;E396|E396+E396/E396\E396;
                      dl TestLevel                              ;;E399|E399+E399/E399\E399;
                      dl SW1Level134                            ;;E39C|E39C+E39C/E39C\E39C;
                      dl SW4Level135                            ;;E39F|E39F+E39F/E39F\E39F;
                      dl SW5Level136                            ;;E3A2|E3A2+E3A2/E3A2\E3A2;
                      dl TestLevel                              ;;E3A5|E3A5+E3A5/E3A5\E3A5;
                      dl TestLevel                              ;;E3A8|E3A8+E3A8/E3A8\E3A8;
                      dl TestLevel                              ;;E3AB|E3AB+E3AB/E3AB\E3AB;
                      dl TestLevel                              ;;E3AE|E3AE+E3AE/E3AE\E3AE;
                      dl TestLevel                              ;;E3B1|E3B1+E3B1/E3B1\E3B1;
                      dl TestLevel                              ;;E3B4|E3B4+E3B4/E3B4\E3B4;
                      dl TestLevel                              ;;E3B7|E3B7+E3B7/E3B7\E3B7;
                      dl TestLevel                              ;;E3BA|E3BA+E3BA/E3BA\E3BA;
                      dl TestLevel                              ;;E3BD|E3BD+E3BD/E3BD\E3BD;
                      dl TestLevel                              ;;E3C0|E3C0+E3C0/E3C0\E3C0;
                      dl TestLevel                              ;;E3C3|E3C3+E3C3/E3C3\E3C3;
                      dl TestLevel                              ;;E3C6|E3C6+E3C6/E3C6\E3C6;
                      dl TestLevel                              ;;E3C9|E3C9+E3C9/E3C9\E3C9;
                      dl TestLevel                              ;;E3CC|E3CC+E3CC/E3CC\E3CC;
                      dl TestLevel                              ;;E3CF|E3CF+E3CF/E3CF\E3CF;
                      dl TestLevel                              ;;E3D2|E3D2+E3D2/E3D2\E3D2;
                      dl TestLevel                              ;;E3D5|E3D5+E3D5/E3D5\E3D5;
                      dl TestLevel                              ;;E3D8|E3D8+E3D8/E3D8\E3D8;
                      dl TestLevel                              ;;E3DB|E3DB+E3DB/E3DB\E3DB;
                      dl TestLevel                              ;;E3DE|E3DE+E3DE/E3DE\E3DE;
                      dl TestLevel                              ;;E3E1|E3E1+E3E1/E3E1\E3E1;
                      dl TestLevel                              ;;E3E4|E3E4+E3E4/E3E4\E3E4;
                      dl TestLevel                              ;;E3E7|E3E7+E3E7/E3E7\E3E7;
                      dl TestLevel                              ;;E3EA|E3EA+E3EA/E3EA\E3EA;
                      dl TestLevel                              ;;E3ED|E3ED+E3ED/E3ED\E3ED;
                      dl TestLevel                              ;;E3F0|E3F0+E3F0/E3F0\E3F0;
                      dl TestLevel                              ;;E3F3|E3F3+E3F3/E3F3\E3F3;
                      dl TestLevel                              ;;E3F6|E3F6+E3F6/E3F6\E3F6;
                      dl TestLevel                              ;;E3F9|E3F9+E3F9/E3F9\E3F9;
                      dl TestLevel                              ;;E3FC|E3FC+E3FC/E3FC\E3FC;
                      dl TestLevel                              ;;E3FF|E3FF+E3FF/E3FF\E3FF;
                      dl TestLevel                              ;;E402|E402+E402/E402\E402;
                      dl TestLevel                              ;;E405|E405+E405/E405\E405;
                      dl TestLevel                              ;;E408|E408+E408/E408\E408;
                      dl TestLevel                              ;;E40B|E40B+E40B/E40B\E40B;
                      dl TestLevel                              ;;E40E|E40E+E40E/E40E\E40E;
                      dl TestLevel                              ;;E411|E411+E411/E411\E411;
                      dl TestLevel                              ;;E414|E414+E414/E414\E414;
                      dl TestLevel                              ;;E417|E417+E417/E417\E417;
                      dl TestLevel                              ;;E41A|E41A+E41A/E41A\E41A;
                      dl TestLevel                              ;;E41D|E41D+E41D/E41D\E41D;
                      dl TestLevel                              ;;E420|E420+E420/E420\E420;
                      dl TestLevel                              ;;E423|E423+E423/E423\E423;
                      dl TestLevel                              ;;E426|E426+E426/E426\E426;
                      dl TestLevel                              ;;E429|E429+E429/E429\E429;
                      dl TestLevel                              ;;E42C|E42C+E42C/E42C\E42C;
                      dl TestLevel                              ;;E42F|E42F+E42F/E42F\E42F;
                      dl TestLevel                              ;;E432|E432+E432/E432\E432;
                      dl TestLevel                              ;;E435|E435+E435/E435\E435;
                      dl TestLevel                              ;;E438|E438+E438/E438\E438;
                      dl TestLevel                              ;;E43B|E43B+E43B/E43B\E43B;
                      dl TestLevel                              ;;E43E|E43E+E43E/E43E\E43E;
                      dl TestLevel                              ;;E441|E441+E441/E441\E441;
                      dl TestLevel                              ;;E444|E444+E444/E444\E444;
                      dl TestLevel                              ;;E447|E447+E447/E447\E447;
                      dl TestLevel                              ;;E44A|E44A+E44A/E44A\E44A;
                      dl TestLevel                              ;;E44D|E44D+E44D/E44D\E44D;
                      dl TestLevel                              ;;E450|E450+E450/E450\E450;
                      dl TestLevel                              ;;E453|E453+E453/E453\E453;
                      dl TestLevel                              ;;E456|E456+E456/E456\E456;
                      dl TestLevel                              ;;E459|E459+E459/E459\E459;
                      dl TestLevel                              ;;E45C|E45C+E45C/E45C\E45C;
                      dl TestLevel                              ;;E45F|E45F+E45F/E45F\E45F;
                      dl TestLevel                              ;;E462|E462+E462/E462\E462;
                      dl TestLevel                              ;;E465|E465+E465/E465\E465;
                      dl TestLevel                              ;;E468|E468+E468/E468\E468;
                      dl TestLevel                              ;;E46B|E46B+E46B/E46B\E46B;
                      dl TestLevel                              ;;E46E|E46E+E46E/E46E\E46E;
                      dl TestLevel                              ;;E471|E471+E471/E471\E471;
                      dl TestLevel                              ;;E474|E474+E474/E474\E474;
                      dl TestLevel                              ;;E477|E477+E477/E477\E477;
                      dl TestLevel                              ;;E47A|E47A+E47A/E47A\E47A;
                      dl TestLevel                              ;;E47D|E47D+E47D/E47D\E47D;
                      dl TestLevel                              ;;E480|E480+E480/E480\E480;
                      dl TestLevel                              ;;E483|E483+E483/E483\E483;
                      dl TestLevel                              ;;E486|E486+E486/E486\E486;
                      dl TestLevel                              ;;E489|E489+E489/E489\E489;
                      dl TestLevel                              ;;E48C|E48C+E48C/E48C\E48C;
                      dl TestLevel                              ;;E48F|E48F+E48F/E48F\E48F;
                      dl TestLevel                              ;;E492|E492+E492/E492\E492;
                      dl TestLevel                              ;;E495|E495+E495/E495\E495;
                      dl TestLevel                              ;;E498|E498+E498/E498\E498;
                      dl TestLevel                              ;;E49B|E49B+E49B/E49B\E49B;
                      dl TestLevel                              ;;E49E|E49E+E49E/E49E\E49E;
                      dl TestLevel                              ;;E4A1|E4A1+E4A1/E4A1\E4A1;
                      dl TestLevel                              ;;E4A4|E4A4+E4A4/E4A4\E4A4;
                      dl TestLevel                              ;;E4A7|E4A7+E4A7/E4A7\E4A7;
                      dl TestLevel                              ;;E4AA|E4AA+E4AA/E4AA\E4AA;
                      dl TestLevel                              ;;E4AD|E4AD+E4AD/E4AD\E4AD;
                      dl TestLevel                              ;;E4B0|E4B0+E4B0/E4B0\E4B0;
                      dl TestLevel                              ;;E4B3|E4B3+E4B3/E4B3\E4B3;
                      dl TestLevel                              ;;E4B6|E4B6+E4B6/E4B6\E4B6;
                      dl WendyCopyLevel                         ;;E4B9|E4B9+E4B9/E4B9\E4B9;
                      dl LemmyCopyLevel                         ;;E4BC|E4BC+E4BC/E4BC\E4BC;
                      dl Mode7BossCopyLevel                     ;;E4BF|E4BF+E4BF/E4BF\E4BF;
                      dl LarryIggyCopyLevel                     ;;E4C2|E4C2+E4C2/E4C2\E4C2;
                      dl LarryIggyCopyLevel                     ;;E4C5|E4C5+E4C5/E4C5\E4C5;
                      dl Mode7BossCopyLevel                     ;;E4C8|E4C8+E4C8/E4C8\E4C8;
                      dl Mode7BossCopyLevel                     ;;E4CB|E4CB+E4CB/E4CB\E4CB;
                      dl Mode7BossCopyLevel                     ;;E4CE|E4CE+E4CE/E4CE\E4CE;
                      dl BowserCopyLevel                        ;;E4D1|E4D1+E4D1/E4D1\E4D1;
                      dl TestLevel                              ;;E4D4|E4D4+E4D4/E4D4\E4D4;
                      dl TestLevel                              ;;E4D7|E4D7+E4D7/E4D7\E4D7;
                      dl TestLevel                              ;;E4DA|E4DA+E4DA/E4DA\E4DA;
                      dl TestLevel                              ;;E4DD|E4DD+E4DD/E4DD\E4DD;
                      dl TestLevel                              ;;E4E0|E4E0+E4E0/E4E0\E4E0;
                      dl TestLevel                              ;;E4E3|E4E3+E4E3/E4E3\E4E3;
                      dl TestLevel                              ;;E4E6|E4E6+E4E6/E4E6\E4E6;
                      dl TestLevel                              ;;E4E9|E4E9+E4E9/E4E9\E4E9;
                      dl TestLevel                              ;;E4EC|E4EC+E4EC/E4EC\E4EC;
                      dl TestLevel                              ;;E4EF|E4EF+E4EF/E4EF\E4EF;
                      dl TestLevel                              ;;E4F2|E4F2+E4F2/E4F2\E4F2;
                      dl TestLevel                              ;;E4F5|E4F5+E4F5/E4F5\E4F5;
                      dl TestLevel                              ;;E4F8|E4F8+E4F8/E4F8\E4F8;
                      dl TestLevel                              ;;E4FB|E4FB+E4FB/E4FB\E4FB;
                      dl TestLevel                              ;;E4FE|E4FE+E4FE/E4FE\E4FE;
                      dl TestLevel                              ;;E501|E501+E501/E501\E501;
                      dl TestLevel                              ;;E504|E504+E504/E504\E504;
                      dl TestLevel                              ;;E507|E507+E507/E507\E507;
                      dl TestLevel                              ;;E50A|E50A+E50A/E50A\E50A;
                      dl TestLevel                              ;;E50D|E50D+E50D/E50D\E50D;
                      dl TestLevel                              ;;E510|E510+E510/E510\E510;
                      dl TestLevel                              ;;E513|E513+E513/E513\E513;
                      dl TestLevel                              ;;E516|E516+E516/E516\E516;
                      dl TestLevel                              ;;E519|E519+E519/E519\E519;
                      dl TestLevel                              ;;E51C|E51C+E51C/E51C\E51C;
                      dl TestLevel                              ;;E51F|E51F+E51F/E51F\E51F;
                      dl TestLevel                              ;;E522|E522+E522/E522\E522;
                      dl TestLevel                              ;;E525|E525+E525/E525\E525;
                      dl TestLevel                              ;;E528|E528+E528/E528\E528;
                      dl TestLevel                              ;;E52B|E52B+E52B/E52B\E52B;
                      dl TestLevel                              ;;E52E|E52E+E52E/E52E\E52E;
                      dl VoB3Sub1Level1BB                       ;;E531|E531+E531/E531\E531;
                      dl FoI3Sub1Level1BC                       ;;E534|E534+E534/E534\E534;
                      dl FDSub10Level1BD                        ;;E537|E537+E537/E537\E537;
                      dl YI4Sub1Level1BE                        ;;E53A|E53A+E53A/E53A\E53A;
                      dl VoB4Sub1Level1BF                       ;;E53D|E53D+E53D/E53D\E53D;
                      dl CSSub1Level1C0                         ;;E540|E540+E540/E540\E540;
                      dl FoI4Sub1Level1C1                       ;;E543|E543+E543/E543\E543;
                      dl VD3Sub2Level1C2                        ;;E546|E546+E546/E546\E546;
                      dl VD2Sub1Level1C3                        ;;E549|E549+E549/E549\E549;
                      dl GnarlySub1Level1C4                     ;;E54C|E54C+E54C/E54C\E54C;
                      dl GnarlySub1Level1C4                     ;;E54F|E54F+E54F/E54F\E54F;
                      dl DS2Sub1Level1C6                        ;;E552|E552+E552/E552\E552;
                      dl BowserLevel1C7                         ;;E555|E555+E555/E555\E555;
                      dl YoshiWingsLevel1C8                     ;;E558|E558+E558/E558\E558;
                      dl WayCoolSub1Level1C9                    ;;E55B|E55B+E55B/E55B\E55B;
                      dl YI2Sub1Level1CA                        ;;E55E|E55E+E55E/E55E\E55E;
                      dl YI1Sub1Level1CB                        ;;E561|E561+E561/E561\E561;
                      dl FDSub8Level1CC                         ;;E564|E564+E564/E564\E564;
                      dl FDSub7Level1CD                         ;;E567|E567+E567/E567\E567;
                      dl FDSub6Level1CE                         ;;E56A|E56A+E56A/E56A\E56A;
                      dl FDSub5Level1CF                         ;;E56D|E56D+E56D/E56D\E56D;
                      dl FDSub9Level1D0                         ;;E570|E570+E570/E570\E570;
                      dl FDSub4Level1D1                         ;;E573|E573+E573/E573\E573;
                      dl FDSub3Level1D2                         ;;E576|E576+E576/E576\E576;
                      dl FDSub2Level1D3                         ;;E579|E579+E579/E579\E579;
                      dl FDSub1Level1D4                         ;;E57C|E57C+E57C/E57C\E57C;
                      dl SW2Sub1Level1D5                        ;;E57F|E57F+E57F/E57F\E57F;
                      dl SW1Sub1Level1D6                        ;;E582|E582+E582/E582\E582;
                      dl BSPSub1Level1D7                        ;;E585|E585+E585/E585\E585;
                      dl RSPSub1Level1D8                        ;;E588|E588+E588/E588\E588;
                      dl VoBGHLevel114                          ;;E58B|E58B+E58B/E58B\E58B;
                      dl GhostHouseExitLevel                    ;;E58E|E58E+E58E/E58E\E58E;
                      dl VoBGHSub2Level1DB                      ;;E591|E591+E591/E591\E591;
                      dl VoBGHSub2Level1DB                      ;;E594|E594+E594/E594\E594;
                      dl VoBGHSub1Level1DD                      ;;E597|E597+E597/E597\E597;
                      dl Mode7BossLayer1                        ;;E59A|E59A+E59A/E59A\E59A;
                      dl FoI4Sub2Level1DF                       ;;E59D|E59D+E59D/E59D\E59D;
                      dl MondoSub1Level1E0                      ;;E5A0|E5A0+E5A0/E5A0\E5A0;
                      dl MondoSub2Level1E1                      ;;E5A3|E5A3+E5A3/E5A3\E5A3;
                      dl VoB2Sub2Level1E2                       ;;E5A6|E5A6+E5A6/E5A6\E5A6;
                      dl VoB2Sub1Level1E3                       ;;E5A9|E5A9+E5A9/E5A9\E5A9;
                      dl VoB1Sub1Level1E4                       ;;E5AC|E5AC+E5AC/E5AC\E5AC;
                      dl VoB1Sub2Level1E5                       ;;E5AF|E5AF+E5AF/E5AF\E5AF;
                      dl FGHSub2Level1E6                        ;;E5B2|E5B2+E5B2/E5B2\E5B2;
                      dl GhostHouseExitLevel                    ;;E5B5|E5B5+E5B5/E5B5\E5B5;
                      dl FGHLevel11D                            ;;E5B8|E5B8+E5B8/E5B8\E5B8;
                      dl FGHLevel11D                            ;;E5BB|E5BB+E5BB/E5BB\E5BB;
                      dl VGHSub1Level1EA                        ;;E5BE|E5BE+E5BE/E5BE\E5BE;
                      dl LarryIggyLevel                         ;;E5C1|E5C1+E5C1/E5C1\E5C1;
                      dl CSSub3Level1EC                         ;;E5C4|E5C4+E5C4/E5C4\E5C4;
                      dl CSSub2Level1ED                         ;;E5C7|E5C7+E5C7/E5C7\E5C7;
                      dl CSSub4Level1EE                         ;;E5CA|E5CA+E5CA/E5CA\E5CA;
                      dl VD1Sub1Level1EF                        ;;E5CD|E5CD+E5CD/E5CD\E5CD;
                      dl VS1Sub2Level1F0                        ;;E5D0|E5D0+E5D0/E5D0\E5D0;
                      dl VS1Sub1Level1F1                        ;;E5D3|E5D3+E5D3/E5D3\E5D3;
                      dl C3Sub3Level1F2                         ;;E5D6|E5D6+E5D6/E5D6\E5D6;
                      dl C3Sub2Level1F3                         ;;E5D9|E5D9+E5D9/E5D9\E5D9;
                      dl C3Sub1Level1F4                         ;;E5DC|E5DC+E5DC/E5DC\E5DC;
                      dl VD4Sub1Level1F5                        ;;E5DF|E5DF+E5DF/E5DF\E5DF;
                      dl LarryIggyLevel                         ;;E5E2|E5E2+E5E2/E5E2\E5E2;
                      dl VD3Sub1Level1F7                        ;;E5E5|E5E5+E5E5/E5E5\E5E5;
                      dl FoI3Sub2Level1F8                       ;;E5E8|E5E8+E5E8/E5E8\E5E8;
                      dl GhostHouseExitLevel                    ;;E5EB|E5EB+E5EB/E5EB\E5EB;
                      dl FGHSub1Level1FA                        ;;E5EE|E5EE+E5EE/E5EE\E5EE;
                      dl VGHLevel107                            ;;E5F1|E5F1+E5F1/E5F1\E5F1;
                      dl C1Sub1Level1FC                         ;;E5F4|E5F4+E5F4/E5F4\E5F4;
                      dl YI3Sub1Level1FD                        ;;E5F7|E5F7+E5F7/E5F7\E5F7;
                      dl C7Sub1Level1FE                         ;;E5FA|E5FA+E5FA/E5FA\E5FA;
                      dl YI4Sub2Level1FF                        ;;E5FD|E5FD+E5FD/E5FD\E5FD;
                                                                ;;                        ;
Layer2Ptrs:           dw DATA_0CE674 : db $FF                   ;;E600|E600+E600/E600\E600;
                      dw DATA_0CDD44 : db $FF                   ;;E603|E603+E603/E603\E603;
                      dw DATA_0CDD44 : db $FF                   ;;E606|E606+E606/E606\E606;
                      dw DATA_0CEC82 : db $FF                   ;;E609|E609+E609/E609\E609;
                      dw DATA_0CEF80 : db $FF                   ;;E60C|E60C+E60C/E60C\E60C;
                      dw DATA_0CEC82 : db $FF                   ;;E60F|E60F+E60F/E60F\E60F;
                      dw DATA_0CDE54 : db $FF                   ;;E612|E612+E612/E612\E612;
                      dw DATA_0CF45A : db $FF                   ;;E615|E615+E615/E615\E615;
                      dw DATA_0CE674 : db $FF                   ;;E618|E618+E618/E618\E618;
                      dl DP2LvlL2009                            ;;E61B|E61B+E61B/E61B\E61B;
                      dw DATA_0CDAB9 : db $FF                   ;;E61E|E61E+E61E/E61E\E61E;
                      dw DATA_0CF45A : db $FF                   ;;E621|E621+E621/E621\E621;
                      dw DATA_0CDD44 : db $FF                   ;;E624|E624+E624/E624\E624;
                      dw DATA_0CDD44 : db $FF                   ;;E627|E627+E627/E627\E627;
                      dl C4LvlL200E                             ;;E62A|E62A+E62A/E62A\E62A;
                      dw DATA_0CDD44 : db $FF                   ;;E62D|E62D+E62D/E62D\E62D;
                      dw DATA_0CDD44 : db $FF                   ;;E630|E630+E630/E630\E630;
                      dw DATA_0CDAB9 : db $FF                   ;;E633|E633+E633/E633\E633;
                      dw DATA_0CDE54 : db $FF                   ;;E636|E636+E636/E636\E636;
                      dw DATA_0CEF80 : db $FF                   ;;E639|E639+E639/E639\E639;
                      dw DATA_0CE674 : db $FF                   ;;E63C|E63C+E63C/E63C\E63C;
                      dw DATA_0CDE54 : db $FF                   ;;E63F|E63F+E63F/E63F\E63F;
                      dw DATA_0CDE54 : db $FF                   ;;E642|E642+E642/E642\E642;
                      dw DATA_0CD900 : db $FF                   ;;E645|E645+E645/E645\E645;
                      dw DATA_0CDAB9 : db $FF                   ;;E648|E648+E648/E648\E648;
                      dw DATA_0CD900 : db $FF                   ;;E64B|E64B+E64B/E64B\E64B;
                      dl C6LvlL201A                             ;;E64E|E64E+E64E/E64E\E64E;
                      dw DATA_0CF45A : db $FF                   ;;E651|E651+E651/E651\E651;
                      dw DATA_0CE7C0 : db $FF                   ;;E654|E654+E654/E654\E654;
                      dw DATA_0CE8FE : db $FF                   ;;E657|E657+E657/E657\E657;
                      dw DATA_0CD900 : db $FF                   ;;E65A|E65A+E65A/E65A\E65A;
                      dw DATA_0CE103 : db $FF                   ;;E65D|E65D+E65D/E65D\E65D;
                      dw DATA_0CF45A : db $FF                   ;;E660|E660+E660/E660\E660;
                      dw DATA_0CEF80 : db $FF                   ;;E663|E663+E663/E663\E663;
                      dw DATA_0CDE54 : db $FF                   ;;E666|E666+E666/E666\E666;
                      dw DATA_0CE7C0 : db $FF                   ;;E669|E669+E669/E669\E669;
                      dw DATA_0CDF59 : db $FF                   ;;E66C|E66C+E66C/E66C\E66C;
                      dw DATA_0CD900 : db $FF                   ;;E66F|E66F+E66F/E66F\E66F;
                      dw DATA_0CD900 : db $FF                   ;;E672|E672+E672/E672\E672;
                      dw DATA_0CD900 : db $FF                   ;;E675|E675+E675/E675\E675;
                      dw DATA_0CD900 : db $FF                   ;;E678|E678+E678/E678\E678;
                      dw DATA_0CD900 : db $FF                   ;;E67B|E67B+E67B/E67B\E67B;
                      dw DATA_0CD900 : db $FF                   ;;E67E|E67E+E67E/E67E\E67E;
                      dw DATA_0CD900 : db $FF                   ;;E681|E681+E681/E681\E681;
                      dw DATA_0CD900 : db $FF                   ;;E684|E684+E684/E684\E684;
                      dw DATA_0CD900 : db $FF                   ;;E687|E687+E687/E687\E687;
                      dw DATA_0CD900 : db $FF                   ;;E68A|E68A+E68A/E68A\E68A;
                      dw DATA_0CD900 : db $FF                   ;;E68D|E68D+E68D/E68D\E68D;
                      dw DATA_0CD900 : db $FF                   ;;E690|E690+E690/E690\E690;
                      dw DATA_0CD900 : db $FF                   ;;E693|E693+E693/E693\E693;
                      dw DATA_0CD900 : db $FF                   ;;E696|E696+E696/E696\E696;
                      dw DATA_0CD900 : db $FF                   ;;E699|E699+E699/E699\E699;
                      dw DATA_0CD900 : db $FF                   ;;E69C|E69C+E69C/E69C\E69C;
                      dw DATA_0CD900 : db $FF                   ;;E69F|E69F+E69F/E69F\E69F;
                      dw DATA_0CD900 : db $FF                   ;;E6A2|E6A2+E6A2/E6A2\E6A2;
                      dw DATA_0CD900 : db $FF                   ;;E6A5|E6A5+E6A5/E6A5\E6A5;
                      dw DATA_0CD900 : db $FF                   ;;E6A8|E6A8+E6A8/E6A8\E6A8;
                      dw DATA_0CD900 : db $FF                   ;;E6AB|E6AB+E6AB/E6AB\E6AB;
                      dw DATA_0CD900 : db $FF                   ;;E6AE|E6AE+E6AE/E6AE\E6AE;
                      dw DATA_0CD900 : db $FF                   ;;E6B1|E6B1+E6B1/E6B1\E6B1;
                      dw DATA_0CD900 : db $FF                   ;;E6B4|E6B4+E6B4/E6B4\E6B4;
                      dw DATA_0CD900 : db $FF                   ;;E6B7|E6B7+E6B7/E6B7\E6B7;
                      dw DATA_0CD900 : db $FF                   ;;E6BA|E6BA+E6BA/E6BA\E6BA;
                      dw DATA_0CD900 : db $FF                   ;;E6BD|E6BD+E6BD/E6BD\E6BD;
                      dw DATA_0CD900 : db $FF                   ;;E6C0|E6C0+E6C0/E6C0\E6C0;
                      dw DATA_0CD900 : db $FF                   ;;E6C3|E6C3+E6C3/E6C3\E6C3;
                      dw DATA_0CD900 : db $FF                   ;;E6C6|E6C6+E6C6/E6C6\E6C6;
                      dw DATA_0CD900 : db $FF                   ;;E6C9|E6C9+E6C9/E6C9\E6C9;
                      dw DATA_0CD900 : db $FF                   ;;E6CC|E6CC+E6CC/E6CC\E6CC;
                      dw DATA_0CD900 : db $FF                   ;;E6CF|E6CF+E6CF/E6CF\E6CF;
                      dw DATA_0CD900 : db $FF                   ;;E6D2|E6D2+E6D2/E6D2\E6D2;
                      dw DATA_0CD900 : db $FF                   ;;E6D5|E6D5+E6D5/E6D5\E6D5;
                      dw DATA_0CD900 : db $FF                   ;;E6D8|E6D8+E6D8/E6D8\E6D8;
                      dw DATA_0CD900 : db $FF                   ;;E6DB|E6DB+E6DB/E6DB\E6DB;
                      dw DATA_0CD900 : db $FF                   ;;E6DE|E6DE+E6DE/E6DE\E6DE;
                      dw DATA_0CD900 : db $FF                   ;;E6E1|E6E1+E6E1/E6E1\E6E1;
                      dw DATA_0CD900 : db $FF                   ;;E6E4|E6E4+E6E4/E6E4\E6E4;
                      dw DATA_0CD900 : db $FF                   ;;E6E7|E6E7+E6E7/E6E7\E6E7;
                      dw DATA_0CD900 : db $FF                   ;;E6EA|E6EA+E6EA/E6EA\E6EA;
                      dw DATA_0CD900 : db $FF                   ;;E6ED|E6ED+E6ED/E6ED\E6ED;
                      dw DATA_0CD900 : db $FF                   ;;E6F0|E6F0+E6F0/E6F0\E6F0;
                      dw DATA_0CD900 : db $FF                   ;;E6F3|E6F3+E6F3/E6F3\E6F3;
                      dw DATA_0CD900 : db $FF                   ;;E6F6|E6F6+E6F6/E6F6\E6F6;
                      dw DATA_0CD900 : db $FF                   ;;E6F9|E6F9+E6F9/E6F9\E6F9;
                      dw DATA_0CD900 : db $FF                   ;;E6FC|E6FC+E6FC/E6FC\E6FC;
                      dw DATA_0CD900 : db $FF                   ;;E6FF|E6FF+E6FF/E6FF\E6FF;
                      dw DATA_0CD900 : db $FF                   ;;E702|E702+E702/E702\E702;
                      dw DATA_0CD900 : db $FF                   ;;E705|E705+E705/E705\E705;
                      dw DATA_0CD900 : db $FF                   ;;E708|E708+E708/E708\E708;
                      dw DATA_0CD900 : db $FF                   ;;E70B|E70B+E70B/E70B\E70B;
                      dw DATA_0CD900 : db $FF                   ;;E70E|E70E+E70E/E70E\E70E;
                      dw DATA_0CD900 : db $FF                   ;;E711|E711+E711/E711\E711;
                      dw DATA_0CD900 : db $FF                   ;;E714|E714+E714/E714\E714;
                      dw DATA_0CD900 : db $FF                   ;;E717|E717+E717/E717\E717;
                      dw DATA_0CD900 : db $FF                   ;;E71A|E71A+E71A/E71A\E71A;
                      dw DATA_0CD900 : db $FF                   ;;E71D|E71D+E71D/E71D\E71D;
                      dw DATA_0CD900 : db $FF                   ;;E720|E720+E720/E720\E720;
                      dw DATA_0CD900 : db $FF                   ;;E723|E723+E723/E723\E723;
                      dw DATA_0CD900 : db $FF                   ;;E726|E726+E726/E726\E726;
                      dw DATA_0CD900 : db $FF                   ;;E729|E729+E729/E729\E729;
                      dw DATA_0CD900 : db $FF                   ;;E72C|E72C+E72C/E72C\E72C;
                      dw DATA_0CD900 : db $FF                   ;;E72F|E72F+E72F/E72F\E72F;
                      dw DATA_0CD900 : db $FF                   ;;E732|E732+E732/E732\E732;
                      dw DATA_0CD900 : db $FF                   ;;E735|E735+E735/E735\E735;
                      dw DATA_0CD900 : db $FF                   ;;E738|E738+E738/E738\E738;
                      dw DATA_0CD900 : db $FF                   ;;E73B|E73B+E73B/E73B\E73B;
                      dw DATA_0CD900 : db $FF                   ;;E73E|E73E+E73E/E73E\E73E;
                      dw DATA_0CD900 : db $FF                   ;;E741|E741+E741/E741\E741;
                      dw DATA_0CD900 : db $FF                   ;;E744|E744+E744/E744\E744;
                      dw DATA_0CD900 : db $FF                   ;;E747|E747+E747/E747\E747;
                      dw DATA_0CD900 : db $FF                   ;;E74A|E74A+E74A/E74A\E74A;
                      dw DATA_0CD900 : db $FF                   ;;E74D|E74D+E74D/E74D\E74D;
                      dw DATA_0CD900 : db $FF                   ;;E750|E750+E750/E750\E750;
                      dw DATA_0CD900 : db $FF                   ;;E753|E753+E753/E753\E753;
                      dw DATA_0CD900 : db $FF                   ;;E756|E756+E756/E756\E756;
                      dw DATA_0CD900 : db $FF                   ;;E759|E759+E759/E759\E759;
                      dw DATA_0CD900 : db $FF                   ;;E75C|E75C+E75C/E75C\E75C;
                      dw DATA_0CD900 : db $FF                   ;;E75F|E75F+E75F/E75F\E75F;
                      dw DATA_0CD900 : db $FF                   ;;E762|E762+E762/E762\E762;
                      dw DATA_0CD900 : db $FF                   ;;E765|E765+E765/E765\E765;
                      dw DATA_0CD900 : db $FF                   ;;E768|E768+E768/E768\E768;
                      dw DATA_0CD900 : db $FF                   ;;E76B|E76B+E76B/E76B\E76B;
                      dw DATA_0CD900 : db $FF                   ;;E76E|E76E+E76E/E76E\E76E;
                      dw DATA_0CD900 : db $FF                   ;;E771|E771+E771/E771\E771;
                      dw DATA_0CD900 : db $FF                   ;;E774|E774+E774/E774\E774;
                      dw DATA_0CD900 : db $FF                   ;;E777|E777+E777/E777\E777;
                      dw DATA_0CD900 : db $FF                   ;;E77A|E77A+E77A/E77A\E77A;
                      dw DATA_0CD900 : db $FF                   ;;E77D|E77D+E77D/E77D\E77D;
                      dw DATA_0CD900 : db $FF                   ;;E780|E780+E780/E780\E780;
                      dw DATA_0CD900 : db $FF                   ;;E783|E783+E783/E783\E783;
                      dw DATA_0CD900 : db $FF                   ;;E786|E786+E786/E786\E786;
                      dw DATA_0CD900 : db $FF                   ;;E789|E789+E789/E789\E789;
                      dw DATA_0CD900 : db $FF                   ;;E78C|E78C+E78C/E78C\E78C;
                      dw DATA_0CD900 : db $FF                   ;;E78F|E78F+E78F/E78F\E78F;
                      dw DATA_0CD900 : db $FF                   ;;E792|E792+E792/E792\E792;
                      dw DATA_0CD900 : db $FF                   ;;E795|E795+E795/E795\E795;
                      dw DATA_0CD900 : db $FF                   ;;E798|E798+E798/E798\E798;
                      dw DATA_0CD900 : db $FF                   ;;E79B|E79B+E79B/E79B\E79B;
                      dw DATA_0CD900 : db $FF                   ;;E79E|E79E+E79E/E79E\E79E;
                      dw DATA_0CD900 : db $FF                   ;;E7A1|E7A1+E7A1/E7A1\E7A1;
                      dw DATA_0CD900 : db $FF                   ;;E7A4|E7A4+E7A4/E7A4\E7A4;
                      dw DATA_0CD900 : db $FF                   ;;E7A7|E7A7+E7A7/E7A7\E7A7;
                      dw DATA_0CD900 : db $FF                   ;;E7AA|E7AA+E7AA/E7AA\E7AA;
                      dw DATA_0CD900 : db $FF                   ;;E7AD|E7AD+E7AD/E7AD\E7AD;
                      dw DATA_0CD900 : db $FF                   ;;E7B0|E7B0+E7B0/E7B0\E7B0;
                      dw DATA_0CD900 : db $FF                   ;;E7B3|E7B3+E7B3/E7B3\E7B3;
                      dw DATA_0CD900 : db $FF                   ;;E7B6|E7B6+E7B6/E7B6\E7B6;
                      dw DATA_0CF45A : db $FF                   ;;E7B9|E7B9+E7B9/E7B9\E7B9;
                      dw DATA_0CF45A : db $FF                   ;;E7BC|E7BC+E7BC/E7BC\E7BC;
                      dw DATA_0CF45A : db $FF                   ;;E7BF|E7BF+E7BF/E7BF\E7BF;
                      dw DATA_0CF45A : db $FF                   ;;E7C2|E7C2+E7C2/E7C2\E7C2;
                      dw DATA_0CF45A : db $FF                   ;;E7C5|E7C5+E7C5/E7C5\E7C5;
                      dw DATA_0CF45A : db $FF                   ;;E7C8|E7C8+E7C8/E7C8\E7C8;
                      dw DATA_0CF45A : db $FF                   ;;E7CB|E7CB+E7CB/E7CB\E7CB;
                      dw DATA_0CF45A : db $FF                   ;;E7CE|E7CE+E7CE/E7CE\E7CE;
                      dw DATA_0CF45A : db $FF                   ;;E7D1|E7D1+E7D1/E7D1\E7D1;
                      dw DATA_0CD900 : db $FF                   ;;E7D4|E7D4+E7D4/E7D4\E7D4;
                      dw DATA_0CD900 : db $FF                   ;;E7D7|E7D7+E7D7/E7D7\E7D7;
                      dw DATA_0CD900 : db $FF                   ;;E7DA|E7DA+E7DA/E7DA\E7DA;
                      dw DATA_0CD900 : db $FF                   ;;E7DD|E7DD+E7DD/E7DD\E7DD;
                      dw DATA_0CD900 : db $FF                   ;;E7E0|E7E0+E7E0/E7E0\E7E0;
                      dw DATA_0CD900 : db $FF                   ;;E7E3|E7E3+E7E3/E7E3\E7E3;
                      dw DATA_0CD900 : db $FF                   ;;E7E6|E7E6+E7E6/E7E6\E7E6;
                      dw DATA_0CD900 : db $FF                   ;;E7E9|E7E9+E7E9/E7E9\E7E9;
                      dw DATA_0CD900 : db $FF                   ;;E7EC|E7EC+E7EC/E7EC\E7EC;
                      dw DATA_0CD900 : db $FF                   ;;E7EF|E7EF+E7EF/E7EF\E7EF;
                      dw DATA_0CD900 : db $FF                   ;;E7F2|E7F2+E7F2/E7F2\E7F2;
                      dw DATA_0CD900 : db $FF                   ;;E7F5|E7F5+E7F5/E7F5\E7F5;
                      dw DATA_0CD900 : db $FF                   ;;E7F8|E7F8+E7F8/E7F8\E7F8;
                      dw DATA_0CD900 : db $FF                   ;;E7FB|E7FB+E7FB/E7FB\E7FB;
                      dw DATA_0CD900 : db $FF                   ;;E7FE|E7FE+E7FE/E7FE\E7FE;
                      dw DATA_0CD900 : db $FF                   ;;E801|E801+E801/E801\E801;
                      dw DATA_0CD900 : db $FF                   ;;E804|E804+E804/E804\E804;
                      dw DATA_0CD900 : db $FF                   ;;E807|E807+E807/E807\E807;
                      dw DATA_0CD900 : db $FF                   ;;E80A|E80A+E80A/E80A\E80A;
                      dw DATA_0CD900 : db $FF                   ;;E80D|E80D+E80D/E80D\E80D;
                      dw DATA_0CD900 : db $FF                   ;;E810|E810+E810/E810\E810;
                      dw DATA_0CD900 : db $FF                   ;;E813|E813+E813/E813\E813;
                      dw DATA_0CD900 : db $FF                   ;;E816|E816+E816/E816\E816;
                      dw DATA_0CD900 : db $FF                   ;;E819|E819+E819/E819\E819;
                      dw DATA_0CD900 : db $FF                   ;;E81C|E81C+E81C/E81C\E81C;
                      dw DATA_0CD900 : db $FF                   ;;E81F|E81F+E81F/E81F\E81F;
                      dw DATA_0CD900 : db $FF                   ;;E822|E822+E822/E822\E822;
                      dw DATA_0CD900 : db $FF                   ;;E825|E825+E825/E825\E825;
                      dw DATA_0CD900 : db $FF                   ;;E828|E828+E828/E828\E828;
                      dw DATA_0CD900 : db $FF                   ;;E82B|E82B+E82B/E82B\E82B;
                      dw DATA_0CD900 : db $FF                   ;;E82E|E82E+E82E/E82E\E82E;
                      dw DATA_0CD900 : db $FF                   ;;E831|E831+E831/E831\E831;
                      dw DATA_0CD900 : db $FF                   ;;E834|E834+E834/E834\E834;
                      dw DATA_0CE674 : db $FF                   ;;E837|E837+E837/E837\E837;
                      dw DATA_0CDF59 : db $FF                   ;;E83A|E83A+E83A/E83A\E83A;
                      dw DATA_0CDD44 : db $FF                   ;;E83D|E83D+E83D/E83D\E83D;
                      dw DATA_0CDF59 : db $FF                   ;;E840|E840+E840/E840\E840;
                      dw DATA_0CDF59 : db $FF                   ;;E843|E843+E843/E843\E843;
                      dw DATA_0CE8FE : db $FF                   ;;E846|E846+E846/E846\E846;
                      dw DATA_0CDE54 : db $FF                   ;;E849|E849+E849/E849\E849;
                      dl GhostHouseExitLvlL2                    ;;E84C|E84C+E84C/E84C\E84C;
                      dw DATA_0CD900 : db $FF                   ;;E84F|E84F+E84F/E84F\E84F;
                      dw DATA_0CE472 : db $FF                   ;;E852|E852+E852/E852\E852;
                      dw DATA_0CDF59 : db $FF                   ;;E855|E855+E855/E855\E855;
                      dw DATA_0CE684 : db $FF                   ;;E858|E858+E858/E858\E858;
                      dw DATA_0CE674 : db $FF                   ;;E85B|E85B+E85B/E85B\E85B;
                      dw DATA_0CE674 : db $FF                   ;;E85E|E85E+E85E/E85E\E85E;
                      dw DATA_0CDD44 : db $FF                   ;;E861|E861+E861/E861\E861;
                      dw DATA_0CF45A : db $FF                   ;;E864|E864+E864/E864\E864;
                      dw DATA_0CDF59 : db $FF                   ;;E867|E867+E867/E867\E867;
                      dw DATA_0CDF59 : db $FF                   ;;E86A|E86A+E86A/E86A\E86A;
                      dw DATA_0CDF59 : db $FF                   ;;E86D|E86D+E86D/E86D\E86D;
                      dw DATA_0CDE54 : db $FF                   ;;E870|E870+E870/E870\E870;
                      dw DATA_0CDE54 : db $FF                   ;;E873|E873+E873/E873\E873;
                      dw DATA_0CE8FE : db $FF                   ;;E876|E876+E876/E876\E876;
                      dw DATA_0CF45A : db $FF                   ;;E879|E879+E879/E879\E879;
                      dl C6Sub1LvlL20D4                         ;;E87C|E87C+E87C/E87C\E87C;
                      dw DATA_0CF45A : db $FF                   ;;E87F|E87F+E87F/E87F\E87F;
                      dw DATA_0CF45A : db $FF                   ;;E882|E882+E882/E882\E882;
                      dw DATA_0CDD44 : db $FF                   ;;E885|E885+E885/E885\E885;
                      dw DATA_0CE8FE : db $FF                   ;;E888|E888+E888/E888\E888;
                      dw DATA_0CF45A : db $FF                   ;;E88B|E88B+E88B/E88B\E88B;
                      dw DATA_0CE674 : db $FF                   ;;E88E|E88E+E88E/E88E\E88E;
                      dw DATA_0CF45A : db $FF                   ;;E891|E891+E891/E891\E891;
                      dl C4Sub2LvlL20DC                         ;;E894|E894+E894/E894\E894;
                      dw DATA_0CDD44 : db $FF                   ;;E897|E897+E897/E897\E897;
                      dw DATA_0CEF80 : db $FF                   ;;E89A|E89A+E89A/E89A\E89A;
                      dw DATA_0CD900 : db $FF                   ;;E89D|E89D+E89D/E89D\E89D;
                      dw DATA_0CF45A : db $FF                   ;;E8A0|E8A0+E8A0/E8A0\E8A0;
                      dw DATA_0CF45A : db $FF                   ;;E8A3|E8A3+E8A3/E8A3\E8A3;
                      dw DATA_0CF45A : db $FF                   ;;E8A6|E8A6+E8A6/E8A6\E8A6;
                      dw DATA_0CDE54 : db $FF                   ;;E8A9|E8A9+E8A9/E8A9\E8A9;
                      dw DATA_0CEF80 : db $FF                   ;;E8AC|E8AC+E8AC/E8AC\E8AC;
                      dw DATA_0CF45A : db $FF                   ;;E8AF|E8AF+E8AF/E8AF\E8AF;
                      dw DATA_0CE674 : db $FF                   ;;E8B2|E8B2+E8B2/E8B2\E8B2;
                      dl C2Sub3LvlL20E7                         ;;E8B5|E8B5+E8B5/E8B5\E8B5;
                      dw DATA_0CF45A : db $FF                   ;;E8B8|E8B8+E8B8/E8B8\E8B8;
                      dw DATA_0CE8FE : db $FF                   ;;E8BB|E8BB+E8BB/E8BB\E8BB;
                      dw DATA_0CE8FE : db $FF                   ;;E8BE|E8BE+E8BE/E8BE\E8BE;
                      dl GhostHouseExitLvlL2                    ;;E8C1|E8C1+E8C1/E8C1\E8C1;
                      dw DATA_0CEF80 : db $FF                   ;;E8C4|E8C4+E8C4/E8C4\E8C4;
                      dw DATA_0CEF80 : db $FF                   ;;E8C7|E8C7+E8C7/E8C7\E8C7;
                      dw DATA_0CEF80 : db $FF                   ;;E8CA|E8CA+E8CA/E8CA\E8CA;
                      dw DATA_0CF45A : db $FF                   ;;E8CD|E8CD+E8CD/E8CD\E8CD;
                      dl GhostHouseExitLvlL2                    ;;E8D0|E8D0+E8D0/E8D0\E8D0;
                      dw DATA_0CEF80 : db $FF                   ;;E8D3|E8D3+E8D3/E8D3\E8D3;
                      dw DATA_0CEF80 : db $FF                   ;;E8D6|E8D6+E8D6/E8D6\E8D6;
                      dw DATA_0CDD44 : db $FF                   ;;E8D9|E8D9+E8D9/E8D9\E8D9;
                      dw DATA_0CE674 : db $FF                   ;;E8DC|E8DC+E8DC/E8DC\E8DC;
                      dw DATA_0CDE54 : db $FF                   ;;E8DF|E8DF+E8DF/E8DF\E8DF;
                      dw DATA_0CDE54 : db $FF                   ;;E8E2|E8E2+E8E2/E8E2\E8E2;
                      dw DATA_0CE8EE : db $FF                   ;;E8E5|E8E5+E8E5/E8E5\E8E5;
                      dw DATA_0CF175 : db $FF                   ;;E8E8|E8E8+E8E8/E8E8\E8E8;
                      dw DATA_0CEF80 : db $FF                   ;;E8EB|E8EB+E8EB/E8EB\E8EB;
                      dw DATA_0CEF80 : db $FF                   ;;E8EE|E8EE+E8EE/E8EE\E8EE;
                      dl GhostHouseExitLvlL2                    ;;E8F1|E8F1+E8F1/E8F1\E8F1;
                      dw DATA_0CEF80 : db $FF                   ;;E8F4|E8F4+E8F4/E8F4\E8F4;
                      dw DATA_0CE674 : db $FF                   ;;E8F7|E8F7+E8F7/E8F7\E8F7;
                      dw DATA_0CEF80 : db $FF                   ;;E8FA|E8FA+E8FA/E8FA\E8FA;
                      dw DATA_0CDE54 : db $FF                   ;;E8FD|E8FD+E8FD/E8FD\E8FD;
                      dw DATA_0CE674 : db $FF                   ;;E900|E900+E900/E900\E900;
                      dw DATA_0CE103 : db $FF                   ;;E903|E903+E903/E903\E903;
                      dw DATA_0CDF59 : db $FF                   ;;E906|E906+E906/E906\E906;
                      dw DATA_0CDF59 : db $FF                   ;;E909|E909+E909/E909\E909;
                      dw DATA_0CD900 : db $FF                   ;;E90C|E90C+E90C/E90C\E90C;
                      dw DATA_0CD900 : db $FF                   ;;E90F|E90F+E90F/E90F\E90F;
                      dw DATA_0CEC82 : db $FF                   ;;E912|E912+E912/E912\E912;
                      dw DATA_0CEF80 : db $FF                   ;;E915|E915+E915/E915\E915;
                      dw DATA_0CE7C0 : db $FF                   ;;E918|E918+E918/E918\E918;
                      dw DATA_0CE8FE : db $FF                   ;;E91B|E91B+E91B/E91B\E91B;
                      dw DATA_0CE8FE : db $FF                   ;;E91E|E91E+E91E/E91E\E91E;
                      dw DATA_0CE8FE : db $FF                   ;;E921|E921+E921/E921\E921;
                      dw DATA_0CD900 : db $FF                   ;;E924|E924+E924/E924\E924;
                      dw DATA_0CE103 : db $FF                   ;;E927|E927+E927/E927\E927;
                      dw DATA_0CF45A : db $FF                   ;;E92A|E92A+E92A/E92A\E92A;
                      dw DATA_0CE8FE : db $FF                   ;;E92D|E92D+E92D/E92D\E92D;
                      dw DATA_0CF45A : db $FF                   ;;E930|E930+E930/E930\E930;
                      dl VoBFLvlL2111                           ;;E933|E933+E933/E933\E933;
                      dw DATA_0CD900 : db $FF                   ;;E936|E936+E936/E936\E936;
                      dw DATA_0CE8FE : db $FF                   ;;E939|E939+E939/E939\E939;
                      dw DATA_0CEF80 : db $FF                   ;;E93C|E93C+E93C/E93C\E93C;
                      dl VoB2LvlL2115                           ;;E93F|E93F+E93F/E93F\E93F;
                      dw DATA_0CE8FE : db $FF                   ;;E942|E942+E942/E942\E942;
                      dw DATA_0CE8FE : db $FF                   ;;E945|E945+E945/E945\E945;
                      dw DATA_0CE8FE : db $FF                   ;;E948|E948+E948/E948\E948;
                      dw DATA_0CE684 : db $FF                   ;;E94B|E94B+E94B/E94B\E94B;
                      dw DATA_0CE8FE : db $FF                   ;;E94E|E94E+E94E/E94E\E94E;
                      dw DATA_0CE674 : db $FF                   ;;E951|E951+E951/E951\E951;
                      dw DATA_0CF45A : db $FF                   ;;E954|E954+E954/E954\E954;
                      dl FGHLvlL211D                            ;;E957|E957+E957/E957\E957;
                      dw DATA_0CEC82 : db $FF                   ;;E95A|E95A+E95A/E95A\E95A;
                      dw DATA_0CEC82 : db $FF                   ;;E95D|E95D+E95D/E95D\E95D;
                      dw DATA_0CDAB9 : db $FF                   ;;E960|E960+E960/E960\E960;
                      dw DATA_0CE674 : db $FF                   ;;E963|E963+E963/E963\E963;
                      dw DATA_0CEC82 : db $FF                   ;;E966|E966+E966/E966\E966;
                      dw DATA_0CEC82 : db $FF                   ;;E969|E969+E969/E969\E969;
                      dw DATA_0CD900 : db $FF                   ;;E96C|E96C+E96C/E96C\E96C;
                      dw DATA_0CDC71 : db $FF                   ;;E96F|E96F+E96F/E96F\E96F;
                      dw DATA_0CEC82 : db $FF                   ;;E972|E972+E972/E972\E972;
                      dw DATA_0CE7C0 : db $FF                   ;;E975|E975+E975/E975\E975;
                      dw DATA_0CDF59 : db $FF                   ;;E978|E978+E978/E978\E978;
                      dw DATA_0CD900 : db $FF                   ;;E97B|E97B+E97B/E97B\E97B;
                      dw DATA_0CDD44 : db $FF                   ;;E97E|E97E+E97E/E97E\E97E;
                      dw DATA_0CE472 : db $FF                   ;;E981|E981+E981/E981\E981;
                      dw DATA_0CD900 : db $FF                   ;;E984|E984+E984/E984\E984;
                      dw DATA_0CDF59 : db $FF                   ;;E987|E987+E987/E987\E987;
                      dw DATA_0CD900 : db $FF                   ;;E98A|E98A+E98A/E98A\E98A;
                      dw DATA_0CD900 : db $FF                   ;;E98D|E98D+E98D/E98D\E98D;
                      dw DATA_0CDAB9 : db $FF                   ;;E990|E990+E990/E990\E990;
                      dw DATA_0CD900 : db $FF                   ;;E993|E993+E993/E993\E993;
                      dw DATA_0CE684 : db $FF                   ;;E996|E996+E996/E996\E996;
                      dw DATA_0CD900 : db $FF                   ;;E999|E999+E999/E999\E999;
                      dw DATA_0CE8FE : db $FF                   ;;E99C|E99C+E99C/E99C\E99C;
                      dw DATA_0CE684 : db $FF                   ;;E99F|E99F+E99F/E99F\E99F;
                      dw DATA_0CE684 : db $FF                   ;;E9A2|E9A2+E9A2/E9A2\E9A2;
                      dw DATA_0CD900 : db $FF                   ;;E9A5|E9A5+E9A5/E9A5\E9A5;
                      dw DATA_0CD900 : db $FF                   ;;E9A8|E9A8+E9A8/E9A8\E9A8;
                      dw DATA_0CD900 : db $FF                   ;;E9AB|E9AB+E9AB/E9AB\E9AB;
                      dw DATA_0CD900 : db $FF                   ;;E9AE|E9AE+E9AE/E9AE\E9AE;
                      dw DATA_0CD900 : db $FF                   ;;E9B1|E9B1+E9B1/E9B1\E9B1;
                      dw DATA_0CD900 : db $FF                   ;;E9B4|E9B4+E9B4/E9B4\E9B4;
                      dw DATA_0CD900 : db $FF                   ;;E9B7|E9B7+E9B7/E9B7\E9B7;
                      dw DATA_0CD900 : db $FF                   ;;E9BA|E9BA+E9BA/E9BA\E9BA;
                      dw DATA_0CD900 : db $FF                   ;;E9BD|E9BD+E9BD/E9BD\E9BD;
                      dw DATA_0CD900 : db $FF                   ;;E9C0|E9C0+E9C0/E9C0\E9C0;
                      dw DATA_0CD900 : db $FF                   ;;E9C3|E9C3+E9C3/E9C3\E9C3;
                      dw DATA_0CD900 : db $FF                   ;;E9C6|E9C6+E9C6/E9C6\E9C6;
                      dw DATA_0CD900 : db $FF                   ;;E9C9|E9C9+E9C9/E9C9\E9C9;
                      dw DATA_0CD900 : db $FF                   ;;E9CC|E9CC+E9CC/E9CC\E9CC;
                      dw DATA_0CD900 : db $FF                   ;;E9CF|E9CF+E9CF/E9CF\E9CF;
                      dw DATA_0CD900 : db $FF                   ;;E9D2|E9D2+E9D2/E9D2\E9D2;
                      dw DATA_0CD900 : db $FF                   ;;E9D5|E9D5+E9D5/E9D5\E9D5;
                      dw DATA_0CD900 : db $FF                   ;;E9D8|E9D8+E9D8/E9D8\E9D8;
                      dw DATA_0CD900 : db $FF                   ;;E9DB|E9DB+E9DB/E9DB\E9DB;
                      dw DATA_0CD900 : db $FF                   ;;E9DE|E9DE+E9DE/E9DE\E9DE;
                      dw DATA_0CD900 : db $FF                   ;;E9E1|E9E1+E9E1/E9E1\E9E1;
                      dw DATA_0CD900 : db $FF                   ;;E9E4|E9E4+E9E4/E9E4\E9E4;
                      dw DATA_0CD900 : db $FF                   ;;E9E7|E9E7+E9E7/E9E7\E9E7;
                      dw DATA_0CD900 : db $FF                   ;;E9EA|E9EA+E9EA/E9EA\E9EA;
                      dw DATA_0CD900 : db $FF                   ;;E9ED|E9ED+E9ED/E9ED\E9ED;
                      dw DATA_0CD900 : db $FF                   ;;E9F0|E9F0+E9F0/E9F0\E9F0;
                      dw DATA_0CD900 : db $FF                   ;;E9F3|E9F3+E9F3/E9F3\E9F3;
                      dw DATA_0CD900 : db $FF                   ;;E9F6|E9F6+E9F6/E9F6\E9F6;
                      dw DATA_0CD900 : db $FF                   ;;E9F9|E9F9+E9F9/E9F9\E9F9;
                      dw DATA_0CD900 : db $FF                   ;;E9FC|E9FC+E9FC/E9FC\E9FC;
                      dw DATA_0CD900 : db $FF                   ;;E9FF|E9FF+E9FF/E9FF\E9FF;
                      dw DATA_0CD900 : db $FF                   ;;EA02|EA02+EA02/EA02\EA02;
                      dw DATA_0CD900 : db $FF                   ;;EA05|EA05+EA05/EA05\EA05;
                      dw DATA_0CD900 : db $FF                   ;;EA08|EA08+EA08/EA08\EA08;
                      dw DATA_0CD900 : db $FF                   ;;EA0B|EA0B+EA0B/EA0B\EA0B;
                      dw DATA_0CD900 : db $FF                   ;;EA0E|EA0E+EA0E/EA0E\EA0E;
                      dw DATA_0CD900 : db $FF                   ;;EA11|EA11+EA11/EA11\EA11;
                      dw DATA_0CD900 : db $FF                   ;;EA14|EA14+EA14/EA14\EA14;
                      dw DATA_0CD900 : db $FF                   ;;EA17|EA17+EA17/EA17\EA17;
                      dw DATA_0CD900 : db $FF                   ;;EA1A|EA1A+EA1A/EA1A\EA1A;
                      dw DATA_0CD900 : db $FF                   ;;EA1D|EA1D+EA1D/EA1D\EA1D;
                      dw DATA_0CD900 : db $FF                   ;;EA20|EA20+EA20/EA20\EA20;
                      dw DATA_0CD900 : db $FF                   ;;EA23|EA23+EA23/EA23\EA23;
                      dw DATA_0CD900 : db $FF                   ;;EA26|EA26+EA26/EA26\EA26;
                      dw DATA_0CD900 : db $FF                   ;;EA29|EA29+EA29/EA29\EA29;
                      dw DATA_0CD900 : db $FF                   ;;EA2C|EA2C+EA2C/EA2C\EA2C;
                      dw DATA_0CD900 : db $FF                   ;;EA2F|EA2F+EA2F/EA2F\EA2F;
                      dw DATA_0CD900 : db $FF                   ;;EA32|EA32+EA32/EA32\EA32;
                      dw DATA_0CD900 : db $FF                   ;;EA35|EA35+EA35/EA35\EA35;
                      dw DATA_0CD900 : db $FF                   ;;EA38|EA38+EA38/EA38\EA38;
                      dw DATA_0CD900 : db $FF                   ;;EA3B|EA3B+EA3B/EA3B\EA3B;
                      dw DATA_0CD900 : db $FF                   ;;EA3E|EA3E+EA3E/EA3E\EA3E;
                      dw DATA_0CD900 : db $FF                   ;;EA41|EA41+EA41/EA41\EA41;
                      dw DATA_0CD900 : db $FF                   ;;EA44|EA44+EA44/EA44\EA44;
                      dw DATA_0CD900 : db $FF                   ;;EA47|EA47+EA47/EA47\EA47;
                      dw DATA_0CD900 : db $FF                   ;;EA4A|EA4A+EA4A/EA4A\EA4A;
                      dw DATA_0CD900 : db $FF                   ;;EA4D|EA4D+EA4D/EA4D\EA4D;
                      dw DATA_0CD900 : db $FF                   ;;EA50|EA50+EA50/EA50\EA50;
                      dw DATA_0CD900 : db $FF                   ;;EA53|EA53+EA53/EA53\EA53;
                      dw DATA_0CD900 : db $FF                   ;;EA56|EA56+EA56/EA56\EA56;
                      dw DATA_0CD900 : db $FF                   ;;EA59|EA59+EA59/EA59\EA59;
                      dw DATA_0CD900 : db $FF                   ;;EA5C|EA5C+EA5C/EA5C\EA5C;
                      dw DATA_0CD900 : db $FF                   ;;EA5F|EA5F+EA5F/EA5F\EA5F;
                      dw DATA_0CD900 : db $FF                   ;;EA62|EA62+EA62/EA62\EA62;
                      dw DATA_0CD900 : db $FF                   ;;EA65|EA65+EA65/EA65\EA65;
                      dw DATA_0CD900 : db $FF                   ;;EA68|EA68+EA68/EA68\EA68;
                      dw DATA_0CD900 : db $FF                   ;;EA6B|EA6B+EA6B/EA6B\EA6B;
                      dw DATA_0CD900 : db $FF                   ;;EA6E|EA6E+EA6E/EA6E\EA6E;
                      dw DATA_0CD900 : db $FF                   ;;EA71|EA71+EA71/EA71\EA71;
                      dw DATA_0CD900 : db $FF                   ;;EA74|EA74+EA74/EA74\EA74;
                      dw DATA_0CD900 : db $FF                   ;;EA77|EA77+EA77/EA77\EA77;
                      dw DATA_0CD900 : db $FF                   ;;EA7A|EA7A+EA7A/EA7A\EA7A;
                      dw DATA_0CD900 : db $FF                   ;;EA7D|EA7D+EA7D/EA7D\EA7D;
                      dw DATA_0CD900 : db $FF                   ;;EA80|EA80+EA80/EA80\EA80;
                      dw DATA_0CD900 : db $FF                   ;;EA83|EA83+EA83/EA83\EA83;
                      dw DATA_0CD900 : db $FF                   ;;EA86|EA86+EA86/EA86\EA86;
                      dw DATA_0CD900 : db $FF                   ;;EA89|EA89+EA89/EA89\EA89;
                      dw DATA_0CD900 : db $FF                   ;;EA8C|EA8C+EA8C/EA8C\EA8C;
                      dw DATA_0CD900 : db $FF                   ;;EA8F|EA8F+EA8F/EA8F\EA8F;
                      dw DATA_0CD900 : db $FF                   ;;EA92|EA92+EA92/EA92\EA92;
                      dw DATA_0CD900 : db $FF                   ;;EA95|EA95+EA95/EA95\EA95;
                      dw DATA_0CD900 : db $FF                   ;;EA98|EA98+EA98/EA98\EA98;
                      dw DATA_0CD900 : db $FF                   ;;EA9B|EA9B+EA9B/EA9B\EA9B;
                      dw DATA_0CD900 : db $FF                   ;;EA9E|EA9E+EA9E/EA9E\EA9E;
                      dw DATA_0CD900 : db $FF                   ;;EAA1|EAA1+EAA1/EAA1\EAA1;
                      dw DATA_0CD900 : db $FF                   ;;EAA4|EAA4+EAA4/EAA4\EAA4;
                      dw DATA_0CD900 : db $FF                   ;;EAA7|EAA7+EAA7/EAA7\EAA7;
                      dw DATA_0CD900 : db $FF                   ;;EAAA|EAAA+EAAA/EAAA\EAAA;
                      dw DATA_0CD900 : db $FF                   ;;EAAD|EAAD+EAAD/EAAD\EAAD;
                      dw DATA_0CD900 : db $FF                   ;;EAB0|EAB0+EAB0/EAB0\EAB0;
                      dw DATA_0CD900 : db $FF                   ;;EAB3|EAB3+EAB3/EAB3\EAB3;
                      dw DATA_0CD900 : db $FF                   ;;EAB6|EAB6+EAB6/EAB6\EAB6;
                      dw DATA_0CF45A : db $FF                   ;;EAB9|EAB9+EAB9/EAB9\EAB9;
                      dw DATA_0CF45A : db $FF                   ;;EABC|EABC+EABC/EABC\EABC;
                      dw DATA_0CF45A : db $FF                   ;;EABF|EABF+EABF/EABF\EABF;
                      dw DATA_0CF45A : db $FF                   ;;EAC2|EAC2+EAC2/EAC2\EAC2;
                      dw DATA_0CF45A : db $FF                   ;;EAC5|EAC5+EAC5/EAC5\EAC5;
                      dw DATA_0CF45A : db $FF                   ;;EAC8|EAC8+EAC8/EAC8\EAC8;
                      dw DATA_0CF45A : db $FF                   ;;EACB|EACB+EACB/EACB\EACB;
                      dw DATA_0CF45A : db $FF                   ;;EACE|EACE+EACE/EACE\EACE;
                      dw DATA_0CF45A : db $FF                   ;;EAD1|EAD1+EAD1/EAD1\EAD1;
                      dw DATA_0CD900 : db $FF                   ;;EAD4|EAD4+EAD4/EAD4\EAD4;
                      dw DATA_0CD900 : db $FF                   ;;EAD7|EAD7+EAD7/EAD7\EAD7;
                      dw DATA_0CD900 : db $FF                   ;;EADA|EADA+EADA/EADA\EADA;
                      dw DATA_0CD900 : db $FF                   ;;EADD|EADD+EADD/EADD\EADD;
                      dw DATA_0CD900 : db $FF                   ;;EAE0|EAE0+EAE0/EAE0\EAE0;
                      dw DATA_0CD900 : db $FF                   ;;EAE3|EAE3+EAE3/EAE3\EAE3;
                      dw DATA_0CD900 : db $FF                   ;;EAE6|EAE6+EAE6/EAE6\EAE6;
                      dw DATA_0CD900 : db $FF                   ;;EAE9|EAE9+EAE9/EAE9\EAE9;
                      dw DATA_0CD900 : db $FF                   ;;EAEC|EAEC+EAEC/EAEC\EAEC;
                      dw DATA_0CD900 : db $FF                   ;;EAEF|EAEF+EAEF/EAEF\EAEF;
                      dw DATA_0CD900 : db $FF                   ;;EAF2|EAF2+EAF2/EAF2\EAF2;
                      dw DATA_0CD900 : db $FF                   ;;EAF5|EAF5+EAF5/EAF5\EAF5;
                      dw DATA_0CD900 : db $FF                   ;;EAF8|EAF8+EAF8/EAF8\EAF8;
                      dw DATA_0CD900 : db $FF                   ;;EAFB|EAFB+EAFB/EAFB\EAFB;
                      dw DATA_0CD900 : db $FF                   ;;EAFE|EAFE+EAFE/EAFE\EAFE;
                      dw DATA_0CD900 : db $FF                   ;;EB01|EB01+EB01/EB01\EB01;
                      dw DATA_0CD900 : db $FF                   ;;EB04|EB04+EB04/EB04\EB04;
                      dw DATA_0CD900 : db $FF                   ;;EB07|EB07+EB07/EB07\EB07;
                      dw DATA_0CD900 : db $FF                   ;;EB0A|EB0A+EB0A/EB0A\EB0A;
                      dw DATA_0CD900 : db $FF                   ;;EB0D|EB0D+EB0D/EB0D\EB0D;
                      dw DATA_0CD900 : db $FF                   ;;EB10|EB10+EB10/EB10\EB10;
                      dw DATA_0CD900 : db $FF                   ;;EB13|EB13+EB13/EB13\EB13;
                      dw DATA_0CD900 : db $FF                   ;;EB16|EB16+EB16/EB16\EB16;
                      dw DATA_0CD900 : db $FF                   ;;EB19|EB19+EB19/EB19\EB19;
                      dw DATA_0CD900 : db $FF                   ;;EB1C|EB1C+EB1C/EB1C\EB1C;
                      dw DATA_0CD900 : db $FF                   ;;EB1F|EB1F+EB1F/EB1F\EB1F;
                      dw DATA_0CD900 : db $FF                   ;;EB22|EB22+EB22/EB22\EB22;
                      dw DATA_0CD900 : db $FF                   ;;EB25|EB25+EB25/EB25\EB25;
                      dw DATA_0CD900 : db $FF                   ;;EB28|EB28+EB28/EB28\EB28;
                      dw DATA_0CD900 : db $FF                   ;;EB2B|EB2B+EB2B/EB2B\EB2B;
                      dw DATA_0CD900 : db $FF                   ;;EB2E|EB2E+EB2E/EB2E\EB2E;
                      dw DATA_0CE674 : db $FF                   ;;EB31|EB31+EB31/EB31\EB31;
                      dw DATA_0CE674 : db $FF                   ;;EB34|EB34+EB34/EB34\EB34;
                      dw DATA_0CF45A : db $FF                   ;;EB37|EB37+EB37/EB37\EB37;
                      dw DATA_0CDF59 : db $FF                   ;;EB3A|EB3A+EB3A/EB3A\EB3A;
                      dw DATA_0CE8FE : db $FF                   ;;EB3D|EB3D+EB3D/EB3D\EB3D;
                      dw DATA_0CDF59 : db $FF                   ;;EB40|EB40+EB40/EB40\EB40;
                      dw DATA_0CDAB9 : db $FF                   ;;EB43|EB43+EB43/EB43\EB43;
                      dw DATA_0CE8FE : db $FF                   ;;EB46|EB46+EB46/EB46\EB46;
                      dw DATA_0CE8FE : db $FF                   ;;EB49|EB49+EB49/EB49\EB49;
                      dw DATA_0CDD44 : db $FF                   ;;EB4C|EB4C+EB4C/EB4C\EB4C;
                      dw DATA_0CDD44 : db $FF                   ;;EB4F|EB4F+EB4F/EB4F\EB4F;
                      dw DATA_0CD900 : db $FF                   ;;EB52|EB52+EB52/EB52\EB52;
                      dw DATA_0CF45A : db $FF                   ;;EB55|EB55+EB55/EB55\EB55;
                      dw DATA_0CDD44 : db $FF                   ;;EB58|EB58+EB58/EB58\EB58;
                      dw DATA_0CDD44 : db $FF                   ;;EB5B|EB5B+EB5B/EB5B\EB5B;
                      dw DATA_0CE8FE : db $FF                   ;;EB5E|EB5E+EB5E/EB5E\EB5E;
                      dw DATA_0CE8FE : db $FF                   ;;EB61|EB61+EB61/EB61\EB61;
                      dw DATA_0CF45A : db $FF                   ;;EB64|EB64+EB64/EB64\EB64;
                      dw DATA_0CE103 : db $FF                   ;;EB67|EB67+EB67/EB67\EB67;
                      dl FDSub6LvlL21CE                         ;;EB6A|EB6A+EB6A/EB6A\EB6A;
                      dl FDSub5LvlL21CF                         ;;EB6D|EB6D+EB6D/EB6D\EB6D;
                      dw DATA_0CE103 : db $FF                   ;;EB70|EB70+EB70/EB70\EB70;
                      dw DATA_0CF45A : db $FF                   ;;EB73|EB73+EB73/EB73\EB73;
                      dw DATA_0CF45A : db $FF                   ;;EB76|EB76+EB76/EB76\EB76;
                      dw DATA_0CF45A : db $FF                   ;;EB79|EB79+EB79/EB79\EB79;
                      dw DATA_0CE103 : db $FF                   ;;EB7C|EB7C+EB7C/EB7C\EB7C;
                      dw DATA_0CDD44 : db $FF                   ;;EB7F|EB7F+EB7F/EB7F\EB7F;
                      dw DATA_0CDD44 : db $FF                   ;;EB82|EB82+EB82/EB82\EB82;
                      dw DATA_0CE674 : db $FF                   ;;EB85|EB85+EB85/EB85\EB85;
                      dw DATA_0CE674 : db $FF                   ;;EB88|EB88+EB88/EB88\EB88;
                      dw DATA_0CEF80 : db $FF                   ;;EB8B|EB8B+EB8B/EB8B\EB8B;
                      dl GhostHouseExitLvlL2                    ;;EB8E|EB8E+EB8E/EB8E\EB8E;
                      dw DATA_0CEF80 : db $FF                   ;;EB91|EB91+EB91/EB91\EB91;
                      dw DATA_0CEF80 : db $FF                   ;;EB94|EB94+EB94/EB94\EB94;
                      dw DATA_0CEF80 : db $FF                   ;;EB97|EB97+EB97/EB97\EB97;
                      dw DATA_0CF45A : db $FF                   ;;EB9A|EB9A+EB9A/EB9A\EB9A;
                      dw DATA_0CE8FE : db $FF                   ;;EB9D|EB9D+EB9D/EB9D\EB9D;
                      dw DATA_0CDD44 : db $FF                   ;;EBA0|EBA0+EBA0/EBA0\EBA0;
                      dw DATA_0CE7C0 : db $FF                   ;;EBA3|EBA3+EBA3/EBA3\EBA3;
                      dl VoB2Sub2LvlL21E2                       ;;EBA6|EBA6+EBA6/EBA6\EBA6;
                      dl VoB2Sub1LvlL21E3                       ;;EBA9|EBA9+EBA9/EBA9\EBA9;
                      dw DATA_0CE674 : db $FF                   ;;EBAC|EBAC+EBAC/EBAC\EBAC;
                      dw DATA_0CE8FE : db $FF                   ;;EBAF|EBAF+EBAF/EBAF\EBAF;
                      dl GhostHouseExitLvlL2                    ;;EBB2|EBB2+EBB2/EBB2\EBB2;
                      dl GhostHouseExitLvlL2                    ;;EBB5|EBB5+EBB5/EBB5\EBB5;
                      dl FGHLvlL211D                            ;;EBB8|EBB8+EBB8/EBB8\EBB8;
                      dl FGHLvlL211D                            ;;EBBB|EBBB+EBBB/EBBB\EBBB;
                      dw DATA_0CEF80 : db $FF                   ;;EBBE|EBBE+EBBE/EBBE\EBBE;
                      dw DATA_0CF45A : db $FF                   ;;EBC1|EBC1+EBC1/EBC1\EBC1;
                      dl CSSub3LvlL21EC                         ;;EBC4|EBC4+EBC4/EBC4\EBC4;
                      dw DATA_0CE8FE : db $FF                   ;;EBC7|EBC7+EBC7/EBC7\EBC7;
                      dw DATA_0CE8FE : db $FF                   ;;EBCA|EBCA+EBCA/EBCA\EBCA;
                      dl VD1Sub1LvlL21EF                        ;;EBCD|EBCD+EBCD/EBCD\EBCD;
                      dw DATA_0CE8FE : db $FF                   ;;EBD0|EBD0+EBD0/EBD0\EBD0;
                      dw DATA_0CE8FE : db $FF                   ;;EBD3|EBD3+EBD3/EBD3\EBD3;
                      dw DATA_0CF45A : db $FF                   ;;EBD6|EBD6+EBD6/EBD6\EBD6;
                      dl C3Sub2LvlL21F3                         ;;EBD9|EBD9+EBD9/EBD9\EBD9;
                      dw DATA_0CF45A : db $FF                   ;;EBDC|EBDC+EBDC/EBDC\EBDC;
                      dw DATA_0CE8FE : db $FF                   ;;EBDF|EBDF+EBDF/EBDF\EBDF;
                      dw DATA_0CF45A : db $FF                   ;;EBE2|EBE2+EBE2/EBE2\EBE2;
                      dw DATA_0CE674 : db $FF                   ;;EBE5|EBE5+EBE5/EBE5\EBE5;
                      dw DATA_0CE8FE : db $FF                   ;;EBE8|EBE8+EBE8/EBE8\EBE8;
                      dl GhostHouseExitLvlL2                    ;;EBEB|EBEB+EBEB/EBEB\EBEB;
                      dw DATA_0CEF80 : db $FF                   ;;EBEE|EBEE+EBEE/EBEE\EBEE;
                      dw DATA_0CEF80 : db $FF                   ;;EBF1|EBF1+EBF1/EBF1\EBF1;
                      dw DATA_0CE103 : db $FF                   ;;EBF4|EBF4+EBF4/EBF4\EBF4;
                      dw DATA_0CE8FE : db $FF                   ;;EBF7|EBF7+EBF7/EBF7\EBF7;
                      dw DATA_0CF45A : db $FF                   ;;EBFA|EBFA+EBFA/EBFA\EBFA;
                      dw DATA_0CDF59 : db $FF                   ;;EBFD|EBFD+EBFD/EBFD\EBFD;
                                                                ;;                        ;
Ptrs05EC00:           dw BonusGameSprites                       ;;EC00|EC00+EC00/EC00\EC00;
                      dw VS2Sprites001                          ;;EC02|EC02+EC02/EC02\EC02;
                      dw VS3Sprites002                          ;;EC04|EC04+EC04/EC04\EC04;
                      dw TSASprites003                          ;;EC06|EC06+EC06/EC06\EC06;
                      dw DGHSprites004                          ;;EC08|EC08+EC08/EC08\EC08;
                      dw DP3Sprites005                          ;;EC0A|EC0A+EC0A/EC0A\EC0A;
                      dw DP4Sprites006                          ;;EC0C|EC0C+EC0C/EC0C\EC0C;
                      dw C2Sprites007                           ;;EC0E|EC0E+EC0E/EC0E\EC0E;
                      dw GSPSprites008                          ;;EC10|EC10+EC10/EC10\EC10;
                      dw DP2Sprites009                          ;;EC12|EC12+EC12/EC12\EC12;
                      dw DS1Sprites00A                          ;;EC14|EC14+EC14/EC14\EC14;
                      dw VFSprites00B                           ;;EC16|EC16+EC16/EC16\EC16;
                      dw BB1Sprites00C                          ;;EC18|EC18+EC18/EC18\EC18;
                      dw BB2Sprites00D                          ;;EC1A|EC1A+EC1A/EC1A\EC1A;
                      dw C4Sprites00E                           ;;EC1C|EC1C+EC1C/EC1C\EC1C;
                      dw CBASprites00F                          ;;EC1E|EC1E+EC1E/EC1E\EC1E;
                      dw CMSprites010                           ;;EC20|EC20+EC20/EC20\EC20;
                      dw SLSprites011                           ;;EC22|EC22+EC22/EC22\EC22;
                      dw TestLevelSprites                       ;;EC24|EC24+EC24/EC24\EC24;
                      dw DSHSprites013                          ;;EC26|EC26+EC26/EC26\EC26;
                      dw YSPSprites014                          ;;EC28|EC28+EC28/EC28\EC28;
                      dw DP1Sprites015                          ;;EC2A|EC2A+EC2A/EC2A\EC2A;
                      dw DP1Sprites015                          ;;EC2C|EC2C+EC2C/EC2C\EC2C;
                      dw DP1Sprites015                          ;;EC2E|EC2E+EC2E/EC2E\EC2E;
                      dw SGSSprites018                          ;;EC30|EC30+EC30/EC30\EC30;
                      dw TestLevelSprites                       ;;EC32|EC32+EC32/EC32\EC32;
                      dw C6Sprites01A                           ;;EC34|EC34+EC34/EC34\EC34;
                      dw CFSprites01B                           ;;EC36|EC36+EC36/EC36\EC36;
                      dw CI5Sprites01C                          ;;EC38|EC38+EC38/EC38\EC38;
                      dw CI4Sprites01D                          ;;EC3A|EC3A+EC3A/EC3A\EC3A;
                      dw TestLevelSprites                       ;;EC3C|EC3C+EC3C/EC3C\EC3C;
                      dw FFSprites01F                           ;;EC3E|EC3E+EC3E/EC3E\EC3E;
                      dw C5Sprites020                           ;;EC40|EC40+EC40/EC40\EC40;
                      dw CGHSprites021                          ;;EC42|EC42+EC42/EC42\EC42;
                      dw CI1Sprites022                          ;;EC44|EC44+EC44/EC44\EC44;
                      dw CI3Sprites023                          ;;EC46|EC46+EC46/EC46\EC46;
                      dw CI2Sprites024                          ;;EC48|EC48+EC48/EC48\EC48;
                      dw TestLevelSprites                       ;;EC4A|EC4A+EC4A/EC4A\EC4A;
                      dw TestLevelSprites                       ;;EC4C|EC4C+EC4C/EC4C\EC4C;
                      dw TestLevelSprites                       ;;EC4E|EC4E+EC4E/EC4E\EC4E;
                      dw TestLevelSprites                       ;;EC50|EC50+EC50/EC50\EC50;
                      dw TestLevelSprites                       ;;EC52|EC52+EC52/EC52\EC52;
                      dw TestLevelSprites                       ;;EC54|EC54+EC54/EC54\EC54;
                      dw TestLevelSprites                       ;;EC56|EC56+EC56/EC56\EC56;
                      dw TestLevelSprites                       ;;EC58|EC58+EC58/EC58\EC58;
                      dw TestLevelSprites                       ;;EC5A|EC5A+EC5A/EC5A\EC5A;
                      dw TestLevelSprites                       ;;EC5C|EC5C+EC5C/EC5C\EC5C;
                      dw TestLevelSprites                       ;;EC5E|EC5E+EC5E/EC5E\EC5E;
                      dw TestLevelSprites                       ;;EC60|EC60+EC60/EC60\EC60;
                      dw TestLevelSprites                       ;;EC62|EC62+EC62/EC62\EC62;
                      dw TestLevelSprites                       ;;EC64|EC64+EC64/EC64\EC64;
                      dw TestLevelSprites                       ;;EC66|EC66+EC66/EC66\EC66;
                      dw TestLevelSprites                       ;;EC68|EC68+EC68/EC68\EC68;
                      dw TestLevelSprites                       ;;EC6A|EC6A+EC6A/EC6A\EC6A;
                      dw TestLevelSprites                       ;;EC6C|EC6C+EC6C/EC6C\EC6C;
                      dw TestLevelSprites                       ;;EC6E|EC6E+EC6E/EC6E\EC6E;
                      dw TestLevelSprites                       ;;EC70|EC70+EC70/EC70\EC70;
                      dw TestLevelSprites                       ;;EC72|EC72+EC72/EC72\EC72;
                      dw TestLevelSprites                       ;;EC74|EC74+EC74/EC74\EC74;
                      dw TestLevelSprites                       ;;EC76|EC76+EC76/EC76\EC76;
                      dw TestLevelSprites                       ;;EC78|EC78+EC78/EC78\EC78;
                      dw TestLevelSprites                       ;;EC7A|EC7A+EC7A/EC7A\EC7A;
                      dw TestLevelSprites                       ;;EC7C|EC7C+EC7C/EC7C\EC7C;
                      dw TestLevelSprites                       ;;EC7E|EC7E+EC7E/EC7E\EC7E;
                      dw TestLevelSprites                       ;;EC80|EC80+EC80/EC80\EC80;
                      dw TestLevelSprites                       ;;EC82|EC82+EC82/EC82\EC82;
                      dw TestLevelSprites                       ;;EC84|EC84+EC84/EC84\EC84;
                      dw TestLevelSprites                       ;;EC86|EC86+EC86/EC86\EC86;
                      dw TestLevelSprites                       ;;EC88|EC88+EC88/EC88\EC88;
                      dw TestLevelSprites                       ;;EC8A|EC8A+EC8A/EC8A\EC8A;
                      dw TestLevelSprites                       ;;EC8C|EC8C+EC8C/EC8C\EC8C;
                      dw TestLevelSprites                       ;;EC8E|EC8E+EC8E/EC8E\EC8E;
                      dw TestLevelSprites                       ;;EC90|EC90+EC90/EC90\EC90;
                      dw TestLevelSprites                       ;;EC92|EC92+EC92/EC92\EC92;
                      dw TestLevelSprites                       ;;EC94|EC94+EC94/EC94\EC94;
                      dw TestLevelSprites                       ;;EC96|EC96+EC96/EC96\EC96;
                      dw TestLevelSprites                       ;;EC98|EC98+EC98/EC98\EC98;
                      dw TestLevelSprites                       ;;EC9A|EC9A+EC9A/EC9A\EC9A;
                      dw TestLevelSprites                       ;;EC9C|EC9C+EC9C/EC9C\EC9C;
                      dw TestLevelSprites                       ;;EC9E|EC9E+EC9E/EC9E\EC9E;
                      dw TestLevelSprites                       ;;ECA0|ECA0+ECA0/ECA0\ECA0;
                      dw TestLevelSprites                       ;;ECA2|ECA2+ECA2/ECA2\ECA2;
                      dw TestLevelSprites                       ;;ECA4|ECA4+ECA4/ECA4\ECA4;
                      dw TestLevelSprites                       ;;ECA6|ECA6+ECA6/ECA6\ECA6;
                      dw TestLevelSprites                       ;;ECA8|ECA8+ECA8/ECA8\ECA8;
                      dw TestLevelSprites                       ;;ECAA|ECAA+ECAA/ECAA\ECAA;
                      dw TestLevelSprites                       ;;ECAC|ECAC+ECAC/ECAC\ECAC;
                      dw TestLevelSprites                       ;;ECAE|ECAE+ECAE/ECAE\ECAE;
                      dw TestLevelSprites                       ;;ECB0|ECB0+ECB0/ECB0\ECB0;
                      dw TestLevelSprites                       ;;ECB2|ECB2+ECB2/ECB2\ECB2;
                      dw TestLevelSprites                       ;;ECB4|ECB4+ECB4/ECB4\ECB4;
                      dw TestLevelSprites                       ;;ECB6|ECB6+ECB6/ECB6\ECB6;
                      dw TestLevelSprites                       ;;ECB8|ECB8+ECB8/ECB8\ECB8;
                      dw TestLevelSprites                       ;;ECBA|ECBA+ECBA/ECBA\ECBA;
                      dw TestLevelSprites                       ;;ECBC|ECBC+ECBC/ECBC\ECBC;
                      dw TestLevelSprites                       ;;ECBE|ECBE+ECBE/ECBE\ECBE;
                      dw TestLevelSprites                       ;;ECC0|ECC0+ECC0/ECC0\ECC0;
                      dw TestLevelSprites                       ;;ECC2|ECC2+ECC2/ECC2\ECC2;
                      dw TestLevelSprites                       ;;ECC4|ECC4+ECC4/ECC4\ECC4;
                      dw TestLevelSprites                       ;;ECC6|ECC6+ECC6/ECC6\ECC6;
                      dw TestLevelSprites                       ;;ECC8|ECC8+ECC8/ECC8\ECC8;
                      dw TestLevelSprites                       ;;ECCA|ECCA+ECCA/ECCA\ECCA;
                      dw TestLevelSprites                       ;;ECCC|ECCC+ECCC/ECCC\ECCC;
                      dw TestLevelSprites                       ;;ECCE|ECCE+ECCE/ECCE\ECCE;
                      dw TestLevelSprites                       ;;ECD0|ECD0+ECD0/ECD0\ECD0;
                      dw TestLevelSprites                       ;;ECD2|ECD2+ECD2/ECD2\ECD2;
                      dw TestLevelSprites                       ;;ECD4|ECD4+ECD4/ECD4\ECD4;
                      dw TestLevelSprites                       ;;ECD6|ECD6+ECD6/ECD6\ECD6;
                      dw TestLevelSprites                       ;;ECD8|ECD8+ECD8/ECD8\ECD8;
                      dw TestLevelSprites                       ;;ECDA|ECDA+ECDA/ECDA\ECDA;
                      dw TestLevelSprites                       ;;ECDC|ECDC+ECDC/ECDC\ECDC;
                      dw TestLevelSprites                       ;;ECDE|ECDE+ECDE/ECDE\ECDE;
                      dw TestLevelSprites                       ;;ECE0|ECE0+ECE0/ECE0\ECE0;
                      dw TestLevelSprites                       ;;ECE2|ECE2+ECE2/ECE2\ECE2;
                      dw TestLevelSprites                       ;;ECE4|ECE4+ECE4/ECE4\ECE4;
                      dw TestLevelSprites                       ;;ECE6|ECE6+ECE6/ECE6\ECE6;
                      dw TestLevelSprites                       ;;ECE8|ECE8+ECE8/ECE8\ECE8;
                      dw TestLevelSprites                       ;;ECEA|ECEA+ECEA/ECEA\ECEA;
                      dw TestLevelSprites                       ;;ECEC|ECEC+ECEC/ECEC\ECEC;
                      dw TestLevelSprites                       ;;ECEE|ECEE+ECEE/ECEE\ECEE;
                      dw TestLevelSprites                       ;;ECF0|ECF0+ECF0/ECF0\ECF0;
                      dw TestLevelSprites                       ;;ECF2|ECF2+ECF2/ECF2\ECF2;
                      dw TestLevelSprites                       ;;ECF4|ECF4+ECF4/ECF4\ECF4;
                      dw TestLevelSprites                       ;;ECF6|ECF6+ECF6/ECF6\ECF6;
                      dw TestLevelSprites                       ;;ECF8|ECF8+ECF8/ECF8\ECF8;
                      dw TestLevelSprites                       ;;ECFA|ECFA+ECFA/ECFA\ECFA;
                      dw TestLevelSprites                       ;;ECFC|ECFC+ECFC/ECFC\ECFC;
                      dw TestLevelSprites                       ;;ECFE|ECFE+ECFE/ECFE\ECFE;
                      dw TestLevelSprites                       ;;ED00|ED00+ED00/ED00\ED00;
                      dw TestLevelSprites                       ;;ED02|ED02+ED02/ED02\ED02;
                      dw TestLevelSprites                       ;;ED04|ED04+ED04/ED04\ED04;
                      dw TestLevelSprites                       ;;ED06|ED06+ED06/ED06\ED06;
                      dw TestLevelSprites                       ;;ED08|ED08+ED08/ED08\ED08;
                      dw TestLevelSprites                       ;;ED0A|ED0A+ED0A/ED0A\ED0A;
                      dw TestLevelSprites                       ;;ED0C|ED0C+ED0C/ED0C\ED0C;
                      dw TestLevelSprites                       ;;ED0E|ED0E+ED0E/ED0E\ED0E;
                      dw TestLevelSprites                       ;;ED10|ED10+ED10/ED10\ED10;
                      dw TestLevelSprites                       ;;ED12|ED12+ED12/ED12\ED12;
                      dw TestLevelSprites                       ;;ED14|ED14+ED14/ED14\ED14;
                      dw TestLevelSprites                       ;;ED16|ED16+ED16/ED16\ED16;
                      dw TestLevelSprites                       ;;ED18|ED18+ED18/ED18\ED18;
                      dw TestLevelSprites                       ;;ED1A|ED1A+ED1A/ED1A\ED1A;
                      dw TestLevelSprites                       ;;ED1C|ED1C+ED1C/ED1C\ED1C;
                      dw TestLevelSprites                       ;;ED1E|ED1E+ED1E/ED1E\ED1E;
                      dw TestLevelSprites                       ;;ED20|ED20+ED20/ED20\ED20;
                      dw TestLevelSprites                       ;;ED22|ED22+ED22/ED22\ED22;
                      dw TestLevelSprites                       ;;ED24|ED24+ED24/ED24\ED24;
                      dw LemmyCopySprites                       ;;ED26|ED26+ED26/ED26\ED26;
                      dw WendyCopySprites                       ;;ED28|ED28+ED28/ED28\ED28;
                      dw ReznorCopySprites                      ;;ED2A|ED2A+ED2A/ED2A\ED2A;
                      dw LarryCopySprites                       ;;ED2C|ED2C+ED2C/ED2C\ED2C;
                      dw IggyCopySprites                        ;;ED2E|ED2E+ED2E/ED2E\ED2E;
                      dw LudwigCopySprites                      ;;ED30|ED30+ED30/ED30\ED30;
                      dw RoyCopySprites                         ;;ED32|ED32+ED32/ED32\ED32;
                      dw MortonCopySprites                      ;;ED34|ED34+ED34/ED34\ED34;
                      dw BowserCopySprites                      ;;ED36|ED36+ED36/ED36\ED36;
                      dw TestLevelSprites                       ;;ED38|ED38+ED38/ED38\ED38;
                      dw TestLevelSprites                       ;;ED3A|ED3A+ED3A/ED3A\ED3A;
                      dw TestLevelSprites                       ;;ED3C|ED3C+ED3C/ED3C\ED3C;
                      dw TestLevelSprites                       ;;ED3E|ED3E+ED3E/ED3E\ED3E;
                      dw TestLevelSprites                       ;;ED40|ED40+ED40/ED40\ED40;
                      dw TestLevelSprites                       ;;ED42|ED42+ED42/ED42\ED42;
                      dw TestLevelSprites                       ;;ED44|ED44+ED44/ED44\ED44;
                      dw TestLevelSprites                       ;;ED46|ED46+ED46/ED46\ED46;
                      dw TestLevelSprites                       ;;ED48|ED48+ED48/ED48\ED48;
                      dw TestLevelSprites                       ;;ED4A|ED4A+ED4A/ED4A\ED4A;
                      dw TestLevelSprites                       ;;ED4C|ED4C+ED4C/ED4C\ED4C;
                      dw TestLevelSprites                       ;;ED4E|ED4E+ED4E/ED4E\ED4E;
                      dw TestLevelSprites                       ;;ED50|ED50+ED50/ED50\ED50;
                      dw TestLevelSprites                       ;;ED52|ED52+ED52/ED52\ED52;
                      dw TestLevelSprites                       ;;ED54|ED54+ED54/ED54\ED54;
                      dw TestLevelSprites                       ;;ED56|ED56+ED56/ED56\ED56;
                      dw TestLevelSprites                       ;;ED58|ED58+ED58/ED58\ED58;
                      dw TestLevelSprites                       ;;ED5A|ED5A+ED5A/ED5A\ED5A;
                      dw TestLevelSprites                       ;;ED5C|ED5C+ED5C/ED5C\ED5C;
                      dw TestLevelSprites                       ;;ED5E|ED5E+ED5E/ED5E\ED5E;
                      dw TestLevelSprites                       ;;ED60|ED60+ED60/ED60\ED60;
                      dw TestLevelSprites                       ;;ED62|ED62+ED62/ED62\ED62;
                      dw TestLevelSprites                       ;;ED64|ED64+ED64/ED64\ED64;
                      dw TestLevelSprites                       ;;ED66|ED66+ED66/ED66\ED66;
                      dw TestLevelSprites                       ;;ED68|ED68+ED68/ED68\ED68;
                      dw TestLevelSprites                       ;;ED6A|ED6A+ED6A/ED6A\ED6A;
                      dw TestLevelSprites                       ;;ED6C|ED6C+ED6C/ED6C\ED6C;
                      dw TestLevelSprites                       ;;ED6E|ED6E+ED6E/ED6E\ED6E;
                      dw TestLevelSprites                       ;;ED70|ED70+ED70/ED70\ED70;
                      dw TestLevelSprites                       ;;ED72|ED72+ED72/ED72\ED72;
                      dw TestLevelSprites                       ;;ED74|ED74+ED74/ED74\ED74;
                      dw TestLevelSprites                       ;;ED76|ED76+ED76/ED76\ED76;
                      dw TestLevelSprites                       ;;ED78|ED78+ED78/ED78\ED78;
                      dw EmptySprites                           ;;ED7A|ED7A+ED7A/ED7A\ED7A;
                      dw CI1Sub2Sprites0BE                      ;;ED7C|ED7C+ED7C/ED7C\ED7C;
                      dw CBASub1Sprites0BF                      ;;ED7E|ED7E+ED7E/ED7E\ED7E;
                      dw CI5Sub2Sprites0C0                      ;;ED80|ED80+ED80/ED80\ED80;
                      dw CMSub1Sprites0C1                       ;;ED82|ED82+ED82/ED82\ED82;
                      dw DS1Sub1Sprites0C2                      ;;ED84|ED84+ED84/ED84\ED84;
                      dw DP4Sub1Sprites0C3                      ;;ED86|ED86+ED86/ED86\ED86;
                      dw GHNormalExitSprites                    ;;ED88|ED88+ED88/ED88\ED88;
                      dw IntroSprites0C5                        ;;ED8A|ED8A+ED8A/ED8A\ED8A;
                      dw SubNormalExitSprites                   ;;ED8C|ED8C+ED8C/ED8C\ED8C;
                      dw TitleScrSprites0C7                     ;;ED8E|ED8E+ED8E/ED8E\ED8E;
                      dw YoshiWingsSprites0C8                   ;;ED90|ED90+ED90/ED90\ED90;
                      dw GSPSub1Sprites0C9                      ;;ED92|ED92+ED92/ED92\ED92;
                      dw YSPSub1Sprites0CA                      ;;ED94|ED94+ED94/ED94\ED94;
                      dw SubNormalExitSprites                   ;;ED96|ED96+ED96/ED96\ED96;
                      dw C5Sub1Sprites0CC                       ;;ED98|ED98+ED98/ED98\ED98;
                      dw CI2Sub8Sprites0CD                      ;;ED9A|ED9A+ED9A/ED9A\ED9A;
                      dw CI2Sub4Sprites0CE                      ;;ED9C|ED9C+ED9C/ED9C\ED9C;
                      dw CI2Sub3Sprites0CF                      ;;ED9E|ED9E+ED9E/ED9E\ED9E;
                      dw CI1Sprites022                          ;;EDA0|EDA0+EDA0/EDA0\EDA0;
                      dw CI1Sprites022                          ;;EDA2|EDA2+EDA2/EDA2\EDA2;
                      dw DP4Sub1Sprites0D2                      ;;EDA4|EDA4+EDA4/EDA4\EDA4;
                      dw C6Sub2Sprites0D3                       ;;EDA6|EDA6+EDA6/EDA6\EDA6;
                      dw C6Sub1Sprites0D4                       ;;EDA8|EDA8+EDA8/EDA8\EDA8;
                      dw ReznorSubSprites                       ;;EDAA|EDAA+EDAA/EDAA\EDAA;
                      dw FFSub1Sprites0D6                       ;;EDAC|EDAC+EDAC/EDAC\EDAC;
                      dw CI3Sub1Sprites0D7                      ;;EDAE|EDAE+EDAE/EDAE\EDAE;
                      dw VS2Sub1Sprites0D8                      ;;EDB0|EDB0+EDB0/EDB0\EDB0;
                      dw C4Sub4Sprites0D9                       ;;EDB2|EDB2+EDB2/EDB2\EDB2;
                      dw EmptySprites                           ;;EDB4|EDB4+EDB4/EDB4\EDB4;
                      dw C4Sub3Sprites0DB                       ;;EDB6|EDB6+EDB6/EDB6\EDB6;
                      dw C4Sub2Sprites0DC                       ;;EDB8|EDB8+EDB8/EDB8\EDB8;
                      dw BB2Sub1Sprites0DD                      ;;EDBA|EDBA+EDBA/EDBA\EDBA;
                      dw DGHSub1Sprites0F9                      ;;EDBC|EDBC+EDBC/EDBC\EDBC;
                      dw ReznorSubSprites                       ;;EDBE|EDBE+EDBE/EDBE\EDBE;
                      dw VFSub1Sprites0E0                       ;;EDC0|EDC0+EDC0/EDC0\EDC0;
                      dw VFSub1Sprites0E0                       ;;EDC2|EDC2+EDC2/EDC2\EDC2;
                      dw ReznorSubSprites                       ;;EDC4|EDC4+EDC4/EDC4\EDC4;
                      dw DP1Sub2Sprites0E3                      ;;EDC6|EDC6+EDC6/EDC6\EDC6;
                      dw DSHSub4Sprites0E4                      ;;EDC8|EDC8+EDC8/EDC8\EDC8;
                      dw C2Sub4Sprites0E5                       ;;EDCA|EDCA+EDCA/EDCA\EDCA;
                      dw EmptySprites                           ;;EDCC|EDCC+EDCC/EDCC\EDCC;
                      dw C2Sub3Sprites0E7                       ;;EDCE|EDCE+EDCE/EDCE\EDCE;
                      dw C2Sub2Sprites0E8                       ;;EDD0|EDD0+EDD0/EDD0\EDD0;
                      dw DP2Sub1Sprites0E9                      ;;EDD2|EDD2+EDD2/EDD2\EDD2;
                      dw CI4Sub1Sprites0EA                      ;;EDD4|EDD4+EDD4/EDD4\EDD4;
                      dw SubSecretExitSprites                   ;;EDD6|EDD6+EDD6/EDD6\EDD6;
                      dw DSHSprites013                          ;;EDD8|EDD8+EDD8/EDD8\EDD8;
                      dw DSHSub1Sprites0ED                      ;;EDDA|EDDA+EDDA/EDDA\EDDA;
                      dw DSHSprites013                          ;;EDDC|EDDC+EDDC/EDDC\EDDC;
                      dw CFSub1Sprites0EF                       ;;EDDE|EDDE+EDDE/EDDE\EDDE;
                      dw GHNormalExitSprites                    ;;EDE0|EDE0+EDE0/EDE0\EDE0;
                      dw DSHSub2Sprites0F1                      ;;EDE2|EDE2+EDE2/EDE2\EDE2;
                      dw DSHSub1Sprites0ED                      ;;EDE4|EDE4+EDE4/EDE4\EDE4;
                      dw SubNormalExitSprites                   ;;EDE6|EDE6+EDE6/EDE6\EDE6;
                      dw EmptySprites                           ;;EDE8|EDE8+EDE8/EDE8\EDE8;
                      dw CI1Sprites022                          ;;EDEA|EDEA+EDEA/EDEA\EDEA;
                      dw CI1Sprites022                          ;;EDEC|EDEC+EDEC/EDEC\EDEC;
                      dw SGSSub2Sprites0F7                      ;;EDEE|EDEE+EDEE/EDEE\EDEE;
                      dw SGSSub1Sprites0F8                      ;;EDF0|EDF0+EDF0/EDF0\EDF0;
                      dw DGHSub1Sprites0F9                      ;;EDF2|EDF2+EDF2/EDF2\EDF2;
                      dw EmptySprites                           ;;EDF4|EDF4+EDF4/EDF4\EDF4;
                      dw GHNormalExitSprites                    ;;EDF6|EDF6+EDF6/EDF6\EDF6;
                      dw CGHSub1Sprites0FC                      ;;EDF8|EDF8+EDF8/EDF8\EDF8;
                      dw EmptySprites                           ;;EDFA|EDFA+EDFA/EDFA\EDFA;
                      dw DGHSub2Sprites0FE                      ;;EDFC|EDFC+EDFC/EDFC\EDFC;
                      dw SubNormalExitSprites                   ;;EDFE|EDFE+EDFE/EDFE\EDFE;
                      dw BonusGameSprites                       ;;EE00|EE00+EE00/EE00\EE00;
                      dw C1Sprites101                           ;;EE02|EE02+EE02/EE02\EE02;
                      dw YI4Sprites102                          ;;EE04|EE04+EE04/EE04\EE04;
                      dw YI3Spirtes103                          ;;EE06|EE06+EE06/EE06\EE06;
                      dw YHSprites104                           ;;EE08|EE08+EE08/EE08\EE08;
                      dw YI1Sprites105                          ;;EE0A|EE0A+EE0A/EE0A\EE0A;
                      dw YI2Sprites106                          ;;EE0C|EE0C+EE0C/EE0C\EE0C;
                      dw VGHSprites107                          ;;EE0E|EE0E+EE0E/EE0E\EE0E;
                      dw TestLevelSprites                       ;;EE10|EE10+EE10/EE10\EE10;
                      dw VS1Sprites109                          ;;EE12|EE12+EE12/EE12\EE12;
                      dw VD3Sprites10A                          ;;EE14|EE14+EE14/EE14\EE14;
                      dw DS2Sprites10B                          ;;EE16|EE16+EE16/EE16\EE16;
                      dw TestLevelSprites                       ;;EE18|EE18+EE18/EE18\EE18;
                      dw FDSprites10D                           ;;EE1A|EE1A+EE1A/EE1A\EE1A;
                      dw BDSprites10E                           ;;EE1C|EE1C+EE1C/EE1C\EE1C;
                      dw VoB4Sprites10F                         ;;EE1E|EE1E+EE1E/EE1E\EE1E;
                      dw C7Sprites110                           ;;EE20|EE20+EE20/EE20\EE20;
                      dw VoBFSprites111                         ;;EE22|EE22+EE22/EE22\EE22;
                      dw TestLevelSprites                       ;;EE24|EE24+EE24/EE24\EE24;
                      dw VoB3Sprites113                         ;;EE26|EE26+EE26/EE26\EE26;
                      dw VoBGHSprites114                        ;;EE28|EE28+EE28/EE28\EE28;
                      dw VoB2Sprites115                         ;;EE2A|EE2A+EE2A/EE2A\EE2A;
                      dw VoB1Sprites116                         ;;EE2C|EE2C+EE2C/EE2C\EE2C;
                      dw CSSprites117                           ;;EE2E|EE2E+EE2E/EE2E\EE2E;
                      dw VD2Sprites118                          ;;EE30|EE30+EE30/EE30\EE30;
                      dw VD4Sprites119                          ;;EE32|EE32+EE32/EE32\EE32;
                      dw VD1Sprites11A                          ;;EE34|EE34+EE34/EE34\EE34;
                      dw RSPSprites11B                          ;;EE36|EE36+EE36/EE36\EE36;
                      dw C3Sprites11C                           ;;EE38|EE38+EE38/EE38\EE38;
                      dw FGHSprites11D                          ;;EE3A|EE3A+EE3A/EE3A\EE3A;
                      dw FoI1Sprites11E                         ;;EE3C|EE3C+EE3C/EE3C\EE3C;
                      dw FoI4Sprites11F                         ;;EE3E|EE3E+EE3E/EE3E\EE3E;
                      dw FoI2Sprites120                         ;;EE40|EE40+EE40/EE40\EE40;
                      dw BSPSprites121                          ;;EE42|EE42+EE42/EE42\EE42;
                      dw FSASprites122                          ;;EE44|EE44+EE44/EE44\EE44;
                      dw FoI3Sprites123                         ;;EE46|EE46+EE46/EE46\EE46;
                      dw TestLevelSprites                       ;;EE48|EE48+EE48/EE48\EE48;
                      dw FunkySprites125                        ;;EE4A|EE4A+EE4A/EE4A\EE4A;
                      dw OutrageousSprites126                   ;;EE4C|EE4C+EE4C/EE4C\EE4C;
                      dw MondoSprites127                        ;;EE4E|EE4E+EE4E/EE4E\EE4E;
                      dw GroovySprites128                       ;;EE50|EE50+EE50/EE50\EE50;
                      dw TestLevelSprites                       ;;EE52|EE52+EE52/EE52\EE52;
                      dw GnarlySprites12A                       ;;EE54|EE54+EE54/EE54\EE54;
                      dw TubularSprites12B                      ;;EE56|EE56+EE56/EE56\EE56;
                      dw WayCoolSprites12C                      ;;EE58|EE58+EE58/EE58\EE58;
                      dw AwesomeSprites12D                      ;;EE5A|EE5A+EE5A/EE5A\EE5A;
                      dw TestLevelSprites                       ;;EE5C|EE5C+EE5C/EE5C\EE5C;
                      dw TestLevelSprites                       ;;EE5E|EE5E+EE5E/EE5E\EE5E;
                      dw SW2Sprites130                          ;;EE60|EE60+EE60/EE60\EE60;
                      dw TestLevelSprites                       ;;EE62|EE62+EE62/EE62\EE62;
                      dw SW3Sprites132                          ;;EE64|EE64+EE64/EE64\EE64;
                      dw TestLevelSprites                       ;;EE66|EE66+EE66/EE66\EE66;
                      dw SW1Sprites134                          ;;EE68|EE68+EE68/EE68\EE68;
                      dw SW4Sprites135                          ;;EE6A|EE6A+EE6A/EE6A\EE6A;
                      dw SW5Sprites136                          ;;EE6C|EE6C+EE6C/EE6C\EE6C;
                      dw TestLevelSprites                       ;;EE6E|EE6E+EE6E/EE6E\EE6E;
                      dw TestLevelSprites                       ;;EE70|EE70+EE70/EE70\EE70;
                      dw TestLevelSprites                       ;;EE72|EE72+EE72/EE72\EE72;
                      dw TestLevelSprites                       ;;EE74|EE74+EE74/EE74\EE74;
                      dw TestLevelSprites                       ;;EE76|EE76+EE76/EE76\EE76;
                      dw TestLevelSprites                       ;;EE78|EE78+EE78/EE78\EE78;
                      dw TestLevelSprites                       ;;EE7A|EE7A+EE7A/EE7A\EE7A;
                      dw TestLevelSprites                       ;;EE7C|EE7C+EE7C/EE7C\EE7C;
                      dw TestLevelSprites                       ;;EE7E|EE7E+EE7E/EE7E\EE7E;
                      dw TestLevelSprites                       ;;EE80|EE80+EE80/EE80\EE80;
                      dw TestLevelSprites                       ;;EE82|EE82+EE82/EE82\EE82;
                      dw TestLevelSprites                       ;;EE84|EE84+EE84/EE84\EE84;
                      dw TestLevelSprites                       ;;EE86|EE86+EE86/EE86\EE86;
                      dw TestLevelSprites                       ;;EE88|EE88+EE88/EE88\EE88;
                      dw TestLevelSprites                       ;;EE8A|EE8A+EE8A/EE8A\EE8A;
                      dw TestLevelSprites                       ;;EE8C|EE8C+EE8C/EE8C\EE8C;
                      dw TestLevelSprites                       ;;EE8E|EE8E+EE8E/EE8E\EE8E;
                      dw TestLevelSprites                       ;;EE90|EE90+EE90/EE90\EE90;
                      dw TestLevelSprites                       ;;EE92|EE92+EE92/EE92\EE92;
                      dw TestLevelSprites                       ;;EE94|EE94+EE94/EE94\EE94;
                      dw TestLevelSprites                       ;;EE96|EE96+EE96/EE96\EE96;
                      dw TestLevelSprites                       ;;EE98|EE98+EE98/EE98\EE98;
                      dw TestLevelSprites                       ;;EE9A|EE9A+EE9A/EE9A\EE9A;
                      dw TestLevelSprites                       ;;EE9C|EE9C+EE9C/EE9C\EE9C;
                      dw TestLevelSprites                       ;;EE9E|EE9E+EE9E/EE9E\EE9E;
                      dw TestLevelSprites                       ;;EEA0|EEA0+EEA0/EEA0\EEA0;
                      dw TestLevelSprites                       ;;EEA2|EEA2+EEA2/EEA2\EEA2;
                      dw TestLevelSprites                       ;;EEA4|EEA4+EEA4/EEA4\EEA4;
                      dw TestLevelSprites                       ;;EEA6|EEA6+EEA6/EEA6\EEA6;
                      dw TestLevelSprites                       ;;EEA8|EEA8+EEA8/EEA8\EEA8;
                      dw TestLevelSprites                       ;;EEAA|EEAA+EEAA/EEAA\EEAA;
                      dw TestLevelSprites                       ;;EEAC|EEAC+EEAC/EEAC\EEAC;
                      dw TestLevelSprites                       ;;EEAE|EEAE+EEAE/EEAE\EEAE;
                      dw TestLevelSprites                       ;;EEB0|EEB0+EEB0/EEB0\EEB0;
                      dw TestLevelSprites                       ;;EEB2|EEB2+EEB2/EEB2\EEB2;
                      dw TestLevelSprites                       ;;EEB4|EEB4+EEB4/EEB4\EEB4;
                      dw TestLevelSprites                       ;;EEB6|EEB6+EEB6/EEB6\EEB6;
                      dw TestLevelSprites                       ;;EEB8|EEB8+EEB8/EEB8\EEB8;
                      dw TestLevelSprites                       ;;EEBA|EEBA+EEBA/EEBA\EEBA;
                      dw TestLevelSprites                       ;;EEBC|EEBC+EEBC/EEBC\EEBC;
                      dw TestLevelSprites                       ;;EEBE|EEBE+EEBE/EEBE\EEBE;
                      dw TestLevelSprites                       ;;EEC0|EEC0+EEC0/EEC0\EEC0;
                      dw TestLevelSprites                       ;;EEC2|EEC2+EEC2/EEC2\EEC2;
                      dw TestLevelSprites                       ;;EEC4|EEC4+EEC4/EEC4\EEC4;
                      dw TestLevelSprites                       ;;EEC6|EEC6+EEC6/EEC6\EEC6;
                      dw TestLevelSprites                       ;;EEC8|EEC8+EEC8/EEC8\EEC8;
                      dw TestLevelSprites                       ;;EECA|EECA+EECA/EECA\EECA;
                      dw TestLevelSprites                       ;;EECC|EECC+EECC/EECC\EECC;
                      dw TestLevelSprites                       ;;EECE|EECE+EECE/EECE\EECE;
                      dw TestLevelSprites                       ;;EED0|EED0+EED0/EED0\EED0;
                      dw TestLevelSprites                       ;;EED2|EED2+EED2/EED2\EED2;
                      dw TestLevelSprites                       ;;EED4|EED4+EED4/EED4\EED4;
                      dw TestLevelSprites                       ;;EED6|EED6+EED6/EED6\EED6;
                      dw TestLevelSprites                       ;;EED8|EED8+EED8/EED8\EED8;
                      dw TestLevelSprites                       ;;EEDA|EEDA+EEDA/EEDA\EEDA;
                      dw TestLevelSprites                       ;;EEDC|EEDC+EEDC/EEDC\EEDC;
                      dw TestLevelSprites                       ;;EEDE|EEDE+EEDE/EEDE\EEDE;
                      dw TestLevelSprites                       ;;EEE0|EEE0+EEE0/EEE0\EEE0;
                      dw TestLevelSprites                       ;;EEE2|EEE2+EEE2/EEE2\EEE2;
                      dw TestLevelSprites                       ;;EEE4|EEE4+EEE4/EEE4\EEE4;
                      dw TestLevelSprites                       ;;EEE6|EEE6+EEE6/EEE6\EEE6;
                      dw TestLevelSprites                       ;;EEE8|EEE8+EEE8/EEE8\EEE8;
                      dw TestLevelSprites                       ;;EEEA|EEEA+EEEA/EEEA\EEEA;
                      dw TestLevelSprites                       ;;EEEC|EEEC+EEEC/EEEC\EEEC;
                      dw TestLevelSprites                       ;;EEEE|EEEE+EEEE/EEEE\EEEE;
                      dw TestLevelSprites                       ;;EEF0|EEF0+EEF0/EEF0\EEF0;
                      dw TestLevelSprites                       ;;EEF2|EEF2+EEF2/EEF2\EEF2;
                      dw TestLevelSprites                       ;;EEF4|EEF4+EEF4/EEF4\EEF4;
                      dw TestLevelSprites                       ;;EEF6|EEF6+EEF6/EEF6\EEF6;
                      dw TestLevelSprites                       ;;EEF8|EEF8+EEF8/EEF8\EEF8;
                      dw TestLevelSprites                       ;;EEFA|EEFA+EEFA/EEFA\EEFA;
                      dw TestLevelSprites                       ;;EEFC|EEFC+EEFC/EEFC\EEFC;
                      dw TestLevelSprites                       ;;EEFE|EEFE+EEFE/EEFE\EEFE;
                      dw TestLevelSprites                       ;;EF00|EF00+EF00/EF00\EF00;
                      dw TestLevelSprites                       ;;EF02|EF02+EF02/EF02\EF02;
                      dw TestLevelSprites                       ;;EF04|EF04+EF04/EF04\EF04;
                      dw TestLevelSprites                       ;;EF06|EF06+EF06/EF06\EF06;
                      dw TestLevelSprites                       ;;EF08|EF08+EF08/EF08\EF08;
                      dw TestLevelSprites                       ;;EF0A|EF0A+EF0A/EF0A\EF0A;
                      dw TestLevelSprites                       ;;EF0C|EF0C+EF0C/EF0C\EF0C;
                      dw TestLevelSprites                       ;;EF0E|EF0E+EF0E/EF0E\EF0E;
                      dw TestLevelSprites                       ;;EF10|EF10+EF10/EF10\EF10;
                      dw TestLevelSprites                       ;;EF12|EF12+EF12/EF12\EF12;
                      dw TestLevelSprites                       ;;EF14|EF14+EF14/EF14\EF14;
                      dw TestLevelSprites                       ;;EF16|EF16+EF16/EF16\EF16;
                      dw TestLevelSprites                       ;;EF18|EF18+EF18/EF18\EF18;
                      dw TestLevelSprites                       ;;EF1A|EF1A+EF1A/EF1A\EF1A;
                      dw TestLevelSprites                       ;;EF1C|EF1C+EF1C/EF1C\EF1C;
                      dw TestLevelSprites                       ;;EF1E|EF1E+EF1E/EF1E\EF1E;
                      dw TestLevelSprites                       ;;EF20|EF20+EF20/EF20\EF20;
                      dw TestLevelSprites                       ;;EF22|EF22+EF22/EF22\EF22;
                      dw TestLevelSprites                       ;;EF24|EF24+EF24/EF24\EF24;
                      dw WendyCopySprites                       ;;EF26|EF26+EF26/EF26\EF26;
                      dw LemmyCopySprites                       ;;EF28|EF28+EF28/EF28\EF28;
                      dw ReznorCopySprites                      ;;EF2A|EF2A+EF2A/EF2A\EF2A;
                      dw LarryCopySprites                       ;;EF2C|EF2C+EF2C/EF2C\EF2C;
                      dw IggyCopySprites                        ;;EF2E|EF2E+EF2E/EF2E\EF2E;
                      dw LudwigCopySprites                      ;;EF30|EF30+EF30/EF30\EF30;
                      dw RoyCopySprites                         ;;EF32|EF32+EF32/EF32\EF32;
                      dw MortonCopySprites                      ;;EF34|EF34+EF34/EF34\EF34;
                      dw BowserCopySprites                      ;;EF36|EF36+EF36/EF36\EF36;
                      dw TestLevelSprites                       ;;EF38|EF38+EF38/EF38\EF38;
                      dw TestLevelSprites                       ;;EF3A|EF3A+EF3A/EF3A\EF3A;
                      dw TestLevelSprites                       ;;EF3C|EF3C+EF3C/EF3C\EF3C;
                      dw TestLevelSprites                       ;;EF3E|EF3E+EF3E/EF3E\EF3E;
                      dw TestLevelSprites                       ;;EF40|EF40+EF40/EF40\EF40;
                      dw TestLevelSprites                       ;;EF42|EF42+EF42/EF42\EF42;
                      dw TestLevelSprites                       ;;EF44|EF44+EF44/EF44\EF44;
                      dw TestLevelSprites                       ;;EF46|EF46+EF46/EF46\EF46;
                      dw TestLevelSprites                       ;;EF48|EF48+EF48/EF48\EF48;
                      dw TestLevelSprites                       ;;EF4A|EF4A+EF4A/EF4A\EF4A;
                      dw TestLevelSprites                       ;;EF4C|EF4C+EF4C/EF4C\EF4C;
                      dw TestLevelSprites                       ;;EF4E|EF4E+EF4E/EF4E\EF4E;
                      dw TestLevelSprites                       ;;EF50|EF50+EF50/EF50\EF50;
                      dw TestLevelSprites                       ;;EF52|EF52+EF52/EF52\EF52;
                      dw TestLevelSprites                       ;;EF54|EF54+EF54/EF54\EF54;
                      dw TestLevelSprites                       ;;EF56|EF56+EF56/EF56\EF56;
                      dw TestLevelSprites                       ;;EF58|EF58+EF58/EF58\EF58;
                      dw TestLevelSprites                       ;;EF5A|EF5A+EF5A/EF5A\EF5A;
                      dw TestLevelSprites                       ;;EF5C|EF5C+EF5C/EF5C\EF5C;
                      dw TestLevelSprites                       ;;EF5E|EF5E+EF5E/EF5E\EF5E;
                      dw TestLevelSprites                       ;;EF60|EF60+EF60/EF60\EF60;
                      dw TestLevelSprites                       ;;EF62|EF62+EF62/EF62\EF62;
                      dw TestLevelSprites                       ;;EF64|EF64+EF64/EF64\EF64;
                      dw TestLevelSprites                       ;;EF66|EF66+EF66/EF66\EF66;
                      dw TestLevelSprites                       ;;EF68|EF68+EF68/EF68\EF68;
                      dw TestLevelSprites                       ;;EF6A|EF6A+EF6A/EF6A\EF6A;
                      dw TestLevelSprites                       ;;EF6C|EF6C+EF6C/EF6C\EF6C;
                      dw TestLevelSprites                       ;;EF6E|EF6E+EF6E/EF6E\EF6E;
                      dw TestLevelSprites                       ;;EF70|EF70+EF70/EF70\EF70;
                      dw TestLevelSprites                       ;;EF72|EF72+EF72/EF72\EF72;
                      dw TestLevelSprites                       ;;EF74|EF74+EF74/EF74\EF74;
                      dw EmptySprites                           ;;EF76|EF76+EF76/EF76\EF76;
                      dw EmptySprites                           ;;EF78|EF78+EF78/EF78\EF78;
                      dw BDSprites10E                           ;;EF7A|EF7A+EF7A/EF7A\EF7A;
                      dw YI4Sub1Sprites1BE                      ;;EF7C|EF7C+EF7C/EF7C\EF7C;
                      dw VoB4Sub1Sprites1BF                     ;;EF7E|EF7E+EF7E/EF7E\EF7E;
                      dw CSSub1Sprites1C0                       ;;EF80|EF80+EF80/EF80\EF80;
                      dw FoI4Sub1Sprites1C1                     ;;EF82|EF82+EF82/EF82\EF82;
                      dw VD3Sub2Sprites1C2                      ;;EF84|EF84+EF84/EF84\EF84;
                      dw VD2Sub1Sprites1C3                      ;;EF86|EF86+EF86/EF86\EF86;
                      dw GnarlySub1Sprites1C4                   ;;EF88|EF88+EF88/EF88\EF88;
                      dw GnarlySub1Sprites1C4                   ;;EF8A|EF8A+EF8A/EF8A\EF8A;
                      dw DS2Sub1Sprites1C6                      ;;EF8C|EF8C+EF8C/EF8C\EF8C;
                      dw BowserSprites1C7                       ;;EF8E|EF8E+EF8E/EF8E\EF8E;
                      dw YoshiWingsSprites1C8                   ;;EF90|EF90+EF90/EF90\EF90;
                      dw EmptySprites                           ;;EF92|EF92+EF92/EF92\EF92;
                      dw YI2Sub1Sprites1CA                      ;;EF94|EF94+EF94/EF94\EF94;
                      dw EmptySprites                           ;;EF96|EF96+EF96/EF96\EF96;
                      dw FDSub8Sprites1CC                       ;;EF98|EF98+EF98/EF98\EF98;
                      dw FDSub7Sprites1CD                       ;;EF9A|EF9A+EF9A/EF9A\EF9A;
                      dw FDSub6Sprites1CE                       ;;EF9C|EF9C+EF9C/EF9C\EF9C;
                      dw FDSub5Sprites1CF                       ;;EF9E|EF9E+EF9E/EF9E\EF9E;
                      dw FDSprites10D                           ;;EFA0|EFA0+EFA0/EFA0\EFA0;
                      dw FDSub4Sprites1D1                       ;;EFA2|EFA2+EFA2/EFA2\EFA2;
                      dw FDSub3Sprites1D2                       ;;EFA4|EFA4+EFA4/EFA4\EFA4;
                      dw FDSub2Sprites1D3                       ;;EFA6|EFA6+EFA6/EFA6\EFA6;
                      dw FDSub1Sprites1D4                       ;;EFA8|EFA8+EFA8/EFA8\EFA8;
                      dw SubNormalExitSprites                   ;;EFAA|EFAA+EFAA/EFAA\EFAA;
                      dw SubNormalExitSprites                   ;;EFAC|EFAC+EFAC/EFAC\EFAC;
                      dw BSPSub1Sprites1D7                      ;;EFAE|EFAE+EFAE/EFAE\EFAE;
                      dw RSPSub1Sprites1D8                      ;;EFB0|EFB0+EFB0/EFB0\EFB0;
                      dw VoBGHSprites114                        ;;EFB2|EFB2+EFB2/EFB2\EFB2;
                      dw GHNormalExitSprites                    ;;EFB4|EFB4+EFB4/EFB4\EFB4;
                      dw VoBGHSub2Sprites1DB                    ;;EFB6|EFB6+EFB6/EFB6\EFB6;
                      dw VoBGHSub2Sprites1DB                    ;;EFB8|EFB8+EFB8/EFB8\EFB8;
                      dw VoBGHSub1Sprites1DD                    ;;EFBA|EFBA+EFBA/EFBA\EFBA;
                      dw ReznorSubSprites                       ;;EFBC|EFBC+EFBC/EFBC\EFBC;
                      dw FoI4Sub2Sprites1DF                     ;;EFBE|EFBE+EFBE/EFBE\EFBE;
                      dw EmptySprites                           ;;EFC0|EFC0+EFC0/EFC0\EFC0;
                      dw SubNormalExitSprites                   ;;EFC2|EFC2+EFC2/EFC2\EFC2;
                      dw VoB2Sub2Sprites1E2                     ;;EFC4|EFC4+EFC4/EFC4\EFC4;
                      dw VoB2Sub1Sprites1E3                     ;;EFC6|EFC6+EFC6/EFC6\EFC6;
                      dw EmptySprites                           ;;EFC8|EFC8+EFC8/EFC8\EFC8;
                      dw VoB1Sub2Sprites1E5                     ;;EFCA|EFCA+EFCA/EFCA\EFCA;
                      dw GHNormalExitSprites                    ;;EFCC|EFCC+EFCC/EFCC\EFCC;
                      dw SubSecretExitSprites                   ;;EFCE|EFCE+EFCE/EFCE\EFCE;
                      dw FGHSprites11D                          ;;EFD0|EFD0+EFD0/EFD0\EFD0;
                      dw FGHSprites11D                          ;;EFD2|EFD2+EFD2/EFD2\EFD2;
                      dw VGHSub1Sprites1EA                      ;;EFD4|EFD4+EFD4/EFD4\EFD4;
                      dw C7Sub2Sprites1EB                       ;;EFD6|EFD6+EFD6/EFD6\EFD6;
                      dw CSSub3Sprites1EC                       ;;EFD8|EFD8+EFD8/EFD8\EFD8;
                      dw CSSub2Sprites1ED                       ;;EFDA|EFDA+EFDA/EFDA\EFDA;
                      dw SubNormalExitSprites                   ;;EFDC|EFDC+EFDC/EFDC\EFDC;
                      dw VD1Sub1Sprites1EF                      ;;EFDE|EFDE+EFDE/EFDE\EFDE;
                      dw VS1Sub2Sprites1F0                      ;;EFE0|EFE0+EFE0/EFE0\EFE0;
                      dw VS1Sub1Sprites1F1                      ;;EFE2|EFE2+EFE2/EFE2\EFE2;
                      dw C3Sub3Sprites1F2                       ;;EFE4|EFE4+EFE4/EFE4\EFE4;
                      dw C3Sub2Sprites1F3                       ;;EFE6|EFE6+EFE6/EFE6\EFE6;
                      dw EmptySprites                           ;;EFE8|EFE8+EFE8/EFE8\EFE8;
                      dw VD4Sub1Sprites1F5                      ;;EFEA|EFEA+EFEA/EFEA\EFEA;
                      dw C1Sub2Sprites1F6                       ;;EFEC|EFEC+EFEC/EFEC\EFEC;
                      dw EmptySprites                           ;;EFEE|EFEE+EFEE/EFEE\EFEE;
                      dw FoI3Sub2Sprites1F8                     ;;EFF0|EFF0+EFF0/EFF0\EFF0;
                      dw GHNormalExitSprites                    ;;EFF2|EFF2+EFF2/EFF2\EFF2;
                      dw FGHSub1Sprites1FA                      ;;EFF4|EFF4+EFF4/EFF4\EFF4;
                      dw VGHSprites107                          ;;EFF6|EFF6+EFF6/EFF6\EFF6;
                      dw C1Sub1Sprites1FC                       ;;EFF8|EFF8+EFF8/EFF8\EFF8;
                      dw YI3Sub1Sprites1FD                      ;;EFFA|EFFA+EFFA/EFFA\EFFA;
                      dw C7Sub1Sprites1FE                       ;;EFFC|EFFC+EFFC/EFFC\EFFC;
                      dw YI4Sub2Sprites1FF                      ;;EFFE|EFFE+EFFE/EFFE\EFFE;
                                                                ;;                        ;
DATA_05F000:          db $07,$5B,$19,$2B,$1B,$5B,$5B,$5B        ;;F000|F000+F000/F000\F000;
                      db $27,$37,$18,$19,$59,$5B,$29,$1B        ;;F008|F008+F008/F008\F008;
                      db $5B,$58,$05,$5B,$2B,$5B,$1B,$1B        ;;F010|F010+F010/F010\F010;
                      db $51,$0B,$4B,$1B,$07,$52,$0B,$1B        ;;F018|F018+F018/F018\F018;
                      db $57,$1B,$5B,$5B,$5B,$0B,$0B,$0B        ;;F020|F020+F020/F020\F020;
                      db $0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B        ;;F028|F028+F028/F028\F028;
                      db $0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B        ;;F030|F030+F030/F030\F030;
                      db $0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B        ;;F038|F038+F038/F038\F038;
                      db $0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B        ;;F040|F040+F040/F040\F040;
                      db $0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B        ;;F048|F048+F048/F048\F048;
                      db $0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B        ;;F050|F050+F050/F050\F050;
                      db $0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B        ;;F058|F058+F058/F058\F058;
                      db $0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B        ;;F060|F060+F060/F060\F060;
                      db $0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B        ;;F068|F068+F068/F068\F068;
                      db $0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B        ;;F070|F070+F070/F070\F070;
                      db $0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B        ;;F078|F078+F078/F078\F078;
                      db $0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B        ;;F080|F080+F080/F080\F080;
                      db $0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B        ;;F088|F088+F088/F088\F088;
                      db $0B,$0B,$0B,$57,$57,$0B,$0B,$0B        ;;F090|F090+F090/F090\F090;
                      db $0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B        ;;F098|F098+F098/F098\F098;
                      db $0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B        ;;F0A0|F0A0+F0A0/F0A0\F0A0;
                      db $0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B        ;;F0A8|F0A8+F0A8/F0A8\F0A8;
                      db $0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B        ;;F0B0|F0B0+F0B0/F0B0\F0B0;
                      db $0B,$0B,$0B,$0B,$0B,$6C,$18,$19        ;;F0B8|F0B8+F0B8/F0B8\F0B8;
                      db $1A,$51,$0D,$1A,$2B,$5B,$1B,$5A        ;;F0C0|F0C0+F0C0/F0C0\F0C0;
                      db $6B,$2B,$2B,$18,$0B,$1B,$1B,$5B        ;;F0C8|F0C8+F0C8/F0C8\F0C8;
                      db $59,$58,$19,$57,$49,$0B,$5B,$52        ;;F0D0|F0D0+F0D0/F0D0\F0D0;
                      db $19,$0B,$6C,$0C,$48,$18,$5A,$0B        ;;F0D8|F0D8+F0D8/F0D8\F0D8;
                      db $59,$59,$0B,$5A,$2A,$0B,$6C,$7D        ;;F0E0|F0E0+F0E0/F0E0\F0E0;
                      db $5B,$5A,$00,$2B,$5B,$5B,$5B,$17        ;;F0E8|F0E8+F0E8/F0E8\F0E8;
                      db $2B,$5B,$58,$18,$6C,$59,$58,$01        ;;F0F0|F0F0+F0F0/F0F0\F0F0;
                      db $17,$5B,$1B,$2B,$1B,$6C,$5A,$2A        ;;F0F8|F0F8+F0F8/F0F8\F0F8;
                      db $07,$1B,$18,$5B,$0B,$5B,$5B,$5B        ;;F100|F100+F100/F100\F100;
                      db $0B,$0D,$58,$5B,$0B,$1A,$1B,$58        ;;F108|F108+F108/F108\F108;
                      db $5B,$48,$0B,$1B,$0A,$4B,$5B,$57        ;;F110|F110+F110/F110\F110;
                      db $52,$17,$57,$2B,$17,$29,$1C,$5B        ;;F118|F118+F118/F118\F118;
                      db $59,$2B,$56,$1C,$0B,$5B,$1C,$1B        ;;F120|F120+F120/F120\F120;
                      db $1A,$0B,$05,$58,$5B,$19,$0B,$0B        ;;F128|F128+F128/F128\F128;
                      db $58,$0B,$5B,$0B,$01,$5B,$5B,$0B        ;;F130|F130+F130/F130\F130;
                      db $0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B        ;;F138|F138+F138/F138\F138;
                      db $0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B        ;;F140|F140+F140/F140\F140;
                      db $0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B        ;;F148|F148+F148/F148\F148;
                      db $0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B        ;;F150|F150+F150/F150\F150;
                      db $0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B        ;;F158|F158+F158/F158\F158;
                      db $0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B        ;;F160|F160+F160/F160\F160;
                      db $0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B        ;;F168|F168+F168/F168\F168;
                      db $0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B        ;;F170|F170+F170/F170\F170;
                      db $0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B        ;;F178|F178+F178/F178\F178;
                      db $0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B        ;;F180|F180+F180/F180\F180;
                      db $0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B        ;;F188|F188+F188/F188\F188;
                      db $0B,$0B,$0B,$57,$57,$0B,$0B,$0B        ;;F190|F190+F190/F190\F190;
                      db $0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B        ;;F198|F198+F198/F198\F198;
                      db $0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B        ;;F1A0|F1A0+F1A0/F1A0\F1A0;
                      db $0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B        ;;F1A8|F1A8+F1A8/F1A8\F1A8;
                      db $0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B        ;;F1B0|F1B0+F1B0/F1B0\F1B0;
                      db $0B,$0B,$0B,$6C,$6C,$1B,$5A,$16        ;;F1B8|F1B8+F1B8/F1B8\F1B8;
                      db $1A,$19,$16,$16,$58,$5C,$1A,$0B        ;;F1C0|F1C0+F1C0/F1C0\F1C0;
                      db $5D,$19,$19,$19,$1B,$1B,$73,$4B        ;;F1C8|F1C8+F1C8/F1C8\F1C8;
                      db $1A,$59,$59,$1B,$1B,$1B,$1B,$2B        ;;F1D0|F1D0+F1D0/F1D0\F1D0;
                      db $2B,$09,$2B,$0B,$0B,$09,$0B,$29        ;;F1D8|F1D8+F1D8/F1D8\F1D8;
                      db $52,$1B,$48,$4B,$6C,$5B,$2B,$2B        ;;F1E0|F1E0+F1E0/F1E0\F1E0;
                      db $2B,$29,$5B,$0B,$4B,$01,$5B,$49        ;;F1E8|F1E8+F1E8/F1E8\F1E8;
                      db $1B,$1B,$57,$48,$1B,$19,$0B,$6C        ;;F1F0|F1F0+F1F0/F1F0\F1F0;
                      db $28,$2B,$1B,$5A,$1B,$19,$19,$1B        ;;F1F8|F1F8+F1F8/F1F8\F1F8;
Lay3EntranceXPosDat:  db $20,$00,$80,$01,$00,$01,$00,$00        ;;F200|F200+F200/F200\F200; format LLEEEXXX
                      db $00,$C0,$38,$39,$00,$00,$00,$00        ;;F208|F208+F208/F208\F208; LL - layer 3 setting
                      db $00,$F8,$00,$00,$00,$00,$00,$00        ;;F210|F210+F210/F210\F210; EEE - entrance setting
                      db $F8,$00,$C0,$00,$00,$01,$00,$80        ;;F218|F218+F218/F218\F218; XXX - x position setting (index to lo/hi position tables)
                      db $01,$00,$00,$00,$00,$00,$00,$00        ;;F220|F220+F220/F220\F220;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F228|F228+F228/F228\F228;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F230|F230+F230/F230\F230;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F238|F238+F238/F238\F238;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F240|F240+F240/F240\F240;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F248|F248+F248/F248\F248;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F250|F250+F250/F250\F250;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F258|F258+F258/F258\F258;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F260|F260+F260/F260\F260;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F268|F268+F268/F268\F268;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F270|F270+F270/F270\F270;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F278|F278+F278/F278\F278;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F280|F280+F280/F280\F280;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F288|F288+F288/F288\F288;
                      db $00,$00,$00,$01,$01,$00,$00,$00        ;;F290|F290+F290/F290\F290;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F298|F298+F298/F298\F298;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F2A0|F2A0+F2A0/F2A0\F2A0;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F2A8|F2A8+F2A8/F2A8\F2A8;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F2B0|F2B0+F2B0/F2B0\F2B0;
                      db $00,$00,$00,$00,$00,$10,$A0,$20        ;;F2B8|F2B8+F2B8/F2B8\F2B8;
                      db $18,$A0,$18,$18,$00,$01,$18,$00        ;;F2C0|F2C0+F2C0/F2C0\F2C0;
                      db $01,$10,$10,$10,$00,$10,$10,$10        ;;F2C8|F2C8+F2C8/F2C8\F2C8;
                      db $31,$30,$20,$01,$C0,$00,$00,$18        ;;F2D0|F2D0+F2D0/F2D0\F2D0;
                      db $20,$00,$10,$01,$C1,$20,$01,$00        ;;F2D8|F2D8+F2D8/F2D8\F2D8;
                      db $39,$39,$00,$18,$00,$00,$10,$C0        ;;F2E0|F2E0+F2E0/F2E0\F2E0;
                      db $01,$18,$01,$00,$00,$03,$03,$00        ;;F2E8|F2E8+F2E8/F2E8\F2E8;
                      db $00,$01,$00,$10,$10,$31,$30,$20        ;;F2F0|F2F0+F2F0/F2F0\F2F0;
                      db $38,$00,$00,$00,$00,$10,$01,$18        ;;F2F8|F2F8+F2F8/F2F8\F2F8;
                      db $20,$00,$80,$00,$01,$00,$00,$00        ;;F300|F300+F300/F300\F300;
                      db $00,$01,$00,$28,$00,$00,$00,$00        ;;F308|F308+F308/F308\F308;
                      db $01,$C0,$00,$00,$00,$C0,$00,$00        ;;F310|F310+F310/F310\F310;
                      db $01,$00,$00,$00,$01,$00,$00,$00        ;;F318|F318+F318/F318\F318;
                      db $38,$00,$00,$00,$00,$00,$00,$40        ;;F320|F320+F320/F320\F320;
                      db $00,$00,$01,$01,$00,$28,$00,$00        ;;F328|F328+F328/F328\F328;
                      db $F8,$00,$00,$00,$01,$00,$00,$00        ;;F330|F330+F330/F330\F330;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F338|F338+F338/F338\F338;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F340|F340+F340/F340\F340;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F348|F348+F348/F348\F348;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F350|F350+F350/F350\F350;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F358|F358+F358/F358\F358;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F360|F360+F360/F360\F360;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F368|F368+F368/F368\F368;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F370|F370+F370/F370\F370;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F378|F378+F378/F378\F378;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F380|F380+F380/F380\F380;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F388|F388+F388/F388\F388;
                      db $00,$00,$00,$01,$01,$00,$00,$00        ;;F390|F390+F390/F390\F390;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F398|F398+F398/F398\F398;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F3A0|F3A0+F3A0/F3A0\F3A0;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F3A8|F3A8+F3A8/F3A8\F3A8;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F3B0|F3B0+F3B0/F3B0\F3B0;
                      db $00,$00,$00,$10,$10,$00,$18,$28        ;;F3B8|F3B8+F3B8/F3B8\F3B8;
                      db $18,$F8,$28,$28,$1B,$19,$18,$00        ;;F3C0|F3C0+F3C0/F3C0\F3C0;
                      db $00,$20,$20,$20,$00,$00,$F8,$C0        ;;F3C8|F3C8+F3C8/F3C8\F3C8;
                      db $00,$00,$00,$00,$80,$18,$10,$10        ;;F3D0|F3D0+F3D0/F3D0\F3D0;
                      db $10,$03,$00,$03,$00,$01,$00,$20        ;;F3D8|F3D8+F3D8/F3D8\F3D8;
                      db $18,$10,$D1,$D1,$10,$18,$00,$00        ;;F3E0|F3E0+F3E0/F3E0\F3E0;
                      db $01,$01,$01,$00,$D1,$10,$10,$D0        ;;F3E8|F3E8+F3E8/F3E8\F3E8;
                      db $09,$11,$01,$C0,$00,$20,$00,$10        ;;F3F0|F3F0+F3F0/F3F0\F3F0;
                      db $20,$00,$01,$01,$80,$20,$00,$10        ;;F3F8|F3F8+F3F8/F3F8\F3F8;
DATA_05F400:          db $0A,$9A,$8A,$0A,$0A,$AA,$AA,$0A        ;;F400|F400+F400/F400\F400;
                      db $0A,$0A,$0A,$0A,$0A,$9A,$0A,$9A        ;;F408|F408+F408/F408\F408;
                      db $9A,$0A,$02,$0A,$0A,$9A,$9A,$9A        ;;F410|F410+F410/F410\F410;
                      db $03,$0A,$BA,$8A,$BA,$00,$0A,$0A        ;;F418|F418+F418/F418\F418;
                      db $0A,$0A,$9A,$9A,$0A,$0A,$0A,$0A        ;;F420|F420+F420/F420\F420;
                      db $0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A        ;;F428|F428+F428/F428\F428;
                      db $0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A        ;;F430|F430+F430/F430\F430;
                      db $0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A        ;;F438|F438+F438/F438\F438;
                      db $0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A        ;;F440|F440+F440/F440\F440;
                      db $0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A        ;;F448|F448+F448/F448\F448;
                      db $0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A        ;;F450|F450+F450/F450\F450;
                      db $0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A        ;;F458|F458+F458/F458\F458;
                      db $0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A        ;;F460|F460+F460/F460\F460;
                      db $0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A        ;;F468|F468+F468/F468\F468;
                      db $0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A        ;;F470|F470+F470/F470\F470;
                      db $0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A        ;;F478|F478+F478/F478\F478;
                      db $0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A        ;;F480|F480+F480/F480\F480;
                      db $0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A        ;;F488|F488+F488/F488\F488;
                      db $0A,$0A,$0A,$0A,$0A,$00,$00,$00        ;;F490|F490+F490/F490\F490;
                      db $00,$00,$00,$00,$0A,$0A,$0A,$0A        ;;F498|F498+F498/F498\F498;
                      db $0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A        ;;F4A0|F4A0+F4A0/F4A0\F4A0;
                      db $0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A        ;;F4A8|F4A8+F4A8/F4A8\F4A8;
                      db $0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A        ;;F4B0|F4B0+F4B0/F4B0\F4B0;
                      db $0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A        ;;F4B8|F4B8+F4B8/F4B8\F4B8;
                      db $0A,$0A,$0A,$0A,$0A,$09,$0A,$0A        ;;F4C0|F4C0+F4C0/F4C0\F4C0;
                      db $0A,$0A,$0A,$0A,$00,$0A,$0A,$0A        ;;F4C8|F4C8+F4C8/F4C8\F4C8;
                      db $9A,$9A,$0A,$0A,$0B,$00,$0A,$03        ;;F4D0|F4D0+F4D0/F4D0\F4D0;
                      db $0A,$00,$0A,$0A,$0A,$0A,$0A,$00        ;;F4D8|F4D8+F4D8/F4D8\F4D8;
                      db $0A,$0A,$00,$0A,$0A,$00,$0A,$03        ;;F4E0|F4E0+F4E0/F4E0\F4E0;
                      db $0A,$0A,$00,$0A,$0A,$0A,$0A,$0A        ;;F4E8|F4E8+F4E8/F4E8\F4E8;
                      db $0A,$0A,$0A,$0A,$0A,$0A,$0A,$03        ;;F4F0|F4F0+F4F0/F4F0\F4F0;
                      db $0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A        ;;F4F8|F4F8+F4F8/F4F8\F4F8;
                      db $0A,$7A,$0A,$9A,$0A,$9A,$9A,$0A        ;;F500|F500+F500/F500\F500;
                      db $0A,$02,$FA,$0A,$0A,$0A,$6A,$9A        ;;F508|F508+F508/F508\F508;
                      db $7A,$0A,$0A,$8A,$0A,$7A,$9A,$7A        ;;F510|F510+F510/F510\F510;
                      db $A0,$9A,$FA,$0A,$9A,$0A,$9A,$9A        ;;F518|F518+F518/F518\F518;
                      db $0A,$0A,$05,$9A,$0A,$0A,$9A,$0A        ;;F520|F520+F520/F520\F520;
                      db $0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A        ;;F528|F528+F528/F528\F528;
                      db $0A,$0A,$0A,$0A,$03,$9A,$0A,$0A        ;;F530|F530+F530/F530\F530;
                      db $0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A        ;;F538|F538+F538/F538\F538;
                      db $0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A        ;;F540|F540+F540/F540\F540;
                      db $0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A        ;;F548|F548+F548/F548\F548;
                      db $0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A        ;;F550|F550+F550/F550\F550;
                      db $0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A        ;;F558|F558+F558/F558\F558;
                      db $0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A        ;;F560|F560+F560/F560\F560;
                      db $0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A        ;;F568|F568+F568/F568\F568;
                      db $0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A        ;;F570|F570+F570/F570\F570;
                      db $0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A        ;;F578|F578+F578/F578\F578;
                      db $0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A        ;;F580|F580+F580/F580\F580;
                      db $0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A        ;;F588|F588+F588/F588\F588;
                      db $0A,$0A,$0A,$0A,$0A,$00,$00,$00        ;;F590|F590+F590/F590\F590;
                      db $00,$00,$00,$00,$0A,$0A,$0A,$0A        ;;F598|F598+F598/F598\F598;
                      db $0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A        ;;F5A0|F5A0+F5A0/F5A0\F5A0;
                      db $0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A        ;;F5A8|F5A8+F5A8/F5A8\F5A8;
                      db $0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A        ;;F5B0|F5B0+F5B0/F5B0\F5B0;
                      db $0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A        ;;F5B8|F5B8+F5B8/F5B8\F5B8;
                      db $0A,$0A,$0A,$0A,$0A,$0A,$0A,$00        ;;F5C0|F5C0+F5C0/F5C0\F5C0;
                      db $0A,$0A,$0A,$0A,$0A,$0A,$03,$0A        ;;F5C8|F5C8+F5C8/F5C8\F5C8;
                      db $0A,$09,$0A,$0A,$0A,$0A,$0A,$0A        ;;F5D0|F5D0+F5D0/F5D0\F5D0;
                      db $0A,$0A,$0A,$0A,$0A,$0A,$00,$0A        ;;F5D8|F5D8+F5D8/F5D8\F5D8;
                      db $03,$0A,$0B,$0A,$0A,$0A,$0A,$0A        ;;F5E0|F5E0+F5E0/F5E0\F5E0;
                      db $0A,$0A,$0A,$00,$0A,$03,$0A,$0A        ;;F5E8|F5E8+F5E8/F5E8\F5E8;
                      db $0A,$0A,$0A,$0A,$0A,$0A,$00,$0A        ;;F5F0|F5F0+F5F0/F5F0\F5F0;
                      db $0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A        ;;F5F8|F5F8+F5F8/F5F8\F5F8;
DATA_05F600:          db $00,$00,$80,$00,$00,$80,$00,$00        ;;F600|F600+F600/F600\F600;
                      db $00,$00,$00,$00,$80,$80,$00,$80        ;;F608|F608+F608/F608\F608;
                      db $00,$00,$64,$00,$00,$00,$00,$00        ;;F610|F610+F610/F610\F610;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F618|F618+F618/F618\F618;
                      db $00,$00,$80,$80,$00,$00,$00,$00        ;;F620|F620+F620/F620\F620;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F628|F628+F628/F628\F628;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F630|F630+F630/F630\F630;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F638|F638+F638/F638\F638;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F640|F640+F640/F640\F640;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F648|F648+F648/F648\F648;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F650|F650+F650/F650\F650;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F658|F658+F658/F658\F658;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F660|F660+F660/F660\F660;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F668|F668+F668/F668\F668;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F670|F670+F670/F670\F670;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F678|F678+F678/F678\F678;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F680|F680+F680/F680\F680;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F688|F688+F688/F688\F688;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F690|F690+F690/F690\F690;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F698|F698+F698/F698\F698;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F6A0|F6A0+F6A0/F6A0\F6A0;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F6A8|F6A8+F6A8/F6A8\F6A8;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F6B0|F6B0+F6B0/F6B0\F6B0;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F6B8|F6B8+F6B8/F6B8\F6B8;
                      db $00,$03,$64,$00,$00,$00,$00,$00        ;;F6C0|F6C0+F6C0/F6C0\F6C0;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F6C8|F6C8+F6C8/F6C8\F6C8;
                      db $10,$07,$00,$00,$00,$00,$00,$00        ;;F6D0|F6D0+F6D0/F6D0\F6D0;
                      db $04,$00,$00,$64,$09,$00,$01,$00        ;;F6D8|F6D8+F6D8/F6D8\F6D8;
                      db $04,$00,$00,$00,$00,$00,$00,$67        ;;F6E0|F6E0+F6E0/F6E0\F6E0;
                      db $02,$00,$60,$00,$02,$04,$04,$00        ;;F6E8|F6E8+F6E8/F6E8\F6E8;
                      db $00,$01,$00,$00,$00,$10,$07,$60        ;;F6F0|F6F0+F6F0/F6F0\F6F0;
                      db $00,$00,$00,$00,$00,$00,$01,$00        ;;F6F8|F6F8+F6F8/F6F8\F6F8;
                      db $00,$00,$80,$80,$00,$00,$00,$00        ;;F700|F700+F700/F700\F700;
                      db $00,$66,$00,$00,$00,$00,$00,$00        ;;F708|F708+F708/F708\F708;
                      db $00,$00,$00,$80,$00,$00,$00,$00        ;;F710|F710+F710/F710\F710;
                      db $00,$80,$00,$00,$00,$00,$00,$00        ;;F718|F718+F718/F718\F718;
                      db $00,$00,$80,$00,$00,$00,$00,$00        ;;F720|F720+F720/F720\F720;
                      db $00,$00,$E4,$00,$80,$00,$00,$00        ;;F728|F728+F728/F728\F728;
                      db $80,$00,$80,$00,$E0,$80,$80,$00        ;;F730|F730+F730/F730\F730;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F738|F738+F738/F738\F738;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F740|F740+F740/F740\F740;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F748|F748+F748/F748\F748;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F750|F750+F750/F750\F750;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F758|F758+F758/F758\F758;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F760|F760+F760/F760\F760;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F768|F768+F768/F768\F768;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F770|F770+F770/F770\F770;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F778|F778+F778/F778\F778;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F780|F780+F780/F780\F780;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F788|F788+F788/F788\F788;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F790|F790+F790/F790\F790;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F798|F798+F798/F798\F798;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F7A0|F7A0+F7A0/F7A0\F7A0;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F7A8|F7A8+F7A8/F7A8\F7A8;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F7B0|F7B0+F7B0/F7B0\F7B0;
                      db $00,$00,$00,$00,$00,$00,$00,$03        ;;F7B8|F7B8+F7B8/F7B8\F7B8;
                      db $00,$03,$00,$00,$01,$00,$00,$00        ;;F7C0|F7C0+F7C0/F7C0\F7C0;
                      db $00,$00,$00,$00,$00,$00,$64,$00        ;;F7C8|F7C8+F7C8/F7C8\F7C8;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F7D0|F7D0+F7D0/F7D0\F7D0;
                      db $00,$03,$00,$03,$00,$03,$00,$00        ;;F7D8|F7D8+F7D8/F7D8\F7D8;
                      db $00,$00,$01,$00,$00,$00,$00,$00        ;;F7E0|F7E0+F7E0/F7E0\F7E0;
                      db $07,$06,$00,$00,$00,$60,$00,$00        ;;F7E8|F7E8+F7E8/F7E8\F7E8;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F7F0|F7F0+F7F0/F7F0\F7F0;
                      db $00,$00,$00,$05,$00,$00,$00,$00        ;;F7F8|F7F8+F7F8/F7F8\F7F8;
DATA_05F800:          db $00,$00,$00,$00,$00,$00,$00,$00        ;;F800|F800+F800/F800\F800;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F808|F808+F808/F808\F808;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F810|F810+F810/F810\F810;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F818|F818+F818/F818\F818;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F820|F820+F820/F820\F820;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F828|F828+F828/F828\F828;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F830|F830+F830/F830\F830;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F838|F838+F838/F838\F838;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F840|F840+F840/F840\F840;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F848|F848+F848/F848\F848;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F850|F850+F850/F850\F850;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F858|F858+F858/F858\F858;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F860|F860+F860/F860\F860;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F868|F868+F868/F868\F868;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F870|F870+F870/F870\F870;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F878|F878+F878/F878\F878;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F880|F880+F880/F880\F880;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F888|F888+F888/F888\F888;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F890|F890+F890/F890\F890;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F898|F898+F898/F898\F898;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F8A0|F8A0+F8A0/F8A0\F8A0;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F8A8|F8A8+F8A8/F8A8\F8A8;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F8B0|F8B0+F8B0/F8B0\F8B0;
                      db $00,$00,$00,$00,$00,$00,$00,$0F        ;;F8B8|F8B8+F8B8/F8B8\F8B8;
                      db $1C,$10,$0A,$06,$00,$00,$00,$00        ;;F8C0|F8C0+F8C0/F8C0\F8C0;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F8C8|F8C8+F8C8/F8C8\F8C8;
                      db $00,$00,$06,$00,$00,$00,$00,$23        ;;F8D0|F8D0+F8D0/F8D0\F8D0;
                      db $01,$00,$00,$00,$00,$0D,$00,$00        ;;F8D8|F8D8+F8D8/F8D8\F8D8;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F8E0|F8E0+F8E0/F8E0\F8E0;
                      db $00,$00,$1D,$00,$00,$00,$00,$14        ;;F8E8|F8E8+F8E8/F8E8\F8E8;
                      db $00,$00,$00,$00,$05,$00,$00,$00        ;;F8F0|F8F0+F8F0/F8F0\F8F0;
                      db $00,$00,$00,$00,$00,$15,$00,$00        ;;F8F8|F8F8+F8F8/F8F8\F8F8;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F900|F900+F900/F900\F900;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F908|F908+F908/F908\F908;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F910|F910+F910/F910\F910;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F918|F918+F918/F918\F918;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F920|F920+F920/F920\F920;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F928|F928+F928/F928\F928;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F930|F930+F930/F930\F930;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F938|F938+F938/F938\F938;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F940|F940+F940/F940\F940;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F948|F948+F948/F948\F948;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F950|F950+F950/F950\F950;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F958|F958+F958/F958\F958;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F960|F960+F960/F960\F960;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F968|F968+F968/F968\F968;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F970|F970+F970/F970\F970;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F978|F978+F978/F978\F978;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F980|F980+F980/F980\F980;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F988|F988+F988/F988\F988;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F990|F990+F990/F990\F990;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F998|F998+F998/F998\F998;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F9A0|F9A0+F9A0/F9A0\F9A0;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F9A8|F9A8+F9A8/F9A8\F9A8;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F9B0|F9B0+F9B0/F9B0\F9B0;
                      db $00,$00,$00,$13,$23,$00,$02,$0F        ;;F9B8|F9B8+F9B8/F9B8\F9B8;
                      db $17,$1F,$00,$18,$00,$00,$0B,$00        ;;F9C0|F9C0+F9C0/F9C0\F9C0;
                      db $00,$2C,$06,$05,$00,$00,$00,$00        ;;F9C8|F9C8+F9C8/F9C8\F9C8;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F9D0|F9D0+F9D0/F9D0\F9D0;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;F9D8|F9D8+F9D8/F9D8\F9D8;
                      db $27,$00,$00,$00,$16,$00,$00,$00        ;;F9E0|F9E0+F9E0/F9E0\F9E0;
                      db $00,$00,$00,$00,$00,$00,$00,$1A        ;;F9E8|F9E8+F9E8/F9E8\F9E8;
                      db $00,$00,$00,$00,$00,$19,$00,$0A        ;;F9F0|F9F0+F9F0/F9F0\F9F0;
                      db $23,$00,$00,$00,$00,$03,$00,$00        ;;F9F8|F9F8+F9F8/F9F8\F9F8;
DATA_05FA00:          db $00,$00,$00,$00,$00,$00,$00,$00        ;;FA00|FA00+FA00/FA00\FA00;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FA08|FA08+FA08/FA08\FA08;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FA10|FA10+FA10/FA10\FA10;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FA18|FA18+FA18/FA18\FA18;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FA20|FA20+FA20/FA20\FA20;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FA28|FA28+FA28/FA28\FA28;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FA30|FA30+FA30/FA30\FA30;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FA38|FA38+FA38/FA38\FA38;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FA40|FA40+FA40/FA40\FA40;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FA48|FA48+FA48/FA48\FA48;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FA50|FA50+FA50/FA50\FA50;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FA58|FA58+FA58/FA58\FA58;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FA60|FA60+FA60/FA60\FA60;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FA68|FA68+FA68/FA68\FA68;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FA70|FA70+FA70/FA70\FA70;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FA78|FA78+FA78/FA78\FA78;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FA80|FA80+FA80/FA80\FA80;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FA88|FA88+FA88/FA88\FA88;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FA90|FA90+FA90/FA90\FA90;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FA98|FA98+FA98/FA98\FA98;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FAA0|FAA0+FAA0/FAA0\FAA0;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FAA8|FAA8+FAA8/FAA8\FAA8;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FAB0|FAB0+FAB0/FAB0\FAB0;
                      db $00,$00,$00,$00,$00,$00,$00,$AB        ;;FAB8|FAB8+FAB8/FAB8\FAB8;
                      db $A9,$C2,$A6,$AA,$00,$00,$00,$00        ;;FAC0|FAC0+FAC0/FAC0\FAC0;
                      db $00,$00,$00,$00,$00,$00,$AA,$02        ;;FAC8|FAC8+FAC8/FAC8\FAC8;
                      db $AA,$00,$A8,$00,$00,$00,$00,$A8        ;;FAD0|FAD0+FAD0/FAD0\FAD0;
                      db $A8,$AA,$00,$AA,$00,$AB,$A9,$00        ;;FAD8|FAD8+FAD8/FAD8\FAD8;
                      db $00,$AB,$00,$00,$00,$00,$00,$00        ;;FAE0|FAE0+FAE0/FAE0\FAE0;
                      db $00,$00,$02,$00,$00,$00,$00,$AB        ;;FAE8|FAE8+FAE8/FAE8\FAE8;
                      db $AA,$00,$00,$00,$A9,$00,$AA,$AB        ;;FAF0|FAF0+FAF0/FAF0\FAF0;
                      db $00,$00,$00,$00,$00,$A9,$00,$AB        ;;FAF8|FAF8+FAF8/FAF8\FAF8;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FB00|FB00+FB00/FB00\FB00;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FB08|FB08+FB08/FB08\FB08;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FB10|FB10+FB10/FB10\FB10;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FB18|FB18+FB18/FB18\FB18;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FB20|FB20+FB20/FB20\FB20;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FB28|FB28+FB28/FB28\FB28;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FB30|FB30+FB30/FB30\FB30;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FB38|FB38+FB38/FB38\FB38;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FB40|FB40+FB40/FB40\FB40;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FB48|FB48+FB48/FB48\FB48;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FB50|FB50+FB50/FB50\FB50;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FB58|FB58+FB58/FB58\FB58;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FB60|FB60+FB60/FB60\FB60;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FB68|FB68+FB68/FB68\FB68;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FB70|FB70+FB70/FB70\FB70;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FB78|FB78+FB78/FB78\FB78;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FB80|FB80+FB80/FB80\FB80;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FB88|FB88+FB88/FB88\FB88;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FB90|FB90+FB90/FB90\FB90;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FB98|FB98+FB98/FB98\FB98;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FBA0|FBA0+FBA0/FBA0\FBA0;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FBA8|FBA8+FBA8/FBA8\FBA8;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FBB0|FBB0+FBB0/FBB0\FBB0;
                      db $00,$00,$00,$A8,$AA,$00,$AB,$A9        ;;FBB8|FBB8+FBB8/FBB8\FBB8;
                      db $A7,$AA,$00,$AA,$00,$00,$A7,$00        ;;FBC0|FBC0+FBC0/FBC0\FBC0;
                      db $00,$AB,$AB,$A9,$00,$00,$00,$00        ;;FBC8|FBC8+FBC8/FBC8\FBC8;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FBD0|FBD0+FBD0/FBD0\FBD0;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FBD8|FBD8+FBD8/FBD8\FBD8;
                      db $AA,$00,$00,$00,$A8,$00,$00,$00        ;;FBE0|FBE0+FBE0/FBE0\FBE0;
                      db $00,$00,$00,$00,$00,$00,$00,$A7        ;;FBE8|FBE8+FBE8/FBE8\FBE8;
                      db $00,$00,$00,$00,$00,$AB,$00,$AB        ;;FBF0|FBF0+FBF0/FBF0\FBF0;
                      db $AA,$00,$00,$00,$00,$A9,$00,$00        ;;FBF8|FBF8+FBF8/FBF8\FBF8;
DATA_05FC00:          db $00,$00,$00,$00,$00,$00,$00,$00        ;;FC00|FC00+FC00/FC00\FC00;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FC08|FC08+FC08/FC08\FC08;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FC10|FC10+FC10/FC10\FC10;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FC18|FC18+FC18/FC18\FC18;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FC20|FC20+FC20/FC20\FC20;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FC28|FC28+FC28/FC28\FC28;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FC30|FC30+FC30/FC30\FC30;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FC38|FC38+FC38/FC38\FC38;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FC40|FC40+FC40/FC40\FC40;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FC48|FC48+FC48/FC48\FC48;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FC50|FC50+FC50/FC50\FC50;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FC58|FC58+FC58/FC58\FC58;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FC60|FC60+FC60/FC60\FC60;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FC68|FC68+FC68/FC68\FC68;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FC70|FC70+FC70/FC70\FC70;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FC78|FC78+FC78/FC78\FC78;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FC80|FC80+FC80/FC80\FC80;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FC88|FC88+FC88/FC88\FC88;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FC90|FC90+FC90/FC90\FC90;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FC98|FC98+FC98/FC98\FC98;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FCA0|FCA0+FCA0/FCA0\FCA0;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FCA8|FCA8+FCA8/FCA8\FCA8;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FCB0|FCB0+FCB0/FCB0\FCB0;
                      db $00,$00,$00,$00,$00,$00,$00,$0E        ;;FCB8|FCB8+FCB8/FCB8\FCB8;
                      db $2A,$25,$64,$04,$00,$00,$00,$00        ;;FCC0|FCC0+FCC0/FCC0\FCC0;
                      db $00,$00,$00,$00,$00,$00,$21,$68        ;;FCC8|FCC8+FCC8/FCC8\FCC8;
                      db $26,$00,$08,$00,$00,$00,$00,$6D        ;;FCD0|FCD0+FCD0/FCD0\FCD0;
                      db $70,$2B,$00,$0D,$00,$2D,$27,$00        ;;FCD8|FCD8+FCD8/FCD8\FCD8;
                      db $00,$2D,$00,$00,$00,$00,$00,$00        ;;FCE0|FCE0+FCE0/FCE0\FCE0;
                      db $00,$00,$6A,$00,$00,$00,$00,$02        ;;FCE8|FCE8+FCE8/FCE8\FCE8;
                      db $6A,$00,$00,$00,$70,$00,$0E,$21        ;;FCF0|FCF0+FCF0/FCF0\FCF0;
                      db $00,$00,$00,$00,$00,$2B,$00,$0A        ;;FCF8|FCF8+FCF8/FCF8\FCF8;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FD00|FD00+FD00/FD00\FD00;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FD08|FD08+FD08/FD08\FD08;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FD10|FD10+FD10/FD10\FD10;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FD18|FD18+FD18/FD18\FD18;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FD20|FD20+FD20/FD20\FD20;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FD28|FD28+FD28/FD28\FD28;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FD30|FD30+FD30/FD30\FD30;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FD38|FD38+FD38/FD38\FD38;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FD40|FD40+FD40/FD40\FD40;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FD48|FD48+FD48/FD48\FD48;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FD50|FD50+FD50/FD50\FD50;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FD58|FD58+FD58/FD58\FD58;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FD60|FD60+FD60/FD60\FD60;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FD68|FD68+FD68/FD68\FD68;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FD70|FD70+FD70/FD70\FD70;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FD78|FD78+FD78/FD78\FD78;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FD80|FD80+FD80/FD80\FD80;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FD88|FD88+FD88/FD88\FD88;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FD90|FD90+FD90/FD90\FD90;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FD98|FD98+FD98/FD98\FD98;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FDA0|FDA0+FDA0/FDA0\FDA0;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FDA8|FDA8+FDA8/FDA8\FDA8;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FDB0|FDB0+FDB0/FDB0\FDB0;
                      db $00,$00,$00,$08,$04,$00,$05,$03        ;;FDB8|FDB8+FDB8/FDB8\FDB8;
                      db $26,$68,$00,$30,$00,$00,$2A,$00        ;;FDC0|FDC0+FDC0/FDC0\FDC0;
                      db $00,$69,$70,$08,$00,$00,$00,$00        ;;FDC8|FDC8+FDC8/FDC8\FDC8;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FDD0|FDD0+FDD0/FDD0\FDD0;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FDD8|FDD8+FDD8/FDD8\FDD8;
                      db $2A,$00,$00,$00,$29,$00,$00,$00        ;;FDE0|FDE0+FDE0/FDE0\FDE0;
                      db $00,$00,$00,$00,$00,$00,$00,$2E        ;;FDE8|FDE8+FDE8/FDE8\FDE8;
                      db $00,$00,$00,$00,$00,$2F,$00,$2F        ;;FDF0|FDF0+FDF0/FDF0\FDF0;
                      db $32,$00,$00,$00,$00,$28,$00,$00        ;;FDF8|FDF8+FDF8/FDF8\FDF8;
DATA_05FE00:          db $00,$00,$00,$00,$00,$00,$00,$00        ;;FE00|FE00+FE00/FE00\FE00;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FE08|FE08+FE08/FE08\FE08;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FE10|FE10+FE10/FE10\FE10;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FE18|FE18+FE18/FE18\FE18;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FE20|FE20+FE20/FE20\FE20;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FE28|FE28+FE28/FE28\FE28;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FE30|FE30+FE30/FE30\FE30;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FE38|FE38+FE38/FE38\FE38;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FE40|FE40+FE40/FE40\FE40;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FE48|FE48+FE48/FE48\FE48;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FE50|FE50+FE50/FE50\FE50;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FE58|FE58+FE58/FE58\FE58;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FE60|FE60+FE60/FE60\FE60;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FE68|FE68+FE68/FE68\FE68;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FE70|FE70+FE70/FE70\FE70;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FE78|FE78+FE78/FE78\FE78;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FE80|FE80+FE80/FE80\FE80;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FE88|FE88+FE88/FE88\FE88;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FE90|FE90+FE90/FE90\FE90;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FE98|FE98+FE98/FE98\FE98;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FEA0|FEA0+FEA0/FEA0\FEA0;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FEA8|FEA8+FEA8/FEA8\FEA8;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FEB0|FEB0+FEB0/FEB0\FEB0;
                      db $00,$00,$00,$00,$00,$00,$00,$03        ;;FEB8|FEB8+FEB8/FEB8\FEB8;
                      db $03,$03,$07,$03,$00,$00,$00,$00        ;;FEC0|FEC0+FEC0/FEC0\FEC0;
                      db $00,$00,$00,$00,$00,$00,$03,$01        ;;FEC8|FEC8+FEC8/FEC8\FEC8;
                      db $03,$00,$06,$00,$00,$00,$00,$04        ;;FED0|FED0+FED0/FED0\FED0;
                      db $06,$03,$00,$03,$00,$03,$00,$00        ;;FED8|FED8+FED8/FED8\FED8;
                      db $00,$03,$00,$00,$00,$00,$00,$00        ;;FEE0|FEE0+FEE0/FEE0\FEE0;
                      db $00,$00,$03,$00,$00,$00,$00,$00        ;;FEE8|FEE8+FEE8/FEE8\FEE8;
                      db $03,$00,$00,$00,$03,$00,$03,$02        ;;FEF0|FEF0+FEF0/FEF0\FEF0;
                      db $00,$00,$00,$00,$00,$04,$00,$00        ;;FEF8|FEF8+FEF8/FEF8\FEF8;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FF00|FF00+FF00/FF00\FF00;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FF08|FF08+FF08/FF08\FF08;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FF10|FF10+FF10/FF10\FF10;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FF18|FF18+FF18/FF18\FF18;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FF20|FF20+FF20/FF20\FF20;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FF28|FF28+FF28/FF28\FF28;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FF30|FF30+FF30/FF30\FF30;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FF38|FF38+FF38/FF38\FF38;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FF40|FF40+FF40/FF40\FF40;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FF48|FF48+FF48/FF48\FF48;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FF50|FF50+FF50/FF50\FF50;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FF58|FF58+FF58/FF58\FF58;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FF60|FF60+FF60/FF60\FF60;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FF68|FF68+FF68/FF68\FF68;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FF70|FF70+FF70/FF70\FF70;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FF78|FF78+FF78/FF78\FF78;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FF80|FF80+FF80/FF80\FF80;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FF88|FF88+FF88/FF88\FF88;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FF90|FF90+FF90/FF90\FF90;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FF98|FF98+FF98/FF98\FF98;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FFA0|FFA0+FFA0/FFA0\FFA0;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FFA8|FFA8+FFA8/FFA8\FFA8;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FFB0|FFB0+FFB0/FFB0\FFB0;
                      db $00,$00,$00,$04,$03,$00,$03,$03        ;;FFB8|FFB8+FFB8/FFB8\FFB8;
                      db $04,$03,$00,$03,$00,$00,$05,$00        ;;FFC0|FFC0+FFC0/FFC0\FFC0;
                      db $00,$03,$03,$06,$00,$00,$00,$00        ;;FFC8|FFC8+FFC8/FFC8\FFC8;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FFD0|FFD0+FFD0/FFD0\FFD0;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;FFD8|FFD8+FFD8/FFD8\FFD8;
                      db $03,$00,$00,$00,$03,$00,$00,$00        ;;FFE0|FFE0+FFE0/FFE0\FFE0;
                      db $00,$00,$00,$00,$00,$00,$00,$02        ;;FFE8|FFE8+FFE8/FFE8\FFE8;
                      db $00,$00,$00,$00,$00,$03,$00,$02        ;;FFF0|FFF0+FFF0/FFF0\FFF0;
                      db $03,$00,$00,$00,$00,$03,$00,$00        ;;FFF8|FFF8+FFF8/FFF8\FFF8;
