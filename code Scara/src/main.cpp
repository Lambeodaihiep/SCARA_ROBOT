#include <Arduino.h>
#include "../lib/motor_config.cpp"

void setup() // chỉ chạy 1 lần duy nhất
{
  Serial.begin(9600); // khai báo sử dụng serial cổng 115200
  stepperInit(); // khai báo step
  servoInit();
  closeGripper();
}

char Buffer[27] = {};
String msg = "";

int kt = true; // biến kiểm tra
void loop()
{
  if (kt) // các hàm trong này chỉ thực hiện một lần duy nhất trong loop
  {
    stepperStart(); // khởi tạo step

    moveByAngle(0, 0, 90, 0);
    delay(1000);
    moveByAngle(0, 0, -90, 0);
    // delay(1000);
    // moveByAngle(0, 10, -90, 0);
    // delay(2000);
    // moveByAngle(0, 20, -90, 0);
    // delay(2000);
    // moveByAngle(0, 30, -90, 0);
    // delay(2000);
    kt = false;
  }

  if(Serial.available() > 0) {
    Serial.readBytesUntil('!', Buffer, 27);
    msg = String(Buffer);
    Serial.print(msg);
    
    String q1 = msg.substring(0, msg.indexOf(";"));
    String temp = msg.substring(msg.indexOf(";")+1, msg.length());
    String q2 = temp.substring(0, temp.indexOf(";"));
    temp = temp.substring(temp.indexOf(";")+1, temp.length());
    String q3 = temp.substring(0, temp.indexOf(";"));
    temp = temp.substring(temp.indexOf(";")+1, temp.length());
    String q4 = temp.substring(0, temp.indexOf(";"));
    String servo = temp.substring(temp.indexOf(";")+1, temp.length());

    moveByAngle(q1.toInt(), q2.toInt(), q3.toInt(), q4.toInt());
    if(servo.toInt() == 1)
      closeGripper();
    else openGripper();
  }

  
  // for (int i = 0; i < 11; i++)
  //   moveByAngle(q1[i], q2[i], q3[i], q4[i]);
  // // stepperRun(); // chạy các giá trị vừa nhập

  // for (int i = 10; i >= 0; i--)
  //   moveByAngle(q1[i], q2[i], q3[i], q4[i]);
  
  
}
