Hash_which columns have duplicate values across rows                                                                                   
                                                                                                                                       
Note the HASH below can also provide count distinct values for each column.                                                            
                                                                                                                                       
  githubs                                                                                                                              
  https://tinyurl.com/y33br5bl                                                                                                         
  https://github.com/rogerjdeangelis/utl-hash_which-columns-have-duplicate-values-across-rows                                          
                                                                                                                                       
  https://tinyurl.com/yymhk4yw                                                                                                         
  https://github.com/rogerjdeangelis/distinct-counts-for_3200-variables-and_660-thousand-records-using-HASH-SQL-and-proc-freq          
                                                                                                                                       
  http://tinyurl.com/y3axr2qd                                                                                                          
  https://github.com/rogerjdeangelis/utl-which-columns-have-duplicate-values-across-rows                                               
                                                                                                                                       
                                                                                                                                       
  StackOverflow                                                                                                                        
  http://tinyurl.com/y5qcqqxz                                                                                                          
  https://stackoverflow.com/questions/55238236/sas-check-field-by-column-by-column                                                     
                                                                                                                                       
*_                   _                                                                                                                 
(_)_ __  _ __  _   _| |_                                                                                                               
| | '_ \| '_ \| | | | __|                                                                                                              
| | | | | |_) | |_| | |_                                                                                                               
|_|_| |_| .__/ \__,_|\__|                                                                                                              
        |_|                                                                                                                            
;                                                                                                                                      
                                                                                                                                       
data have;                                                                                                                             
  array nums NUM1-NUM9;                                                                                                                
  do rec=1 to 5;                                                                                                                       
     do i=1 to 9;                                                                                                                      
       nums[i]=int(100*uniform(1235)) + 1000;                                                                                          
       NUM1=1111;                                                                                                                      
       NUM5=5555;                                                                                                                      
       NUM7=7777;                                                                                                                      
     end;                                                                                                                              
     output;                                                                                                                           
  end;                                                                                                                                 
  drop rec i;                                                                                                                          
run;quit;                                                                                                                              
                                                                                                                                       
WORK.HAVE                                                                                                                              
                                                                                                                                       
Obs    NUM1    NUM2    NUM3    NUM4    NUM5    NUM6    NUM7    NUM8    NUM9                                                            
                                                                                                                                       
 1     1111    1005    1078    1035    5555    1005    7777    1063    1049                                                            
 2     1111    1085    1098    1094    5555    1092    7777    1067    1006                                                            
 3     1111    1073    1097    1076    5555    1072    7777    1055    1063                                                            
 4     1111    1048    1061    1052    5555    1004    7777    1023    1007                                                            
 5     1111    1045    1021    1058    5555    1081    7777    1028    1008                                                            
                                                                                                                                       
RULES  If column is has constant value then 1 else 0                                                                                   
                                                                                                                                       
      ----    ----    ----    ----    ----    ----    ----    ----    ----                                                             
        1       0       0       0       1       0       1       0       0                                                              
                                                                                                                                       
 *            _               _                                                                                                        
  ___  _   _| |_ _ __  _   _| |_                                                                                                       
 / _ \| | | | __| '_ \| | | | __|                                                                                                      
| (_) | |_| | |_| |_) | |_| | |_                                                                                                       
 \___/ \__,_|\__| .__/ \__,_|\__|                                                                                                      
                |_|                                                                                                                    
;                                                                                                                                      
                                                                                                                                       
WORK.WANT total obs=6                                                                                                                  
                                                                                                                                       
Obs    NUM1    NUM2    NUM3    NUM4    NUM5    NUM6    NUM7    NUM8    NUM9                                                            
                                                                                                                                       
 1     1111    1005    1078    1035    5555    1005    7777    1063    1049                                                            
 2     1111    1085    1098    1094    5555    1092    7777    1067    1006                                                            
 3     1111    1073    1097    1076    5555    1072    7777    1055    1063                                                            
 4     1111    1048    1061    1052    5555    1004    7777    1023    1007                                                            
 5     1111    1045    1021    1058    5555    1081    7777    1028    1008                                                            
                                                                                                                                       
 6        1       0       0       0       1       0       1       0       0                                                            
                                                                                                                                       
*          _       _   _                                                                                                               
 ___  ___ | |_   _| |_(_) ___  _ __                                                                                                    
/ __|/ _ \| | | | | __| |/ _ \| '_ \                                                                                                   
\__ \ (_) | | |_| | |_| | (_) | | | |                                                                                                  
|___/\___/|_|\__,_|\__|_|\___/|_| |_|                                                                                                  
                                                                                                                                       
;                                                                                                                                      
                                                                                                                                       
data _null_;                                                                                                                           
                                                                                                                                       
  do idx=1 to 9;                                                                                                                       
     call symputx('var',cats('num',idx));                                                                                              
                                                                                                                                       
     rc=dosubl('                                                                                                                       
        data &var;                                                                                                                     
          if _n_=0 then set have(keep=&var);                                                                                           
          if _n_ = 1 then do;                                                                                                          
            dcl hash h(dataset:"have(keep=&var)", duplicate: "r");                                                                     
            h.defineKey("&var");                                                                                                       
            h.defineDone();                                                                                                            
            call missing(&var);                                                                                                        
          end;                                                                                                                         
          &var = h.num_items;                                                                                                          
          if &var>1 then &var=0;                                                                                                       
          output;                                                                                                                      
          stop;                                                                                                                        
        run;                                                                                                                           
     ');                                                                                                                               
  end;                                                                                                                                 
  stop;                                                                                                                                
                                                                                                                                       
run;quit;                                                                                                                              
                                                                                                                                       
sasfile have close;                                                                                                                    
                                                                                                                                       
data want;                                                                                                                             
  do until (dne);                                                                                                                      
     set have end=dne;;                                                                                                                
     output;                                                                                                                           
  end;                                                                                                                                 
  merge num:;                                                                                                                          
  output;                                                                                                                              
run;quit;                                                                                                                              
                                                                                                                                       
                                                                                                                                       
