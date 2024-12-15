//Method for 4-unit intercalation

#include <Wire.h>
#include <Adafruit_INA219.h>
#include <movingAvg.h>

Adafruit_INA219 ina219_0(0x40);
Adafruit_INA219 ina219_1(0x41);
Adafruit_INA219 ina219_2(0x44);
Adafruit_INA219 ina219_3(0x45);
movingAvg foo0(3);
movingAvg foo1(3);
movingAvg foo2(3);
movingAvg foo3(3);
float start = millis();
bool lightOn = false;
int intercalationCount = 0;
int vib = 0;      //dt
int drive = 175;  //amplitude
int vibCount = 0;

void setup(void) {
  Serial.begin(9600);

  foo0.begin();
  foo1.begin();
  foo2.begin();
  foo3.begin();
  pinMode(8, OUTPUT);
  digitalWrite(8, HIGH);


  uint32_t currentFrequency;

  // Initialize the INA219.
  // By default the initialization will use the largest range (32V, 2A).  However
  // you can call a setCalibration function to change this range (see comments).
  if (!ina219_0.begin()) {
    Serial.println("Failed to find INA219 chip 1");
    while (1) {
      delay(10);
    }
  }
  //  Serial.print("one");
  if (!ina219_1.begin()) {
    Serial.println("Failed to find INA219 chip 2");
    while (1) {
      delay(10);
    }
  }
  // //  Serial.print("two");
  if (!ina219_2.begin()) {
    Serial.println("Failed to find INA219 chip 3");
    while (1) {
      delay(10);
    }
  }
   Serial.print("three");
  if (!ina219_3.begin()) {
    Serial.println("Failed to find INA219 chip 4");
    while (1) {
      delay(10);
    }
// }

//  Serial.println("Power1Readings: ");
}

void loop(void) {
  if (Serial.available() > 0) {

    delay(10);
    if (!lightOn) {
      String inputString = Serial.readStringUntil('\n');
      int in = inputString.toInt();
      // Serial.println(in);
      start = millis();
      if (in <= 10) {
        lightOn = !lightOn;
        in = 100;
      }
    }
  }

  if (lightOn) {
    // Serial.println("here");
    digitalWrite(8, LOW);  //light turns on
    float shuntvoltage_0 = 0;
    float busvoltage_0 = 0;
    float current_mA_0 = 0;
    float loadvoltage_0 = 0;
    float power_mW_0 = 0;
    float lipoVoltage_0 = analogRead(A0);
    shuntvoltage_0 = ina219_0.getShuntVoltage_mV();
    busvoltage_0 = ina219_0.getBusVoltage_V();
    current_mA_0 = ina219_0.getCurrent_mA();
    power_mW_0 = ina219_0.getPower_mW();
    loadvoltage_0 = busvoltage_0 + (shuntvoltage_0 / 1000);

    float shuntvoltage_1 = 0;
    float busvoltage_1 = 0;
    float current_mA_1 = 0;
    float loadvoltage_1 = 0;
    float power_mW_1 = 0;
    float lipoVoltage_1 = analogRead(A1);
    shuntvoltage_1 = ina219_1.getShuntVoltage_mV();
    busvoltage_1 = ina219_1.getBusVoltage_V();
    current_mA_1 = ina219_1.getCurrent_mA();
    power_mW_1 = ina219_1.getPower_mW();
    loadvoltage_1 = busvoltage_1 + (shuntvoltage_1 / 1000);

    float shuntvoltage_2 = 0;
    float busvoltage_2 = 0;
    float current_mA_2 = 0;
    float loadvoltage_2 = 0;
    float power_mW_2 = 0;
    float lipoVoltage_2 = analogRead(A1);
    shuntvoltage_2 = ina219_2.getShuntVoltage_mV();
    busvoltage_2 = ina219_2.getBusVoltage_V();
    current_mA_2 = ina219_2.getCurrent_mA();
    power_mW_2 = ina219_2.getPower_mW();
    loadvoltage_2 = busvoltage_2 + (shuntvoltage_2 / 1000);

    // float shuntvoltage_3 = 0;
    // float busvoltage_3 = 0;
    // float current_mA_3 = 0;
    // float loadvoltage_3 = 0;
    // float power_mW_3 = 0;
    // float lipoVoltage_3 = analogRead(A1);
    // shuntvoltage_3 = ina219_3.getShuntVoltage_mV();
    // busvoltage_3 = ina219_3.getBusVoltage_V();
    // current_mA_3 = ina219_3.getCurrent_mA();
    // power_mW_3 = ina219_3.getPower_mW();
    // loadvoltage_3 = busvoltage_3 + (shuntvoltage_3 / 1000);

    float data0 = foo0.reading(power_mW_0);
    float data1 = foo1.reading(power_mW_1);
    float data2 = foo2.reading(power_mW_2);
    float data3 = foo3.reading(power_mW_3);
    // float data3 = foo3.reading(0);
    //  Serial.print("Power1Readings: ");

    Serial.print(data0);
    Serial.print(",");
    Serial.print(data1);
    Serial.print(",");
    Serial.print(data2);
    Serial.print(",");
    Serial.print(data3);
    Serial.print(",");
    Serial.println(millis() - start);
    // Serial.print(",");
    // Serial.print(vib);
    // Serial.print(",");
    // Serial.print(drive);
    // Serial.print(",");
    // Serial.println(intercalationCount);

    if (Serial.available() > 0) {
      String inputString = Serial.readStringUntil('\n');
      int in = inputString.toInt();
      // Serial.println(in);
      // start = millis();
      if (in <= 10) {
        lightOn = !lightOn;
        in = 100;
      }
    }
  } else {
    digitalWrite(8, HIGH);
  }





  delay(1);
  //  delay(2000);
}
