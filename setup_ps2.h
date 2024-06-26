#pragma once

void mouseTick();
void mouseReset();
void mouseSetRequestedId(uint8_t);
uint8_t getMouseId();
bool mouseIsReady();
uint8_t getMousePacketSize();

void keyboardTick();
void keyboardReset();
bool keyboardIsReady();
