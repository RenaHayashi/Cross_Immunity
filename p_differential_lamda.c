#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>


// メイン
int main(void){

// 変数・型宣言
  int i, j, k, l, m, n, ST, T;
  double ft, dt;
  double p, pp, xx, ww, tt;
  double lambda, c, b, h, delta, a, d;
  double bm, hm;
  double rate[5]= {0.833, 0.909, 1, 1.1, 1.2};
  double t[50004], x[50004], y[50004], w[50004];
  FILE *fp, *fp1;
//データファイルの読み込み-配列格納(fp)
  fp=fopen("x_lamda.csv","r");
  if(fp==NULL){
    printf("ファイルオープン失敗\n");
    return -1;
  }

  for(i=0; i<=50004; i++){
    fscanf(fp, "%lf,%lf,%lf,%lf", &t[i], &x[i], &y[i], &w[i] );    
  }
  fclose(fp);
  t[0] = 0;
  x[0] = 5*pow(10, 4);
  y[0] = 1*pow(10, 2);
  w[0] = 1*pow(10, 1);
  
  // 読み込み確認
  // printf("%f\n", t[500]);
  // 書き込み
  fp1=fopen("p_differential_lamda.csv","w");

// パラメーター
  // lambda = 5*pow(10, 4);
  c = 1*pow(10, 0);
  b = 2.5*pow(10, -4);
  h = 5*pow(10, -5);
  // h = 5*pow(10, -3);
  delta = 5*pow(10, 0);
  a = 1*pow(10, 1);
  d = 5*pow(10, 0);
  
  ft = 100.0;
  n = 10000;
  dt = ft/n;
  rate[0] = 0.833;
  // T = 50000;
  // printf("dt = %f",dt);
  printf("%f, %f, %f, %f, %f", rate[0], rate[1], rate[2], rate[3], rate[4]);

  bm = 1.2*b;
  hm = 0.4*h;
  // p(t)の算出
  // p = 1;
  // fprintf(fp1,"%f,%f\n", t[T], p);
  for (j = 0; j <= 4; j++){
    lambda = 5*pow(10, 4)*rate[j];
    // hm = 0.8*h;
    T = (j+1)*10000 + j;

    p = 1;
    fprintf(fp1,"%f,%f\n", t[T], p);

    for ( i = 1; i <= n; i++){

      tt = t[T-i];
      xx = x[T-i];
      ww = w[T-i];
      pp = p + (-p*p*bm*xx - (delta + hm*ww - bm*xx)*p)*dt;
      p = pp;
      fprintf(fp1,"%f,%f\n", tt, p);
      // printf("%f\n", p);
    }
  }
  fclose(fp1);
  return 0;
}
