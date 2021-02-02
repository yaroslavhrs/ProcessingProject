// Дано: O1(x1,y1), O2(x2,y2), O1A, AB, O2B 
int d_width=1366, d_height=768;
float k=1;                               // коефіцієнт масштабу 
float x1=(k/1.11)*490, y1=500, x2=100, y2=500;
float h=k*190;
float O1A=k*60, AB=k*390, O2B=k*200, BC=k*250;
float c_rad = 9;
float[] B_xy = new float[2];
float rock_angle=0, rock_side=35*(k/1.7);
int angle=60;
float end_x_O1A,end_y_O1A;
float end_x_AB,end_y_AB;
float end_x_BC,end_y_BC;
float d;
float x5,y5,x6,y6, D;// D - дискримінант при знаходженні x-координати точки C  
float xA,yA; // координати точки для підпису точок А
String A="A", B="B", C="C", O1="O\u2081", O2="O\u2082", Pa="Pa";
float Px, Py, w=9.42; // w - кутова частота. n=90 об/хв => w=9.42 рад/с
float px_O1A_start, py_O1A_start, px_O1A_end, py_O1A_end;
float p_len=400; // довжина перпендикулярів
float corner_AB,corner_O2B, corner_BC;
float a_x,a_y,b_x,b_y,c_x,c_y,point_pO2B_x,point_pO2B_y,point_pAB_x,point_pAB_y,pAB_k,pAB_b,pO2B_k,pO2B_b,test_x,test_y,xx_x1,xx_y1,xx_x2,xx_y2;
float point_Pv_x,point_pBC_x,point_pBC_y;
float a_n_BA,a_n_BA_x,a_n_BA_y,  a_n_O2B,a_n_O2B_x,a_n_O2B_y,  a_n_BC,a_n_BC_x,a_n_BC_y;
float[] b_xy = new float[2];
float[] c_xy = new float[2];
String sh="02D4";
int n = unhex(sh);
char[] chars=Character.toChars(n);
String ch=new String(chars);
String par = "\u007C"+"\u007C";
String tau = "\u03C4";
    

