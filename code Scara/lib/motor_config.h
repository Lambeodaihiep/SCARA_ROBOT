#include "AccelStepper.h"
AccelStepper stepper[3];

void stepperInit();   // Khai báo step với thư viện
void stepperStart();  // Khởi tạo (bao gồm Homing khi bắt đầu chạy và home về giữa)
void stepperHoming(); // Homing cho động cơ về vị trí ban đầu
void stepperHome();   // di chuyển động cơ về vị trí giữa, đặt là home
void readAngle();     // Nhập xuất dữ liệu bằng góc đơn vị độ
void deg2step();      // Truyền số bước, gia tốc cho động cơ
void theAccel();      // Tính toán gia tốc cho từng động cơ
void stepperRun();    // Thực hiện chạy động cơ