#include "motor_config.h"
#include "Arduino.h"
#include "config.h"

AccelStepper stepperA(motorInterfaceType, stepLA, dirLA);

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
  Serial.println("X, Y, Z plane is homing ...");
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
    Serial.print(digitalRead(swLimit[0]));
    Serial.print(digitalRead(swLimit[1]));
    Serial.print(digitalRead(swLimit[2]));
    Serial.println(digitalRead(swLimitA));
    for (int i = 0; i < N; i++)                                  // for chạy lần lượt từng động cơ
    {
      if (digitalRead(swLimit[i]) != 1) // Nếu động cơ chưa homing xong
      {
        stepper[i].moveTo(flagHome); // Cho động cơ quay ngược chiều kim đồng hồ
        stepper[i].move(flagHome);
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
    delayMicroseconds(1000);
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
}

void readAngle()
{
  for (int i = 0; i < N; i++)
  {
    degToGo[i] = degGo[index];
    index++;
    if (index > numDeg)
    {
    //   servoHome();
      while (1);
    }
    delay(5);
  }
}

int servoVal = 0;

void theAccel()
{
  accel[0] = MAXACCEL; // cho động cơ 1 mặc định là maxAccel

  for (int i = 0; i < N; i++)                        // các động cơ khác nhận giá trị
  { // tỉ lệ so với động cơ 1
    accel[i] = (degToGo[i] / degToGo[0]) * accel[0]; // để đảm bảo các động cơ dừng đồng thời
    // Serial.println(accel[i]);
  }           
  accelA = (degToGoA / degToGo[0]) * accel[0];                                       
}

void deg2step()
{
  theAccel();
  // đổi từ góc sang bước,
  // chia góc cho 1.8/microStep (vi bước)
  //    stepToGo[i] = degToGo[i] * microStep * ratioPuley / 1.8; // sau đó nhân với tỉ số truyền của bánh răng và dây đai
  stepToGo[0] = degToGo[0];
  stepToGo[1] = degToGo[1];
  stepToGo[2] = degToGo[2];
  stepToGoA = degToGoA;

  if (abs(stepToGo[0]) == 3600)
  {
    servoVal = abs(stepToGo[0]) / stepToGo[0];
    Serial.print("servo");

    stepToGo[0] = 1;
    stepToGo[1] = 1;
    stepToGo[2] = 1;
    stepToGo[3] = 1;
  }

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