//-------------------------------- STEPPER MOTOR --------------------------------
#define motorInterfaceType 1 // mode 1 thư viện accel

#define N 3 // Số lượng động cơ bước

//------------ STEP 1 - X ------------
#define stepL1 2    // dây động cơ bên trái
#define dirL1 5     // dây động cơ bên trái
#define swLimit1 9

//------------ STEP 2 - Z ------------
#define stepL2 4    // dây động cơ bên phải
#define dirL2 7     // dây động cơ bên phải
#define swLimit2 11

//------------ STEP 3 - Y ------------
#define stepL3 3    // dây động cơ bên phải
#define dirL3 6     // dây động cơ bên phải
#define swLimit3 10

//------------ STEP 4 - A ------------
#define stepLA 12    // dây động cơ bên phải
#define dirLA 13     // dây động cơ bên phải
#define swLimitA A3

const int step[N] = {stepL1, stepL2, stepL3};        // list chân step
const int dir[N] = {dirL1, dirL2, dirL3};           // list chân dir
const int swLimit[N] = {swLimit2, swLimit3, swLimit1}; // list công tắc hành trình
int accel[N], accelA;                                // Gia tốc của động cơ
float degToGo[N], degToGoA, currentDeg[N], currentDegA; 

#define numDeg 101

#define en 8 // chân en động cơ, LOW chạy HIGH tắt

//------------ Phần cứng ------------
#define microStep 16   // Vi bước sử dụng
#define ratioPuley1 4 // Tỉ số truyền đai pulley
#define ratioPuley2 4
#define ratioPuley3 9
#define ratioPuleyA 4

//------------ Tốc độ ------------
#define MAXSPEED 2000 // Vận tốc lớn nhất động cơ có thể đạt được
#define MAXACCEL 500  // Gia tốc lớn nhất động cơ có thể đạt được

long stepToGo[N], stepToGoA, MAXSTEP;                            // Số bước cần di chuyển
#define degHome1 90                           // số góc từ công tắc hành trình về giữa
#define degHome2 50                          // số góc từ công tắc hành trình về giữa
#define degHome3 55
#define degHomeA -92                        // số góc từ công tắc hành trình về giữa
// #define degHome3 -94* microStep * ratioPuley3 / 1.8                           // số góc từ công tắc hành trình về giữa

//-------------------------------- RC SERVO --------------------------------

//------------ SERVO ------------
#define pinServo A0 // dây số 7

float q1[21] = {0,	0.8,	1.5,	2.2,	3,	3.7,	4.4,	5.1,	5.8,	6.5,	7.1,	7.8,	8.5,	9.1,	9.7,	10.4,	11,	11.6,	12.2,	12.8,	13.4,};
float q3[21] = {-90,	-91.5,	-93	-94.4,	-95.9,	-97.3,	-98.7,	-100.1,	-101.5,	-102.8,	-104.2,	-105.5,	-106.8,	-108.1,	-109.4,	-110.7,	-112	-113.2,	-114.5,	-115.7,	-117};
float q4[21] = {0,	-0.4,	-0.8,	-1.3,	-1.7,	-2.1,	-2.5,	-2.9,	-3.3,	-3.7,	-4.1,	-4.5,	-4.9,	-5.3,	-5.7,	-6.1,	-6.5,	-6.9,	-7.3,	-7.7,	-8};
float q2[21] = {0, 0,	0, 0,	0,	0,	0,	0,	0,	0, 0,0, 0,	0, 0,	0,	0,	0,	0,	0,	0};