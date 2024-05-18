#include <Arduino.h>
#include <SPI.h>
#include <Wire.h>
#include <Adafruit_GFX.h>
#include <Adafruit_SSD1306.h>


#define SCREEN_WIDTH 128
#define SCREEN_HEIGHT 64

#define OLED_MOSI   23
#define OLED_CLK    4
#define OLED_DC     18
#define OLED_CS     5
#define OLED_RESET  19

unsigned long OLED_lastTime = 0;

Adafruit_SSD1306 display(SCREEN_WIDTH, SCREEN_HEIGHT,
  OLED_MOSI, OLED_CLK, OLED_DC, OLED_RESET, OLED_CS);

void OLED_display_by_number(int A1, int A2, int A3, int A4)
{
  display.clearDisplay();
  display.setTextSize(1);
  display.setTextColor(SSD1306_WHITE);
  display.setCursor(0,0);
  display.print("q1: "); display.println(String(A1));
  display.print("q2: "); display.println(String(A2));
  display.print("q3: "); display.println(String(A3));
  display.print("q4: "); display.println(String(A4));
  display.display();
}
void OLED_display_by_string(String A1, String A2, String A3, String A4)
{
  display.clearDisplay();
  display.setTextSize(1);
  display.setTextColor(SSD1306_WHITE);
  display.setCursor(0,0);
  display.print("q1: "); display.println(A1);
  display.print("q2: "); display.println(A2);
  display.print("q3: "); display.println(A3);
  display.print("q4: "); display.println(A4);
  display.display();
}
void OLED_display_text(String s)
{
  display.clearDisplay();
  display.setTextSize(2);
  display.setTextColor(SSD1306_WHITE);
  display.setCursor(0,0);
  display.print(s);
  display.display();
}