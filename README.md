# Arduino MATLAB serial communication

## Description 

This script was used to receive GPS data from an Arduino board in a computer using MATLAB, but it can be used to fetch data from any other serial connection.
% The purpose was to plot the GPS positions in real time and save it in a log file using CVS format (data separated using a comma delimiter).

## Requirements:
```
    - Data must be sent through Serial port.
     - Variables must be sent separated by a comma ',' with a carriage return and newline characters after the last variable. Example: Serial.println()
```

## Arduino

To use it with an Arduino:
```   - The Arduino board must be connected to the computer via USB port;
      - Data must be send using Serial.print() and Serial.println() functions.
````

### Example:

       To send the following variables:
        ```Latitude = -401034; Longitude = -501343; RandomData = 12314;```
        
        Use:

 ```
               Serial.print("%d", Latitude)
               Serial.print("%d", Longitude)
               Serial.println("%d", RandomData)
```
