#include "motor_config.h"
#include "Arduino.h"
#include "config.h"
#include "ESP32Servo.h"

AccelStepper stepperA(motorInterfaceType, stepLA, dirLA);
Servo gripper;

void stepperInit()
{
  pinMode(en, OUTPUT);   // Chân dừng khẩn cấp
  digitalWrite(en, LOW); // LOW cho phép động cơ chạy

  for (int i = 0; i < N; i++)
  {
    stepper[i] = AccelStepper(motorInterfaceType, step[i], dir[i]); // Khai báo các chân ứng với mỗi động cơ
    pinMode(swLimit[i], INPUT_PULLUP);                    // Khai báo công tắc hành trình              
  }
  pinMode(swLimitA, INPUT_PULLUP);
}

void stepperStart()
{
  stepperHoming(); // thực hiện homming

  stepperHome(); // ra vị trí chính giữa, là trạng thái ban đầu của robot
  for (int i = 0; i < N; i++)
  {
    stepper[i].setMaxSpeed(MAXSPEED); // Khởi tạo Vận tốc lớn nhất cho động cơ
  }
  stepperA.setMaxSpeed(MAXSPEED);
}

void stepperHoming()
{
  // Serial.println("X, Y, Z plane is homing ...");
  for (int i = 0; i < N; i++) // Khởi tạo Vận tốc và Gia tốc
  {
    stepper[i].setMaxSpeed(MAXSPEED);
    stepper[i].setAcceleration(MAXACCEL);
  }
  stepperA.setMaxSpeed(MAXSPEED);
  stepperA.setAcceleration(MAXACCEL);

  long flagHome = 1; // Biến kiểm tra công tắc hành trình

  while (digitalRead(swLimit[0]) == 0 || digitalRead(swLimit[1]) == 0 || digitalRead(swLimit[2]) == 0 || digitalRead(swLimitA) == 0) // chừng nào có 1 trong 4 động cơ chưa về vị trí homing
  { 
    // Serial.print(digitalRead(swLimit[0]));
    // Serial.print(digitalRead(swLimit[1]));
    // Serial.print(digitalRead(swLimit[2]));
    // Serial.println(digitalRead(swLimitA));
    for (int i = 0; i < N; i++)                                  // for chạy lần lượt từng động cơ
    {
      if (digitalRead(swLimit[i]) != 1) // Nếu động cơ chưa homing xong
      {
        stepper[i].moveTo(-flagHome); // Cho động cơ quay ngược chiều kim đồng hồ
        stepper[i].move(-flagHome);
        stepper[i].run();
      }
    }
    if (digitalRead(swLimitA) != 1) // Nếu động cơ chưa homing xong
    {
      stepperA.moveTo(flagHome); // Cho động cơ quay ngược chiều kim đồng hồ
      stepperA.move(flagHome);
      stepperA.run();
    }
    flagHome++; // tăng giá trị cần quay về
    delayMicroseconds(2000);
  }

  for (int i = 0; i < N; i++)
  {
    stepper[i].setCurrentPosition(0); // Sau khi homing set vị trí đó là 0
  }
  stepperA.setCurrentPosition(0);
}

void stepperHome()
{
  for (int i = 0; i < N; i++) // Khởi tạo Vận tốc và Gia tốc
  {
    stepper[i].setMaxSpeed(MAXSPEED);
    stepper[i].setAcceleration(MAXACCEL);
  }
  stepperA.setMaxSpeed(MAXSPEED);
  stepperA.setAcceleration(MAXACCEL);

  degToGo[0] = degHome1; // đưa robot về giữa
  degToGo[1] = degHome2; // đưa robot về giữa
  degToGo[2] = degHome3; // đưa robot về giữa
  degToGoA = degHomeA; // đưa robot về giữa

  stepperRun();

  // Sau khi home set vị trí ban đầu
  stepper[0].setCurrentPosition(0);
  stepper[1].setCurrentPosition(0);
  stepper[2].setCurrentPosition(0);
  stepperA.setCurrentPosition(0);

  currentDeg[0] = 0;
  currentDeg[1] = 0;
  currentDeg[2] = 0;
  currentDegA = 0;
}