void setup(){
  size(1366, 768);
  frameRate(60);
  background (253, 253, 200);
  fill(253, 253, 190);
   
  end_y_BC = y1-h;
  
  end_x_O1A = end_x(x1,O1A,angle);
  end_y_O1A = end_y(y1,O1A,angle);
  d = sqrt( (x2-end_x_O1A)*(x2-end_x_O1A) + (y2-end_y_O1A)*(y2-end_y_O1A) ); // довжина між кінцем першої ланки O1A та другою стійкою
  
  B_xy = point_B(x2,y2,O2B,end_x_O1A,end_y_O1A,AB);
  end_x_AB = B_xy[0];
  end_y_AB = B_xy[1];
  
  D = 4*end_x_AB*end_x_AB - 4*( ((y1-h)-end_y_AB)*((y1-h)-end_y_AB) - BC*BC + end_x_AB*end_x_AB) ; // D=(2*x1)^2 - 4*( (y2-y1)^2 - BC^2 + x1^2 ) - дискримінант
  
  if (D>0) {
    end_x_BC = (2*end_x_AB+sqrt(D))/2;
  } else if (D==0) {
    end_x_BC = end_x_AB;
  }
  
  strokeWeight(1);
  Px = d_width/2;
  Py = d_height/2; 
  circle(Px,Py,c_rad);
  
  // acceleration line A
  parallel(Px,Py,angle,(O1+A));
  strokeWeight(2);
  a_x=end_x(Px,O1A,angle+180);
  a_y=end_y(Py,O1A,angle+180);
  line(Px,Py,a_x,a_y);
  pointer(a_x,a_y,angle);


  corner_AB=degrees(acos(  (end_x_O1A-100 - end_x_O1A)*(end_x_AB-end_x_O1A)/(100*AB) ));
  corner_O2B=degrees(acos(  (end_x_AB-x2)/O2B ));
  corner_BC=degrees(acos((end_x_BC-end_x_AB)/BC ));
  strokeWeight(1);
  //parallel(a_x,a_y,corner_AB);
  a_n_BA=w*w*AB/100;
  a_n_BA_x=end_x(a_x,a_n_BA,corner_AB);
  a_n_BA_y=end_y(a_y,a_n_BA,corner_AB); 
  line(a_x,a_y,a_n_BA_x,a_n_BA_y);
  text("anBA",a_n_BA_x-25,a_n_BA_y-30);
  pointer(a_n_BA_x,a_n_BA_y,corner_AB-180);
  
  //parallel(Px,Py,(180-corner_O2B));
  
  a_n_O2B=w*w*O2B/100;
  a_n_O2B_x=end_x(Px,a_n_O2B,(180-corner_O2B));
  a_n_O2B_y=end_y(Py,a_n_O2B,(180-corner_O2B)); 
  line(Px,Py,a_n_O2B_x,a_n_O2B_y);
  text("anO2B",a_n_O2B_x-50,a_n_O2B_y-35);
  pointer(a_n_O2B_x,a_n_O2B_y,(180-corner_O2B)-180);
  perpendicular(a_n_O2B_x,a_n_O2B_y,(180-corner_O2B), "O2B");
  perpendicular(a_n_BA_x,a_n_BA_y,corner_AB, "BA");

  point_pO2B_x=end_x(a_n_O2B_x,100,(180-corner_O2B)-90);
  point_pO2B_y=end_y(a_n_O2B_y,100,(180-corner_O2B)-90);
  point_pAB_x=end_x(a_n_BA_x,100,corner_AB+90);
  point_pAB_y=end_y(a_n_BA_y,100,corner_AB+90);

  b_xy = cross_point(a_n_BA_x,a_n_BA_y,point_pAB_x,point_pAB_y,a_n_O2B_x,a_n_O2B_y,point_pO2B_x,point_pO2B_y);
  b_x=b_xy[0];
  b_y=b_xy[1];
  strokeWeight(2);
  line(Px,Py,b_x,b_y);
  pointer(b_x,b_y,corner_AB-170);
 // pointer(b_x,b_y,(273-corner_O2B));
 // pointer(b_x,b_y,corner_AB-90);
  text('a'+tau+"O2B",b_x-180,b_y-15);
  text('a'+tau+"BA",b_x+45,b_y-35);

  strokeWeight(1);
  
  parallel(b_x,b_y,(180-corner_BC), (B+C));
  a_n_BC=w*w*BC/100;
  a_n_BC_x=end_x(b_x,a_n_BC,(180-corner_BC)-180);
  a_n_BC_y=end_y(b_y,a_n_BC,(180-corner_BC)-180);
  line(b_x,b_y,a_n_BC_x,a_n_BC_y);
  pointer(a_n_BC_x,a_n_BC_y,(180-corner_BC));
  perpendicular(a_n_BC_x,a_n_BC_y,(180-corner_BC), (B+C));
  
  xx_x1=end_x(Px,k*p_len,180);
  xx_y1=end_y(Py,k*p_len,180);
  xx_x2=end_x(Px,k*p_len+200,0);
  xx_y2=end_y(Py,k*p_len+200,0);
  line(xx_x1,xx_y1,xx_x2,xx_y2);
  text(par+" x-x", xx_x2-35,xx_y2-10);

  point_Pv_x = end_x(Px,50,0);
  //point_Pv_y=Py
  point_pBC_x=end_x(a_n_BC_x,50,(180-corner_BC)+90);
  point_pBC_y=end_y(a_n_BC_y,50,(180-corner_BC)+90);
  
  c_xy = cross_point(Px,Py,point_Pv_x,Py,a_n_BC_x,a_n_BC_y,point_pBC_x,point_pBC_y);
  c_x=c_xy[0];      
  //c_y=c_xy[1];
  c_y=Py;
  strokeWeight(2);
  line(Px,Py,c_x,c_y);
  pointer(c_x,c_y,180);
  
  fill(50);
  textSize(16);
  text((Pa+O1+O2),Px-35,Py-20);
  textSize(20);
  text('a',a_x-30,a_y);
  text('b',b_x,b_y-20);
  text('c',c_x-20,c_y+25);
  
}


void draw(){
      
}


void perpendicular(float x0, float y0, float corner, String line){
  float px_start = end_x(x0,k*p_len,corner+90);
  float py_start = end_y(y0,k*p_len,corner+90);
  float px_end = end_x(x0,k*p_len,corner-90);
  float py_end = end_y(y0,k*p_len,corner-90);
  line(px_start,py_start,px_end,py_end);
  fill(50);
  if (px_end<d_width && py_end<d_height) {
    textSize(40);
    text(ch, px_end,py_end-2);
    textSize(20);
    text(line, px_end+20,py_end-10);
  }
  else {
    textSize(40);
    text(ch, px_start,py_start-2);
    textSize(20);
    text(line, px_start+20,py_start-10);
  }
}

