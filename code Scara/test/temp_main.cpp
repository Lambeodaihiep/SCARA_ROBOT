#include <Arduino.h>
#include "../lib/motor_config.cpp"

void setup() // chỉ chạy 1 lần duy nhất
{
  Serial.begin(115200); // khai báo sử dụng serial cổng 115200
  stepperInit(); // khai báo step
  servoInit();
  closeGripper();
}

int kt = true; // biến kiểm tra
void loop()
{
  if (kt) // các hàm trong này chỉ thực hiện một lần duy nhất trong loop
  {
    stepperStart(); // khởi tạo step
    kt = false;
    
    moveByAngle(0, 0, 90, 0);
    delay(1000);
    moveByAngle(0, 0, -90, 0);
  }
  // for (int i = 0; i < 11; i++)
  //   moveByAngle(q1[i], q2[i], q3[i], q4[i]);
  // // stepperRun(); // chạy các giá trị vừa nhập

  // for (int i = 10; i >= 0; i--)
  //   moveByAngle(q1[i], q2[i], q3[i], q4[i]);
  
  
}
