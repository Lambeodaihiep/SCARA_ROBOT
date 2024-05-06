#include <Wire.h>
#include <Arduino.h>

int magnetStatus = 0; // lưu trữ trạng thái của cảm biến từ

int lowbyte; 
word highbyte; 
int rawAngle; 
float degAngle; 

int quadrantNumber, previousquadrantNumber; 
float numberofTurns = 0; // Số lần quay
float correctedAngle = 0; 
float startAngle = 0; 
float totalAngle = 0; 
float previoustotalAngle = 0; 

void ReadRawAngle() // đọc byte min & max để tìm ra raw angle --> degangle
{ 
  // 7:0 - bit
  Wire.beginTransmission(0x36); // 0x36 địa chỉ của cb từ
  Wire.write(0x0D); 
  Wire.endTransmission(); 
  Wire.requestFrom(0x36, 1); 
  
  while(Wire.available() == 0); 
  lowbyte = Wire.read();  

  // 11:8 - 4 bit
  Wire.beginTransmission(0x36);
  Wire.write(0x0C); 
  Wire.endTransmission();
  Wire.requestFrom(0x36, 1);
  
  while(Wire.available() == 0);  
  highbyte = Wire.read();
  
  highbyte = highbyte << 8; 
  rawAngle = highbyte | lowbyte; 
  degAngle = rawAngle * 0.087890625; 
  
}

void correctAngle() // hiệu chỉnh góc đọc được dựa trên góc khởi đầu --> tính được góc thực tế
{
  correctedAngle = degAngle - startAngle; 
  if(correctedAngle < 0) { // cảm biến quay vượt quá 360 độ
    correctedAngle = correctedAngle + 360; 
  }
}

void checkQuadrant()
{
  if(correctedAngle >= 0 && correctedAngle <=90){
    quadrantNumber = 1;
  }

  if(correctedAngle > 90 && correctedAngle <=180){
    quadrantNumber = 2;
  }

  if(correctedAngle > 180 && correctedAngle <=270)
  {
    quadrantNumber = 3;
  }

  if(correctedAngle > 270 && correctedAngle <360){
    quadrantNumber = 4;
  }
// kiểm tra xem góc quay cùng chiều hay ngược chiều kim đồng hồ (từ góc phần tư thứ 1 -> 4, hay 4 -> 1)
  if(quadrantNumber != previousquadrantNumber) {
    if(quadrantNumber == 1 && previousquadrantNumber == 4)
      numberofTurns++; 

    if(quadrantNumber == 4 && previousquadrantNumber == 1)
      numberofTurns--; 

    previousquadrantNumber = quadrantNumber; 
  
  }  

  totalAngle = (numberofTurns*360) + correctedAngle; 
}

void checkMagnetPresence() // kiểm tra từ tính (nam châm)
{  
  while((magnetStatus & 32) != 32)  // kiểm tra xem bit thứ 5 của magnet có set 1 không
  {
    magnetStatus = 0; 

    Wire.beginTransmission(0x36); 
    Wire.write(0x0B); 
    Wire.endTransmission(); 
    Wire.requestFrom(0x36, 1); 

    while(Wire.available() == 0); 
    magnetStatus = Wire.read(); 
  }      
}

void displayInfoSerial()
{
  Serial.print("Total Angle: ");
  Serial.print(totalAngle);
  Serial.print(" degrees, Quadrant: ");
  Serial.println(quadrantNumber);
}

void setup()
{
  Serial.begin(115200); 
  Wire.begin(); 
  Wire.setClock(800000L); // Thiết lập tốc độ I2C

  checkMagnetPresence(); // Kiểm tra từ tính
  ReadRawAngle(); // Đọc góc gốc
  startAngle = degAngle; // Cập nhật góc khởi đầu để tẩy

  delay(100); 
}

void loop()
{    
    ReadRawAngle();
    correctAngle(); 
    checkQuadrant(); 
    displayInfoSerial();

    delay(100); 
}