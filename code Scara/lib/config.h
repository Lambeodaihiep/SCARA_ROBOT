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
const int swLimit[N] = {swLimit1, swLimit2, swLimit3}; // list công tắc hành trình
int accel[N], accelA;                                // Gia tốc của động cơ
long degToGo[N], degToGoA;                             // Số góc nhập vào

//#define numLine 1
#define numDeg 88*2
long degGo[numDeg] = {
-650,1081,
-3600, -3600,
14,-18,
14,-18,
14,-19,
14,-19,
14,-19,
14,-20,
15,-20,
15,-21,
15,-21,
15,-22,
15,-22,
15,-23,
16,-24,
16,-24,
16,-25,
17,-26,
17,-27,
18,-28,
18,-29,
19,-31,
19,-32,
20,-34,
21,-36,
22,-39,
24,-42,
26,-47,
29,-53,
34,-63,
43,-82,
99,-197,
0,0,
-93,197,
-37,82,
-27,63,
-22,53,
-19,47,
-17,42,
-15,39,
-14,36,
-13,34,
-12,32,
-11,31,
-10,29,
-10,28,
-9,27,
-8,26,
-8,25,
-7,24,
-7,24,
-7,23,
-6,22,
-6,22,
-6,21,
-5,21,
-5,20,
-5,20,
-4,19,
-4,19,
-4,19,
-3,18,
-3,18,
3600,3600,
389,-1065,
-3600,-3600,
0,0,
7,2,
7,2,
7,2,
7,2,
7,1,
7,1,
7,1,
7,1,
7,0,
8,0,
8,-0,
8,-0,
8,-1,
8,-1,
8,-1,
8,-1,
8,-2,
8,-2,
9,-2,
9,-2,
3600,3600}; //endDEG
long index = 0; //chỉ số chạy mảng nhập sẵn

#define en 8 // chân en động cơ, LOW chạy HIGH tắt

//------------ Phần cứng ------------
#define microStep 8   // Vi bước sử dụng
#define ratioPuley1 4 // Tỉ số truyền đai pulley
#define ratioPuley2 4
#define ratioPuley3 9
#define ratioPuley4 4

//------------ Tốc độ ------------
#define MAXSPEED 5000 // Vận tốc lớn nhất động cơ có thể đạt được
#define MAXACCEL 500  // Gia tốc lớn nhất động cơ có thể đạt được

long stepToGo[N], stepToGoA;                            // Số bước cần di chuyển
#define degHome1 -800                           // số góc từ công tắc hành trình về giữa
#define degHome2 0                          // số góc từ công tắc hành trình về giữa
#define degHome3 -5800
#define degHomeA -1600                          // số góc từ công tắc hành trình về giữa
// #define degHome3 -94* microStep * ratioPuley3 / 1.8                           // số góc từ công tắc hành trình về giữa

//-------------------------------- RC SERVO --------------------------------

//------------ SERVO ------------
// #define pinServo  // dây số 7

// #define posMax 180 // vị trí cao nhất L3
// #define posMin 0   // vị trí thấp nhất L3

// int posWrite; // vị trí hoạt đông của L3

