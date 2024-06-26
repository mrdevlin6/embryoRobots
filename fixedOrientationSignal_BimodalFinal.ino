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
int n = -2;  //if it's -1 you divide by zero

double a = 0.0;
double b = 0.0;
double c = 0.0;
double d = 0.0;
bool flip = false;
int coin = 1;
double coinRand = 0;
int headPin = int(random(0, 7));  //gives a randomNumber

//------------------------------------------------------------------------

int centerLine = 100;
int max_amp = 0;




int high_dt = 470;  //TODO 4
int low_dt = 470;   //changes per experiment TODO

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

  //delete
  // delay(67 * 10000 * 10000);

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
int phase_offset = int(random(100, 300));
Gaussian g1 = Gaussian(0, 10);  //was 0, 20


double var = g1.random();

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
    if (avg[i] > 450) {  //was 600, 700 for demos
      counter++;
      //      Serial.println(avg[i]);
    }
  }

  arrMin(avg, minOut);  //was diodes
  int index = minOut[0];

  // headPin = polarizeHead(index);


  //  Serial.println(millis());
  if (counter > 2) {  //TODO >2 ;counter > 2
    // Serial.println("light on");
    // Serial.println(headPin);
    if (dt_counter < (high_dt)) {
      if (max_amp == 0) {
        setSpins(headPin, centerLine);
      } else {
        setSpins(headPin, round(centerLine + max_amp + var));
        Serial.println(round(centerLine + max_amp + var));
        dt_counter++;
      }
    } else if (dt_counter >= high_dt & dt_counter < (high_dt + low_dt)) {
      if (max_amp == 0) {
        setSpins(headPin, centerLine);
      } else {
        setSpins(headPin, round(centerLine - max_amp - var));
        Serial.println(round(centerLine - max_amp - var));
        dt_counter++;
      }

    } else if (dt_counter >= (high_dt + low_dt)) {
      dt_counter = 0;
      var = g1.random();
      if (abs(var) > 15) {
        if (var > 0) {
          var = 15;
        } else {
          var = -1 * 15;
        }
      }
      phase_offset = int(random(100, 300));
      dt_counter = phase_offset;
      //
    }
  } else {
    setSpins(headPin, 0);
    // dt = pulse;
    // Serial.println(dt);
  }
  //  Serial.print(randCount);
  //  Serial.print(" ");
  //  Serial.println(randNumber);
  //  }

  //----------------------------------------------------------------
  //                  DEBUG PRINT STATEMENTS
  //----------------------------------------------------------------
  //  if (program) {
  //  Serial.println(index);
  //  } else {
  //    Serial.println("Set");
  //  }
  //  Serial.print("Vib: ");
  //  Serial.println(vibArr[index]);
  //  Serial.print("Drive: ");
  //  Serial.println(driveArr[index]);
  //
  //    Serial.println(" ");
  //    for (int i = 0; i < 8; i++) {
  //      text = "Sensor" + String(i + 1) + ":";
  //      Serial.print(text);
  //      //          Serial.print(signal_purify(diodes[i]));
  //      //    Serial.print(diodes[i]);
  //      Serial.print(avg[i]);
  //      Serial.print(" ");
  //      //        Serial.print("; ");
  //      //        if (i ==7) {
  //      //          Serial.println(diodes[i]);
  //      //        }
  //}
  //
  //  Serial.println("");
  //  Serial.println(headPin+1);
}

//----------------------------------------------------------------
//                           WRAPPERS
//----------------------------------------------------------------

int polarizeHead(int index) {
  // int pin = 0;
  // if (index == 0 || index == 4) {
  //   pin = 2;
  //   return pin;
  // } else if (index == 1 || index == 5) {
  //   pin = 3;
  //   return pin;
  // } else if (index == 2 || index == 6) {
  //   pin = 4;
  //   return pin;
  // } else if (index == 3 || index == 7) {
  //   pin = 5;
  //   return pin;
  // } else {
  //   return -1;
  // }
  return int(random(2, 5));
}

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

void arrMin(int (&diodes)[8], int (&minOut)[2]) {  //need wrapper for full array max/min finding using native functions
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
