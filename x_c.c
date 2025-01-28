#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>

int main(void){

// 変数・型宣言
  int i,j,n;
  double x, xx, y, yy, w, ww, m,mm, t, dt, ft;
  double rate[5]= {0.833, 0.909, 1, 1.1, 1.2};
  double lambda, c, b, h, delta, a, d;
  FILE *fp;
//データファイルの作成と項目の記入(fp)
  fp=fopen("x_c.csv","w");
  // fprintf(fp,"t,x,y\n");
// パラメーター
  lambda = 5*pow(10, 4);
  // c = 1*pow(10, 0);
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

  printf("%f, %f, %f, %f, %f", rate[0], rate[1], rate[2], rate[3], rate[4]);
//初期値
  // t = 0;
  // x = 5*pow(10, 4);
  // y = 1*pow(10, 2);
  // w = 1*pow(10, 1);
// 初期値記載
  // fprintf(fp,"%f,%f,%f,%f\n", t, x, y, w);
// モデル
  for (j = 0; j <= 4; j++){
    c = 1*rate[j];
    t = 0;
    x = 5*pow(10, 4);
    y = 1*pow(10, 2);
    w = 1*pow(10, 1);
    fprintf(fp,"%f,%f,%f,%f\n", t, x, y, w);
    for ( i = 1; i <= n; i++){
      t = dt*i;
      xx = x + (lambda - c*x - b*x*y)*dt;
      yy = y + (b*x*y - h*w*y - delta*y)*dt;
      ww = w + (a*y - d*w)*dt;

      x = xx;
      y = yy;
      w = ww;
      fprintf(fp,"%f,%f,%f,%f\n", t, x, y, w);
    }
  }
  fclose(fp);
  return 0;
}
