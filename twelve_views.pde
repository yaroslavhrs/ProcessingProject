// Дано: O1(x1,y1), O2(x2,y2), O1A, AB, O2B 

float k=2.2;                               // коефіцієнт масштабу 
float x1=(k/1.11)*490, y1=500, x2=100, y2=500;
float h=k*190;
float O1A=k*60, AB=k*390, O2B=k*200, BC=k*250;
float c_rad = 9;
float[] B_xy = new float[2];
float rock_angle=0, rock_side=35*(k/1.7);
float end_x_O1A,end_y_O1A;
float end_x_AB,end_y_AB;
float end_x_BC,end_y_BC;
float d;
float x5,y5,x6,y6, D;// D - дискримінант при знаходженні x-координати точки C  
float xA,yA; // координати точки для підпису точок А
String A="A", B="B", C="C", O1="O1", O2="O2";
    

void setup(){
  size(1366, 768);
  frameRate(60);
  background (253, 253, 200);
  fill(253, 253, 190);
  
  stand(x1,y1,rock_side,rock_angle);
  stand(x2,y2,rock_side,rock_angle);
  
  line(x1-350,y1-h+13,x1-30,y1-h+13);     // горизонтальна лінія стійки С
   
  fill(50);
  textSize(14);
  text(O1,x1+10,y1-15);
  text(O2,x2+15,y2-5);
  fill(253, 253, 190);
    
  for (float i=9; x1-350+i<x1-30; i+=9) {     // штриховка стійки C 
   
    x5=x1-350+i*cos(radians(0));
    x6=x5+10*cos(radians(135));
   
    line(x5,y1-h+13,x6,y1-h+22);
  }
  
  end_y_BC = y1-h;
  
  for (int angle=0,i=1; angle<360; angle+=30,i++) {
    
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
    
    line(x1,y1,end_x_O1A,end_y_O1A);               // O1A
    line(end_x_O1A,end_y_O1A,end_x_AB,end_y_AB);   // AB
    line(x2,y2,end_x_AB,end_y_AB);                 // O2B
    //rect(end_x_BC-14,y1-h-13, 28,26);              // прямокутник повзуна
    line(end_x_AB,end_y_AB,end_x_BC,end_y_BC);     // BC
   
    
    circle(x1,y1,c_rad);
    circle(x2,y2,c_rad);
    circle(end_x_BC,end_y_BC,c_rad);
    circle(end_x_O1A,end_y_O1A,c_rad);
    circle(end_x_AB,end_y_AB,c_rad);
 
    fill(50);
    textSize(14);
    
    
    if (i%3==0 & i!=9){
      text(B+str(i), end_x_AB-10,end_y_AB-15);
    }
    else if (i==2){
      text(B+str(i), end_x_AB+15,end_y_AB-9);
    }
    else if (i==5){
      text(B+str(i), end_x_AB-10,end_y_AB-17);
    }
    else if (i==8){
      text(B+str(i), end_x_AB-20,end_y_AB-9);
    }
    else if (i==9){
      text(B+str(i), end_x_AB+9,end_y_AB-9);
    }
    else if (i==7){
      text(B+str(i), end_x_AB-7,end_y_AB-20);
    }
    else{
      text(B+str(i), end_x_AB-10,end_y_AB-30);
    }
    
    if (i==1){
      text(C+str(i), end_x_BC,end_y_BC-30);
    }
    if (i==2){
      text(C+str(i), end_x_BC+13,end_y_BC);
    }
    if (i==7){
      text(C+str(i), end_x_BC-5,end_y_BC-15);
    } 
    if (i==8){
      text(C+str(i), end_x_BC-8,end_y_BC-15);
    } 
    if (i==9){
      text(C+str(i), end_x_BC+8,end_y_BC-15);
    } 
    if (i==10){
      text(C+str(i), end_x_BC+15,end_y_BC-15);
    }
    if (i<7 & i>2){
      text(C+str(i), end_x_BC,end_y_BC-15);
    }
    if (i>10){
      text(C+str(i), end_x_BC,end_y_BC-30);
    }
    
    xA=end_x(end_x_O1A,25,angle);
    yA=end_y(end_y_O1A,25,angle);
    text(A+str(i), xA-10,yA);

    fill(253, 253, 190);
  }
}

void draw(){
      
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
