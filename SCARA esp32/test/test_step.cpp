#include <Arduino.h>
#include <AccelStepper.h>

// defines pins numbers

const int stepX = 32;
const int stepY = 33;
const int stepZ = 25;
const int stepA = 26;

const int dirX = 27;
const int dirY = 14;
const int dirZ = 12;
const int dirA = 13;

const int enPin = 15;

const int X_limit = 36;
const int Y_limit = 39;
const int Z_limit = 34;
const int A_limit = 35;

AccelStepper stepper_X(1, stepX, dirX);
AccelStepper stepper_Y(1, stepY, dirY);
AccelStepper stepper_Z(1, stepZ, dirZ);
AccelStepper stepper_A(1, stepA, dirA);

void setup()
{
  Serial.begin(9600);
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

  stepper_A.setMaxSpeed(5000);
  stepper_A.setAcceleration(1000);
  stepper_A.moveTo(800);

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
  // Serial.println(digitalRead(A_limit));
  // delay(500);
}