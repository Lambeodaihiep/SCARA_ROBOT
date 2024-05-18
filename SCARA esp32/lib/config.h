//-------------------------------- STEPPER MOTOR --------------------------------
#define motorInterfaceType 1 // mode 1 thư viện accel

#define N 3 // Số lượng động cơ bước

//------------ STEP 1 - X ------------
#define stepL1 32    // dây động cơ bên trái
#define dirL1 27     // dây động cơ bên trái
#define swLimit1 36

//------------ STEP 2 - Z ------------
#define stepL2 25    // dây động cơ bên phải
#define dirL2 12     // dây động cơ bên phải
#define swLimit2 34

//------------ STEP 3 - Y ------------
#define stepL3 33    // dây động cơ bên phải
#define dirL3 14     // dây động cơ bên phải
#define swLimit3 39

//------------ STEP 4 - A ------------
#define stepLA 26    // dây động cơ bên phải
#define dirLA 13     // dây động cơ bên phải
#define swLimitA 35

const int step[N] = {stepL1, stepL2, stepL3};        // list chân step
const int dir[N] = {dirL1, dirL2, dirL3};           // list chân dir
const int swLimit[N] = {swLimit1, swLimit2, swLimit3}; // list công tắc hành trình
int accel[N], accelA;                                // Gia tốc của động cơ
float degToGo[N], degToGoA, currentDeg[N], currentDegA; 

#define en 15 // chân en động cơ, LOW chạy HIGH tắt

//------------ Phần cứng ------------
#define microStep 16   // Vi bước sử dụng
#define ratioPuley1 4 // Tỉ số truyền đai pulley
#define ratioPuley2 4
#define ratioPuley3 9
#define ratioPuleyA 4

//------------ Tốc độ ------------
#define MAXSPEED 10000 // Vận tốc lớn nhất động cơ có thể đạt được
#define MAXACCEL 2000  // Gia tốc lớn nhất động cơ có thể đạt được

long stepToGo[N], stepToGoA, MAXSTEP;                            // Số bước cần di chuyển
#define degHome1 151                           // số góc từ công tắc hành trình về giữa
#define degHome2 0                        // số góc từ công tắc hành trình về giữa
#define degHome3 143.5
#define degHomeA -94                        // số góc từ công tắc hành trình về giữa
// #define degHome3 -94* microStep * ratioPuley3 / 1.8                           // số góc từ công tắc hành trình về giữa

//-------------------------------- RC SERVO --------------------------------

//------------ SERVO ------------
#define pinServo 2 // dây số 7