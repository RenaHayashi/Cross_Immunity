#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>

int main(void){

// 変数・型宣言
  int i,n;
  double x, xx, y, yy, w, ww, m,mm, t, dt, ft;
  long double lambda, c, b, h, delta, a, d;
  FILE *fp, *fp2;
//データファイルの作成と項目の記入(fp)
  fp=fopen("x_AC.csv","w");
  // fp2=fopen("x_t0.csv","w");
  // fprintf(fp,"t,x,y\n");
// パラメーター
  lambda = 5*pow(10, 4);
  c = 1*pow(10, 0);
  b = 2.5*pow(10, -4);
  h = 5*pow(10, -5);
  delta = 5*pow(10, 0);
  a = 1*pow(10, 1);
  d = 5*pow(10, 0);
  
  ft = 10.0;
  n = 1000;
  dt = ft/n;
//初期値
  t = 0;
  x = 5*pow(10, 4);
  y = 1*pow(10, 2);
  w = 1*pow(10, 1);
// 初期値記載
  fprintf(fp,"%f,%f,%f,%f\n", t, x, y, w);
  // fprintf(fp2,"%f,%f,%f,%f\n", t, x, y, w);
// モデル
  
  for ( i = 1; i <= n; i++){
    t = dt*i;
    xx = x + (-c*(x - lambda/c) - b*lambda*y/c)*dt;
    yy = y + (b*lambda*y/c - delta*y)*dt;
    ww = w + (a*y - d*w)*dt;

    x = xx;
    y = yy;
    w = ww;
    fprintf(fp,"%f,%f,%f,%f\n", t, x, y, w);
  }
  fclose(fp);

  // for ( i = 1; i <= n; i++){
  //   t = dt*i;
  //   xx = x + (lambda - c*x - b*x*y)*dt;
  //   yy = y + (b*x*y - h*w*y - delta*y)*dt;
  //   ww = w + (a*y - d*w)*dt;

  //   x = xx;
  //   y = yy;
  //   w = ww;
  //   fprintf(fp2,"%f,%f,%f,%f\n", t, x, y, w);
  // }
  // fclose(fp2);
  return 0;
}
