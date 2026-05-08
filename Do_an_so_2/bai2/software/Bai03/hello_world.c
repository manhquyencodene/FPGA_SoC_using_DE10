#include <stdio.h>
#include "io.h"
#include "system.h"
#include "altera_avalon_timer_regs.h" // Add library for Timer

int main() {
    unsigned int sw_val;
    int tens_val, ones_val;

    int hours = 0;
    int minutes = 0;
    int seconds = 0;
    int mode = 0;

    printf("Clock operation: HEX IP (3 Write Regs) + Switch PIO (Offset 0)...\n");
    printf("Mode 00: Count up | 01: Set Seconds | 10: Set Minutes | 11: Set Hours\n");

    // --- INITIALIZE INTERVAL TIMER (Continuous mode, no interrupts) ---
    IOWR_ALTERA_AVALON_TIMER_CONTROL(TIMER_0_BASE, ALTERA_AVALON_TIMER_CONTROL_STOP_MSK);

    unsigned int period = 50000000 - 1; // Clock 50MHz = 50,000,000 counts per 1 second
    IOWR_ALTERA_AVALON_TIMER_PERIODL(TIMER_0_BASE, period & 0xFFFF);
    IOWR_ALTERA_AVALON_TIMER_PERIODH(TIMER_0_BASE, (period >> 16) & 0xFFFF);

    IOWR_ALTERA_AVALON_TIMER_CONTROL(TIMER_0_BASE,
        ALTERA_AVALON_TIMER_CONTROL_CONT_MSK |  // Continuous counting mode
        ALTERA_AVALON_TIMER_CONTROL_START_MSK); // Start timer
    // ---------------------------------------------------------------

    while (1) {
        sw_val = IORD(SWITCHES_0_BASE, 0);

        mode = (sw_val >> 8) & 0x03;     // Get SW9, SW8 status
        tens_val = (sw_val >> 4) & 0x0F; // Get SW7 - SW4 status (Tens digit)
        ones_val = sw_val & 0x0F;        // Get SW3 - SW0 status (Ones digit)

        // --- CONTROL ONES DIGIT ---
        // Force ones digit to be <= 9 to prevent invalid BCD values
        if (ones_val > 9) ones_val = 9;

        // --- CHECK MODE ---
        if (mode == 0) {

            // --- FIX IS HERE: REPLACE FOR LOOP WITH INTERVAL TIMER ---
            // CPU waits until the Timeout (TO) flag of the Timer becomes 1
            while ((IORD_ALTERA_AVALON_TIMER_STATUS(TIMER_0_BASE) & ALTERA_AVALON_TIMER_STATUS_TO_MSK) == 0) {}

            // 1 second elapsed -> Clear TO flag to 0 for the next cycle
            IOWR_ALTERA_AVALON_TIMER_STATUS(TIMER_0_BASE, 0);
            // ---------------------------------------------------------

            seconds++;
            if (seconds >= 60) {
                seconds = 0;
                minutes++;
                if (minutes >= 60) {
                    minutes = 0;
                    hours++;
                    if (hours >= 24) hours = 0;
                }
            }
        }
        else {
            // Mode 01, 10, 11: PAUSE COUNTING & ADJUST
            if (mode == 1) {
                // 01: Set Seconds
                if (tens_val > 5) tens_val = 5; // Tens digit of seconds cannot exceed 5
                seconds = (tens_val * 10) + ones_val;
            }
            else if (mode == 2) {
                // 10: Set Minutes
                if (tens_val > 5) tens_val = 5; // Tens digit of minutes cannot exceed 5
                minutes = (tens_val * 10) + ones_val;
            }
            else if (mode == 3) {
                // 11: Set Hours
                if (tens_val > 2) tens_val = 2; // Tens digit of hours cannot exceed 2
                int temp_hours = (tens_val * 10) + ones_val;
                if (temp_hours > 23) temp_hours = 23; // Total hours cannot exceed 23
                hours = temp_hours;
            }
        }

        // --- OUTPUT DATA TO UNIFIED HEX IP ---
        // Offset 0: Seconds | Offset 1: Minutes | Offset 2: Hours
        // Pack BCD: Shift tens digit left by 4 bits, OR with ones digit
        IOWR(HEX_0_BASE, 0, ((seconds / 10) << 4) | (seconds % 10));
        IOWR(HEX_0_BASE, 1, ((minutes / 10) << 4) | (minutes % 10));
        IOWR(HEX_0_BASE, 2, ((hours / 10) << 4)   | (hours % 10));
    }

    return 0;
}
