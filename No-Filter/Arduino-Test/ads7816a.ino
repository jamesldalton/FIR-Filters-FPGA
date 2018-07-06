// PINS
const unsigned int D_OUT = 7; // 12-bit of input data, valid on neg-edge of D_CLK
const unsigned int D_CLK = 8; // Data clock syncronizes the serial data transfer
const unsigned int _CS   = 9; // Chip select (neg)

// CONSTs
const double V_REF = 2.0; // [V]
const long unsigned int SAMP_RATE = 63400; // [Hz]

//struct bitset12 { unsigned val:12; };

void setup() {

  pinMode(D_OUT, INPUT);
  pinMode(D_CLK, OUTPUT);
  pinMode(_CS,   OUTPUT);

  digitalWrite(D_CLK, 0);
  digitalWrite(_CS,   1);
  
  Serial.begin(9600);
  
}

void loop() {
  uint16_t DATA = 0x0000;
  // Begin data conversion and data transfer
  digitalWrite(_CS, 0);
  tick();
  tick();
  delayMicroseconds(5);
  // Capture data
  DATA = (digitalRead(D_OUT) << 11);    // B11, MSB
  tick();
  DATA += (digitalRead(D_OUT) << 10);   // B10
  tick();
  DATA += (digitalRead(D_OUT) << 9);    // B9
  tick();
  DATA += (digitalRead(D_OUT) << 8);    // B8
  tick();
  DATA += (digitalRead(D_OUT) << 7);    // B7
  tick();
  DATA += (digitalRead(D_OUT) << 6);    // B6
  tick();
  DATA += (digitalRead(D_OUT) << 5);    // B5
  tick();
  DATA += (digitalRead(D_OUT) << 4);    // B4
  tick();
  DATA += (digitalRead(D_OUT) << 3);    // B3
  tick();
  DATA += (digitalRead(D_OUT) << 2);    // B2
  tick();
  DATA += (digitalRead(D_OUT) << 1);    // B1
  tick();
  DATA += digitalRead(D_OUT);           // B0, LSB

  digitalWrite(_CS, 1);

  double data_in_v = (DATA*V_REF)/2048;
  Serial.println(data_in_v);
  Serial.print(" ");

  delay(10);
}

void tick() {
  digitalWrite(D_CLK, 1);
  delayMicroseconds(1);
  digitalWrite(D_CLK, 0);
  delayMicroseconds(1);
}






