                      ORG $0F8000                               ;;  J |  U + SS / E0 \ E1 ;
                                                                ;;                        ;
MusicSamples:         dw SampleData-MusicSamples-4              ;;8000|8000+8000/8000\8000;
                      dw !SamplePtrTable                        ;;8002|8002+8002/8002\8002;
                                                                ;;                        ;
                      dw Sample00, Sample00+$24                 ;;8002|8002+8002/8002\8002;
                      dw Sample01, Sample01+$24                 ;;8006|8006+8006/8006\8006;
                      dw Sample02, Sample02+$EA                 ;;800A|800A+800A/800A\800A;
                      dw Sample03, Sample03+$129                ;;800E|800E+800E/800E\800E;
                      dw Sample04, Sample04+$24                 ;;8012|8012+8012/8012\8012;
                      dw Sample05, Sample05+$129                ;;8016|8016+8016/8016\8016;
                      dw Sample06, Sample06                     ;;801A|801A+801A/801A\801A;
                      dw Sample07, Sample07+$627                ;;801E|801E+801E/801E\801E;
                      dw Sample08, Sample08+$24                 ;;8022|8022+8022/8022\8022;
                      dw Sample09, Sample09+$C2A                ;;8026|8026+8026/8026\8026;
                      dw Sample0A, Sample0A                     ;;802A|802A+802A/802A\802A;
                      dw Sample0B, Sample0B                     ;;802E|802E+802E/802E\802E;
                      dw Sample0C, Sample0C+$24                 ;;8032|8032+8032/8032\8032;
                      dw Sample0D, Sample0D+$29A                ;;8036|8036+8036/8036\8036;
                      dw Sample0E, Sample0E+$A71                ;;803A|803A+803A/803A\803A;
                      dw Sample0F, Sample0F                     ;;803E|803E+803E/803E\803E;
                      dw Sample10, Sample10                     ;;8042|8042+8042/8042\8042;
                      dw Sample11, Sample11+$510                ;;8046|8046+8046/8046\8046;
                      dw Sample12, Sample12                     ;;804A|804A+804A/804A\804A;
                      dw Sample13, Sample13                     ;;804E|804E+804E/804E\804E;
                                                                ;;                        ;
SampleData:           dw SampleData_End-SampleData-4            ;;8054|8054+8054/8054\8054;
                      dw !SampleTable                           ;;8056|8056+8056/8056\8056;
                                                                ;;                        ;
                      base !SampleTable                         ;;                        ;
Sample00:             incbin "samples/Sample00.brr"             ;;8100|8100+8100/8100\8100;
Sample01:             incbin "samples/Sample01.brr"             ;;813F|813F+813F/813F\813F;
Sample02:             incbin "samples/Sample02.brr"             ;;817E|817E+817E/817E\817E;
Sample03:             incbin "samples/Sample03.brr"             ;;8283|8283+8283/8283\8283;
Sample04:             incbin "samples/Sample04.brr"             ;;83C7|83C7+83C7/83C7\83C7;
Sample05:             incbin "samples/Sample05.brr"             ;;8406|8406+8406/8406\8406;
Sample06:             incbin "samples/Sample06.brr"             ;;863D|863D+863D/863D\863D;
Sample07:             incbin "samples/Sample07.brr"             ;;8AAB|8AAB+8AAB/8AAB\8AAB;
Sample08:             incbin "samples/Sample08.brr"             ;;9111|9111+9111/9111\9111;
Sample09:             incbin "samples/Sample09.brr"             ;;9150|9150+9150/9150\9150;
Sample0A:             incbin "samples/Sample0A.brr"             ;;9D95|9D95+9D95/9D95\9D95;
Sample0B:             incbin "samples/Sample0B.brr"             ;;C013|B013+B013/B013\B013;
Sample0C:             incbin "samples/Sample0C.brr"             ;;B6AF|B6AF+B6AF/B6AF\B6AF;
Sample0D:             incbin "samples/Sample0D.brr"             ;;B6EE|B6EE+B6EE/B6EE\B6EE;
Sample0E:             incbin "samples/Sample0E.brr"             ;;B9C7|B9C7+B9C7/B9C7\B9C7;
Sample0F:             incbin "samples/Sample0F.brr"             ;;C453|C453+C453/C453\C453;
Sample10:             incbin "samples/Sample10.brr"             ;;C6D2|C6D2+C6D2/C6D2\C6D2;
Sample11:             incbin "samples/Sample11.brr"             ;;CFB7|CFB7+CFB7/CFB7\CFB7;
Sample12:             incbin "samples/Sample12.brr"             ;;D521|D521+D521/D521\D521;
Sample13:             incbin "samples/Sample13.brr"             ;;DE7B|DE7B+DE7B/DE7B\DE7B;
                                                                ;;                        ;
                      base off                                  ;;                        ;
                                                                ;;                        ;
SampleData_End:       dw $0000,!SPCEngine                       ;;EF78|EF78+EF78/EF78\EF78;
                                                                ;;                        ;
                      db $18,$00,$00,$00                        ;;EF7C|EF7C+EF7C/EF7C\EF7C;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;EF80|EF80+EF80/EF80\EF80;
                      db $00,$00,$00,$00,$00,$00,$00,$00        ;;EF88|EF88+EF88/EF88\EF88;
                                                                ;;                        ;
                   %insert_empty($1070,$1070,$1070,$1070,$1070) ;;EF90|EF90+EF90/EF90\EF90;
