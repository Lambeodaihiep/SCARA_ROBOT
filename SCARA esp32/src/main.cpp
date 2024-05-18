#include <Arduino.h>
#include <../lib/motor_config.cpp>
#include <Adafruit_I2CDevice.h>
#include <../lib/config_oled.cpp>
#include <Wire.h>
#include <SPI.h>

char Buffer[31] = {};
String msg = "";
String q1, q2, q3, q4, servo, temp;
float angle1[100];// = {0,   -5.3300,   -7.3200,   -8.7900,   -9.9400,  -10.8900,  -11.7400,  -12.4800,  -13.1000,  -13.6900,  -14.2100,  -14.6900,  -15.1200,  -15.4500,  -15.8000,  -16.1200,  -16.4000,  -16.6600,  -16.8800,  -17.0800,  -17.2600,  -17.3500,  -17.4800,  -17.5900,  -17.6800,  -17.7500,  -17.8000,  -17.8300,  -17.8500,  -17.8400,  -17.8200,  -17.7800,  -17.7200,  -17.6500,  -17.5600,  -17.4500,  -17.3000,  -17.1700,  -17.0300,  -16.8700,  -16.7000,  -16.5100,  -16.3100,  -16.1000,  -15.8700,  -15.6300,  -15.3800,  -15.1100,  -14.8300,  -14.5400,  -14.2300};
float angle2[100];// = {0,         0,         0,         0,         0,         0,         0,         0,         0,         0,         0,         0,         0,         0,         0,         0,         0,         0,         0,         0,         0,         0,         0,         0,         0,         0,         0,         0,         0,         0,         0,         0,         0,         0,         0,         0,         0,         0,         0,         0,         0,         0,         0,         0,         0,         0,         0,         0,         0,         0,         0};
float angle3[100];// = {0,   10.8900,   15.3100,   18.9200,   21.7300,   24.1600,   26.5400,   28.7400,   30.5000,   32.3900,   34.1800,   35.8800,   37.5000,   38.7300,   40.2000,   41.6200,   42.9900,   44.3000,   45.5800,   46.8000,   47.9800,   48.8300,   49.9500,   51.0400,   52.1100,   53.1400,   54.1500,   55.1200,   56.0800,   57.0000,   57.9000,   58.7700,   59.6200,   60.4400,   61.2400,   62.0100,   62.6200,   63.3900,   64.1400,   64.8800,   65.5900,   66.2900,   66.9800,   67.6400,   68.2900,   68.9200,   69.5300,   70.1200,   70.7000,   71.2700,   71.8100};
float angle4[100];// = {0,    4.3900,    6.4000,    7.3900,    8.7600,   10.0700,   10.7900,   11.4100,   12.6600,   13.2500,   13.7800,   14.2700,   14.7500,   15.9800,   16.4300,   16.8600,   17.2800,   17.6800,   18.0700,   18.4700,   18.8700,   19.9900,   20.3400,   20.6700,   21.0000,   21.3200,   21.6300,   21.9400,   22.2500,   22.5500,   22.8600,   23.1800,   23.4900,   23.8100,   24.1400,   24.4800,   25.1700,   25.4000,   25.6300,   25.8500,   26.0700,   26.2800,   26.4900,   26.7000,   26.9100,   27.1100,   27.3100,   27.5100,   27.7100,   27.9100,   28.1000};
       
int j = 0;

void setup() // chỉ chạy 1 lần duy nhất
{
  Serial.begin(9600); // khai báo sử dụng serial cổng 115200

  if(!display.begin(SSD1306_SWITCHCAPVCC))
  {
    Serial.println(F("SSD1306 allocation failed"));
    for(;;);
  }
  display.clearDisplay();
  display.display();
  
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
    OLED_display_by_number(0, 0, 0, 0);
    // moveByAngle(0, 0, 90, 0);
    // for(int i = 0; i < 51; i++) {
    //   moveByAngle(angle1[i], angle2[i], angle3[i], angle4[i]);
    //   OLED_display_by_string(String(angle1[i]), String(angle2[i]), String(angle3[i]), String(angle4[i]));
    // }
    // for(int i = 50; i >= 0; i--) {
    //   moveByAngle(angle1[i], angle2[i], angle3[i], angle4[i]);
    //   OLED_display_by_string(String(angle1[i]), String(angle2[i]), String(angle3[i]), String(angle4[i]));
    // }
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

      angle1[j] = q1.toFloat();
      angle2[j] = q2.toFloat();
      angle3[j] = q3.toFloat();
      angle4[j] = q4.toFloat();
      j++;
    }
  }
  if(msg == "let move") {
    for(int i = 0; i < j; i++) {
      moveByAngle(angle1[i], angle2[i], angle3[i], angle4[i]);
      OLED_display_by_string(String(angle1[i]), String(angle2[i]), String(angle3[i]), String(angle4[i]));
    }
    j = 0;
    msg = "";
  }
  if(servo.toInt() == 1)
    closeGripper();
  else openGripper();
}
