#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>

int main(void){

// 変数・型宣言
  int i,j,k,l,m,n,T;
  double xx, yy, ww, tt, dt, ft;
  double ran;
  // char para_name[] = {"lambda", "c", "b", "h", "delta", "a", "d"};
  // double para[] = {5*pow(10, 4), 1*pow(10, 0), 2.5*pow(10, -4), 5*pow(10, -5), 5*pow(10, 0), 1*pow(10, 1), 5*pow(10, 0), 1.2, 0.4};
  double t[10001], x[10001], y[10001], w[100001], p[100001];
  double para_st[] = {5*pow(10, 4), 1*pow(10, 0), 2.5*pow(10, -4), 5*pow(10, -5), 5*pow(10, 0), 1*pow(10, 1), 5*pow(10, 0), 1.2, 0.4};
  double para_ch[9], para[9];
  FILE *fp, *fp1;
//データファイルの作成と項目の記入(fp)
  fp=fopen("SA_ramdom_x.csv","w");
  fp1=fopen("SA_ramdom_p.csv","w");

  for (m = 0; m < 100; m++){

    srand(m);
    for (j = 0; j<=6; j++){
      ran = rand() / (double)RAND_MAX;
      // printf("%f\n", ran);
      if (ran<0.33){
        para_ch[j]= 0.5*para_st[j];
      }else if (0.66<ran){
        para_ch[j]= 2*para_st[j];
      }else{
        para_ch[j]=para_st[j];
      }
    }
    para_ch[7] = para_st[7];
    para_ch[8] = para_st[8];
  
    ft = 10.0;
    n = 1000;
    dt = ft/n;
    
    for( k = 0; k <=9; k++){

      for (l = 0; l < 9; ++l) {
          para[l] = para_ch[l];
      }

      if (k==1){
        para[0]=para_ch[0]*0.833;
      }else if (k==2){
        para[1]=para_ch[1]*0.833;
      }else if (k==3){
        para[2]=para_ch[2]*0.833;
      }else if (k==4){
        para[3]=para_ch[3]*0.833;
      }else if (k==5){
        para[4]=para_ch[4]*0.833;
      }else if (k==6){
        para[5]=para_ch[5]*0.833;
      }else if (k==7){
        para[6]=para_ch[6]*0.833;
      }else if (k==8){
        para[7]=para_ch[7]*0.833;
      }else if (k==9){
        para[8]=para_ch[8]*0.833;
      }
      
      printf("%f,%f,%f,%f,%f,%f,%f,%f,%f\n", para[0], para[1], para[2], para[3], para[4], para[5], para[6], para[7], para[8]);
    //初期値

      t[0] = 0;
      x[0] = 5*pow(10, 4);
      y[0] = 1*pow(10, 2);
      w[0] = 1*pow(10, 1);
      p[1000]=1;
    // 初期値記載
      fprintf(fp,"%f,%f,%f,%f\n", t[0], x[0], y[0], w[0]);
    // モデル
      for ( i = 0; i <= n-1; i++){
        t[i+1] = dt*(i+1);
        x[i+1] = x[i] + (para[0] - para[1]*x[i] - para[2]*x[i]*y[i])*dt;
        y[i+1] = y[i] + (para[2]*x[i]*y[i]- para[3]*w[i]*y[i] - para[4]*y[i])*dt;
        w[i+1] = w[i] + (para[5]*y[i] - para[6]*w[i])*dt;

        fprintf(fp,"%f,%f,%f,%f\n", t[i+1], x[i+1], y[i+1], w[i+1]);
      }

      fprintf(fp1,"%f,%f\n", t[1000], p[1000]);
      for ( i = 1; i <= n; i++){

        tt = t[n-i];
        xx = x[n-i];
        ww = w[n-i];
        p[n-i] = p[n+1-i] + (-p[n+1-i]*p[n+1-i]*para[7]*para[2]*xx - (para[4] + para[8]*para[3]*ww - para[7]*para[2]*xx)*p[n+1-i])*dt;

        fprintf(fp1,"%f,%f\n", tt, p[n-i]);
        // printf("%f\n", p);
      }
    }
  }
  fclose(fp);
  fclose(fp1);
  return 0;
}
