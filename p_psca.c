#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>


// メイン
int main(void){

// 変数・型宣言
  int i, j, k, l, m, n, T;
  double ft, dt;
  double p, pp, xx, yy, ww, tt, x2, w2, t2, psca;
  double lambda, c, b, h, delta, a, d;
  double bm, hm, D;
  double t[100001], x[100001], y[100001], w[100001],ram[10];
  FILE *fp, *fp1, *fp2;

  fp2=fopen("p0_psca0.csv","w");
  fprintf(fp2,"p,psca\n");

  for(l=0; l<100; l++){

    for (k = 0; k < 10; k++){
        ram[k] = 0.5 + (rand() / (double)RAND_MAX);
        // printf("ram = %f\n", ram[k]);
    }

    // パラメーター
    lambda = 5*pow(10, 4)*ram[0];
    c = 1*pow(10, 0)*ram[1];
    b = 2.5*pow(10, -4)*ram[2];
    h = 5*pow(10, -5)*ram[3];
    delta = 5*pow(10, 0)*ram[4];
    a = 1*pow(10, 1)*ram[5];
    d = 5*pow(10, 0)*ram[6];

    bm = 1.2*b;
    hm = 0.4*h;
    
    ft = 1000.0;
    n = 100000;
    dt = ft/n;
    T = 50000;

    // fp=fopen("x_p_psca.csv","w");
    //初期値
    t[0] = 0;
    x[0] = 5*pow(10, 4);
    y[0] = 1*pow(10, 2);
    w[0] = 1*pow(10, 1);
    // fprintf(fp,"%f,%f,%f,%f\n", t[0], x[0], y[0], w[0]);

    // モデル
    for ( i = 1; i <= n; i++){
      t[i] = dt*i;
      x[i] = x[i-1] + (lambda - c*x[i-1] - b*x[i-1]*y[i-1])*dt;
      y[i] = y[i-1] + (b*x[i-1]*y[i-1] - h*w[i-1]*y[i-1] - delta*y[i-1])*dt;
      w[i] = w[i-1] + (a*y[i-1] - d*w[i-1])*dt;
      // fprintf(fp,"%f,%f,%f,%f\n", t[i], x[i], y[i], w[i]);
    }
    // fclose(fp);

    // p(t)の算出
    p = 1.0;
    // fp1=fopen("p_psca.csv","w");
    // fprintf(fp1,"%f,%f\n", t[T], p);

    for ( j = 1; j <= T; j++){

      t2 = t[T-j];
      x2 = x[T-j];
      w2 = w[T-j];
      pp = p + (-p*p*bm*x2 - (delta + hm*w2 - bm*x2)*p)*dt;
      p = pp;
      // fprintf(fp1,"%f,%f\n", t2, p);
    }
    // fclose(fp1);
    // printf("p=%f", p);

    psca = 1 - (c*delta)/(bm*lambda);
    fprintf(fp2,"%f,%f\n", p, psca);
  }
  fclose(fp2);
  return 0;
}
