import RPi.GPIO as GPIO
import time
import sys

# Define GPIO pins
PWMA = 18
AIN1 = 22
AIN2 = 27

PWMB = 23
BIN1 = 25
BIN2 = 24

# Speed variables
speed = 50
max_speed = 100
min_speed = 0

# Adjust speed function
def adjust_speed(factor):
    global speed
    if factor == 0:
        speed = min_speed
    elif factor == 1:
        speed += 50
        if speed > max_speed:
            speed = max_speed
    elif factor == -1:
        speed -= 50
        if speed < min_speed:
            speed = min_speed
    elif factor == 2:
        speed = max_speed
    elif factor == -2:
        speed = min_speed

# Set up GPIO
GPIO.setwarnings(False)
GPIO.setmode(GPIO.BCM)
GPIO.setup(AIN1, GPIO.OUT)
GPIO.setup(AIN2, GPIO.OUT)
GPIO.setup(PWMA, GPIO.OUT)
GPIO.setup(BIN1, GPIO.OUT)
GPIO.setup(BIN2, GPIO.OUT)
GPIO.setup(PWMB, GPIO.OUT)

# Initialize PWM on motor pins
L_Motor = GPIO.PWM(PWMA, 100)  # 100 Hz frequency
L_Motor.start(0)  # Start with 0% duty cycle

R_Motor = GPIO.PWM(PWMB, 100)  # 100 Hz frequency
R_Motor.start(0)  # Start with 0% duty cycle

# Function to move the motor
def move(left_motor, right_motor, left_dir1, left_dir2, right_dir1, right_dir2):
    # Set motor direction
    GPIO.output(AIN1, left_dir1)
    GPIO.output(AIN2, left_dir2)
    GPIO.output(BIN1, right_dir1)
    GPIO.output(BIN2, right_dir2)

    # Set motor speed
    L_Motor.ChangeDutyCycle(speed)
    R_Motor.ChangeDutyCycle(speed)

    # Sleep for 1 second
    time.sleep(1)

    # Stop after 1 second
    stop()

# Function to stop the motor
def stop():
    L_Motor.ChangeDutyCycle(0)
    R_Motor.ChangeDutyCycle(0)
    GPIO.output(AIN1, False)
    GPIO.output(AIN2, False)
    GPIO.output(BIN1, False)
    GPIO.output(BIN2, False)

# Main control loop
if __name__ == "__main__":
    try:
        if len(sys.argv) > 1:
            command = sys.argv[1]
            
            if command == '1':  # Forward
                move(1, 1, 0, 1, 0, 1)
            elif command == '2':  # Backward
                move(1, 1, 1, 0, 1, 0)
            elif command == '3':  # Right
                move(1, 1, 0, 1, 1, 0)
            elif command == '4':  # Left
                move(1, 1, 1, 0, 0, 1)
            elif command == '5':  # Stop
                stop()
            else:
                print("Invalid command")
                GPIO.cleanup()
                sys.exit(1)
        
        else:
            print("Please provide a command as an argument (1: Forward, 2: Backward, 3: Right, 4: Left, 5: Stop)")
            sys.exit(1)

    except KeyboardInterrupt:
        GPIO.cleanup()
