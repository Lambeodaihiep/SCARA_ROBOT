#include <Arduino.h>
#include "../lib/motor_config.cpp"

void setup() // chỉ chạy 1 lần duy nhất
{
  Serial.begin(115200); // khai báo sử dụng serial cổng 115200
  stepperInit(); // khai báo step
}

int kt = true; // biến kiểm tra
void loop()
{
  if (kt) // các hàm trong này chỉ thực hiện một lần duy nhất trong loop
  {
    stepperStart(); // khởi tạo step
    kt = false;
  }
  // readAngle();  // đọc vào giá trị từ serial
  // stepperRun(); // chạy các giá trị vừa nhập
}
