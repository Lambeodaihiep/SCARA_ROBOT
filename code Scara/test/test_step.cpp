#include <Arduino.h>
#include <AccelStepper.h>

// defines pins numbers

const int stepX = 2;
const int dirX = 5;

const int stepY = 3;
const int dirY = 6;

const int stepZ = 4;
const int dirZ = 7;

const int stepA = 12;
const int dirA = 13;

const int enPin = 8;

const int Z_limit = 11;
const int Y_limit = 10;
const int X_limit = 9;
const int A_limit = A3;

AccelStepper stepper_X(1, stepX, dirX);
AccelStepper stepper_Y(1, stepY, dirY);
AccelStepper stepper_Z(1, stepZ, dirZ);
AccelStepper stepper_A(1, stepA, dirA);

void setup()
{
  Serial.begin(115200);
  pinMode(enPin, OUTPUT);
  digitalWrite(enPin, LOW);

  stepper_X.setMaxSpeed(2000);
  stepper_X.setAcceleration(1000);
  stepper_X.moveTo(800);

  stepper_Y.setMaxSpeed(2000);
  stepper_Y.setAcceleration(1000);
  stepper_Y.moveTo(800);

  stepper_Z.setMaxSpeed(5000);
  stepper_Z.setAcceleration(1000);
  stepper_Z.moveTo(800);

  stepper_A.setMaxSpeed(2000);
  stepper_A.setAcceleration(1000);
  stepper_A.moveTo(1600);

  pinMode(Z_limit, INPUT_PULLUP);
  pinMode(Y_limit, INPUT_PULLUP);
  pinMode(X_limit, INPUT_PULLUP);
  pinMode(A_limit, INPUT_PULLUP);
}

void loop()
{
  stepper_X.run();
  stepper_Y.run();
  stepper_Z.run();
  stepper_A.run();
  // Serial.print(digitalRead(Z_limit));
  // Serial.print(digitalRead(Y_limit));
  // Serial.print(digitalRead(X_limit));
  // Serial.print(digitalRead(A_limit));
  // delay(500);
}