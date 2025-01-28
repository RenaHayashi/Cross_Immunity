#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>


// メイン
int main(void){

// 変数・型宣言
  int i, j, k, l, m, n, T;
  double ft, dt;
  double p, pp, xx, ww, tt;
  double lambda, c, b, h, delta, a, d;
  double bm, hm, D;
  double e, ee, e2, domi, domi1;
  double t[100001], x[100001], y[100001], w[100001];
  FILE *fp, *fp1;
//データファイルの読み込み-配列格納(fp)
  fp=fopen("x.csv","r");
  if(fp==NULL){
    printf("ファイルオープン失敗\n");
    return -1;
  }

  for(i=0; i<=100000; i++){
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
  fp1=fopen("p_equilibrium_point_b.csv","w");

// パラメーター
  lambda = 5*pow(10, 4);
  c = 1*pow(10, 0);
  b = 2.5*pow(10, -4);
  h = 5*pow(10, -5);
  delta = 5*pow(10, 0);
  a = 1*pow(10, 1);
  d = 5*pow(10, 0);
  
  ft = 1000.0;
  n = 100000;
  dt = ft/n;
  T = 50000;
  D = h*w[100000]/delta;
  hm = h;


  for ( j = 100; j <= 1000; j++){
    bm = j*1*pow(10, -2)*b;
    p = 1 - ((hm/h)*D + 1)/((bm/b)*(D + 1));
    fprintf(fp1,"%f,%f\n", bm, p);
    // printf("%f\n", p);
  }
  
  fclose(fp1);
  return 0;
}
