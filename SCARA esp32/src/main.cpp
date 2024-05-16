#include <Arduino.h>
#include "../lib/motor_config.cpp"

void setup() // chỉ chạy 1 lần duy nhất
{
  Serial.begin(9600); // khai báo sử dụng serial cổng 115200
  stepperInit(); // khai báo step
  servoInit();
  closeGripper();

  stepperStart(); // khởi tạo step
}

char Buffer[31] = {};
String msg = "";
String q1, q2, q3, q4, servo, temp;
float angle[4][100], a1, a2, a3, a4;
int j = 0;

bool kt = false; // biến kiểm tra
void loop()
{
  if (kt) // các hàm trong này chỉ thực hiện một lần duy nhất trong loop
  {
    stepperStart(); // khởi tạo step
    // moveByAngle(0, 0, 90, 0);
    // delay(1000);
    // moveByAngle(0, 0, -90, 0);
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
    Serial.readBytesUntil('!', Buffer, 31);
    msg = String(Buffer);
    if (msg[0] == 'e')
      msg = "let move";
    else {
      q1 = msg.substring(0, msg.indexOf(";"));
      temp = msg.substring(msg.indexOf(";")+1, msg.length());
      q2 = temp.substring(0, temp.indexOf(";"));
      temp = temp.substring(temp.indexOf(";")+1, temp.length());
      q3 = temp.substring(0, temp.indexOf(";"));
      temp = temp.substring(temp.indexOf(";")+1, temp.length());
      q4 = temp.substring(0, temp.indexOf(";"));
      servo = temp.substring(temp.indexOf(";")+1, temp.length());

      angle[0][j] = q1.toFloat();
      angle[1][j] = q2.toFloat();
      angle[2][j] = q3.toFloat();
      angle[3][j] = q4.toFloat();
      j++;
    }
  }
  if(msg == "let move") {
    // for(int i = 0; i < j; i++) {
      // a1 = angle[0][j];
      // a2 = angle[1][j];
      // a3 = angle[2][j];
      // a4 = angle[3][j];
      // moveByAngle(, angle[1][j], angle[2][j], angle[3][j]);
    // }
    j = 0;
    msg = "";
  }
  if(servo.toInt() == 1)
    closeGripper();
  else openGripper();
}
