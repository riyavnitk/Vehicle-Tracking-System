# A Real-time Vehicle Tracking System using 8051 Microcontroller
This repository contains the code loaded into the microcontroller to track the vehicle in real-time. The code is written in assembly language and compiled using Keil uVision IDE. The code is loaded into the microcontroller using Flash Magic.

## Introduction
It monitors the vehicle location using the latitude and longitude values obtained from the GPS module. The location is sent to the desired emergency contact provided using the GSM module. The location is displayed on the map using the Google Maps API. The location is updated every 5 seconds.

## Components
* 8051 Microcontroller
* GPS Module
* GSM Module
* LCD Display
* Keypad
* AT89S52