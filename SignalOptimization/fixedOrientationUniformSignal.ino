#include <SparkFun_TB6612.h>
#include <movingAvg.h>
#include <Gaussian.h>
//#include <SPI.h>

const int diodes_idx[8] = { A0, A1, A2, A3, A4, A5, A6, A7 };
int diodes[8];     // stores raw diode readings
String text = "";  // dummy serial print variable
// int headPin = -1;


int avg[8];  //smoothing buffer
int avgBuff = 25;
movingAvg s1(avgBuff);
movingAvg s2(avgBuff);
movingAvg s3(avgBuff);
movingAvg s4(avgBuff);
movingAvg s5(avgBuff);
movingAvg s6(avgBuff);
movingAvg s7(avgBuff);
movingAvg s8(avgBuff);

#define AIN1 2
#define BIN1 7
#define AIN2 4
#define BIN2 8
#define PWMA 5
#define PWMB 6
#define STBY 9  //3 10
#define ERM_PIN 10
const int offsetA = 1;
const int offsetB = 1;
Motor motor1 = Motor(AIN1, AIN2, PWMA, offsetA, STBY);
Motor motor2 = Motor(BIN1, BIN2, PWMB, offsetB, STBY);

int minOut[2] = { 0, 0 };
int spd = 0;
void setSpins(int headPin, int spd);
void arrMin(int (&avg)[8], int (&minOut)[2]);  //was diodes
int polarizeHead(int spd);                     //not spd but just need a 0
bool program = true;
int index = 0;
int vibArr[11] = { 255, 0, 0, 0, 0, 0, 0, 175, 200, 225, 250 };
int driveArr[11] = { 0, 0, 0, 0, 0, 0, 150, 175, 200, 225, 250 };
int randSpeed = 0;



// int pulse = (100 * 670);
// int pulse = 470;
int pulse = 470;  //1270 is the analysis dt
int dt = pulse;
int dtFlip = pulse;
int n = -2;  //if it's -1 you divide by zero idiot


bool flip = false;
int coin = 1;
double coinRand = 0;
int headPin = int(random(0, 7));  //gives a randomNumber

//------------------------------------------------------------------------

int centerLine = 110;
int max_amp = 60;

int high_dt = 470;
int low_dt = 470;  //usually 470 TODO


int dt_counter = 0;

//------------------------------------------------------------------------
unsigned long start = millis();
double randNumber = 0;
// int phase_offset = 0;


void setup() {

  TCCR0B = TCCR0B & B11111000 | B00000001;  //62.5khz
  //TCCR0B = TCCR0B & B11111000 | B00000010; 7k ish
  pinMode(PWMA, OUTPUT);
  pinMode(PWMB, OUTPUT);
  pinMode(13, OUTPUT);
  for (int i = 0; i < 8; i++) {
    pinMode(diodes_idx[i], INPUT);  // initiate pinModes
  }
  Serial.begin(115200);  // usually 500000 115200
  // Serial.println("Start");
  analogWrite(ERM_PIN, 0);
  s1.begin();
  s2.begin();
  s3.begin();
  s4.begin();
  s5.begin();
  s6.begin();
  s7.begin();
  s8.begin();
  //    delay(67*10000);
  randomSeed(analogRead(3));

  //TODO

  analogWrite(ERM_PIN, 0);
  coinRand = random(0.01, 100) / 100.00;
  dt_counter = int(random(300, 800)); 



  if (coinRand > 0.5) {
    coin = -1;
  }
  headPin = int(random(0, 7));
}

// Gaussian g1 = Gaussian(0, 30); //was 0, 20
// double var = g1.random();
double var = random(-10, 10);
int phase_offset = int(random(100, 300)); 

void loop() {
  // scan all pins and record current state
  for (int i = 0; i < 8; i++) {
    diodes[i] = analogRead(diodes_idx[i]);
    if (i == 0) {
      avg[i] = s1.reading(diodes[i]);
    } else if (i == 1) {
      avg[i] = s2.reading(diodes[i]);
    } else if (i == 2) {
      avg[i] = s3.reading(diodes[i]);
    } else if (i == 3) {
      avg[i] = s4.reading(diodes[i]);
    } else if (i == 4) {
      avg[i] = s5.reading(diodes[i]);
    } else if (i == 5) {
      avg[i] = s6.reading(diodes[i]);
    } else if (i == 6) {
      avg[i] = s7.reading(diodes[i]);
    } else if (i == 7) {
      avg[i] = s8.reading(diodes[i]);
    }
  }

  int counter = 0;
  int counter2 = 0;
  for (int i = 0; i < 8; i++) {
    if (avg[i] > 600) {
      counter++;
      //      Serial.println(avg[i]);
    }
  }

  arrMin(avg, minOut);  //was diodes
  int index = minOut[0];

  // headPin = polarizeHead(index);


  //  Serial.println(millis());
  if (counter > 2) { //>2 
    // Serial.println("light on");
    // Serial.println(headPin);
    if (dt_counter < (high_dt)) {
      setSpins(headPin, round(centerLine + max_amp + var));
      Serial.println(round(centerLine  + var));
      dt_counter++;
    } else if (dt_counter >= high_dt & dt_counter < (high_dt + low_dt)) {
      setSpins(headPin, round(centerLine - var));
      Serial.println(round(centerLine - var));
      dt_counter++;
    } else if (dt_counter >= (high_dt + low_dt)) {
      dt_counter = 0;
      var = random(-1*max_amp, max_amp);
      phase_offset = int(random(100, 300)); 
      dt_counter = phase_offset;
    }


  } else {
    setSpins(headPin, 0);
    // dt = pulse;
    // Serial.println(dt);
  }
}

  //----------------------------------------------------------------
  //                           WRAPPERS
  //----------------------------------------------------------------



  void setSpins(int headPin, int spd) {
    // camer spd = 100;
    if (spd < 0 || spd > 255) {
      spd = 0;
    }
    if (headPin == 0 || headPin == 4) {
      motor1.drive(spd, 10);
      motor2.drive(spd, 10);
    } else if (headPin == 1 || headPin == 5) {
      motor1.drive(-1 * spd, 10);
      motor2.drive(spd, 10);
    } else if (headPin == 2 || headPin == 6) {
      motor1.drive(-1 * spd, 10);
      motor2.drive(-1 * spd, 10);
    } else if (headPin == 3 || headPin == 7) {
      motor1.drive(spd, 10);
      motor2.drive(-1 * spd, 10);
    } else {
      motor1.drive(0, 10);
      motor2.drive(0, 10);
    }
  }

  void arrMin(int(&diodes)[8], int(&minOut)[2]) {  //need wrapper for full array max/min finding using native functions
    int j = 0;
    for (int i = 0; i < 8; i++) {
      if (i == 0) {
        minOut[0] = i;
        minOut[1] = diodes[0];
      } else {
        if (diodes[i] < minOut[1]) {
          minOut[0] = i;
          minOut[1] = diodes[i];
        }
      }
    }
  }
