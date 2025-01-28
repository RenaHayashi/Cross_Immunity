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
  double lambda, c, b, h, delta, a, d, bm, hm, D;
  double p0;
  double peq, integ1, integ2, integ3;
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
  fp1=fopen("p0.csv","w");

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
  bm = b;
  hm = h;
  // printf("%f\n", hm);

  // pの平衡点
  D = h*w[100000]/delta;
  peq = 1 - ((hm/h)*D + 1)/((bm/b)*(D + 1));
  // printf("%f\n", peq);

  integ1=0.0;
  integ2=0.0;
  integ3=0.0;
  // integral1
  // integ1=0.0;
  for(j=0; j<100001; j++){
    integ1 += (bm*x[j] - hm*w[j] - delta)*dt;
  }
  printf("%f\n", integ1);

  // integral2&3
  integ3=0.0;
  for(l=0; l<100001; l++){
    integ2=0.0;
    for(k=l; k<100001; k++){
      integ2 += (bm*x[k] - hm*w[k] - delta)*dt;
    }
    integ3 += (exp(-1*integ2))*bm*x[l]*dt;
  }
  printf("%f\n", integ2);
  printf("%f\n", integ3);

  p0 = 1/(exp(integ1)*( 1/peq + integ3));
  printf("%f\n", p0);

  fclose(fp1);
  return 0;
}