void parallel(float x0, float y0, float corner, String line){
  float px_start = end_x(x0,k*p_len,corner-180);
  float py_start = end_y(y0,k*p_len,corner-180);
  float px_end = end_x(x0,k*p_len,corner);
  float py_end = end_y(y0,k*p_len,corner);
  line(px_start,py_start,px_end,py_end);
  fill(50);
  textSize(20);
  if (px_end<d_width && py_end<d_height) {
    text((par+line), px_end,py_end-10);
  }
  else {
    text((par+line), px_start,py_start-10);
  }
}


float[] cross_point(float x1_s, float y1_s, float x1_e, float y1_e, float x2_s, float y2_s, float x2_e, float y2_e){
    
    float p1_k=(y1_e-y1_s)/(x1_e-x1_s);
    float p1_b=y1_s-p1_k*x1_s;
    
    float p2_k=(y2_e-y2_s)/(x2_e-x2_s);
    float p2_b=y2_s-p2_k*x2_s;
    
    float x=(p2_b-p1_b)/(p1_k-p2_k);
    float y=p1_k*x+p1_b;
      
      
    float[] cross_xy = {x,y};
    return cross_xy;   
  }
  
  void pointer(float x0, float y0, float angle){
   float x1 = end_x(x0,15,angle+20);
   float y1 = end_y(y0,15,angle+20);
   float x2 = end_x(x0,15,angle-20);
   float y2 = end_y(y0,15,angle-20);
   line(x0,y0,x1,y1);
   line(x0,y0,x2,y2);
  }


// Функція для створення стійки за координатами точки з'єднання (x0,y0), довжиною катетів, кутом нахилу стійки 
void stand(float x0, float y0, float len, float alpha){
  float x1,y1,x2,y2,x3,y3,x4,y4,x5,y5,x6,y6;
  x1=x0+len*cos(radians(135+alpha));
  y1=y0+len*sin(radians(135+alpha));
  
  x2=x0+len*cos(radians(45+alpha));
  y2=y0+len*sin(radians(45+alpha));
  
  triangle(x1,y1, x0,y0, x2,y2);
  
  x3=x1+10*cos(radians(180+alpha));
  y3=y1+10*sin(radians(180+alpha));
  
  x4=x2+10*cos(radians(alpha));
  y4=y2+10*sin(radians(alpha));
    
  line(x1,y1, x3,y3);
  line(x2,y2, x4,y4);
  
  float h = sqrt(2*rock_side*rock_side)+20; // довжина нижньої сторони трикутника стійки
  
    for (float i=9; i<h ; i+=9) {
     
     x5=x3+i*cos(radians(alpha));
     y5=y3+i*sin(radians(alpha));
    
     x6=x5+10*cos(radians(135+alpha));
     y6=y5+10*sin(radians(135+alpha));
     line(x5,y5,x6,y6);
  }
  
  
}

// Функція для знаходження координати X кінця ланки за т. початку, довжиною, кутом нахилу
float end_x(float x0, float len, float alpha){
  float end_x = x0+len*cos(radians(alpha));
  return end_x;
}

// Функція для знаходження координати Y кінця ланки за т. початку, довжиною, кутом нахилу
float end_y(float y0, float len, float alpha){
  float end_y = y0+len*sin(radians(alpha));
  return end_y;
}

// Функція для знаходження точки з'єднання двох ланок: AB та O2B (через перетин двох кіл з радіусами AB та O2B)
float[] point_B(float x1,float y1,float r1,float x2,float y2,float r2){
    float x0,y0; // точка перетину всіх ліній
    float d;     // відстань між центрами кіл
    float a;     // відстань від r1 до точки перетину всіх ліній
    float h;     // відстань від точки перетину кіл до точки перетину всіх ліній
    float xp_1,yp_1,xp_2,yp_2; // шукані точки перетину
  
    d = sqrt( (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1));
    a = (r1*r1 - r2*r2 + d*d ) / (2*d);
    h = sqrt( r1*r1 - a*a);

    if (d > (r1+r2)){
      println("Кола не перетинаються");
    }
    
    if (a == r1){
      println("Одна точка перетину");
    }

    x0 = x1 + a*(x2 - x1) / d;
    y0 = y1 + a*(y2 - y1) / d;

    xp_1= x0 + h*(y2 - y1) / d;
    yp_1= y0 - h*(x2 - x1) / d;

    xp_2= x0 - h*(y2 - y1) / d;
    yp_2= y0 + h*(x2 - x1) / d;
    
    float[] AB = {xp_1,yp_1};
    return AB;   
}