void moveByAngle(float q1, float q2, float q3, float q4)
{

    degToGo[0] = q1 - currentDeg[0];
    degToGo[1] = q2 - currentDeg[1];
    degToGo[2] = q3 - currentDeg[2];
    degToGoA = q4 - currentDegA;
    
    currentDeg[0] = q1;
    currentDeg[1] = q2;
    currentDeg[2] = q3;
    currentDegA = q4;

    stepperRun();
    // currentPosition();
}

int servoVal = 0;

void theAccel()
{
  // động cơ nào di chuyển nhiều nhất sẽ có gia tốc lớn nhất
  MAXSTEP = 0;
  for (int i = 0; i < N; i++) {
    if (abs(MAXSTEP) < abs(stepToGo[i]))
      MAXSTEP = stepToGo[i];
  }
  if (abs(MAXSTEP) < abs(stepToGoA))
    MAXSTEP = stepToGoA;
  
  // Serial.println(MAXSTEP);
  if (MAXSTEP != 0) {
    for (int i = 0; i < N; i++)                        // các động cơ khác nhận giá trị
    {
      accel[i] = (stepToGo[i] / MAXSTEP) * MAXACCEL; // để đảm bảo các động cơ dừng đồng thời
    }           
    accelA = (stepToGoA / MAXSTEP) * MAXACCEL;     
  }                                  
}

void deg2step()
{
  // đổi từ góc sang bước,
  // chia góc cho 1.8/microStep (vi bước)
  //    stepToGo[i] = degToGo[i] * microStep * ratioPuley / 1.8; // sau đó nhân với tỉ số truyền của bánh răng và dây đai
  stepToGo[0] = degToGo[0] * ratioPuley1 * microStep / 1.8;
  stepToGo[1] = 9 * degToGo[1] * ratioPuley2 * microStep / 1.8;
  stepToGo[2] = degToGo[2] * ratioPuley3 * microStep / 1.8;
  stepToGoA = degToGoA * ratioPuleyA * microStep / 1.8;

  // Serial.println(stepToGo[0]);
  // Serial.println(stepToGo[1]);
  // Serial.println(stepToGo[2]);
  // Serial.println(stepToGoA);

  theAccel();

  // if (abs(stepToGo[0]) == 3600)
  // {
  //   servoVal = abs(stepToGo[0]) / stepToGo[0];
  //   Serial.print("servo");

  //   stepToGo[0] = 1;
  //   stepToGo[1] = 1;
  //   stepToGo[2] = 1;
  //   stepToGo[3] = 1;
  // }

  for (int i = 0; i < N; i++)
  {
    stepper[i].moveTo(stepToGo[i]);       // gán các bước cần di chuyển cho step
    stepper[i].move(stepToGo[i]);         //
    stepper[i].setAcceleration(accel[i]); // gán gia tốc cho từng động cơ
  }
  stepperA.moveTo(stepToGoA);       // gán các bước cần di chuyển cho step
  stepperA.move(stepToGoA);         //
  stepperA.setAcceleration(accelA);

  delay(10);

}

void stepperRun()
{
  deg2step();

  // Tiếp tục stepperRun() khi chưa thực hiện đủ bước
  while (stepper[0].distanceToGo() != 0 || stepper[1].distanceToGo() != 0 || stepper[2].distanceToGo() != 0 || stepperA.distanceToGo() != 0)
  {
    stepper[0].run();
    stepper[1].run();
    stepper[2].run();
    stepperA.run();
  }
}

void currentPosition()
{
  for(int i = 0; i < N; i++)
    Serial.println(stepper[i].currentPosition());

  Serial.println(stepperA.currentPosition());
}

void servoInit()
{
  gripper.attach(pinServo);
}
void openGripper()
{
  gripper.write(0);
}
void closeGripper()
{
  gripper.write(90);
}