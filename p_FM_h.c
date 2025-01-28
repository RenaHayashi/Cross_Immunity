#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>

// 関数
int maxIndex(double nums[], int n){
  int max_value;
  int max_index;
  int i;

  max_value = nums[0];
  max_index = 0;

  for(i=0; i<n; i++){
    if(nums[i]>max_value){
      max_value = nums[i];
      max_index = i;
    }
  }
  return max_index;
}

int minIndex(double nums[], int n1, int n2){
  int min_value;
  int min_index;
  int i;

  min_value = 1*pow(10, 4);
  min_index = 0;

  for(i=n1; i<n2; i++){
    if(nums[i] < min_value){
     min_value = nums[i];
     min_index = i;
    }
  }
  return min_index;
}

// メイン
int main(void){

// 変数・型宣言
  int i, j, k, l, m, n, T, max_index, min_index;
  double ft, dt, dh, fh, m1;
  double xx, yy, ww, tt, x2, w2, t2, psca;
  double lambda, c, b, h, delta, a, d;
  double bm, hm, FM1, FM2;
  double t[100001], x[100001], y[100001], w[100001], p[100001], bxyp[50000];
  FILE *fp;

  fp=fopen("p_FM_h.csv","w");
  fprintf(fp,"h, FM\n");

  // パラメーター
  lambda = 5*pow(10, 4);
  c = 1*pow(10, 0);
  b = 2.5*pow(10, -4);
  bm = 1.2*b;
  delta = 5*pow(10, 0);
  a = 1*pow(10, 1);
  d = 5*pow(10, 0);

  fh = 1*pow(10, -3);
  m1 = 1000;
  dh = fh/m1;

  ft = 1000.0;
  n = 100000;
  dt = ft/n;
  T = 50000;

  for(m = 0; m <= m1; m++){
    h = dh*m;
    // h100 = h*100;
    hm = 0.4*h;
    FM2 = 0;

    //初期値
    t[0] = 0;
    x[0] = 5*pow(10, 4);
    y[0] = 1*pow(10, 2);
    w[0] = 1*pow(10, 1);

    // モデル
    for ( i = 1; i <= n; i++){
      t[i] = dt*i;
      x[i] = x[i-1] + (lambda - c*x[i-1] - b*x[i-1]*y[i-1])*dt;
      y[i] = y[i-1] + (b*x[i-1]*y[i-1] - h*w[i-1]*y[i-1] - delta*y[i-1])*dt;
      w[i] = w[i-1] + (a*y[i-1] - d*w[i-1])*dt;
    }

    // p(t)の算出
    p[50000] = 1.0;

    for ( j = 1; j <= T; j++){
      t2 = t[T-j];
      x2 = x[T-j];
      w2 = w[T-j];
      p[T-j] = p[T-j+1] + (-p[T-j+1]*p[T-j+1]*bm*x2 - (delta + hm*w2 - bm*x2)*p[T-j+1])*dt;
    }
    // printf("%f",p[0]);

    for ( k = 0; k <= 1000; k++){
      bxyp[k] = b*x[k]*y[k]*p[k];
      // fprintf(fp, "%f\n", bxyp[k]);
    }

    max_index = maxIndex(bxyp, 1000);
    // printf("%d\n", max_index);
    min_index = minIndex(bxyp, max_index, 1000);
    // printf("%d\n", min_index);

    for ( l = 0; l < min_index; l++){
      FM1 = dt*bxyp[l];
      FM2 += FM1;
    }

    fprintf(fp, "%f,%f\n", h, FM2);
  }
  fclose(fp);
  return 0;
}
